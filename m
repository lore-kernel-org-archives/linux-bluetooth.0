Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Chris Boyle <bluez-devel@cmb.is-a-geek.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: snd-bt-sco problem
Message-ID: <20041208103449.GC2258@zeus.galaxy.org.uk>
References: <20041206225609.GA1177@zeus.galaxy.org.uk> <cp3mkk$m7t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cp3mkk$m7t$1@sea.gmane.org>
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
Date: Wed, 8 Dec 2004 10:34:49 +0000

On Tue, Dec 07, 2004 at 08:37:56AM +0100, Sebastian Roth wrote:
> Please post the ouput of `hciconfig hci0 revision'

zeus:~# hciconfig hci0 revision
hci0:	Type: USB
	BD Address: 00:0B:0D:40:6C:63 ACL MTU: 120:20  SCO MTU: 64:0
	Unsupported manufacturer

> The second issue was that all "sound-apps" were blocking (hanging) 
> without playing any sound. My headsets (both from Anycom) must be 
> activated with the switch to recieve the sound. Just like answer the 
> telephone.

As mentioned in reply to Brad Midgley, this established a successful
connection (pressing the volume buttons affected alsamixer), but I
still couldn't actually get any audio to flow in either direction,
despite continuous SCO data packets seen with hcidump, although only in
one direction.

"> SCO data: handle 0x0100 dlen 24"

-- 
Chris Boyle - http://cmb.is-a-geek.org/
GPG: B7D86E0F, MSN: shortcipher@hotmail.com, ICQ: 24151961,
AIM: kerneloops, Yahoo: kerneloops, IRC: cmb on irc.uwcs.co.uk


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
