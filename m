Return-Path: <cyrus@holtmann.org>
Message-Id: <611B2C34-999E-411F-802F-95867D6E9DA0@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: sidibebinta@yahoo.com
In-Reply-To: <66945.28299.qm@web57404.mail.re1.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 7 Mar 2008 19:38:24 +0100
References: <66945.28299.qm@web57404.mail.re1.yahoo.com>
Cc: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>,
	bintasidibeh@hotmail.com
Subject: Re: [Bluez-users] SDP discovery not working
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

Hi,

> i need help with my bluetooth project. i have two boards TS7300 and  
> i have attached Dlink DT-120 on both. For my project, one is the  
> server and the other is the client. i want to have sevices offered  
> by my server so that my client can just connect to my servers SDP  
> server to get the port numbers. When i hard code the port number i  
> am using, my client can send message to my service...good. Now i  
> went a step ahead and tried to register a service on my server but  
> it fails to connect to local sdp server.
>

you have to use "sdptool browse local" for that.

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
