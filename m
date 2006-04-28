Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1146183877.13358.7.camel@pc7.dolda2000.com>
Mime-Version: 1.0
Subject: [Bluez-devel] Motorola HT820 audio fidelity
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
Date: Fri, 28 Apr 2006 02:24:37 +0200

Hi all!

I just got a pair of Motorola HT820 bluetooth headphones, which support
A2DP and work with a2play. However, the audio fidelity could definitely
be a lot better. I'm no audiophile, but it sounds to me as though the
higher frequency bands ("higher" as in, I'd guestimate, ~10 kHz and
above) are seriously distorted (I can't put a better word on it than
that they are completely transformed into "chirping"). All the lower
bands are completely unaffected as far as I can hear, though.

A friend told me that they work perfectly fine with his BT-enabled cell
phone. I haven't tried myself, though, since my phone doesn't support
A2DP.

I don't know A2DP very well -- could this be the result of bad
transmission? I'd guess not, since when I move away, the audio tends to
break up rather than lose quality.

I found this little tidbit on Wikipedia:

 Most bluetooth stacks implement the SCMS-T copyright protection. In
 these cases it is not possible to connect the A2DP headphones for high
 quality audio. E.g. the Motorola HT820 can be used for high quality
 audio only with certain versions of the Toshiba bluetooth stack.
 (From <http://en.wikipedia.org/wiki/Bluetooth>)

I don't know if that is related to this, but I thought I should at least
mention it.

Does anyone know what could be at fault?

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
