Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Check result code for l2cap info rsp
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
In-Reply-To: <1280904213-2097-1-git-send-email-ville.tervo@nokia.com>
References: <1280904213-2097-1-git-send-email-ville.tervo@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 07:27:45 -0700
Message-ID: <1280932065.12579.110.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

> Check result code in l2cap information response. Othervise
> the response code would read invalid feature mask and access
> invalid memory.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  net/bluetooth/l2cap.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


