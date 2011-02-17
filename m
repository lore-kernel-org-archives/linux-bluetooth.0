Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 00/10] Support for OOB in mgmt interface
Date: Thu, 17 Feb 2011 14:16:31 +0100
Message-ID: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches add support for OOB in mgmt interface. New commands added:
- mgmt_read_local_oob_data - read local oob data from chip and forward it to
  userspace
- mgmt_add/remote_oob_data - allow to store(or remove) remote oob data in
  kernel, this data is then used by kernel while pairing, storing that data
  in kernel minimize kernel<->userpace interaction on pairing (approche
  suggested by Johan on irc)

There are also patches that do some clean up work on files touched by new mgmt
commands (mostly issues reported by checkpatch).

"Add optional data parameter to mgmt_ev_cmd_status event" and
"Use EIO code to report HCI error to userpace." touch some issues with mgmt
interface that I've mentioned already on irc:
- On error mgmt_read_local_oob_data needs to report to userspace on which
  adapter request failed. In mgmt cmd_status is used to report errors so this
  adds optional data[0] parameter to it. This may also be usefull for other
  commands as well.
- It is not possible to distinguish in cmd status if error was from kernel
  or from HCI. Since in mgmt only kernel sends HCI commands their errors
  shouldn't be needed for userspace so report EIO to userspace on HCI error
  (if HCI error is needed for debugging, logs can be added on kernel side)


When mgmt interface to OOB will be agreed, I'll prepare patches for bluetoothd
as well.


Comments are welcome.


BR,
Szymon Janc
on behalf of ST-Ericsson

Szymon Janc (10):
  Bluetooth: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
  Bluetooth: Clean up hci_sniff_subrate_evt function
  Bluetooth: Add optional data parameter to mgmt_ev_cmd_status event
  Bluetooth: Use EIO code to report HCI error to userpace
  Bluetooth: Add read_local_oob_data management command
  Bluetooth: Add add/remove_remote_oob_data management commands
  Bluetooth: Fix code style issues and make checkpatch silent about
    hci_core.h
  Bluetooth: Fix code style issues and make checkpatch silent about
    hci_core.c
  Bluetooth: Fix code style issues, make checkpatch less noisy about
    hci_event.c
  Bluetooth: Log command and status parameters in command status event

 include/net/bluetooth/hci.h      |   24 ++++
 include/net/bluetooth/hci_core.h |  109 ++++++++++------
 include/net/bluetooth/mgmt.h     |   29 ++++
 net/bluetooth/hci_core.c         |  106 +++++++++++++--
 net/bluetooth/hci_event.c        |  201 +++++++++++++++++++++--------
 net/bluetooth/mgmt.c             |  263 ++++++++++++++++++++++++++++++++------
 6 files changed, 580 insertions(+), 152 deletions(-)

