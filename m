Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <454D24B2.1030102@xmission.com>
References: <BAY117-F267DA7541D01225F684CB5BFFD0@phx.gbl>
	<454D24B2.1030102@xmission.com>
Date: Wed, 15 Nov 2006 13:20:25 +0800
Message-Id: <1163568025.3396.163.camel@shinybook.infradead.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluetooth-Alsa: Emulate headset on the PC
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sat, 2006-11-04 at 16:39 -0700, Brad Midgley wrote:
> > Has there been any development to use the computer as a bluetooth headset 
> > using SCO in which calls from a handphone could be received on the computer 
> > and played out on the PC's speakers. Something similar to the a2recv 
> > application developed which runs on the A2DP.
> 
> I hear that the asterisk folks have written a plugin of sorts to do that.

OpenPBX (www.openpbx.org) has a chan_bluetooth channel driver module
which does this. I use it a lot for making VoIP (and ISDN-terminated)
calls from a Bluetooth headset, but it does also have support for HS
mode where it talks to a phone. It ought to work for routing a call from
an AG to the computer's speaker/mic (since OpenPBX also has an 'ALSA'
channel driver which does that).

Seems like a little bit of overkill to use OpenPBX for that, but it
ought to work.

There are OpenPBX packages in Fedora Extras.

-- 
dwmw2


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
