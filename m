Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH v3] Bluetooth: Fix append max 11 bytes of name to scan rsp
 data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1476865227-18807-1-git-send-email-michal.narajowski@codecoup.pl>
Date: Wed, 19 Oct 2016 18:52:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8209A507-B8DB-4AAC-8679-400BDC0CF4CD@holtmann.org>
References: <1476865227-18807-1-git-send-email-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> Append maximum of 10 + 1 bytes of name to scan response data.
> Complete name is appended only if exists and is <= 10 characters.
> Else append short name if exists or shorten complete name if not.
> This makes sure name is consistent across multiple advertising
> instances.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> net/bluetooth/hci_request.c | 49 +++++++++++++++++++++------------------------
> net/bluetooth/hci_request.h |  2 ++
> net/bluetooth/mgmt.c        | 26 +++++++++++++++---------
> 3 files changed, 42 insertions(+), 35 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

