Return-Path: <palli@pallit.lhi.is>
Message-ID: <415921D4.9000605@pallit.lhi.is>
Date: Tue, 28 Sep 2004 08:33:24 +0000
From: Pall Thayer <palli@pallit.lhi.is>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] accessing info on paired devices
References: <41570BC9.6090109@pallit.lhi.is> <1096359364.4684.28.camel@notepaq>
In-Reply-To: <1096359364.4684.28.camel@notepaq>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

But the link key is in binary form so I can't read it. What I've been 
doing is just sending a single l2ping to each of the discovered devices, 
the ones that are paired and authorized respond, the others time-out and 
are eventually ignored. The only problem is that I end up with a stack 
of PIN request pop-ups for the ones that aren't paired and authorized. 
Not a big deal but somewhat annoying. I tried playing around with the 
security settings in hcid.conf but nothing I did managed to avoid the 
PIN request pop-up.

Pall

Marcel Holtmann wrote:
> Hi Pall,
> 
> 
>>I'm working on a little project that would have to automatically scan 
>>for bluetooth devices (using a little perl script) and then attempt to 
>>connect to them. However, I would prefer if it would only attempt to 
>>connect to devices that have already been paired with the computer (via 
>>bluetooth usb-dongle) and ignore discovered devices that have not been 
>>paired. So, how can I find out which of the discovered devices have been 
>>paired?
> 
> 
> if there exists a link key for this device then they are paired, but the
> problem is that security mode 1 not demands to pair two devices.
> 
> Regards
> 
> Marcel
> 
> 

-- 
_______________________________
Pall Thayer
artist/teacher
http://www.this.is/pallit
http://pallit.lhi.is/panse
_______________________________
