Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445189C8.6060602@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
In-Reply-To: <1146183877.13358.7.camel@pc7.dolda2000.com>
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
Date: Thu, 27 Apr 2006 21:19:36 -0600

Fredrik

> I just got a pair of Motorola HT820 bluetooth headphones, which support
> A2DP and work with a2play. However, the audio fidelity could definitely
> be a lot better. I'm no audiophile, but it sounds to me as though the
> higher frequency bands ("higher" as in, I'd guestimate, ~10 kHz and
> above) are seriously distorted (I can't put a better word on it than
> that they are completely transformed into "chirping"). All the lower
> bands are completely unaffected as far as I can hear, though.

I noticed some quality loss at high frequencies, such as high notes on a
violin, possibly when using fixed point to build libsbc. It is subtle.
On the other hand, if you hear an unexpected "pop" using fixed point,
it's definitely an overflow error in the encoder. There's still a
problem in there I didn't hunt down.

Steven Singer suggested we to track the error "K" after an
encode-decode. K is derived from the root-mean-square error. We could
use this to rule out a misbehaving codec.

It doesn't help that we're typically decoding mp3 and reencoding in sbc.
Loss is really compounded. Try to test with something in a lossless
format or with a high-quality first-generation mp3 or ogg.

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
