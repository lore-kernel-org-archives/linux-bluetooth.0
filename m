Return-Path: <cyrus@holtmann.org>
Message-ID: <4D9B04CA.4020208@Atheros.com>
Date: Tue, 5 Apr 2011 17:32:18 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Zhang Jiejing-B33651 <B33651@freescale.com>
CC: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: change gfp type in hci_recv_stream_fragment()
References: <1301554616-27595-1-git-send-email-jiejing.zhang@freescale.com>,<20110404211617.GD2230@joana> <00EDC7B5DB2F5145BEDBC1CE66AD2727166177@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <00EDC7B5DB2F5145BEDBC1CE66AD2727166177@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhang,

On 4/5/2011 2:17 PM, Zhang Jiejing-B33651 wrote:
> 2. I think it should do some thing like report an error, let upper level know the receive data is got error.
> I guess maybe upper level like rfcomm will check the package's checksum ?

I guess if there is an issue with allocating buffer, the only option 
could be just dropping. If we have L2CAP using ERTM mode, it might be 
able to recover from the data loss. Otherways, not sure there is anyway 
other than disconnecting the link(profile other than A2DP).

Ideally there would be a break in traffic at the protocol level and the 
protocol might initiate a graceful disconnection here.

Regards
Suraj

