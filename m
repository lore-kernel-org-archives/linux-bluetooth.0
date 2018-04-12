Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180412103432.9760-2-maico.timmerman@gmail.com>
References: <20180412103432.9760-1-maico.timmerman@gmail.com> <20180412103432.9760-2-maico.timmerman@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Apr 2018 17:39:43 +0300
Message-ID: <CABBYNZ+9mXa8tT-N-4YbTti0LTQwPH0-LZjdQt9BQNC8Tzxo8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Client: Added support for the history file.
To: Maico Timmerman <maico.timmerman@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Maico,

On Thu, Apr 12, 2018 at 1:34 PM, Maico Timmerman
<maico.timmerman@gmail.com> wrote:
> Individual interactive tools can set a history file, which will be read
> on startup and written on clean-up.
> ---
>  AUTHORS            |  1 +
>  client/main.c      |  1 +
>  src/shared/shell.c | 23 +++++++++++++++++++++++
>  src/shared/shell.h |  2 ++
>  4 files changed, 27 insertions(+)
>
> diff --git a/AUTHORS b/AUTHORS
> index df9cb96ad..d2edbf749 100644
> --- a/AUTHORS
> +++ b/AUTHORS
> @@ -100,3 +100,4 @@ Bharat Panda <bharat.panda@samsung.com>
>  Marie Janssen <jamuraa@chromium.org>
>  Jaganath Kanakkassery <jaganath.k@samsung.com>
>  Micha=C5=82 Narajowski <michal.narajowski@codecoup.pl>
> +Maico Timmerman <maico.timmerman@gmail.com>

Id leave this for a separate patch, usually we only add people to
AUTHORS when they contribute substential code to the project.

> diff --git a/client/main.c b/client/main.c
> index b96278d45..ed536a720 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2544,6 +2544,7 @@ int main(int argc, char *argv[])
>         bt_shell_add_submenu(&scan_menu);
>         bt_shell_add_submenu(&gatt_menu);
>         bt_shell_set_prompt(PROMPT_OFF);
> +       bt_shell_set_history_file(".bluetoothctl_history");

Id enable the history by default, the shell could figure out the
binary name from argv as well. Besides Id update the tools in a
separate patch.

>         if (agent_option)
>                 auto_register_agent =3D g_strdup(agent_option);
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index be2a8dfe0..39583de1e 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -38,6 +38,7 @@
>
>  #include <readline/readline.h>
>  #include <readline/history.h>
> +#include <pwd.h>
>
>  #include "src/shared/mainloop.h"
>  #include "src/shared/timeout.h"
> @@ -69,6 +70,8 @@ static struct {
>         int timeout;
>         struct io *input;
>
> +       char *bt_shell_history;

Call it just history.

> +
>         bool saved_prompt;
>         bt_shell_prompt_input_func saved_func;
>         void *saved_user_data;
> @@ -1027,6 +1030,11 @@ void bt_shell_cleanup(void)
>         bt_shell_release_prompt("");
>         bt_shell_detach();
>
> +       if (data.bt_shell_history) {
> +               write_history(data.bt_shell_history);
> +               history_truncate_file(data.bt_shell_history, 500);
> +       }

If the tools crashes or bt_shell_cleanup is not called for whatever
reason it appears we would lose the history, perhaps it is a it would
be better to set a timer once something is written to the history and
then update the history using that, well if the history size is small
otherwise it may be too much io to keep updating it frequently.

>         if (data.envs) {
>                 queue_destroy(data.envs, env_destroy);
>                 data.envs =3D NULL;
> @@ -1079,6 +1087,21 @@ bool bt_shell_add_submenu(const struct bt_shell_me=
nu *menu)
>         return true;
>  }
>
> +void bt_shell_set_history_file(const char *string)
> +{
> +       char *homedir;
> +
> +       // First check HOME env variable, otherwise read homedir from /et=
c/passwd.

Comments should be using /* */

> +       if ((homedir =3D getenv("HOME")) =3D=3D NULL) {
> +               homedir =3D getpwuid(getuid())->pw_dir;
> +       }
> +       data.bt_shell_history =3D strcat(strcat(homedir, "/"), string);;

Perhaps we could write to current dir if HOME is not set, Im also not
sure writing to use home directly is a good idea. Perhaps we should
check with XDG spec:

https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

Probably it makes sense to use XDG_CACHE_HOME for these files.

> +       // Read history file and set index of history beyond latest posit=
ion.
> +       read_history(data.bt_shell_history);
> +       history_set_pos(history_length);
> +}
> +
>  void bt_shell_set_prompt(const char *string)
>  {
>         if (!data.init || data.mode)
> diff --git a/src/shared/shell.h b/src/shared/shell.h
> index 8b7cb7f30..1c4ff0e7b 100644
> --- a/src/shared/shell.h
> +++ b/src/shared/shell.h
> @@ -79,6 +79,8 @@ bool bt_shell_remove_submenu(const struct bt_shell_menu=
 *menu);
>
>  void bt_shell_set_prompt(const char *string);
>
> +void bt_shell_set_history_file(const char *string);
> +
>  void bt_shell_printf(const char *fmt,
>                                 ...) __attribute__((format(printf, 1, 2))=
);
>  void bt_shell_hexdump(const unsigned char *buf, size_t len);
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
