Return-Path: <ian@mnementh.co.uk>
Subject: Re: BCM43430 BT driver almost working...
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@gmail.com>, linux-bluetooth@vger.kernel.org
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
 <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
 <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
 <F9B6438D-2D83-46BD-AE63-DBECB3A0B9A1@holtmann.org>
 <4078da55-c5d8-7c2d-d954-9da790982b22@mnementh.co.uk>
 <5efb7448-9208-f6e3-0c87-6b077a439b5c@mnementh.co.uk>
 <EEA6BBCD-78B8-41E1-9658-808CAF7F0308@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <a0fe3c57-0020-51c3-27e2-bf7f1d933976@mnementh.co.uk>
Date: Fri, 30 Jun 2017 22:46:48 +0100
MIME-Version: 1.0
In-Reply-To: <EEA6BBCD-78B8-41E1-9658-808CAF7F0308@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Resent because of MUA error:

On 30/06/17 22:27, Marcel Holtmann wrote:
> Hi Ian,

>> It seems there is a fair bit of commonality among the h4 based
>> bluetooth drivers - probably better to abstract it out and make a
>> h4 core around which the other serdev and ldisc drivers could sit?
> 
> don't try to overthink this. The code is already abstracted and
> optimized. Add the serdev support to hci_bcm.c and do not try to mess
> with the hci_nokia.c. That one is a total different driver and it is
> special in its own way.


It doesnt *look* terribly special - there are a few extra entries in
nokia_recv_pkts[] along with their helper functions - but its otherwise
very similar indeed...

I'm happy to add the code to hci_bcm, but it looks like theres a fair
bit of code duplication across at least these two drivers...

-Ian
