Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: convert spaces to tabs in l2cap
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 17 Oct 2011 08:52:07 -0700
In-Reply-To: <1318859423-26489-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318859423-26489-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318866730.15441.99.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |  108 ++++++++++++++++++++--------------------
>  1 files changed, 54 insertions(+), 54 deletions(-)

please lets not do that. It will break too many peoples pending patches
right now and it is sort of legacy in Bluetooth coding style to keep
these as spaces. Same as for HCI btw.

Regards

Marcel


