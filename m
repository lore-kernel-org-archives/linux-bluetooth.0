Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Apr 2012 20:55:27 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 12/26] Bluetooth: A2MP: Process A2MP Discover Request
Message-ID: <20120406235527.GH2915@joana>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332941509-21345-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-28 16:31:35 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Process A2MP Discover Request, code makes sure that first
> controller in the list is BREDR one. Trace is shown below:
> 
> ...
> > ACL data: handle 11 flags 0x02 dlen 16
>     A2MP: Discover req: mtu/mps 670 mask: 0x0000
> < ACL data: handle 11 flags 0x00 dlen 22
>     A2MP: Discover rsp: mtu/mps 670 mask: 0x0000
>       Controller list:
>         id 0 type 0 (BR-EDR) status 0x01 (Bluetooth only)
>         id 1 type 1 (802.11 AMP) status 0x01 (Bluetooth only)
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

I think patch 11 and 12 can be merged.

	Gustavo
