Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] more encoder stuff
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A67548.90805@dark-reality.de>
References: <41A56774.1000308@xmission.com>
	 <20041125071423.10e449c3.henryk@ploetzli.ch>
	 <1101365484.7538.74.camel@pegasus>
	 <20041126000655.1a762210.henryk@ploetzli.ch>
	 <1101425014.6465.39.camel@pegasus>  <41A67548.90805@dark-reality.de>
Content-Type: text/plain
Message-Id: <1101429888.6465.47.camel@pegasus>
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
Date: Fri, 26 Nov 2004 01:44:48 +0100

Hi Lars,

> | we can optimize at any time if needed, because the SBC API should hide
> | this stuff. For me this sounds perfect for a diploma thesis for someone
> | interested in audio codec stuff and Bluetooth.
> 
> *raising hand*
> 
> thing is, on modern CPU you won't get much speedup with fixed point
> stuff, because the main advantage was eliminated by Intel when they
> build the pseudo-pipes into their FPU's. That's why id used floating
> point operations for gfx for the first time, making life for non-Pentium
> owners really hard. AMD also has the pseudo-pipes, and modern
> multiplication/devision on FPU is very fast.
> 
> But of course there are still some cycles to kill in audio processing
> always. I'll advertise this project to my professor...

a non floating point version is interesting for embedded platforms and
not all desktops are running with a 3 GHz processor. I think what the
MAD library does is very good and their MP3 decoding is fast. Running
top shows a very nice CPU load. However we can't simply copy their
stuff, because their code is under GPL only and I wanna keep the SBC
library under LGPL.

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
