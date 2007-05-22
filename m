Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46536A7D.7010500@access-company.com>
Date: Wed, 23 May 2007 00:11:09 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <464B36D4.80702@access-company.com>	<1179666685.10069.250.camel@violet>	<e1effdeb0705210812p64d34f57l7800556df240fb23@mail.gmail.com>	<4653218D.3090504@access-company.com>	<1179854658.9152.37.camel@aeonflux.holtmann.net>	<46533F31.9090406@access-company.com>
	<1179868135.9152.39.camel@aeonflux.holtmann.net>
In-Reply-To: <1179868135.9152.39.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Fix for disconnection in new serial service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Marcel, Claudio,

>>>> What I want to do in my program is : ConnectService, open rfcomm, DisconnectService, than use file descriptor on rfcomm. Close rfcomm after, that should 
>>>> disconnect the bluetooth connection.
>>> that is not the the use case for ConnectService and DisconnectService.
>>> It is as simple as that. What you want is more like the CreatePort
>>> methods that create persistent RFCOMM bindings.
>> Even if I change to : ConnectService, open rfcommX, use file descriptor on rfcommX, close rfcommX, DisconnectService 
>> (that is a more classical use), the rfcommX connection is not released (and acl connection, until remote close it), as 
>> serial service keep a file descriptor opened on the rfcommX device (no close on node->io).
> 
> that is the use case this is designed for. If this doesn't seem to work
> than it actually looks like a bug. Can you provide further information
> for Claudio so he can debug it.

To simply check this, I do :

- on remote, I create a SPP server :
     frederic.danis@remote:~$ sdptool add --channel=5 sp
     Serial Port service registered
     frederic.danis@remote:~$ rfcomm listen 0 5
     Waiting for connection on channel 5

- on local, I connect to remote using serial service :
     ~ # dbus-send --system --type=method_call --print-reply --dest=org.bluez /org/bluez org.bluez.Manager.ActivateService string:serial
     method return sender=:1.0 -> dest=:1.22
        string ":1.19"
     ~ # dbus-send --system --type=method_call --print-reply --dest=:1.19 /org/bluez/serial org.bluez.serial.Manager.ConnectService string:00:01:02:03:04:05 
string:spp
     serial[1040]: /org/bluez/serial: org.bluez.serial.Manager.ConnectService()
     serial[1040]: Connect in progress
     serial[1040]: rfcomm_connect_cb: connected
     serial[1040]: name_listener_add(:1.23)
     method return sender=:1.19 -> dest=:1.23
        string "/dev/rfcomm0"
     serial[1040]: Connect requestor :1.23 exited. Releasing /dev/rfcomm0 node
     ~ # ls -l /dev/rfcomm0
     crw-rw----    1 root     dialout  216,   0 May 22 21:37 /dev/rfcomm0
- on remote I get :
     Connection from 00:01:02:03:04:05 to /dev/rfcomm0
     Press CTRL-C for hangup

As there is no program using /dev/rfcomm0, and it has been released at end of "ConnectService call by dbus-send", it should no more exist and rfcomm (and acl) 
connection should be closed. It does not occur until pressing ctrl-c on remote. (I do not see any way to close the rfcomm connection from local)

- on local I have :
     ~ # hcitool con
     Connections:
             < ACL 00:01:02:03:04:05 handle 42 state 1 lm MASTER
     ~ # ls -l /dev/rfcomm0
     crw-rw----    1 root     dialout  216,   0 May 22 21:37 /dev/rfcomm0
- I press ctrl-c on remote :
     Disconnected
- on local I have :
     ~ # hcitool con
     Connections:
     ~ # ls -l /dev/rfcomm0
     ls: /dev/rfcomm0: No such file or directory

To me it seems that this bug is due to the file descriptor on /dev/rfcomm0 opened during connection and set in a g_io_channel. This file descriptor is not 
closed before the g_io_channel is unreferenced (so reference to this file descriptor is lost, but still opened) preventing rfcomm stack to really release 
connection.

Hope this helps,

Regards

Fred

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
