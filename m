Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: do not use assignment in if condition
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1290424897-32463-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1290424897-32463-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Nov 2010 13:40:39 +0100
Message-ID: <1290602439.13641.12.camel@aeonflux.mpl.access-company.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Fix checkpatch errors like:
> "ERROR: do not use assignment in if condition"
> Simplify code and fix one long line.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/hci_event.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)

I am fine with these. It is just pretty old code and it is good that you
start fixing these up.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


