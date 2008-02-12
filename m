Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Feb 2008 10:47:08 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080212091420.4o1zmuk9usoocwck@www.domaingo-webmail.de>
Message-ID: <Pine.LNX.4.64.0802121026580.3841@xena.cft.ca.us>
References: <20080212091420.4o1zmuk9usoocwck@www.domaingo-webmail.de>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Using multiple bluetooth devices or WLAN creates
 sluggish sound
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

On Tue, 12 Feb 2008, mail@saschahoppe.de wrote:

> But whenever I load a webpage via WLAN there is a drop-out in the  
> music output. And when I try to use my Bluetooth mouse simultaneously  
> with music playback everything is over. Whenever I move the mouse the  
> music is totally paused until I stop moving the mouse.
> 
> Isn't bluetooth capable of supporting up to seven simultaneous  
> devices? Wasn't it fixed in Bluetooth 1.2 that WLAN interferes with  
> Bluetooth via Adaptive frequency hopping?

It certainly sounds like trashed packets are not being retransmitted, and 
if the dongle does Bluetooth 2.0 I start wondering about the Volis audio 
gateway.  But my Russian isn't good enough to find the Bluetooth version 
that it supports.

When I play music to headphones and Bluetooth 2.0 is used on both ends, I 
have no trouble with interference from WiFi.  However, this is on a laptop 
machine with an internal Bluetooth transceiver that coordinates with WiFi 
so only one transmits at a time and they avoid transmitting when the other 
service expects a scheduled packet.  (Dell Inspiron 6400 with Dell type 355 
internal Bluetooth and Intel IWL3945abg WiFi.)

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
