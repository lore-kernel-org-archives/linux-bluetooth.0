Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix ccc descriptor handle
Date: Thu, 05 Feb 2015 16:10:18 +0100
Message-ID: <2567879.N39PURCVzr@uw000953>
In-Reply-To: <1422970395-22110-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1422970395-22110-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 03 of February 2015 14:33:15 Jakub Tyszkowski wrote:
> Some service handle count was recently changed.
> ---
>  android/tester-gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 23c6609..15a54fa 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -1084,7 +1084,7 @@ static struct iovec send_notification_1[] = {
>  static struct iovec att_read_req_op_v = raw_pdu(L2CAP_ATT_READ_REQ);
>  static struct iovec att_write_req_op_v = raw_pdu(L2CAP_ATT_WRITE_REQ);
>  
> -static struct iovec svc_change_ccc_handle_v = raw_pdu(0x1a, 0x00);
> +static struct iovec svc_change_ccc_handle_v = raw_pdu(0x1c, 0x00);
>  static struct iovec svc_change_ccc_value_v = raw_pdu(0x00, 0x01);
>  
>  static void gatt_client_register_action(void)

Patch applied, thanks. 

-- 
Best regards, 
Szymon Janc
