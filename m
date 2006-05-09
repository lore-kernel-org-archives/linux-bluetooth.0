Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4460B46B.6060203@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
References: <1146183877.13358.7.camel@pc7.dolda2000.com>	 <445189C8.6060602@xmission.com>	 <1146492165.13358.16.camel@pc7.dolda2000.com>	 <44561FB6.5000306@xmission.com>	 <1146567726.13358.40.camel@pc7.dolda2000.com>	 <445789D6.7030408@xmission.com>	 <1146709233.13358.73.camel@pc7.dolda2000.com>	 <445991B0.9030208@xmission.com> <1147144809.25965.51.camel@pc7.dolda2000.com>
In-Reply-To: <1147144809.25965.51.camel@pc7.dolda2000.com>
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
Date: Tue, 09 May 2006 09:25:31 -0600

Fredrik

> Except the bitpool value, doesn't that mean that it's already using the
> best possible values? Or do lower values of sbc.subbands or sbc.blocks
> increase quality?

iirc, changing subbands to 4 will increase the traffic and it looks
computationally simpler. try it out with your problematic audio. also it
isn't clear what allocation method does in terms of quality.

this is interesting at http://www.otolith.com/otolith/olt/sbc.html

"Most SBC encoders use a structure like this. First, a time-frequency
mapping (a filter bank, or FFT, or something else) decomposes the input
signal into subbands. The psychoacoustic model looks at these subbands
as well as the original signal, and determines masking thresholds using
psychoacoustic information."

We are just trying to follow the spec for our codec, so anything
optional like analyzing the psychoacoustic model might as well be rocket
science.

brad



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
