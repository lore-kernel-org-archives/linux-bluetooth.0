Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427183840-8089-8-git-send-email-jpawlowski@google.com>
References: <1427183840-8089-1-git-send-email-jpawlowski@google.com>
	<1427183840-8089-8-git-send-email-jpawlowski@google.com>
Date: Tue, 24 Mar 2015 11:35:27 +0200
Message-ID: <CABBYNZLUMpt_RTcHqEHPqm0iMt4nWxXBDaWJfw8bpzh1iFLycQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] client: main: add support for SetDiscoveryFilter
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Mar 24, 2015 at 9:57 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch adds filtered-scan command to sample DBus client that might
> be used to call SetDiscoveryFilter.
> ---
>  client/main.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 235 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 7f1c903..d3c6853 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -891,6 +891,239 @@ static void cmd_scan(const char *arg)
>         }
>  }
>
> +static void append_variant(DBusMessageIter *iter, int type, void *val)
> +{
> +       DBusMessageIter value;
> +       char sig[2] = { type, '\0' };
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
> +
> +       dbus_message_iter_append_basic(&value, type, val);
> +
> +       dbus_message_iter_close_container(iter, &value);
> +}
> +
> +static void dict_append_entry(DBusMessageIter *dict, const char *key,
> +                                                       int type, void *val)
> +{
> +       DBusMessageIter entry;
> +
> +       if (type == DBUS_TYPE_STRING) {
> +               const char *str = *((const char **) val);
> +
> +               if (str == NULL)
> +                       return;
> +       }
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
> +                                                       NULL, &entry);
> +
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +
> +       append_variant(&entry, type, val);
> +
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +#define        DISTNACE_VAL_INVALID    0x7FFF
> +
> +struct set_discovery_filter_args {
> +       char *transport;
> +       dbus_uint16_t rssi;
> +       dbus_int16_t pathloss;
> +       GList *uuids;
> +};
> +
> +static void set_discovery_filter_setup(DBusMessageIter *iter,
> +                                          void *user_data)
> +{
> +       struct set_discovery_filter_args *args = user_data;
> +       DBusMessageIter dict;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                           DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +                           DBUS_TYPE_STRING_AS_STRING
> +                           DBUS_TYPE_VARIANT_AS_STRING
> +                           DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
> +
> +       if (args->uuids != NULL) {
> +               DBusMessageIter entry, value, arrayIter;
> +               char *uuids = "UUIDs";
> +               GList *list;
> +
> +               dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
> +                                                NULL, &entry);
> +               /* dict key */
> +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> +                                              &uuids);
> +
> +               dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
> +                                                "as", &value);
> +
> +               dbus_message_iter_open_container(&value, DBUS_TYPE_ARRAY, "s",
> +                                                &arrayIter);
> +
> +               for (list = g_list_first(args->uuids); list;
> +                                                     list = g_list_next(list))
> +                       /* list->data contains string representation of uuid */
> +                       dbus_message_iter_append_basic(&arrayIter,
> +                                                      DBUS_TYPE_STRING,
> +                                                      &list->data);
> +
> +               dbus_message_iter_close_container(&value, &arrayIter);
> +
> +               /* close vararg*/
> +               dbus_message_iter_close_container(&entry, &value);
> +
> +               /* close entry */
> +               dbus_message_iter_close_container(&dict, &entry);
> +       }
> +
> +       if (args->pathloss != DISTNACE_VAL_INVALID)
> +               dict_append_entry(&dict, "Pathloss", DBUS_TYPE_UINT16,
> +                                 &args->pathloss);
> +
> +       if (args->rssi != DISTNACE_VAL_INVALID)
> +               dict_append_entry(&dict, "RSSI", DBUS_TYPE_INT16, &args->rssi);
> +
> +       if (args->transport != NULL)
> +               dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
> +                                 &args->transport);
> +
> +       dbus_message_iter_close_container(iter, &dict);
> +}
> +
> +
> +static void set_discovery_filter_reply(DBusMessage *message,
> +                                      void *user_data)
> +{
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +       if (dbus_set_error_from_message(&error, message) == TRUE) {
> +               rl_printf("SetDiscoveryFilter failed: %s\n", error.name);
> +               dbus_error_free(&error);
> +               return;
> +       }
> +
> +       rl_printf("SetDiscoveryFilter success\n");
> +}
> +
> +static gint filtered_scan_rssi, filtered_scan_pathloss;
> +static char **filtered_scan_uuids;
> +static gboolean filtered_scan_help;
> +static char *filtered_scan_transport;
> +
> +static GOptionEntry filtered_discovery_options[] = {
> +       { "rssi", 'r', 0, G_OPTION_ARG_INT, &filtered_scan_rssi,
> +                               "RSSI filter" },
> +       { "pathloss", 'p', 0, G_OPTION_ARG_INT, &filtered_scan_pathloss,
> +                               "pathloss filter" },
> +       { "transport", 't', 0, G_OPTION_ARG_STRING, &filtered_scan_transport,
> +                               "transport" },
> +       { "uuids", 'u', 0, G_OPTION_ARG_STRING_ARRAY, &filtered_scan_uuids,
> +                               "uuid to filter by" },
> +       { "help", 'h', 0, G_OPTION_ARG_NONE, &filtered_scan_help,
> +                               "show help" },
> +       { NULL },
> +};
> +
> +static void cmd_set_discovery_filter(const char *arg)
> +{
> +       struct set_discovery_filter_args args;
> +       int argc, loop;
> +       GOptionContext *context;
> +       GError *error = NULL;
> +
> +       gchar **arguments = NULL, **argv, *cmdline_arg;
> +
> +       /* add fake program name at beginning for g_shell_parse_argv */
> +       cmdline_arg = g_strconcat("set-discovery-filter ", arg, NULL);
> +       if (g_shell_parse_argv(cmdline_arg, &argc, &arguments, &error)
> +                                                                   == FALSE) {
> +               if (error != NULL) {
> +                       g_printerr("error when parsing arguments: %s\n",
> +                                  error->message);
> +                       g_error_free(error);
> +               } else
> +                       g_printerr("An unknown error occurred\n");
> +
> +               g_strfreev(arguments);
> +               g_free(cmdline_arg);
> +               return;
> +       }
> +       g_free(cmdline_arg);
> +
> +       argc = g_strv_length(arguments);
> +
> +       /* Rewrite arguments to argv, argv is not null-terminated and will be
> +        * passed to g_option_context_parse.
> +        */
> +       argv = g_new(gchar *, argc);
> +       for (loop = 0; loop < argc; loop++)
> +               argv[loop] = arguments[loop];
> +
> +       context = g_option_context_new(NULL);
> +       g_option_context_add_main_entries(context, filtered_discovery_options,
> +                                                                        NULL);
> +       /* set default values for all options */
> +       filtered_scan_rssi = DISTNACE_VAL_INVALID;
> +       filtered_scan_pathloss = DISTNACE_VAL_INVALID;
> +       filtered_scan_uuids = NULL;
> +       filtered_scan_transport = NULL;
> +       filtered_scan_help = FALSE;
> +
> +       g_option_context_set_help_enabled(context, FALSE);
> +       if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
> +               if (error != NULL) {
> +                       g_printerr("error in g_option_context_parse: %s\n",
> +                                                              error->message);
> +                       g_error_free(error);
> +               } else
> +                       g_printerr("An unknown error occurred\n");
> +
> +               g_strfreev(arguments);
> +               g_free(argv);
> +               return;
> +       }
> +
> +       if (filtered_scan_help) {
> +               printf("Set discovery filter. Usage:\n");
> +               printf("        set-discovery-filter [-r rssi | -p pathlos] ");
> +               printf("[-t transport] -u <uuid1> [-u <uuid2> ...]\n");
> +               printf("\n");
> +               printf("Example: set-discovery-filter -p 65 -u baba -u 1900\n");
> +               return;
> +       }
> +
> +       args.uuids = NULL;
> +       args.pathloss = filtered_scan_pathloss;
> +       args.rssi = filtered_scan_rssi;
> +       args.transport = filtered_scan_transport;
> +
> +       if (filtered_scan_uuids != NULL)
> +               for (loop = 0; filtered_scan_uuids[loop] != NULL; loop++) {
> +                       args.uuids = g_list_append(args.uuids,
> +                                           strdup(filtered_scan_uuids[loop]));
> +               }
> +
> +       g_strfreev(arguments);
> +       g_free(argv);
> +       g_strfreev(filtered_scan_uuids);
> +
> +       g_option_context_free(context);
> +
> +       if (check_default_ctrl() == FALSE)
> +               return;
> +
> +       if (g_dbus_proxy_method_call(default_ctrl, "SetDiscoveryFilter",
> +               set_discovery_filter_setup, set_discovery_filter_reply,
> +               &args, NULL /* TODO: proper freeing method here*/) == FALSE) {
> +               rl_printf("Failed to set discovery filter\n");
> +               return;
> +       }
> +}
> +
>  static struct GDBusProxy *find_device(const char *arg)
>  {
>         GDBusProxy *proxy;
> @@ -1433,6 +1666,8 @@ static const struct {
>                                                         capability_generator},
>         { "default-agent",NULL,       cmd_default_agent,
>                                 "Set agent as the default one" },
> +       { "set-discovery-filter", "", cmd_set_discovery_filter,
> +               "Set discovery filter. Run discovery-filter -h for help" },
>         { "scan",         "<on/off>", cmd_scan, "Scan for devices" },
>         { "info",         "[dev]",    cmd_info, "Device information",
>                                                         dev_generator },
> --
> 2.2.0.rc0.207.ga3a616c

This looks really messy, Id probably add support for sub parser
separately so it parses the parameters before the callback so we don't
have to duplicate this code for each command, but Im not sure we want
GOptionEntry either since for the other commands we normally don't use
that style. Perhaps another way would be to have each filter as
separate command e.g. set-pathloss, set-rssi, and just update the
filter everytime it changes. Btw we also need a way to reset the
filter.

-- 
Luiz Augusto von Dentz
