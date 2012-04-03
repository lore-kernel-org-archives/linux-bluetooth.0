Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333126569-1606-1-git-send-email-hemant.gupta@stericsson.com>
References: <1333126569-1606-1-git-send-email-hemant.gupta@stericsson.com>
Date: Tue, 3 Apr 2012 15:38:46 +0530
Message-ID: <CACj007k38=4L3PDUG+pgkTqz5M+MqBYF8APyioK_x_vG32EYPQ@mail.gmail.com>
Subject: Re: [PATCH v1] Adapter: Fix Discovering state while Powering Off
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Any comments on this patch ?

Best Regards
Hemant

On Fri, Mar 30, 2012 at 10:26 PM, Hemant Gupta
<hemant.gupta@stericsson.com> wrote:
> This patch fixes the adater discovering state while powering off.
> Without this fix, BlueZ sends incorrect discovering state to upper
> layers while switching off.
> ---
>  src/adapter.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index f8f46f8..eb9745f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -289,6 +289,12 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
>                        return err;
>
>                adapter->off_requested = TRUE;
> +               /*
> +                * Change the discovering state to FALSE, otherwise
> +                * inquiry fails to start if BT is switched off and then on
> +                * while inquiry is already active.
> +                */
> +               adapter->discovering = FALSE;
>
>                goto done;
>        }
> --
> 1.7.0.4
>



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
