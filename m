Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 23 Apr 2007 08:07:32 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
In-reply-to: <462B9264.7030604@xmission.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <7.0.1.0.2.20070423075933.03d4a650@dubai.oilfield.slb.com>
MIME-version: 1.0
References: <7.0.1.0.2.20070422102711.03d6a030@dubai.oilfield.slb.com>
	<462B9264.7030604@xmission.com>
Subject: Re: [Bluez-devel] Unable to set number of SCO buffers : please
 upgrade your Kernel !
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad,

Thanks - I guess I was fooled by the "upgrade your plugz to head" 
part of the phrase. I deleted my plugz download directory and 
recompiled it from the latest cvs with the same results.

The earliest patch in the cvs is v2.0 for 2.6.18-mh7 - given that I 
have 2.6.12 (DSL-N is like Knoppix, you cannot easily update the 
kernel), is there a patch archive somewhere with a patch closer to my 
kernel or do I need to try and apply the patch "manually"?

John

At 20:50 22-04-07, you wrote:
>John
>
> > I can compile plugz without problems
>
>if you just checked plugz out, then that's equivalent to an old checkout
>that you updated with "cvs update -d"
>
>in your case you need the kernel patch under plugz/patches
>
>brad
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by DB2 Express
>Download DB2 Express C - the FREE version of DB2 express and take
>control of your XML. No limits. Just data. Click to get it now.
>http://sourceforge.net/powerbar/db2/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
