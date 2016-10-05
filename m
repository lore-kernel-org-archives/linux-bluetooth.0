Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix local name in scan rsp
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1475663307-3191-1-git-send-email-michal.narajowski@codecoup.pl>
Date: Wed, 5 Oct 2016 13:19:13 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E142798C-BC79-4CD7-BD82-5FAD258C3721@holtmann.org>
References: <1475663307-3191-1-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Use complete name if it fits. If not and there is short name
> check if it fits. If not then use shortened name as prefix
> of complete name.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> net/bluetooth/hci_request.c | 47 +++++++++++++++++++++++++++++++++------------
> 1 file changed, 35 insertions(+), 12 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

