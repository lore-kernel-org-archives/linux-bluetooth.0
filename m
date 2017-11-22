Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ce49d596-5ea4-a2ff-0e42-a0b308eeaccd@jp.fujitsu.com>
References: <ce49d596-5ea4-a2ff-0e42-a0b308eeaccd@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Nov 2017 10:53:27 +0200
Message-ID: <CABBYNZKVC0M-2OvkrzM6J1hvM9ZRosa1zgadip093C=g-OUMag@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/shell: Fix command completion without character
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Tue, Nov 21, 2017 at 9:14 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> If the command completion without any character is run, then only returns
> the commands of default menu since readline increases the variable state
> during each matching and tools specific menu is not compared.
> ---
>  src/shared/shell.c | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 378c0c029..c271a53ee 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -390,32 +390,46 @@ done:
>         free(input);
>  }
>
> -static char *cmd_generator(const char *text, int state)
> +static char *find_cmd(const char *text,
> +                       const struct bt_shell_menu_entry *entry, int *index)
>  {
> -       static const struct bt_shell_menu_entry *entry;
> -       static int index, len;
>         const char *cmd;
> +       int len;
>
> -       if (!state) {
> -               entry = default_menu;
> -               index = 0;
> -               len = strlen(text);
> -       }
> +       len = strlen(text);
>
> -       while ((cmd = entry[index].cmd)) {
> -               index++;
> +       while ((cmd = entry[*index].cmd)) {
> +               (*index)++;
>
>                 if (!strncmp(cmd, text, len))
>                         return strdup(cmd);
>         }
>
> -       if (state)
> -               return NULL;
> +       return NULL;
> +}
>
> -       entry = data.menu->entries;
> -       index = 0;
> +static char *cmd_generator(const char *text, int state)
> +{
> +       static int index;
> +       static bool default_menu_enabled;
> +       char *cmd;
> +
> +       if (!state) {
> +               index = 0;
> +               default_menu_enabled = true;
> +       }
> +
> +       if (default_menu_enabled) {
> +               cmd = find_cmd(text, default_menu, &index);
> +               if (cmd) {
> +                       return cmd;
> +               } else {
> +                       index = 0;
> +                       default_menu_enabled = false;
> +               }
> +       }
>
> -       return cmd_generator(text, 1);
> +       return find_cmd(text, data.menu->entries, &index);
>  }
>
>  static char **menu_completion(const struct bt_shell_menu_entry *entry,
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
