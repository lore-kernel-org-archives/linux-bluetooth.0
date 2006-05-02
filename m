Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445789D6.7030408@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
References: <1146183877.13358.7.camel@pc7.dolda2000.com>	 <445189C8.6060602@xmission.com>	 <1146492165.13358.16.camel@pc7.dolda2000.com>	 <44561FB6.5000306@xmission.com> <1146567726.13358.40.camel@pc7.dolda2000.com>
In-Reply-To: <1146567726.13358.40.camel@pc7.dolda2000.com>
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
Date: Tue, 02 May 2006 10:33:26 -0600

Fredrik

> I have Windows in a VMware exactly for things like these, so I could
> test that. However, I could find no such thing on bluetooth.org. In
> fact, googling for "sbc site:bluetooth.org" only yielded two
> insignificant results, so I'm beginning to wonder if I'm doing something
> wrong (whatever that'd be...). Any pointers?

You can get it but you probably need to be logged into a (free) account:

https://www.bluetooth.org/foundry/adopters/document/A2DP_Bitstream/en/1/A2DP_Bitstream.zip

we can also compare with our floating point implementation which we have
more faith in.

> Unfortunately, that seems to be no relief in this case. a2play gets only
> one acp_seid_info from the headset, so I guess that means that it only
> supports SBC, correct?

It wouldn't be hard to add mp3 support. We might have to know just a bit
of mp3 smarts like how to break up a stream into packets appropriately.
I don't think we'd ever want to encode mp3 on the fly so it's not as
complex as sbc support.

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
