Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <015501c39df9$714a5420$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: <bluez-devel@lists.sourceforge.net>
References: <200310281437.01092.xavier@xgarreau.org> <3F9EBF48.2070401@prim-time.fr>
Subject: Re: [Bluez-devel] Wrong errno
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Wed, 29 Oct 2003 09:48:36 +0100

Hi,

This code does not use alarm, sigaction, signal or siginterrrupt and thus
won't be interrupted by SIGALRM. My question is about bluez socket
implementation behaviour when a system call is interrupted.

> I don't know why ESPIPE error.
> But after a connect I negociate the MTU and MRU and I haven'y noticed
> any error with a recv() :
>
> (g_error()/g_message are GTK+ functions)
>
> struct l2cap_options opts;
> int  opt;
> .......

Regards,
-- 
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
