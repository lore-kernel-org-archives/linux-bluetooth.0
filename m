Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Motorola HT820 audio fidelity
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <445189C8.6060602@xmission.com>
References: <1146183877.13358.7.camel@pc7.dolda2000.com>
	 <445189C8.6060602@xmission.com>
Content-Type: text/plain
Message-Id: <1146492165.13358.16.camel@pc7.dolda2000.com>
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
Date: Mon, 01 May 2006 16:02:44 +0200

On Thu, 2006-04-27 at 21:19 -0600, Brad Midgley wrote:
> It doesn't help that we're typically decoding mp3 and reencoding in sbc.
> Loss is really compounded.

Indeed, that seems to be the problem. I was always under the
(uninformed) impression that SBC was lossless, but I just tried
re-encoding an MP3 to SBC and playing that SBC with sbcenc and sbcdec,
and the exact same audio artifacts are showing themselves when I play
back to my normal speaker system as through the headphones.

So, at least it's not a hardware or BT stack problem. Is this an
inherent problem in SBC, or is there a way to tune the encoder to
compensate? Is it possibly so that a better encoder could be written
altogether?

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
