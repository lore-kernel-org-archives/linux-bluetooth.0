Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4191AB4B.8060701@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>	 <418E6FBF.3090409@xmission.com> <1099863224.6896.57.camel@pegasus>
In-Reply-To: <1099863224.6896.57.camel@pegasus>
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
Date: Tue, 09 Nov 2004 22:46:51 -0700

Marcel

[avdtp]
> This was not what I meant. You must open the signal channel first and
> then open the media channel. This is the basic mode.
 >
>>I don't know where to start with the avdtp protocol handling. Can you 
>>give me a pointer?
> 
> I think you should start with a simple test implementation in user space
> that fulfils your purpose. I haven't understand the AVDTP enough to move
> any part of it into the kernel at the moment.

The avdtp document is almost 150 pages long and very terse! It looks to 
me like I start with sdp to find the avdtp psm, open it with raw l2cap, 
then do stream endpoint discovery and get capabilities, set stream 
config, open the l2cap stream psm and send the stream. I am planning to 
write an app that sends one of the reference sbc streams.

What should the sdp search look like? The more promising sdptool options 
I found didn't work flawlessly... I'm assuming 0x110d is A2DP and 0x19 
is AVDTP (http://www.bluetooth.org/assigned-numbers.htm redirects to 
http://www.bluetoothsig.org/assigned-numbers/ which won't resolve). What 
is the uint16 under AVDTP trying to tell us?

sdptool search --bdaddr 00:08:F4:30:05:BB 0x110d
Class 0x110D
Searching for 0x110d on 00:08:F4:30:05:BB ...
Service Name: Audio Sink
Service RecHandle: 0x10002
Service Class ID List:
   "" (0x110b)
Protocol Descriptor List:
   "L2CAP" (0x0100)
     PSM: 25
   "" (0x0019)
     uint16: 0x0
Profile Descriptor List:
   "" (0x110d)
     Version: 0x0100

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
