Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4193F258.3000003@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco: help with autoconf cleanup
References: <4193B453.50005@xmission.com>	 <1100199408.12168.24.camel@pegasus>  <4193D3F5.2010505@xmission.com> <1100207774.12168.26.camel@pegasus>
In-Reply-To: <1100207774.12168.26.camel@pegasus>
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
Date: Thu, 11 Nov 2004 16:14:32 -0700

Marcel

>>what do you suggest for packing bits together in a portable way before 
>>putting them on the wire? is there some code somewhere that you can 
>>point to that works in userspace?
> 
> 
> actually I don't understand this question. Please explain to me what do
> you wanna know.

Yeah, I guess I just needed to read up more.

I'm going to be assembling parts of frames like the media packet header. 
I started looking at l2cap_build_cmd to see how you do it in kernel 
space. I see htobs() is the equivalent of __cpu_to_le16 for 16-bit 
values and I see the __attribute__ ((packed)) directives that result in 
a packed struct that can be copied byte for byte into the buffer. I 
think I'm good to go.

I'll probably be running the naming for some of the structures and 
members by you to see if they're ok to eventually go into the bluetooth 
headers.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
