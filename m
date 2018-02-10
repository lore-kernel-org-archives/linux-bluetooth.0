Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: Fix incorrect bits for LE states
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180209172602.20250-1-lukasz.rymanowski@codecoup.pl>
Date: Sat, 10 Feb 2018 21:08:47 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4438159A-1EB9-481C-8897-043C462260AB@holtmann.org>
References: <20180209172602.20250-1-lukasz.rymanowski@codecoup.pl>
To: =?utf-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> This patch fixes incorrect checks for LE states.
> Issues found when doing mgmt tests for scenario
> when Linux Kernel should do connectable advertising
> while connected.
> 
> Signed-off-by: Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
> ---
> net/bluetooth/hci_request.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

