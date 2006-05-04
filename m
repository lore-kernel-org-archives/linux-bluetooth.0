Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <445789D6.7030408@xmission.com>
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
	 <445189C8.6060602@xmission.com>
	 <1146492165.13358.16.camel@pc7.dolda2000.com>
	 <44561FB6.5000306@xmission.com>
	 <1146567726.13358.40.camel@pc7.dolda2000.com>
	 <445789D6.7030408@xmission.com>
Content-Type: text/plain
Message-Id: <1146709233.13358.73.camel@pc7.dolda2000.com>
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
Date: Thu, 04 May 2006 04:20:33 +0200

On Tue, 2006-05-02 at 10:33 -0600, Brad Midgley wrote:
> Fredrik
> 
> > I have Windows in a VMware exactly for things like these, so I could
> > test that. However, I could find no such thing on bluetooth.org. In
> > fact, googling for "sbc site:bluetooth.org" only yielded two
> > insignificant results, so I'm beginning to wonder if I'm doing something
> > wrong (whatever that'd be...). Any pointers?
> 
> You can get it but you probably need to be logged into a (free) account:
> 
> https://www.bluetooth.org/foundry/adopters/document/A2DP_Bitstream/en/1/A2DP_Bitstream.zip

I could get it without an account. I find it rather weird that google
didn't find it, but oh well.

Anyway, I tried it, and it was an *enormous* difference. It is true that
the file encoded by the encoder from bluetooth.org is almost twice as
large as that encoded by sbcenc as well, but nonetheless, the difference
in audio quality was huge.

> we can also compare with our floating point implementation which we have
> more faith in.

Is this in the CVS tree? I can't seem to find any other encoder than
sbcenc. (Speaking of which, what's the difference between the "sbc" and
"sbc32" directories?)

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
