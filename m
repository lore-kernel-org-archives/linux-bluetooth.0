Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41922031.4090204@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: siemens s55
References: <20040727145602.30665.qmail@webmail.aruba.it>            <1090940808.4845.21.camel@pegasus> <20041110120818.14111.qmail@webmail2.aruba.it>
In-Reply-To: <20041110120818.14111.qmail@webmail2.aruba.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Nov 2004 07:05:37 -0700

hi

we have wacky problems with bluetooth-alsa when you connect to the 
handsfree rather than the headset profile. does sdptool show you are 
connecting to the channel for the phone's headset profile?

brad

ubaldo wrote:
> I try to use the computer as a bluetooth headphone for the S55, it works 
> great with nokia and motorola, but not yet with the siemens, I think, 
> maybe, I need to send some "special" AT command (at+ckpd=200 return 
> error) or maybe I need to configure something with spdtool to let the 
> S55 know that it is working with a bt-headphone, any idea about?
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel 
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
