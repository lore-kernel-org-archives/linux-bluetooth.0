Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 16 May 2007 12:35:51 +0200
MIME-Version: 1.0
Message-Id: <200705161235.51289.fernando@bluexare.org>
Subject: [Bluez-devel] How I can select between 2 bluetooth devices?
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

Hello,
I'm working in an application that scans for bluetooth devices and send some 
content to they...

Due to several issues, I need to separate the action scan and send between two 
devices...

I have the code for doing this in one bluetooth device, and I don't know very 
well how it works, but I have read it some times...

But I don't find where i can select which bluetooth device I want to use to 
doing one method or other...

I have seen that "OBEX_Init" creates a handle to manage the conection..., but 
it can be select which bluetooth device select for doing this handle?

Thank you very much and I hope somebody understand me.

Fernando

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
