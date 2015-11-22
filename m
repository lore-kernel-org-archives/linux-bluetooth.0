Return-Path: <johan.hedberg@gmail.com>
Date: Sun, 22 Nov 2015 16:28:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Add support for Get Advertising Size
 Information command
Message-ID: <20151122142810.GA22995@t440s>
References: <1447946203-17620-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447946203-17620-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Nov 19, 2015, Marcel Holtmann wrote:
> The Get Advertising Size Information command allows to retrieve size
> information for advertising data and scan response data fields depending
> on the selected flags. This is useful if applications want to know the
> available size ahead of time.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/mgmt.h | 13 ++++++++++
>  net/bluetooth/mgmt.c         | 58 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)

This patch has now also been applied. Thanks.

Johan
