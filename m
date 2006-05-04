Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445991B0.9030208@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
References: <1146183877.13358.7.camel@pc7.dolda2000.com>	 <445189C8.6060602@xmission.com>	 <1146492165.13358.16.camel@pc7.dolda2000.com>	 <44561FB6.5000306@xmission.com>	 <1146567726.13358.40.camel@pc7.dolda2000.com>	 <445789D6.7030408@xmission.com> <1146709233.13358.73.camel@pc7.dolda2000.com>
In-Reply-To: <1146709233.13358.73.camel@pc7.dolda2000.com>
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
Date: Wed, 03 May 2006 23:31:28 -0600

Fredrik

>>> I have Windows in a VMware exactly for things like these, so I could
>>> test that. However, I could find no such thing on bluetooth.org. In
>>> fact, googling for "sbc site:bluetooth.org" only yielded two
>>> insignificant results, so I'm beginning to wonder if I'm doing something
>>> wrong (whatever that'd be...). Any pointers?
>> You can get it but you probably need to be logged into a (free) account:
>>
>> https://www.bluetooth.org/foundry/adopters/document/A2DP_Bitstream/en/1/A2DP_Bitstream.zip
> 
> I could get it without an account. I find it rather weird that google
> didn't find it, but oh well.

google won't necessarily "deep link" into sites like bluetooth.org

> Anyway, I tried it, and it was an *enormous* difference. It is true that
> the file encoded by the encoder from bluetooth.org is almost twice as
> large as that encoded by sbcenc as well, but nonetheless, the difference
> in audio quality was huge.

twice as large? could be they're using 4 subbands.

maybe our defaults are too lossy. after calling sbc_init, you can change
sbc.subbands (default 8), sbc.blocks (default 16), sbc.bitpool (default
32). subbands can be 4,8. blocks can be 4,8,12,16. i need to check the
spec on bitpool ranges.

>> we can also compare with our floating point implementation which we have
>> more faith in.
> 
> Is this in the CVS tree? I can't seem to find any other encoder than
> sbcenc. (Speaking of which, what's the difference between the "sbc" and
> "sbc32" directories?)

a lot of this will change, but for now, "sbc" has floating, 64-bit
fixed, and 32-bit fixed and chooses one at compile time. you'll get
floating point implementation if you configure without --enable-fixed.
(heh, maybe that's what you're getting even now)

sbc32 was the precursor to separating out the library and has only the
32-bit implementation. it probably isn't even being built.

a2play "sort of" has a flag for choosing encoder settings (-t for
thrifty) but it is pretty rough.

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
