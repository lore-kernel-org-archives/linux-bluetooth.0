Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Feb 2008 10:21:57 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000e01c86d90$827b5c60$87721520$@de>
Message-ID: <Pine.LNX.4.64.0802121001010.3841@xena.cft.ca.us>
References: <000e01c86d90$827b5c60$87721520$@de>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] FW: Loss concealment with SBC codec
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Tue, 12 Feb 2008, Christian Hoene wrote:

> I am considering to include the BlueZ SBC codec into Ekiga in order to
> support music over Internet Telephony. I have not understood the SBC codec
> fully therefore I need a clarification on the following issues.

I'm not a codec guru, but my experience with SBC has not been wonderful.  
Using Motorola HT-820 phones, comparing Bluetooth/A2DP/SBC vs. the same 
phones connected by the optional wire, the wired connection has very 
noticeably better treble and bass response and is subjectively noticeably 
clearer, on Chopin played directly off the CD (no other compression to 
confound the judgment).  

While there's nothing wrong with including SBC in Ekiga, it should be 
scored lower in negotiations than Vorbis (best in my opinion, plus having 
the more sanitary politics) or MP3 (close second), among the commonly 
available music codecs.  But if the other end knows it's going to be piping 
the music to Bluetooth phones, you may or may not win by encoding as SBC at 
the source, and the Bluetooth end might usefully insist on SBC.

(Does the Bluetooth stack have a feature to swallow SBC coded material 
directly, rather than insisting that the client decode SBC to raw, then the 
audio service re-codes raw to SBC?)

> If the CRC8 is wrong, does sbc_decode function conceals the lost frame? If
> not, did you hear anything about a packet loss concealment algorithm for
> SBC? Any work on that?

Again I'm not a codec guru, but when I read the spec for SBC I didn't 
notice any such thing, but I could have missed it.  In my experience, when 
a packet is trashed and USB-2.0 retransmission is impossible, you just get 
a brief gap in the sound.  It sounds like popcorn, loudness proportional to 
the loudness of the surrounding music.  The effect is a lot worse if you 
have a USB-1.1 dongle (I mistakenly bought 2 of them), which does no 
retransmission.

Hope this helps!

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
