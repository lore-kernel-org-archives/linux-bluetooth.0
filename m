Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] audio problems with a2play
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A3FD27.6060400@xmission.com>
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>
	 <20041123033429.132bf84b.henryk@ploetzli.ch>
	 <41A2B331.4010001@xmission.com>
	 <20041123070621.50569968.henryk@ploetzli.ch>
	 <41A3471C.4000602@xmission.com>
	 <20041123203836.046fb4f4.henryk@ploetzli.ch>
	 <41A3ACE2.4030501@xmission.com> <1101246735.27351.45.camel@pegasus>
	 <41A3FD27.6060400@xmission.com>
Content-Type: text/plain
Message-Id: <1101272951.27351.76.camel@pegasus>
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
Date: Wed, 24 Nov 2004 06:09:11 +0100

Hi Brad,

> If I'm understanding right, the payload should include the sbc_info 
> header. I thought all along that was just for the purpose of storing the 
> sbc in a file, but it sounds like the headset needs it.

I also don't see any reason why we need to store a SBC configuration and
then submit the same values with every frame. However without the header
it is impossible to get the SBC frame size.

> Is this closer? It doesn't sound right yet, but maybe we really do need 
> to load up the packet to be closer to the mtu in order for the headset 
> to be happy.

Do you mean you get some working sound with the specification conform
payload?

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
