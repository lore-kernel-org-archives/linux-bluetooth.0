Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 1/3] android/gatt: Use g_attrib buffer where possible for att
Date: Mon, 26 May 2014 10:55:04 +0200
Message-ID: <2452899.UsNMVtilX5@uw000953>
In-Reply-To: <1401088396-2074-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401088396-2074-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Monday 26 of May 2014 09:13:14 Jakub Tyszkowski wrote:
> This replaces fixed size pdu usage with g_attrib buffer when possible.
> When only received packets are decoded we use dynamic allocation with
> current mtu.
> ---
>  android/gatt.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 70cd5fe..2ae3669 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3569,7 +3569,8 @@ static bool is_service(const bt_uuid_t *type)
>  static void send_dev_pending_response(struct gatt_device *device,

Applied, thanks.

-- 
Best regards, 
Szymon Janc
