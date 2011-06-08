Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307440992-11087-1-git-send-email-hadess@hadess.net>
References: <BANLkTi=X16G8JreU68yFZeoqTbLfy5EyNg@mail.gmail.com>
	<1307440992-11087-1-git-send-email-hadess@hadess.net>
Date: Wed, 8 Jun 2011 12:13:47 -0400
Message-ID: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Jun 7, 2011 at 6:03 AM, Bastien Nocera <hadess@hadess.net> wrote:
> +static char *read_pretty_host_name (void)

Unnecessary space before "(".

> +{
> +       char *contents, *ret;
> +       char **lines;
> +       guint i;
> +
> +       ret = NULL;

You can postpone the attribution above to where it is necessary
(before the for()).

> +
> +       if (g_file_get_contents(MACHINE_INFO_DIR MACHINE_INFO_FILE,

I wonder if it would be better to use the autoconf variable for
"/etc/" instead of MACHINE_INFO_DIR.

> +                       &contents, NULL, NULL) == FALSE) {
> +               return NULL;
> +       }

Unnecessary {} on the if() above.

> +       lines = g_strsplit_set(contents, "\r\n", 0);
> +       g_free(contents);
> +
> +       if (lines == NULL)
> +               return NULL;
> +
> +       for (i = 0; lines[i] != NULL; i++) {
> +               if (g_str_has_prefix(lines[i], "PRETTY_HOSTNAME=")) {
> +                       ret = g_strdup(lines[i] + strlen("PRETTY_HOSTNAME="));

Maybe it is also good to strip whitespaces before/after the string as
well (there is a glib function for that).

> +                       break;
> +               }
> +       }
> +
> +       g_strfreev(lines);

Missing empty line here.

> +       return ret;
> +}
> [...]
> +static int adaptername_probe(struct btd_adapter *adapter)
> +{
> +       int current_id;
> +       char name[MAX_NAME_LENGTH + 1];
> +       char *pretty_hostname;
> +       bdaddr_t bdaddr;
> +
> +       current_id = adapter_get_dev_id(adapter);
> +
> +       pretty_hostname = read_pretty_host_name();
> +       if (pretty_hostname != NULL) {
> +               int default_adapter;
> +
> +               default_adapter = manager_get_default_adapter();
> +
> +               /* Allow us to change the name */
> +               adapter_set_allow_name_changes(adapter, TRUE);
> +
> +               /* If it's the first device, let's assume it will
> +                * be the default one, as we're not told when
> +                * the default adapter changes */
> +               if (default_adapter < 0)
> +                       default_adapter = current_id;
> +
> +               if (default_adapter != current_id) {
> +                       char *str;
> +
> +                       /* +1 because we don't want an adapter called "Foobar's laptop #0" */
> +                       str = g_strdup_printf ("%s #%d", pretty_hostname, current_id + 1);

Unnecessary whitespace before "(".

> +                       DBG("Setting name '%s' for device 'hci%d'", str, current_id);
> +
> +                       adapter_update_local_name(adapter, str);
> +                       g_free(str);
> +               } else {
> +                       DBG("Setting name '%s' for device 'hci%d'", pretty_hostname, current_id);
> +                       adapter_update_local_name(adapter, pretty_hostname);
> +               }
> +               g_free(pretty_hostname);
> +
> +               /* And disable the name change now */
> +               adapter_set_allow_name_changes(adapter, FALSE);
> +
> +               return 0;
> +       }
> +
> +       adapter_set_allow_name_changes(adapter, TRUE);
> +       adapter_get_address(adapter, &bdaddr);
> +
> +       if (read_local_name(&bdaddr, name) < 0) {
> +               expand_name(name, MAX_NAME_LENGTH, main_opts.name,
> +                                                       current_id);
> +       }

Unnecessary {} on the if() above.

> +       DBG("Setting name '%s' for device 'hci%d'", name, current_id);
> +       adapter_update_local_name(adapter, name);
> +
> +       return 0;
> +}
> +
> +static gboolean handle_inotify_cb(GIOChannel *channel,
> +               GIOCondition condition, gpointer data)
> +{
> +       char buf[EVENT_BUF_LEN];
> +       GIOStatus err;
> +       gsize len, i;
> +       gboolean changed;
> +
> +       changed = FALSE;
> +
> +       err = g_io_channel_read_chars(channel, buf, EVENT_BUF_LEN, &len, NULL);
> +       if (err != G_IO_STATUS_NORMAL) {
> +               error("Error reading inotify event: %d\n", err);
> +               return FALSE;
> +       }
> +
> +       i = 0;
> +       while (i < len) {
> +               struct inotify_event *pevent = (struct inotify_event *) & buf[i];

Unnecessary spaces between "&"

> +
> +               /* check that it's ours */
> +               if (pevent->len &&
> +                   pevent->name != NULL &&
> +                   strcmp(pevent->name, MACHINE_INFO_FILE) == 0) {
> +                       changed = TRUE;
> +               }

Unnecessary {} on the if() above.

> +               i += EVENT_SIZE + pevent->len;
> +       }
> +
> +       if (changed != FALSE) {
> +               DBG(MACHINE_INFO_DIR MACHINE_INFO_FILE
> +                               " changed, changing names for adapters");
> +               manager_foreach_adapter ((adapter_cb) adaptername_probe, NULL);

Unnecessary space before first "(".

> +       }
> +
> +       return TRUE;
> +}
> +
> +static void adaptername_remove(struct btd_adapter *adapter)
> +{
> +       if (watch_fd >= 0)
> +               close (watch_fd);

Unnecessary whitespace before "(".

> +       if (inotify != NULL)
> +               g_io_channel_shutdown(inotify, FALSE, NULL);
> +}
> +
> +static struct btd_adapter_driver adaptername_driver = {
> +       .name   = "adaptername",
> +       .probe  = adaptername_probe,
> +       .remove = adaptername_remove,
> +};
> +
> +static int adaptername_init(void)
> +{
> +       int ret;
> +
> +       ret = btd_register_adapter_driver(&adaptername_driver);
> +
> +       if (ret == 0) {

You can invert the logic of the ret check and drop the if().

> +               int inot_fd;
> +
> +               inot_fd = inotify_init();
> +               if (inot_fd < 0) {
> +                       error("Failed to setup inotify");
> +                       return 0;
> +               }
> +               watch_fd = inotify_add_watch(inot_fd,
> +                               MACHINE_INFO_DIR,
> +                               IN_CLOSE_WRITE | IN_DELETE | IN_CREATE);
> +               if (watch_fd < 0) {
> +                       error("Failed to setup watch for '%s'",
> +                                       MACHINE_INFO_DIR);
> +                       return 0;
> +               }
> +
> +               inotify = g_io_channel_unix_new(inot_fd);
> +               g_io_channel_set_close_on_unref(inotify, TRUE);
> +               g_io_channel_set_encoding (inotify, NULL, NULL);
> +                 g_io_channel_set_flags (inotify, G_IO_FLAG_NONBLOCK, NULL);

Indentation seems broken on the line above. Also two lines with
unnecessary space before "(".

> +               g_io_add_watch(inotify, G_IO_IN, handle_inotify_cb, NULL);
> +
> +               return 0;
> +       }
> +
> +       return ret;
> +}
> +
> +static void adaptername_exit(void)
> +{
> +       btd_unregister_adapter_driver(&adaptername_driver);
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(adaptername, VERSION,
> +               BLUETOOTH_PLUGIN_PRIORITY_LOW, adaptername_init, adaptername_exit)
>[...]
> @@ -938,38 +884,29 @@ void adapter_update_local_name(struct btd_adapter *adapter, const char *name)
>                                                DBUS_TYPE_STRING, &name_ptr);
>        }
>
> +       if (adapter->up) {
> +               int err = adapter_ops->set_name(adapter->dev_id, name);
> +               if (err < 0)
> +                       return err;
> +
> +               adapter->name_stored = TRUE;

This looks incorrect. If the if() is entered, adapter->name_stored is
set to TRUE and right after to FALSE.

> +       }
> +
>        adapter->name_stored = FALSE;
> +
> +       return 0;
>  }
>
>  static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
>                                        const char *name, void *data)
>  {
>        struct btd_adapter *adapter = data;
> -       char *name_ptr = adapter->name;
> -
> -       if (!g_utf8_validate(name, -1, NULL)) {
> -               error("Name change failed: supplied name isn't valid UTF-8");
> -               return btd_error_invalid_args(msg);
> -       }
> -
> -       if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
> -               goto done;
> -
> -       strncpy(adapter->name, name, MAX_NAME_LENGTH);
> -       write_local_name(&adapter->bdaddr, name);
> -       emit_property_changed(connection, adapter->path,
> -                                       ADAPTER_INTERFACE, "Name",
> -                                       DBUS_TYPE_STRING, &name_ptr);
> -
> -       if (adapter->up) {
> -               int err = adapter_ops->set_name(adapter->dev_id, name);
> -               if (err < 0)
> -                       return btd_error_failed(msg, strerror(-err));
> +       int err;
>
> -               adapter->name_stored = TRUE;
> -       }
> +       err = adapter_update_local_name (adapter, name);

Unnecessary whitespace before "(".

> +       if (err < 0)
> +               return btd_error_failed(msg, strerror(-err));
>
> -done:
>        return dbus_message_new_method_return(msg);
>  }
>
> @@ -2576,6 +2513,8 @@ gboolean adapter_init(struct btd_adapter *adapter)
>         * start off as powered */
>        adapter->up = TRUE;
>
> +       adapter->allow_name_changes = TRUE;
> +
>        adapter_ops->read_bdaddr(adapter->dev_id, &adapter->bdaddr);
>
>        if (bacmp(&adapter->bdaddr, BDADDR_ANY) == 0) {
> @@ -2591,14 +2530,6 @@ gboolean adapter_init(struct btd_adapter *adapter)
>                return FALSE;
>        }
>
> -       if (read_local_name(&adapter->bdaddr, adapter->name) < 0)
> -               expand_name(adapter->name, MAX_NAME_LENGTH, main_opts.name,
> -                                                       adapter->dev_id);
> -
> -       if (main_opts.attrib_server)
> -               attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
> -                       (const uint8_t *) adapter->name, strlen(adapter->name));

I can't find where you moved the attrib_gap_set() call to. This is
necessary for GATT attribute server.

> -
>        sdp_init_services_list(&adapter->bdaddr);
>        load_drivers(adapter);
>        clear_blocked(adapter);
> @@ -2684,6 +2615,12 @@ void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr)
>        bacpy(bdaddr, &adapter->bdaddr);
>  }
>
> +void adapter_set_allow_name_changes(struct btd_adapter *adapter,
> +                                               gboolean allow_name_changes)
> +{
> +       adapter->allow_name_changes = allow_name_changes;
> +}
> +
>  static inline void suspend_discovery(struct btd_adapter *adapter)
>  {
>        if (adapter->state != STATE_SUSPENDED)
> diff --git a/src/adapter.h b/src/adapter.h
> index 3526849..626c9ef 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -100,6 +100,8 @@ int adapter_resolve_names(struct btd_adapter *adapter);
>  struct btd_adapter *adapter_create(DBusConnection *conn, int id);
>  gboolean adapter_init(struct btd_adapter *adapter);
>  void adapter_remove(struct btd_adapter *adapter);
> +void adapter_set_allow_name_changes(struct btd_adapter *adapter,
> +                                               gboolean allow_name_changes);
>  uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
>  const gchar *adapter_get_path(struct btd_adapter *adapter);
>  void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
> @@ -115,7 +117,7 @@ int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
>  void adapter_emit_device_found(struct btd_adapter *adapter,
>                                                struct remote_dev_info *dev);
>  void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
> -void adapter_update_local_name(struct btd_adapter *adapter, const char *name);
> +int adapter_update_local_name(struct btd_adapter *adapter, const char *name);
>  void adapter_service_insert(struct btd_adapter *adapter, void *rec);
>  void adapter_service_remove(struct btd_adapter *adapter, void *rec);
>  void btd_adapter_class_changed(struct btd_adapter *adapter,
> diff --git a/src/manager.c b/src/manager.c
> index e805e0c..dedec8b 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -288,6 +288,11 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
>                btd_start_exit_timer();
>  }
>
> +int manager_get_default_adapter (void)

Unnecessary whitespace before "(". Also I've seem a patch sent to this
list a while ago with this change.

> +{
> +       return default_adapter_id;
> +}
> +
>  void manager_cleanup(DBusConnection *conn, const char *path)
>  {
>        g_slist_foreach(adapters, (GFunc) manager_remove_adapter, NULL);
> diff --git a/src/manager.h b/src/manager.h
> index 05c38b3..90d3690 100644
> --- a/src/manager.h
> +++ b/src/manager.h
> @@ -41,3 +41,4 @@ struct btd_adapter *btd_manager_register_adapter(int id);
>  int btd_manager_unregister_adapter(int id);
>  void manager_add_adapter(const char *path);
>  void btd_manager_set_did(uint16_t vendor, uint16_t product, uint16_t version);
> +int manager_get_default_adapter (void);
> --
> 1.7.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
