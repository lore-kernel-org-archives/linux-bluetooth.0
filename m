Return-Path: <pfavr@mip.sdu.dk>
Message-ID: <40E803E1.1090703@mip.sdu.dk>
Date: Sun, 04 Jul 2004 15:19:29 +0200
From: Peter Favrholdt <pfavr@mip.sdu.dk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
References: <003401c45c2b$b6eab240$0364a8c0@haruo>	 <1088359746.3774.20.camel@pegasus>  <000c01c45d2c$ed2e5f80$0364a8c0@haruo>	 <1088442828.6030.27.camel@pegasus>  <002801c45dfb$c533d760$0364a8c0@haruo>	 <1088530908.6030.310.camel@pegasus>  <000d01c45ebe$72d6e660$0264a8c0@haruo>	 <1088619095.4540.126.camel@pegasus>  <000a01c461a4$e79be160$0364a8c0@haruo> <1088941116.4639.17.camel@pegasus>
In-Reply-To: <1088941116.4639.17.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
<snip>
> I will attend there and my plan is to present something very
> nice, but right now I am not sure what it will be. Any proposals?

How about a Logitech bt headset working under linux as an alsa soundcard? 
(Just kidding :-)

Anyway, if anyone is interested, I've made a patch of the snd-bt-sco stuff 
against the 2.6.6 kernel. It is available here:

   http://how.dk/~pfavr/snd_bt_sco-kernel-2.6.6.patch

I'm currently trying with 2.6.7, although the above patch misses a hunk in 
/drivers/bluetooth/hci_usb.c - I'll just try to see if it works even without 
that hunk applied.

As usual, any guidance or suggestions on this matter is very welcome!

Best regards,

Peter
