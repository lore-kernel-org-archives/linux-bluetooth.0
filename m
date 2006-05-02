Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4456E4DF.5000601@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
References: <1146183877.13358.7.camel@pc7.dolda2000.com>	 <445189C8.6060602@xmission.com>	 <1146492165.13358.16.camel@pc7.dolda2000.com>	 <44561FB6.5000306@xmission.com> <6297d67c0605012039x618add3bq2b29b9ad584c609e@mail.gmail.com>
In-Reply-To: <6297d67c0605012039x618add3bq2b29b9ad584c609e@mail.gmail.com>
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
Date: Mon, 01 May 2006 22:49:35 -0600

Mayank

> http://www.assisttechnology.co.uk/documents/Sonorix_Bluetooth_Headset-Pamphlet.pdf

Nice find.

It brings up an interesting challenge. When using this headset, the
driver should have access to the encoded audio so it can choose whether
it's appropriate to decode the stream and then encode it in sbc or if it
can pass the stream as-is to the set. I'll bet a gst bin could be
constructed that would configure its elements accordingly for the input
type and the headset caps.

iirc, a2play assumes the first codec reported from the set is sbc. we
should test it with the sonorix if somebody here has it to make sure we
handle multiple codec capabilities properly.

A bit of good news. It takes a couple of tries to get gxine to talk to
my a2dp headset via the newly working plugin, but once it works the
audio is very close to being in sync with the video and it is pretty
solid for the duration of playing some video.

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
