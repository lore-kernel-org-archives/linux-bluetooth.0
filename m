Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171121070848.7305-1-inga.stotland@intel.com>
References: <20171121070848.7305-1-inga.stotland@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Nov 2017 12:19:41 +0200
Message-ID: <CABBYNZLjP+SoVtSQnLrXyxqDvpv+be1nYbGktPdD_fMFDPKGxA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh: validate configuration target
To: Inga Stotland <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Tue, Nov 21, 2017 at 9:08 AM, Inga Stotland <inga.stotland@intel.com> wrote:
> Require obtaining node composition prior to sending configuration
> commands that assume knowledge about the node's element/model layout.
> ---
>  mesh/config-client.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/mesh/config-client.c b/mesh/config-client.c
> index d80f784e6..782781602 100644
> --- a/mesh/config-client.c
> +++ b/mesh/config-client.c
> @@ -461,16 +461,37 @@ static void cmd_del_app_key(const char *args)
>         cmd_app_key(args, OP_APPKEY_DELETE);
>  }
>
> +static bool verify_config_target(uint32_t dst)
> +{
> +       struct mesh_node *node;
> +
> +       if (IS_UNASSIGNED(dst)) {
> +               rl_printf("Destination not set\n");
> +               return false;
> +       }
> +
> +       node = node_find_by_addr(dst);
> +       if (!node) {
> +               rl_printf("Node with unicast address %4.4x unknown\n", dst);
> +               return false;
> +       }
> +
> +       if (!node_get_composition(node)) {
> +               rl_printf("Node composition for %4.4x unknown\n", dst);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
>  static void cmd_bind(const char *args)
>  {
>         uint16_t n;
>         uint8_t msg[32];
>         int parm_cnt;
>
> -       if (IS_UNASSIGNED(target)) {
> -               rl_printf("Destination not set\n");
> +       if (!verify_config_target(target))
>                 return;
> -       }
>
>         parm_cnt = read_input_parameters(args);
>         if (parm_cnt != 3 && parm_cnt != 4) {
> @@ -529,10 +550,8 @@ static void cmd_set_pub(const char *args)
>         uint8_t msg[32];
>         int parm_cnt;
>
> -       if (IS_UNASSIGNED(target)) {
> -               rl_printf("Destination not set\n");
> +       if (!verify_config_target(target))
>                 return;
> -       }
>
>         n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
>
> --
> 2.13.6

Applied, thanks.

-- 
Luiz Augusto von Dentz
