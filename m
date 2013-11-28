Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1385637056-561-2-git-send-email-szymon.janc@tieto.com>
References: <1385637056-561-1-git-send-email-szymon.janc@tieto.com>
	<1385637056-561-2-git-send-email-szymon.janc@tieto.com>
Date: Thu, 28 Nov 2013 07:26:55 -0400
Message-ID: <CAJdJm_P_mho-QXy_Gfpqqps1b5cM0AuVKp30=EQCrVzuNLGSVQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gitignore: Add tools/avdtp-tester
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Nov 28, 2013 at 7:10 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index d567d26..2d3435a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -100,6 +100,7 @@ unit/test-gobex-apparam
>  unit/test-gobex-header
>  unit/test-gobex-packet
>  unit/test-gobex-transfer
> +unit/test-avdtp
>  unit/test-*.log
>  unit/test-*.trs

The tool name on the commit description is incorrect.

Best Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
