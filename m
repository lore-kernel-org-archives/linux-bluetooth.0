Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <44561FB6.5000306@xmission.com>
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
	 <445189C8.6060602@xmission.com>
	 <1146492165.13358.16.camel@pc7.dolda2000.com>
	 <44561FB6.5000306@xmission.com>
Content-Type: text/plain
Message-Id: <1146567726.13358.40.camel@pc7.dolda2000.com>
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
Date: Tue, 02 May 2006 13:02:06 +0200

On Mon, 2006-05-01 at 08:48 -0600, Brad Midgley wrote:
> Fredrik
> 
> >>It doesn't help that we're typically decoding mp3 and reencoding in sbc.
> >>Loss is really compounded.
> > 
> > 
> > Indeed, that seems to be the problem. I was always under the
> > (uninformed) impression that SBC was lossless, but I just tried
> > re-encoding an MP3 to SBC and playing that SBC with sbcenc and sbcdec,
> > and the exact same audio artifacts are showing themselves when I play
> > back to my normal speaker system as through the headphones.
> 
> You haven't ruled out our implementation of sbc however. We could have
> problems still. Also, there are also some defaults for encoding that
> although set fairly high are not at the max iirc.
> 
> There is/was a reference SBC encoder that is a windows executable
> somewhere at bluetooth.org. Testing with it would let us rule out (or
> implicate) our implementation.

I have Windows in a VMware exactly for things like these, so I could
test that. However, I could find no such thing on bluetooth.org. In
fact, googling for "sbc site:bluetooth.org" only yielded two
insignificant results, so I'm beginning to wonder if I'm doing something
wrong (whatever that'd be...). Any pointers?

> The spec allows us to negotiate a different codec with the headset. SBC
> is the only required codec. fwiw, I've never seen a headset that accepts
> mp3 or others. I should modify a2play to flag these so they would be
> easier to spot.

Unfortunately, that seems to be no relief in this case. a2play gets only
one acp_seid_info from the headset, so I guess that means that it only
supports SBC, correct?

Fredrik Tolf




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
