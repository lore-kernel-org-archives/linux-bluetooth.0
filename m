Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A4E200.9000601@xmission.com>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	 <1101191260.26578.43.camel@pegasus>
	 <20041123074829.7f978ce7.henryk@ploetzli.ch>
	 <1101201897.26578.54.camel@pegasus>
	 <20041123204901.776fe240.henryk@ploetzli.ch>
	 <1101243809.27351.18.camel@pegasus>
	 <20041124042114.5e1fee94.henryk@ploetzli.ch>
	 <1101272477.27351.67.camel@pegasus>  <41A43E8A.8030602@xmission.com>
	 <1101307146.27351.104.camel@pegasus>  <41A4C6A8.2080508@xmission.com>
	 <1101318257.27351.138.camel@pegasus>  <41A4E200.9000601@xmission.com>
Content-Type: text/plain
Message-Id: <1101362826.7538.65.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 25 Nov 2004 07:07:06 +0100

Hi Brad,

> Too bad 0xff is an invalid media payload header or we could work out a 
> way to send it regardless of which headset is listening.
> 
> You were saying there is a way to tell the aiptek is listening...

the code for device detection is in the CVS now. The magic word is
device ID.

> The current rcplay works fine with this headset. Something must have 
> changed since the last time I tried. (Even streams like 5 which don't 
> work with a2play work with rcplay.) I just wish we knew that sbc over 
> rfcomm was an official part of the a2dp profile.

The only advantage of using A2DP and thus AVDTP is that it is based on
RTP, but actually the AVDTP basic mode is nothing more or less than a
simple stream without flow control.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
