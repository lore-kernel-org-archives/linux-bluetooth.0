Return-Path: <cyrus@holtmann.org>
From: "Cooper Xu" <cooper.xu@mapleworks.com>
To: <linux-bluetooth@vger.kernel.org>
References: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com> <1268609330.3897.51.camel@localhost.localdomain> <7ED1002624DD4A3BB31F08AF5DC6090E@mapleworks.com> <1268707083.2700.14.camel@localhost.localdomain> 
Subject: RE: A strange compatible problem for eSCO audio with CSR USB Bluetooth dongle
Date: Mon, 19 Apr 2010 18:03:48 -0400
Message-ID: <59FE3CD83DDB458F9735CBE4B6E3CD0D@mapleworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: 
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

I was written to this list one month ago about a strange compatible problem
between Bluetooth dongle of CSR chipset with HCI Rev: 0xc5c and Bluez. The
phenomena were that the eSCO connection can be made without any problem, but
I received all zero for voice data. 

After some tests with several USB Dongles of CSR chipset, I found that if I
turned off eSCO, I am able to get real voice data. 

The strange thing is that I used a host with Bluez and CSR dongle to test
the eSCO connection with Blackberry 8310 curve, which Blackberry has the CSR
chipset and HCI Rev: 0xc5c, the voice data worked without problem. However
if I use two hosts with CSR dongles and Bluez at the both ends, the eSCO
connection keeps receiving zero for voice data. This problem exists with all
CSR USB dongles I tried including a Bluetooth 2.1 dongle. If I turn off eSCO
mode, this problem will go away.

Does any one have clue why the eSCO connection will receive all zero if the
both side of eSCO connection are using Bluez and CSR chipset? How can eSCO
connection not compatible between USB dongles with the same CSR chipset and
firmware?


Thanks,
Cooper

