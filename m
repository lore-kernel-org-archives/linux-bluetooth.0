Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] audio problems with a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041123070621.50569968.henryk@ploetzli.ch>
References: <41A22C0B.4050008@xmission.com> <41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101202495.26578.58.camel@pegasus>
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
Date: Tue, 23 Nov 2004 10:34:55 +0100

Hi Henryk,

> > I don't know the "real" mapping between the indexed settings in the
> > sbc file format and the bitmapped settings/capabilities we use with
> > the a2dp protocol.
> 
> It's on page 20 of the A2DP spec where it says, for example, that the
> first byte of the codec specific information elements for SBC encodes
> the sampling frequency in the upper half of the byte and the channel
> mode in the lower half. The first byte that a2play sends for
> sbc_test_01.sbc (which is 48 kHz mono) is 0x81, so bits 7 (0x80) and 0
> (0x01) are set. Bit 7 set means 16 kHz (section 4.3.2.1), bit 0 set
> means joint stereo (section 4.3.2.2). The correct value for this byte
> would be 0x18 (bits 4 and 3 set). 
> 
> Similarly the second byte (currently 0x86) should be 0x1a (bits 4, 3 and
> 1 set).

may you check the hcidump from CVS again if it is now correct? If yes,
then I will release another version.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
