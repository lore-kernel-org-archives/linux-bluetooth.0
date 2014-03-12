Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394637058-586-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1394637058-586-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Wed, 12 Mar 2014 17:39:31 +0200
Message-ID: <CABBYNZJEQi4pQHtNjqnn6ccb2x4B2JwBYE_aVq4OYCd33ErwYQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] android/hal-msg: Add HDP app registration struct
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wed, Mar 12, 2014 at 5:10 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ---
>  android/hal-msg.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 0abbbe6..b1942de 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -383,6 +383,27 @@ struct hal_cmd_pan_disconnect {
>         uint8_t bdaddr[6];
>  } __attribute__((packed));
>
> +#define HAL_OP_HEALTH_REG_APP          0x01
> +struct hal_cmd_health_reg_app {
> +       uint8_t app_name[255];
> +       uint8_t provider_name[255];
> +       uint8_t service_name[255];
> +       uint8_t service_descr[200];
> +       uint8_t num_of_mdep;
> +
> +       struct {
> +               uint8_t role;
> +               uint8_t data_type;
> +               uint8_t channel_type;
> +               uint8_t descr[255];
> +       } mdep_cfg[20];
> +} __attribute__((packed));
> +
> +struct hal_rsp_health_reg_app {
> +       uint16_t app_id;
> +} __attribute__((packed));

This most likely will not fit in our MTU which currently is 1024 bytes
and given that you have 20 cfgs this is going to be huge. We should
probably define a hal_string e.g:

struct hal_string {
    uint8_t len;
    uint8_t data[0];
};

Also we do not need to send the 20 cfgs every time so that should
probably be set to 0 and we write only num_of_mdep, if that still
doesn't fit in our MTU perhaps we should consider a bigger size.


-- 
Luiz Augusto von Dentz
