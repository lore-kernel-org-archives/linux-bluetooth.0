Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180322200450.27180-1-inga.stotland@intel.com>
References: <20180322200450.27180-1-inga.stotland@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 23 Mar 2018 13:36:33 +0200
Message-ID: <CABBYNZ+dAsNVPi819GpFnRBKt4AimEi+Ywwz19OS65ohP_vs=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/shell: Add bt_shell_cleanup
To: Inga Stotland <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Thu, Mar 22, 2018 at 10:04 PM, Inga Stotland <inga.stotland@intel.com> wrote:
> This releases resources used for shell initialization.
> This is needed as a separate function to enable clean shutdown
> when an application needs to exit prior to calling bt_shell_run(),
> e.g., when failing program initialization based on processed command
> line input options.
> ---
>  src/shared/shell.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 10f26264f..33bc0d980 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1001,11 +1001,16 @@ void bt_shell_run(void)
>
>         mainloop_run();
>
> +       io_destroy(signal);
> +
> +       bt_shell_cleanup();
> +}
> +
> +void bt_shell_cleanup(void)
> +{
>         bt_shell_release_prompt("");
>         bt_shell_detach();
>
> -       io_destroy(signal);
> -
>         if (data.envs) {
>                 queue_destroy(data.envs, env_destroy);
>                 data.envs = NULL;
> --
> 2.13.6

Applied, thanks.

-- 
Luiz Augusto von Dentz
