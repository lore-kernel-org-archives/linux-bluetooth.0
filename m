Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco: help with autoconf cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4193F258.3000003@xmission.com>
References: <4193B453.50005@xmission.com>
	 <1100199408.12168.24.camel@pegasus>  <4193D3F5.2010505@xmission.com>
	 <1100207774.12168.26.camel@pegasus>  <4193F258.3000003@xmission.com>
Content-Type: text/plain
Message-Id: <1100221344.12168.40.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 12 Nov 2004 02:02:24 +0100

Hi Brad,

> >>what do you suggest for packing bits together in a portable way before 
> >>putting them on the wire? is there some code somewhere that you can 
> >>point to that works in userspace?
> > 
> > actually I don't understand this question. Please explain to me what do
> > you wanna know.
> 
> Yeah, I guess I just needed to read up more.
> 
> I'm going to be assembling parts of frames like the media packet header. 
> I started looking at l2cap_build_cmd to see how you do it in kernel 
> space. I see htobs() is the equivalent of __cpu_to_le16 for 16-bit 
> values and I see the __attribute__ ((packed)) directives that result in 
> a packed struct that can be copied byte for byte into the buffer. I 
> think I'm good to go.
> 
> I'll probably be running the naming for some of the structures and 
> members by you to see if they're ok to eventually go into the bluetooth 
> headers.

please don't think about any kernel part at this time. It is not the
time to do any kernel work. The l2cap_build_cmd() is by the way the
wrong place to look at, because AVDTP is L2CAP payload.

If we get a program that can play pre-encoded SBC files on an A2DP
headphone then this is a good start. This program should be in userspace
first so we can learn through it. Remember that RFCOMM and HID were
implemented both in userspace first, before we did the kernel version.

After this is working, we need a subband codec implementation for the
ALSA library and then we should really start doing the kernel version of
the AVDTP. I don't wanna scare you, but it must look like the RFCOMM
one. It needs to do its own L2CAP connection setup.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
