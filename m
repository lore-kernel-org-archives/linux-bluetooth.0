Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Headset reconnection
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43022E86.7080909@xmission.com>
References: <1124215347.21719.31.camel@pc7.dolda2000.com>
	 <43022E86.7080909@xmission.com>
Content-Type: text/plain
Message-Id: <1124754748.21719.82.camel@pc7.dolda2000.com>
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
Date: Tue, 23 Aug 2005 01:52:28 +0200

On Tue, 2005-08-16 at 12:20 -0600, Brad Midgley wrote:
> Fredrik,
> 
> You can get pdfs from bluetooth.org. The relevant ones are 6_headset.pdf 
> and "HFP Spec Version 1_0.pdf"
> 
> Most headsets attempt to make the rfcomm connection to the last-used 
> handset (or only handset if they only keep one pairing) on power-up. The 
> stereo headsets tend to wait until the first click of the answer button.

Indeed -- I tried clicking the button on my headset, and judging from
hcidump, it attempts to connect to my computer (although I have a mono
headset, not a stereo). After that, however, weirdness occurs.

Looking at the data from hcidump, the headset requests a connection, and
the computer replies with a success message. The next package, the
headset disconnects again immediately (and the computer acknowledges
that). Then the headset connects again, and disconnects again, over and
over.

> I don't think we are doing the device class or sdp stuff to even make 
> the headset aware that it can make this connection. On top of that, we 
> need to be listening for connections.

Indeed, I'm not even attempting to public SDP data to the headset at
this point, but if that were the problem, I would think that the headset
wouldn't even attempt to connect to begin with, rather than going into a
loop of connecting and disconnecting all the time, right?

Does anyone have any idea what the cause of this could be?

Fredrik Tolf




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
