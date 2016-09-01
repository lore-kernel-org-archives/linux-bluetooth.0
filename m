Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] Bluetooth: Append local name and CoD to Extended Controller Info
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1472741184-29311-2-git-send-email-michal.narajowski@codecoup.pl>
Date: Thu, 1 Sep 2016 08:56:40 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AEB04E1D-D449-400D-B5B9-F9EA9753362F@holtmann.org>
References: <1472741184-29311-1-git-send-email-michal.narajowski@codecoup.pl> <1472741184-29311-2-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> This adds device class, complete local name and short local name
> to EIR data in Extended Controller Info as specified in docs.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> net/bluetooth/mgmt.c | 63 ++++++++++++++++++++++++++++++++++------------------
> 1 file changed, 42 insertions(+), 21 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

