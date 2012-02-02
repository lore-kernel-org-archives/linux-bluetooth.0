Return-Path: <cyrus@holtmann.org>
Message-ID: <1328199079.2062.16.camel@aeonflux>
Subject: Re: [PATCHv2 0/2] Fixes kernel crashes and warnings
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 02 Feb 2012 08:11:19 -0800
In-Reply-To: <1328171538-16020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328171538-16020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Set of patches fixes issues with traversing RCU lists.
> 
> Changes:
> 	v2: removed patch fixing delayed work warnings since
> 	the issue was proper fixed already.
> 
> Andrei Emeltchenko (2):
>   Bluetooth: Use list _safe deleting from conn_hash_list
>   Bluetooth: Use list _safe deleting from conn chan_list
> 
>  net/bluetooth/hci_conn.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

if nobody else objects, then these two patches should be applied.

Regards

Marcel


