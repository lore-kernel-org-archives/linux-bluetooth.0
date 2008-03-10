Return-Path: <cyrus@holtmann.org>
Message-Id: <A0E9FA39-0B62-4D12-B243-A8002AC48F37@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <2d5cd43e0803100324g683c6bdbl33f9025d9d673512@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 10 Mar 2008 13:30:56 +0100
References: <2cb4fa160803050333j22a9bc9et68f30c2664d34061@mail.gmail.com>
	<d89ddf300803050603k17a30359g173ab08f0756ff49@mail.gmail.com>
	<59861CFE-213C-4E19-B3B9-9FD3875434B9@holtmann.org>
	<2d5cd43e0803100324g683c6bdbl33f9025d9d673512@mail.gmail.com>
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

Hi Manuwela,

> Please can you tell me how to use the L2CAP_LM_MASTER. Should it be  
> defined while socket creation? And due to this switching of role, is  
> it possible to send data simultaneously?? Because, we have tried to  
> multithread and accept connections from multiple devices on the  
> server, but it does not work... only one connection is accepted by  
> server.

the bluez-utils contains a lot of examples on how to use it. Check the  
files l2test.c and rctest.c for example.

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
