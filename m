Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4193D3F5.2010505@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco: help with autoconf cleanup
References: <4193B453.50005@xmission.com> <1100199408.12168.24.camel@pegasus>
In-Reply-To: <1100199408.12168.24.camel@pegasus>
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
Date: Thu, 11 Nov 2004 14:04:53 -0700

Marcel,

> look at the BlueZ libs and utils CVS repository.
...
> This keeps your CVS repository clean.

ok, thanks.

>>btw, I added a sort of placeholder "a2play.c" to the project for sending 
>>preencoded audio to an a2dp player. I want to make sure our autoconf 
>>mess is cleaned up before putting it in the build.
> 
> 
> This is great. Does it work for you already. Do you hear any sound?

no, it's pretty early yet.

what do you suggest for packing bits together in a portable way before 
putting them on the wire? is there some code somewhere that you can 
point to that works in userspace?

brad


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
