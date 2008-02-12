Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802121139p12c7e8d4y73e6d1cd995a0075@mail.gmail.com>
Date: Tue, 12 Feb 2008 12:39:32 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0802121001010.3841@xena.cft.ca.us>
MIME-Version: 1.0
References: <000e01c86d90$827b5c60$87721520$@de>
	<Pine.LNX.4.64.0802121001010.3841@xena.cft.ca.us>
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

Hey

> I'm not a codec guru, but my experience with SBC has not been wonderful.

the codec settings may make a difference here. 4 subband-encoded audio
sounds better. There are also parts of the code we will target for
better numerical accuracy once some bugfixes are complete.

for devel-related issues, see http://wiki.bluez.org/wiki/SBC

> (Does the Bluetooth stack have a feature to swallow SBC coded material
> directly, rather than insisting that the client decode SBC to raw, then the
> audio service re-codes raw to SBC?)

yes. If you use gstreamer, you can separate a2dp transmission from the
codec. It can accept sbc coded material and with a gstreamer patch it
can accept mp3 material (provided your headset has an mp3 decoder).

> > If the CRC8 is wrong, does sbc_decode function conceals the lost frame? If
> > not, did you hear anything about a packet loss concealment algorithm for
> > SBC? Any work on that?

there is no attempt at packet loss concealment, but we're not opposed
to the idea :)

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
