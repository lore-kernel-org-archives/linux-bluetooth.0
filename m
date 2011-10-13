Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 17:36:18 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0 3/4] Bluetooth: physical link HCI interface to AMP
Message-ID: <20111013203618.GI20892@joana>
References: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318406039-24843-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318406039-24843-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-12 10:53:58 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds support for physical link create/acceppt/disconnect AMP HCI
> commands. To be used by the upper layer.
> Backport from CodeAurora & Atheros
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |   24 ++++++++++++++++++++++
>  net/bluetooth/hci_core.c    |   45 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 0 deletions(-)

I prefer to see this patch together with code that actually uses it.

	Gustavo
