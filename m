Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <d9a6586e0605041028t3c3499e8t25f1dae3a82c978f@mail.gmail.com>
From: "Shawn Rutledge" <shawn.t.rutledge@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
In-Reply-To: <4456E4DF.5000601@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
	 <445189C8.6060602@xmission.com>
	 <1146492165.13358.16.camel@pc7.dolda2000.com>
	 <44561FB6.5000306@xmission.com>
	 <6297d67c0605012039x618add3bq2b29b9ad584c609e@mail.gmail.com>
	 <4456E4DF.5000601@xmission.com>
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
Date: Thu, 4 May 2006 10:28:06 -0700

On 5/1/06, Brad Midgley <bmidgley@xmission.com> wrote:
> It brings up an interesting challenge. When using this headset, the
> driver should have access to the encoded audio so it can choose whether
> it's appropriate to decode the stream and then encode it in sbc or if it
> can pass the stream as-is to the set. I'll bet a gst bin could be
> constructed that would configure its elements accordingly for the input
> type and the headset caps.

What about the plan to support A2DP via ALSA?

Maybe there needs to be a new kind of sound device (/dev/sound/play or
something) which for typical sound hardware, does the decoding, and
for A2DP can either decode or send the packets across, depending on
whether it can negotiate a compatible decoder on the device.  Having
it work only with one library/toolkit like gstreamer is kindof
limiting.  And some day, I bet there will be A2DP support for even
more codecs.  FLAC would be awesome (but you'd need EDR I suppose).=20
So say if the device supports SBC, MP3 and FLAC, you could send MP3
directly, and encode everything else as FLAC.  A player program would
only need to open the /dev file and write MP3/Ogg/whatever packets to
the device, after stripping off any metadata.

The ALSA A2DP driver was supposed to be in userspace anyway, right?


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
