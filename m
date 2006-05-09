Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <445991B0.9030208@xmission.com>
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
	 <445189C8.6060602@xmission.com>
	 <1146492165.13358.16.camel@pc7.dolda2000.com>
	 <44561FB6.5000306@xmission.com>
	 <1146567726.13358.40.camel@pc7.dolda2000.com>
	 <445789D6.7030408@xmission.com>
	 <1146709233.13358.73.camel@pc7.dolda2000.com>
	 <445991B0.9030208@xmission.com>
Content-Type: text/plain
Message-Id: <1147144809.25965.51.camel@pc7.dolda2000.com>
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
Date: Tue, 09 May 2006 05:20:09 +0200

On Wed, 2006-05-03 at 23:31 -0600, Brad Midgley wrote:
> > Anyway, I tried it, and it was an *enormous* difference. It is true that
> > the file encoded by the encoder from bluetooth.org is almost twice as
> > large as that encoded by sbcenc as well, but nonetheless, the difference
> > in audio quality was huge.
> 
> twice as large? could be they're using 4 subbands.

I don't entirely remember, but I really think it was using 8 subbands
(when checking with sbcinfo).

> maybe our defaults are too lossy. after calling sbc_init, you can change
> sbc.subbands (default 8), sbc.blocks (default 16), sbc.bitpool (default
> 32). subbands can be 4,8. blocks can be 4,8,12,16. i need to check the
> spec on bitpool ranges.

Except the bitpool value, doesn't that mean that it's already using the
best possible values? Or do lower values of sbc.subbands or sbc.blocks
increase quality?

> (heh, maybe that's what you're getting even now)

Indeed. :)

> a2play "sort of" has a flag for choosing encoder settings (-t for
> thrifty) but it is pretty rough.

Again, wouldn't that make the audio quality worse (given how the thrifty
value only decreases the given values)?

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
