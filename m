Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] phone+heaset
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Santos <jsantos_pt@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Sea2-F4J2ivuV8vTWoq0001672a@hotmail.com>
References: <Sea2-F4J2ivuV8vTWoq0001672a@hotmail.com>
Content-Type: text/plain
Message-Id: <1073519086.9584.0.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 08 Jan 2004 00:44:46 +0100

Hi Joao,

> I want to use the casira as a headset of a 6310i, using a headphone/speaker 
> in the pc.
> 
> i have made a rfcomm connection to the phone using:
> 
> [root@olivia test]# rfcomm connect /dev/rfcomm0 00:60:57:15:8A:A9 12
> Connected /dev/rfcomm0 to 00:60:57:15:8A:A9 on channel 12
> Press CTRL-C for hangup
> 
> and using the test application scotest in the bluez-utils-2.3 i have:
> 
> [root@olivia test]# ./scotest -r  00:60:57:15:8A:A9
> scotest[30657]: Waiting for connection ...
> scotest[30657]: Connect from 00:60:57:15:8A:A9
> 
> then i click in any button an the app pass to the recv mode
> 
> scotest[30657]: Receiving ...recv_mode()
> 
> 
> scotest[30657]: Read failed. Connection reset by peer(104)
> scotest[30657]: Disconnect
> 
> but i don't receve any data in my buffer.
> When i stop pushing the buttons for a while, i recebe -1 in my read() 
> function and the appl disconnect.
> 
> what is the problem!!

check SCO mapping of your Casira.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
