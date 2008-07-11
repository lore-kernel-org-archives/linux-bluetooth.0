Return-Path: <cyrus@holtmann.org>
Message-ID: <4877BFBE.70305@evilgenius.de>
Date: Fri, 11 Jul 2008 22:17:02 +0200
From: Martin Karger <martin@evilgenius.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <0a3901c8e03c$0fd66eb0$6701a8c0@freqonedev>
In-Reply-To: <0a3901c8e03c$0fd66eb0$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] SSP testing and BlueZ
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

David Stockwell wrote:
> While attempting to test SSP with 3.34-3.35, I found that I was unable 
> to pair with SSP; I was able to pair with the legacy 
> pin-request/response mode.  I checked the HCI level of my aging BT 
> dongle (somehow this sounds a bit "dirty"), and found that it was only 
> HCI 1.1 compliant.  Replacing it with a BT2.0+EDR compliant dongle, I 
> found that it still would not pair with SSP.
> 
> Consulting with CSR, they confirmed that unless both devices are 
> Bluetooth HCI 2.1 compliant, SSP will not work; it will always fall back 
> to Legacy pairing.
> 
> I searched yesterday for HCI 2.1-compliant dongles, and found only one, 
> from Logitec (not Logitech) in Japan.  These are not available in the US 
> market.
> 

you can update CSRs BT2.0 with 2.1 Firmware. That should work. I think
you can download the firmware on the csr support site.


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
