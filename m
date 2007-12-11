Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2007 14:00:01 -0200
Message-Id: <JSW741$A58C7550DB40F4B04CB558CA34606BF7@multidominios>
MIME-Version: 1.0
From: "vcallegari" <vcallegari@terra.com.br>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Instability with BlueZ under medium load
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

There are some very odd situations with an application running on a 2.6.22 kernel, using dbus-glib, and several
bluetooth dongles on USB with a hub. All dongles are hci version 2.0, CSR bluecore 4, class 2, the hubs are
cheapo no names. It works correctly while there are only a few bluetooth device in the area, but as soon as the
number of peers reaches a certain level, the follwoing messages pop up in the kernel log files:

	add_conn: Failed to register connection
	hci_cmd_task: hci0 command tx timeout

These lines are repeated several times, the second being more frequent, but from there on, most connections
will fail, the
g_io_watch callback getting an G_IO_ERR. It seems that once this happens, all lines refer to the same device,
which doesn't need to be hci0. At that moment the dbus-method ListConnections returns an empty list or with at
most one or two entries. The failure of the connections and these messages don't seem to happen at the same
instant, but once the connections start to fail, the kernel log certainly will show them. hcidump doesn't
indicate any problem, it's just that the connection had timed out. This effect was reproduced with different
computers, different dongles, and hubs. All computers have USB from VIA, but there is one which has USB from
Intel, which also shows this effect.

The only method to restore this situation is to switch off the computer, wait a few minutes and restart it with
no peers in the
area. One really funny thing is, when the application is restarted without reboot in such a situation, but
choosing different dongles
which where formerly present but not used. Then it can happen that performance improves somewhat (though not to
normal operation) while the messages in the kernel log files refer to a device which is not even being used.

Is this a problem with BlueZ, USB in Linux or is this hardware related? Where would be the best place to ask?
And most importantly, what can be done about it?

Thanks for your reply.

Valter


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
