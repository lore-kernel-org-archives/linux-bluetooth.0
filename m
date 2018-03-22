Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180322031300.32156-1-inga.stotland@intel.com>
References: <20180322031300.32156-1-inga.stotland@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Mar 2018 12:30:31 +0200
Message-ID: <CABBYNZLd0rhkcVyCr4sJEOnYkdY-vJhc34UHfQZaN44v23OQew@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/shell: Fix short option parsing
To: Inga Stotland <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Thu, Mar 22, 2018 at 5:13 AM, Inga Stotland <inga.stotland@intel.com> wrote:
> The index value used for detecting and validating a short option
> was not reset after processing a first short option.
> This prevented the correct parsing of additional short options.
> Fixed by resetting the index value back to original after each
> iteration.
> ---
>  src/shared/shell.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 9cd8d2567..10f26264f 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -957,6 +957,8 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
>
>                         *opt->optarg[index - offset] = optarg;
>                 }
> +
> +               index = -1;
>         }
>
>         data.argc = argc - optind;
> --
> 2.13.6

Applied, thanks.

-- 
Luiz Augusto von Dentz
