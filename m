Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F55cRz2LaCzuo0000d275@hotmail.com>
Subject: [Bluez-devel] OBEX error code?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 14 Dec 2003 04:01:28 +0000

I made simple obex program that Puts a file on the server..

when the Put() function of OBEX is executed, it returned an error code.. THe 
error code means Insufficient resources? so what resource was insufficient?

when i tried sending a text file maximum of 100 bytes, the Put() function 
was fine... but when i send a jpg file 20K in size, the Put function does 
not succeed and the error code = insufficient resources is returned...

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*. 
http://join.msn.com/?page=features/virus



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
