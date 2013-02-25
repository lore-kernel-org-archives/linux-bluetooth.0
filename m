Return-Path: <cyrus@holtmann.org>
From: dean_jenkins@mentor.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org
Subject: [PATCH 0/6] Bluetooth: Rework the RFCOMM session refcnt
Date: Mon, 25 Feb 2013 16:38:31 +0000
Message-Id: <1361810317-4005-1-git-send-email-dean_jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset consists of the following 6 patches that reworks the RFCOMM
session refcnt by adding handling for a NULL RFCOMM session pointer when the
session has been deleted followed by removing the now redundant refcnt
mechanism:

----------------------------------------------------------------
Dean Jenkins (6):
      Bluetooth: Avoid rfcomm_session_timeout using freed session
      Bluetooth: Check rfcomm session and DLC exists on socket close
      Bluetooth: Return RFCOMM session ptrs to avoid freed session
      Bluetooth: Remove RFCOMM session refcnt
      Bluetooth: Remove redundant call to rfcomm_send_disc
      Bluetooth: Remove redundant RFCOMM BT_CLOSED settings

 include/net/bluetooth/rfcomm.h |    6 ----
 net/bluetooth/rfcomm/core.c    |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------
 2 files changed, 76 insertions(+), 93 deletions(-)

The motivation for the change was RFCOMM kernel crashes in a 2.6.34 based ARM
SMP kernel. It is noted that RFCOMM in kernel 3.7 still contains the RFCOMM
session refcnt so the patches have been forward ported. Crashes were due to
malfunctions of the RFCOMM session refcnt such as premature deletion of the
session and double deletion of the session. Some crashes were caused by
the interaction of 2 kernel threads under very high processor loading.

Note that the refcnt is incorrectly initialised, it should be set to 1 before
allowing the session structure to be used, the old code used a value of 0 and
this contributes to a weak implementation of the refcnt.

In kernels later than 2.6.34, the threading model for RFCOMM was modified to
use work queues and this reduced the probability of a RFCOMM crash. This
helps to explain why the reports of RFCOMM crashes went away. However, the
implementation of the RFCOMM session refcnt is weak and is in fact logically
incorrect by using the RFCOMM data channel "initiator" flag. The control
channel disconnection procedures do not care about how the control channel
was established eg. by host or remote device request.

The patches also make it clear when the RFCOMM session has been deleted by
using a NULL pointer. The old code has a possibility to access freed RFCOMM
session structures because there are multiple local copies of the pointer. The
patches ensure that local copies of the pointer are set to NULL when the
session has been deleted so avoiding any possibility of accessing freed memory.

Therefore, the patchset cleans up the disconnection of the RFCOMM session
control channel and now the code is deterministic and is understandable by
code review.

These patches were lightly tested against kernel 3.7.3 on a x86 PC. The design
of the patches were proven on a commercial project using a modified embedded ARM
SMP kernel 2.6.34.13. All previously observed RFCOMM control channel
disconnection kernel crashes on ARM 2.6.34.13 went away with the patches
applied.

Patch summaries are shown below:

0001: Bluetooth: Avoid rfcomm_session_timeout using freed session
    
    Use del_timer_sync() instead of del_timer() as this ensures
    that rfcomm_session_timeout() is not running on a different
    CPU when rfcomm_session_put() is called. This avoids a race
    condition on SMP systems because potentially
    rfcomm_session_timeout() could reuse the freed RFCOMM session
    structure caused by the execution of rfcomm_session_put().
    
    Note that this modification makes the reason for the RFCOMM
    session refcnt mechanism redundant.
    

0002: Bluetooth: Check rfcomm session and DLC exists on socket close
    
    A race condition exists between near simultaneous asynchronous
    DLC data channel disconnection requests from the host and remote device.
    This causes the socket layer to request a socket shutdown at the same
    time the rfcomm core is processing the disconnect request from the remote
    device.
    
    The socket layer retains a copy of a struct rfcomm_dlc d pointer.
    The d pointer refers to a copy of a struct rfcomm_session.
    When the socket layer thread performs a socket shutdown, the thread
    may wait on a rfcomm lock in rfcomm_dlc_close(). This means that
    whilst the thread waits, the rfcomm_session and/or rfcomm_dlc structures
    pointed to by d maybe freed due to rfcomm core handling. Consequently,
    when the rfcomm lock becomes available and the thread runs, a
    malfunction could occur as a freed rfcomm_session structure and/or a
    freed rfcomm_dlc structure will be erroneously accessed.
    
    Therefore, after the rfcomm lock is acquired, check that the struct
    rfcomm_session is still valid by searching the rfcomm session list.
    If the session is valid then validate the d pointer by searching the
    rfcomm session list of active DLCs for the rfcomm_dlc structure
    pointed by d.
    

0003: Bluetooth: Return RFCOMM session ptrs to avoid freed session
    
    Unfortunately, the design retains local copies of the s RFCOMM
    session pointer in various code blocks and this invites the erroneous
    access to a freed RFCOMM session structure.
    
    Therefore, return the RFCOMM session pointer back up the call stack
    to avoid accessing a freed RFCOMM session structure. When the RFCOMM
    session is deleted, NULL is passed up the call stack.
    
    If active DLCs exist when the rfcomm session is terminating,
    avoid a memory leak of rfcomm_dlc structures by ensuring that
    rfcomm_session_close() is used instead of rfcomm_session_del().
    

0004: Bluetooth: Remove RFCOMM session refcnt
    
    Previous commits have improved the handling of the RFCOMM session
    timer and the RFCOMM session pointers such that freed RFCOMM
    session structures should no longer be erroneously accessed. The
    RFCOMM session refcnt now has no purpose and will be deleted by
    this commit.
    
    Note that the RFCOMM session is now deleted as soon as the
    RFCOMM control channel link is no longer required. This makes the
    lifetime of the RFCOMM session deterministic and absolute.
    Previously with the refcnt, there was uncertainty about when
    the session structure would be deleted because the relative
    refcnt prevented the session structure from being deleted at will.
    
    It was noted that the refcnt could malfunction under very heavy
    real-time processor loading in embedded SMP environments. This
    could cause premature RFCOMM session deletion or double session
    deletion that could result in kernel crashes. Removal of the
    refcnt prevents this issue.
    
    There are 4 connection / disconnection RFCOMM session scenarios:
    host initiated control link ---> host disconnected control link
    host initiated ctrl link ---> remote device disconnected ctrl link
    remote device initiated ctrl link ---> host disconnected ctrl link
    remote device initiated ctrl link ---> remote device disc'ed ctrl link
    
    The control channel connection procedures are independent of the
    disconnection procedures. Strangely, the RFCOMM session refcnt was
    applying special treatment so erroneously combining connection and
    disconnection events. This commit fixes this issue by removing
    some session code that used the "initiator" member of the session
    structure that was intended for use with the data channels.
    

0005: Bluetooth: Remove redundant call to rfcomm_send_disc
    
    In rfcomm_session_del() remove the redundant call to
    rfcomm_send_disc() because it is not possible for the
    session to be in BT_CONNECTED state during deletion
    of the session.
    

0006: Bluetooth: Remove redundant RFCOMM BT_CLOSED settings
    
    rfcomm_session_close() sets the RFCOMM session state to BT_CLOSED.
    However, in multiple places immediately before the function is
    called, the RFCOMM session is set to BT_CLOSED. Therefore,
    remove these unnecessary state settings.
    
