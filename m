Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Wrong errno
From: Marcel Holtmann <marcel@holtmann.org>
To: Xavier Garreau <xavier@xgarreau.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200310281437.01092.xavier@xgarreau.org>
References: <200310281437.01092.xavier@xgarreau.org>
Content-Type: text/plain
Message-Id: <1067441911.24041.284.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 29 Oct 2003 16:38:25 +0100

Hi Xavier,

> I'm currently developping an application with bluez. I wrote a little code to 
> test the alarm behaviour with bluez sockets code.
> 
> The connect and read (or recv) get interrupted but errno is set to ESPIPE (29) 
> instead of EINTR (4). Does any one of you guys know why i'm getting this 
> illegal seek operation errno ?

I don't see any usage of ESPIPE in L2CAP, so this can be a general
behaviour of the socket code. What errno do you get if you try this with
TCP socket code?

BTW what kernel and/or patches do you use?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
