Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387747496-20654-1-git-send-email-szymon.janc@gmail.com>
References: <1387747496-20654-1-git-send-email-szymon.janc@gmail.com>
Date: Mon, 23 Dec 2013 09:57:21 +0200
Message-ID: <CABBYNZKQ8xjQZ_x-vHhWfPd0ACiMLL6eYU23Ch1k8eT7sjQeBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] client: Clean up agent if bluetoothd exited without
 releasing it
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Dec 22, 2013 at 11:24 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> If bluetoothd exited without releasing agent (eg. due to crash) it was
> not possible to register client as agent after daemon was restarted.
> ---
>  client/agent.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/client/agent.c b/client/agent.c
> index 2d9dffd..b34ad77 100644
> --- a/client/agent.c
> +++ b/client/agent.c
> @@ -35,6 +35,7 @@
>
>  #define AGENT_PATH "/org/bluez/agent"
>  #define AGENT_INTERFACE "org.bluez.Agent1"
> +#define BLUEZ_NAME "org.bluez"
>
>  #define AGENT_PROMPT   COLOR_RED "[agent]" COLOR_OFF " "
>
> @@ -43,6 +44,7 @@ static const char *agent_capability = NULL;
>  static DBusMessage *pending_message = NULL;
>  static char *agent_saved_prompt = NULL;
>  static int agent_saved_point = 0;
> +static guint watch_id = 0;
>
>  static void agent_prompt(const char *msg)
>  {
> @@ -154,8 +156,7 @@ dbus_bool_t agent_input(DBusConnection *conn, const char *input)
>         return TRUE;
>  }
>
> -static DBusMessage *release_agent(DBusConnection *conn,
> -                                       DBusMessage *msg, void *user_data)
> +static void clean_agent(DBusConnection *conn, void *user_data)
>  {
>         agent_registered = FALSE;
>         agent_capability = NULL;
> @@ -171,6 +172,15 @@ static DBusMessage *release_agent(DBusConnection *conn,
>
>         g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
>
> +       g_dbus_remove_watch(conn, watch_id);
> +       watch_id = 0;
> +}
> +
> +static DBusMessage *release_agent(DBusConnection *conn, DBusMessage *msg,
> +                                                               void *user_data)
> +{
> +       clean_agent(conn, NULL);
> +
>         return dbus_message_new_method_return(msg);
>  }
>
> @@ -364,6 +374,10 @@ static void register_agent_reply(DBusMessage *message, void *user_data)
>         if (dbus_set_error_from_message(&error, message) == FALSE) {
>                 agent_registered = TRUE;
>                 rl_printf("Agent registered\n");
> +
> +               watch_id = g_dbus_add_service_watch(conn, BLUEZ_NAME, NULL,
> +                                                       clean_agent, NULL,
> +                                                       NULL);
>         } else {
>                 rl_printf("Failed to register agent: %s\n", error.name);
>                 dbus_error_free(&error);
> @@ -425,6 +439,9 @@ static void unregister_agent_reply(DBusMessage *message, void *user_data)
>                 if (g_dbus_unregister_interface(conn, AGENT_PATH,
>                                                 AGENT_INTERFACE) == FALSE)
>                         rl_printf("Failed to unregister agent object\n");
> +
> +               g_dbus_remove_watch(conn, watch_id);
> +               watch_id = 0;
>         } else {
>                 rl_printf("Failed to unregister agent: %s\n", error.name);
>                 dbus_error_free(&error);
> --
> 1.8.5.2

Ive send a patch for it not long time ago, but instead of adding a new
watch I just unregister the agent whenever org.bluez.AgentManager1
proxy is removed which should treat the case where the daemon crash or
exit without sending a proper unregister.


-- 
Luiz Augusto von Dentz
