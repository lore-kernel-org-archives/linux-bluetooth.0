Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445A40CE.9000509@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
References: <1146183877.13358.7.camel@pc7.dolda2000.com>	 <445189C8.6060602@xmission.com>	 <1146492165.13358.16.camel@pc7.dolda2000.com>	 <44561FB6.5000306@xmission.com>	 <6297d67c0605012039x618add3bq2b29b9ad584c609e@mail.gmail.com>	 <4456E4DF.5000601@xmission.com> <d9a6586e0605041028t3c3499e8t25f1dae3a82c978f@mail.gmail.com>
In-Reply-To: <d9a6586e0605041028t3c3499e8t25f1dae3a82c978f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 04 May 2006 11:58:38 -0600

Shawn

> Maybe there needs to be a new kind of sound device (/dev/sound/play or
> something) which for typical sound hardware, does the decoding, and
> for A2DP can either decode or send the packets across, depending on
> whether it can negotiate a compatible decoder on the device.  Having
> it work only with one library/toolkit like gstreamer is kindof
> limiting. 

alsa doesn't transparently provide an api like this. it's either
something on top of alsa or approximated by writing a plugin for each
type of codec. alsa plugins are only supposed to know about some very
simple encoding audio schemes though.

ironic that you are making the case for gstreamer at the same time you
say it's limiting. :)

> The ALSA A2DP driver was supposed to be in userspace anyway, right?

We have the alsa plugin mostly working now. We haven't abandoned that
idea. alsa plugins are relatively simple in what they expose to the client.

i plan to keep improving the alsa plugin and get into gstreamer to get
some of the more advanced stuff. i have a little picture illustrating
how we tear btsco into two projects that go into these two camps.

http://bluetooth-alsa.sourceforge.net/wavez.png

Brad


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
