Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 12 Nov 2015 16:37:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core/gatt-client: Fix warning when removing
 services
Message-ID: <20151112143740.GA15722@t440s.P-661HNU-F1>
References: <1447249256-10581-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447249256-10581-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Nov 11, 2015, Luiz Augusto von Dentz wrote:
> This fixes the following warnings caused by not resetting id to 0:
> 
> GLib-CRITICAL **: Source ID 145 was not found when attempting to remove it
> GLib-CRITICAL **: Source ID 151 was not found when attempting to remove it
> GLib-CRITICAL **: Source ID 155 was not found when attempting to remove it
> GLib-CRITICAL **: Source ID 162 was not found when attempting to remove it
> ---
>  src/gatt-client.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
