Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A67548.90805@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] more encoder stuff
References: <41A56774.1000308@xmission.com>	 <20041125071423.10e449c3.henryk@ploetzli.ch>	 <1101365484.7538.74.camel@pegasus>	 <20041126000655.1a762210.henryk@ploetzli.ch> <1101425014.6465.39.camel@pegasus>
In-Reply-To: <1101425014.6465.39.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 26 Nov 2004 01:14:00 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Henryk,
|
|
|>>The MAD library (www.underbit.com/products/mad/) is using fixed-point
|>>integer computation. Do you think it is possible to do the same thing
|>>for SBC? Will it give us some extra performance?
|>
|>Unfortunately I'm not familiar with fixed-point arithmetics, especially
|>with how to handle multiplication. So if anyone who has done this before
|>would step forward ...
|>
|>Well, I did some naive tests: I probably did something wrong, but I'm
|>not seeing any significant difference between floating point and fixed
|>point (that is: integer). For multiplication the difference is not
|>noticeable (1.38s vs. 1.36s in my test program) and for addition it is
|>not that big (0.77s vs. 0.47s).
|>
|>I guess we'll be fine using floating point as long as there is an FPU.
|
|
| we can optimize at any time if needed, because the SBC API should hide
| this stuff. For me this sounds perfect for a diploma thesis for someone
| interested in audio codec stuff and Bluetooth.

*raising hand*

thing is, on modern CPU you won't get much speedup with fixed point
stuff, because the main advantage was eliminated by Intel when they
build the pseudo-pipes into their FPU's. That's why id used floating
point operations for gfx for the first time, making life for non-Pentium
owners really hard. AMD also has the pseudo-pipes, and modern
multiplication/devision on FPU is very fast.

But of course there are still some cycles to kill in audio processing
always. I'll advertise this project to my professor...

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBpnVHQWC6DTWkDAoRAgkgAKDAZ9hRDYGRP4sNtuJKFFu/0zcomQCgmG8v
UoPSMR/LGba03dC7OsdwkUM=
=vL5b
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
