Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A67F77.3040501@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] more encoder stuff
References: <41A56774.1000308@xmission.com>	 <20041125071423.10e449c3.henryk@ploetzli.ch>	 <1101365484.7538.74.camel@pegasus>	 <20041126000655.1a762210.henryk@ploetzli.ch>	 <1101425014.6465.39.camel@pegasus>  <41A67548.90805@dark-reality.de> <1101429888.6465.47.camel@pegasus>
In-Reply-To: <1101429888.6465.47.camel@pegasus>
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
Date: Fri, 26 Nov 2004 01:57:27 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,
|
|
|>| we can optimize at any time if needed, because the SBC API should hide
|>| this stuff. For me this sounds perfect for a diploma thesis for someone
|>| interested in audio codec stuff and Bluetooth.
|>
|>*raising hand*
|>
|>thing is, on modern CPU you won't get much speedup with fixed point
|>stuff, because the main advantage was eliminated by Intel when they
|>build the pseudo-pipes into their FPU's.
|>But of course there are still some cycles to kill in audio processing
|>always. I'll advertise this project to my professor...
|
|
| a non floating point version is interesting for embedded platforms

good argument

| and
| not all desktops are running with a 3 GHz processor. I think what the
| MAD library does is very good and their MP3 decoding is fast.

Depending on the purpose of the calculations fixed point calculations
add an overhead that can - in some situations - eat up the speed gain
compared to true fpu.

But as you said, not all systems run on CPU/FPU combinations with the
specs of a modern desktop computer, and in fact this is important for
bluetooth stuff as many portable devices also use linux nowadays.

So I think we both have a point, but yours matches the BlueZ situation
much better than mine :)

Not used to it. Strange enough, as I program for PalmOS quite a lot...

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBpn93QWC6DTWkDAoRAhETAJ9dthtjsNEM0Acxt3GSDVmzg8g/kACgg644
eNFC/R0TmjKb9hKu0Y5fR00=
=2HW2
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
