Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Cedric Hottier <chottier@nerim.net>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <200304122336.49369.chottier@nerim.net>
Subject: [Bluez-users] btobex and fisio820/825
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 12 Apr 2003 23:36:49 +0200

Hi all,

I tried to transfer some pictures from my PC to my fisio 825 with btobex.
I had to change a little bit the obex.c file to make it work.

I removed the first OBEX_ObjectAddHeader call :
	//OBEX_ObjectAddHeader(handle, object,
	//	OBEX_HDR_CONNECTION, hd, 4, OBEX_FL_FIT_ONE_PACKET);
and I replaced OBEX_FL_FIT_ONE_PACKET by 0 in the others OBEX_ObjectAddHeader 
call.

I tried to understand what does mean the OBEX_HDR_CONNECTION in reading OBEX 
spec, but I still do not understand why this OBEX header makes the transfer 
failed.

Does anybody have experience on transfering files with an other phone ?
Is the transfer failing due to a limitation of the OBEX implementation in 
fisio ?

Cheers

Cedric





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
