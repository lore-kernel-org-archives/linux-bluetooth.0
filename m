Return-Path: <cyrus@holtmann.org>
Message-ID: <1359045847.6791.24.camel@dellpc>
Subject: RFC: Race between hci_unregister_dev and hidp_session
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: Gustavo Padovan <gustavo@padovan.org>, Marcel Holtmann
 <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 24 Jan 2013 16:44:07 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Gustavo/Marcel

I believe I have tracked down a race condition between
hci_unregister_dev() and hidp_session() that can lead to userspace
failure of bluetooth input devices (see [1] below).


hci_unregister_dev calls
  hci_dev_do_close calls
    hci_conn_hash_flush calls
      hci_proto_disconn_cfm which triggers (via a wakeup)
        hidp_session running in another thread (a kthread)

hci_unregister_dev, after the above calls, will go on to call
  hci_del_sysfs to remove the 'hci' device

Meanwhile hidp_session will drop out its main loop, start cleaning up
which includes a call to
   hid_destroy_device which removes the input & hid (and hidraw) devices


For correct operation, and what userspace would normally expect, removal
from the sysfs tree should be 'bottom up', i.e. event then input then
hid then hci.

For this operation, one would need to guaruntee that hidp_session
finishes its cleanup before hci_unregister_dev continues with its work.

At the moment this is not done. Any delay in hidp_session will allow
hci_unregister_dev to win the race, causing an out of sequence sysfs
removal, and headaches for userspace.


Currently, the power_supply system is causing hidp_session to stall for
5 seconds (as detailed in [2]). Plenty of time to cause hidp_session to
lose the race! But even without such silliness, a race can't be a good
thing can it?


How to fix? Some synchronisation between hidp_session thread and the hci
code is required. hci_conn devices already use a ref counting system to
delay removing the device from sysfs until the count gets to zero
(hci_conn_put_device), so presumably a similar arrangement can be
implemented for the hci device? Note this would need to be a different
count to that currently in hci_dev_put/hold, because that is based on
the lower level kobj references. Perhaps hci_dev_put/hold can be
augmented to keep its own count in addition to the underlying kobj
count?

Karl


References:
[1] https://bugzilla.kernel.org/show_bug.cgi?id=52471
the udev remove events, being out of sequence, have truncated paths
which disturbs userspace programs like Xorg evdev so they cannot process
the keyboard/mouse removal.

[2] https://bugzilla.kernel.org/show_bug.cgi?id=52471#c2 and
https://bugzilla.kernel.org/show_bug.cgi?id=52471#c3
