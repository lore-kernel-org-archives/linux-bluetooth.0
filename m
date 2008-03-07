Return-Path: <cyrus@holtmann.org>
Message-Id: <59861CFE-213C-4E19-B3B9-9FD3875434B9@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300803050603k17a30359g173ab08f0756ff49@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 7 Mar 2008 19:41:19 +0100
References: <2cb4fa160803050333j22a9bc9et68f30c2664d34061@mail.gmail.com>
	<d89ddf300803050603k17a30359g173ab08f0756ff49@mail.gmail.com>
Subject: Re: [Bluez-users] Question about bluetooth simultaneous connections
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

Hi Brad,

> Mohomed, you'll get closer to 7 if you try to keep your device master
> on its connections. Something like calling a fn after estabishing
> connections:

the RFCOMM and L2CAP sockets provide a {L2CAP|RFCOMM}_LM_MASTER to do  
this task on the server socket directly.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
