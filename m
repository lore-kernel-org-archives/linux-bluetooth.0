Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20060429110332.81242.qmail@web31006.mail.mud.yahoo.com>
From: Sergey Krivov <krivov@yahoo.com>
Subject: Re: [Bluez-devel] a2dp alsa plugin "better"
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <445295C9.5030004@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 29 Apr 2006 04:03:32 -0700 (PDT)

Brad,

> Sergey,
> 
> This is formatted as if the second statement was
> inside the if. What was
> your intent here?
> 
> 	if (a2dp->state == BT_CONNECTED)
> 		a2dp->num += len / a2dp->frame_bytes; //update
> pointer
> 		a2dp->num %=io->buffer_size;

this code i kept from the previos version of the
plugin. looked at the other alsa pcm codes i guess it
updates the pointer to the current position in the
data buffer. it is returned in the pointer function.

Sergey

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
