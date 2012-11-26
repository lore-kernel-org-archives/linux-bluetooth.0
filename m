Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1353920860-14912-4-git-send-email-szymon.janc@tieto.com>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
	<1353920860-14912-4-git-send-email-szymon.janc@tieto.com>
Date: Mon, 26 Nov 2012 06:45:30 -0400
Message-ID: <CAJdJm_OLsmmxvLddeT2T=Xg427=ADNNdmfSRre5+jB-inTiGBw@mail.gmail.com>
Subject: Re: [PATCH 4/5] adaptername: Remove not needed empty remove callback
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 26, 2012 at 5:07 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>  static struct btd_adapter_driver adaptername_driver = {
>         .name   = "adaptername",
>         .probe  = adaptername_probe,
> -       .remove = adaptername_remove,
> +       .remove = NULL,
>  };

This variable is static, so not explicitly initialized members will be NULL.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
