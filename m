Return-Path: <cyrus@holtmann.org>
Message-ID: <1322663247.26198.13.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove magic numbers from le scan cmd
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 30 Nov 2011 15:27:27 +0100
In-Reply-To: <1322662630-32759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322662630-32759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Make code readable by removing magic numbers.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    3 +++
>  net/bluetooth/hci_event.c   |   12 ++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


