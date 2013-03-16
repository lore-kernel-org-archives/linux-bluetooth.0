Return-Path: <cyrus@holtmann.org>
Message-ID: <1363442955.4088.1.camel@dellpc>
Subject: Re: [PATCH 00/16] Rewrite HIDP Session Management
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>
Date: Sat, 16 Mar 2013 14:09:15 +0000
In-Reply-To: <CANq1E4TOdosxqw4BbXrKFSHMDBFWpKz4__5Bd-O=cmCJS6TUsA@mail.gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
	 <CANq1E4TOdosxqw4BbXrKFSHMDBFWpKz4__5Bd-O=cmCJS6TUsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2013-03-12 at 18:24 +0100, David Herrmann wrote:
> ping?
> 

I looked over the patches, and they seemed sensible to me. Thanks for
the good work!

Regards
Karl

> On Sun, Feb 24, 2013 at 7:36 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> > Hi
> >
> > If anyone tested "hotplugging" with HIDP in the last years, there's a 50% chance
> > you get an oops when "unplugging" devices. I never got around fixing it until
> > now. I took the time to thoroughly review HIDP, hci_dev and hci_conn
> > interaction and it turned out to be totally broken. The thing is that HIDP
> > highly depends on the underlying hci_conn object. However, there is no way to
> > notify HIDP when the connection is shut down. So this is where I started fixing
> > things.
> >
> > First, a list of bugs that all played together and are mostly fixed in this
> > series:
> >
> > * hci_conn use after free:
> >   hci_conn_del() calls hci_conn_put_device() which might call
> >   hci_conn_del_sysfs(), which itself calls put_device() which might call
> >   bt_link_release() which calls kfree(hci_conn).
> >   That is, the "conn->handle" check in hci_conn_del() dereferences "conn" after
> >   it has been freed.
> >   Note that the "might"-case is the usual case. So this is a real bug.
> >
> > * kfree() after device_initialize()
> >   During hci_conn_add() we call hci_conn_init_sysfs() which calls
> >   device_initialize() on hci_conn. However, if we never call
> >   hci_conn_add_sysfs(), then hci_conn_del() will not use "put_device()" to drop
> >   the reference but instead call kfree(hci_conn).
> >   This is not allowed (see documentation for device_initialize()).
> >
> > * ref-count for device_del()
> >   We use a "devcnt" reference-count in every hci_conn structure which controls
> >   when we call device_del(hci_conn). This isn't a but itself, but discouraged
> >   behavior. device_del() is supposed to be called when the (virtual) hardware
> >   of the device goes away. So when the hci-connection is closed, we are supposed
> >   to call device_del() immediately. If the direct call to device_del()
> >   introduces bugs, we _must_ fix the bugs instead of delaying
> >   device_del(). The correct fix is to notify all childs that the
> >   device goes away (they can now call device_del(child)) and then call
> >   device_del() afterwards. But this needs to be done synchronously.
> >
> > * device_find_child() + device_move()
> >   This is really wrong. When an hci_conn object goes away, we move all it's
> >   childs to the root node. The code doesn't have a comment to say _why_ we do
> >   this bug digging in commit-messages it said that client RFCOMM-TTY devices
> >   might have a reason to stay alive even though the hci_conn is gone.
> >   Could anyone please tell me _one_ reason, why an RFCOMM-TTY object should stay
> >   even though the hci_conn is gone?
> >
> > * hci_conn use after free
> >   If an hci_conn is grabbed via hci_conn_hold_device(), but the connection
> >   hasn't been added to user-space, yet, then hci_conn_del() might call kfree()
> >   on the device, even though a later call to hci_conn_put_device() will still
> >   access it.
> >   This is a theoretical bug as we have other means to avoid it. But it's still
> >   ugly.
> >
> > * hci_conn_put() called more often than hci_conn_hold()
> >   I added a debug-print to hci_conn_put() and the ref-count dropped below 0
> >   everytime I disconnected a device. It doesn't break anything, but we really
> >   should avoid this!
> >
> > * hci_conn_put_device() doesn't take the parent hci_dev into account.
> >   So the bug we tried to fix with _hold/put_device(), comes up again if we
> >   unplug the adapter instead of disconnecting the remote device.
> >
> > * HIDP doesn't consider "terminate" in wait-conditions
> >   No wait-condition in HIDP watches for "terminate" to become non-zero, even
> >   though it is a _very_ likely condition to terminate HIDP.
> >
> > * HIDP removes the HID/input devices asynchronously from within the session
> >   instead of synchronously when the connection goes down. This causes the
> >   session-thread to use the connection even though it's gone.
> >
> > That's all I can remember for now, but there's some more small bugs that I fixed
> > together with the session-rewrite.
> >
> > This series includes some small fixes/cleanups that can be applied right away
> > (which would simplify this series a lot). The other patches depend on each other
> > so they cannot be cherry-picked.
> >
> > I tested this series and it works perfectly well. 10 connect/disconnect
> > cycles worked without a bug. I can shut down the device, unplug the adapter or
> > do an explicit disconnect without an oops.
> > I haven't tested suspend/resume, yet, though.
> >
> > Please review!
> > Thanks
> > David
> >
> >
> > Overview:
> >
> > Patch 1-3: They remove a bogus return-code in bt_sock_unregister() which doesn't
> >            make sense to me.
> >
> > Patch 4: Add is_l2cap_socket() which allows HIDP to verify that the passed
> >          sockets are real l2cap sockets.
> >
> > Patch 5-7: Introduce ref-counting for hci_conn objects so we can have a
> >            reference to them in the HIDP session. Note that we cannot reuse the
> >            current "refcnt" as this is used for something totally differen: It
> >            counts the number of active users on the underlying connection. It
> >            doesn't ref-count the hci_conn object itself!
> >
> > Patch 8-10: Some small HIDP and HCI-core fixes
> >
> > Patch 11: Add l2cap_sock_get_hci_conn() helper to allow HIDP to use l2cap
> >           sockets and retrieve the underlying hci_conn object instead of using
> >           an unnecessary hash-table lookup.
> >
> > Patch 12: Add hci_conn_user objects. This allows external protocols to bind to
> >           an hci_conn object and get notified whenever the connection is closed
> >           and unlinked from sysfs.
> >
> > Patch 13: Small HIDP cleanup patch
> >
> > Patch 14-15: Rewrite the HIDP session-management based on hci_conn_user objects.
> >              I haven't found an easy way to do this in many small patches as the
> >              new session-management is totally different than the previous one.
> >              Hence, I first add the new helpers and then remove the old helpers
> >              and do the switch in a follow-up patch. This makes reviewing
> >              easier.
> >
> > Patch 16: Again a small fix for HIDP that uses the new session-management
> >           helpers.
> >
> > David Herrmann (16):
> >   Bluetooth: discard bt_sock_unregister() errors
> >   Bluetooth: change bt_sock_unregister() to return void
> >   Bluetooth: hidp: simplify error path in sock-init
> >   Bluetooth: hidp: verify l2cap sockets
> >   Bluetooth: rename hci_conn_put to hci_conn_drop
> >   Bluetooth: remove unneeded hci_conn_hold/put_device()
> >   Bluetooth: introduce hci_conn ref-counting
> >   Bluetooth: hidp: remove unused session->state field
> >   Bluetooth: hidp: test "terminate" before sleeping
> >   Bluetooth: allow constant arguments for bacmp()/bacpy()
> >   Bluetooth: l2cap: add l2cap_sock_get_hci_conn() helper
> >   Bluetooth: add hci_conn_user sub-modules
> >   Bluetooth: hidp: move hidp_schedule() to core.c
> >   Bluetooth: hidp: add new session-management helpers
> >   Bluetooth: hidp: remove old session-management
> >   Bluetooth: hidp: handle kernel_sendmsg() errors correctly
> >
> >  include/net/bluetooth/bluetooth.h |   6 +-
> >  include/net/bluetooth/hci_core.h  |  46 ++-
> >  include/net/bluetooth/l2cap.h     |   2 +
> >  net/bluetooth/af_bluetooth.c      |  15 +-
> >  net/bluetooth/bnep/sock.c         |   4 +-
> >  net/bluetooth/cmtp/sock.c         |   4 +-
> >  net/bluetooth/hci_conn.c          |  92 ++++-
> >  net/bluetooth/hci_event.c         |  40 +-
> >  net/bluetooth/hci_sock.c          |   4 +-
> >  net/bluetooth/hci_sysfs.c         |   1 -
> >  net/bluetooth/hidp/core.c         | 787 +++++++++++++++++++++++++-------------
> >  net/bluetooth/hidp/hidp.h         |  67 ++--
> >  net/bluetooth/hidp/sock.c         |  35 +-
> >  net/bluetooth/l2cap_core.c        |   6 +-
> >  net/bluetooth/l2cap_sock.c        |  31 +-
> >  net/bluetooth/mgmt.c              |   6 +-
> >  net/bluetooth/rfcomm/sock.c       |   3 +-
> >  net/bluetooth/sco.c               |   9 +-
> >  net/bluetooth/smp.c               |   2 +-
> >  19 files changed, 737 insertions(+), 423 deletions(-)
> >
> > --
> > 1.8.1.4
