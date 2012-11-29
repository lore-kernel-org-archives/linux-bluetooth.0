Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Nov 2012 08:34:05 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 5/5] Bluetooth: AMP: Mark controller radio powered down
 after HCIDEVDOWN
Message-ID: <20121129103405.GC26707@joana>
References: <1354118382-25571-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1354118382-25571-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354118382-25571-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-11-28 17:59:42 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> After getting HCIDEVDOWN controller did not mark itself as 0x00 which
> means: "The Controller radio is available but is currently physically
> powered down". The result was even if the hdev was down we return
> in controller list value 0x01 "status 0x01 (Bluetooth only)".
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |    3 +++
>  1 file changed, 3 insertions(+)

Patches 2 and 5 of this series were applied. Thanks.

	Gustavo
