Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382608220-25572-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382608220-25572-1-git-send-email-jerzy.kasenberg@tieto.com>
Date: Fri, 25 Oct 2013 11:16:35 +0300
Message-ID: <CABBYNZLzhw+5+17t70qcaHQtN3uhP14aKBuCYAX9i=_=v2LGpA@mail.gmail.com>
Subject: Re: [PATCH v2] android/client: Fix various coding style issues
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Thu, Oct 24, 2013 at 12:50 PM, Jerzy Kasenberg
<jerzy.kasenberg@tieto.com> wrote:
> Mostly indentation of arguments in functions and calls.
> Prefix p remove from puser/penum_func.
> Some empty lines added after closing } when needed.
> Magic number for string length changed to preprocessor define.
> Added spaces after casts.
> ---
>
> v2:
>  - fixed casts
>
>  android/client/haltest.c       |   18 +++--
>  android/client/if-bt.c         |  154 ++++++++++++++++++++++------------------
>  android/client/if-hh.c         |   64 ++++++++---------
>  android/client/if-main.h       |   12 ++--
>  android/client/if-pan.c        |   34 ++++-----
>  android/client/if-sock.c       |   26 +++----
>  android/client/tabcompletion.c |    8 +--
>  android/client/terminal.c      |    5 ++
>  android/client/textconv.h      |    2 +-
>  9 files changed, 175 insertions(+), 148 deletions(-)
>
> diff --git a/android/client/haltest.c b/android/client/haltest.c
> index 19e81b8..189af0b 100644
> --- a/android/client/haltest.c
> +++ b/android/client/haltest.c
> @@ -47,6 +47,7 @@ struct method *get_method(struct method *methods, const char *name)
>                         return methods;
>                 methods++;
>         }
> +
>         return NULL;
>  }
>
> @@ -103,11 +104,11 @@ static void help_print_interface(const struct interface *i)
>  }
>
>  /* Help completion */
> -static void help_c(int argc, const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +static void help_c(int argc, const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 2)
> -               *penum_func = interface_name;
> +               *enum_func = interface_name;
>  }
>
>  /* Help execution */
> @@ -125,11 +126,13 @@ static void help_p(int argc, const char **argv)
>                                                 (m->help ? m->help : ""));
>                         m++;
>                 }
> +
>                 terminal_print("\nAvailable interfaces to use:\n");
>                 while (NULL != *ip) {
>                         terminal_print("\t%s\n", (*ip)->name);
>                         ip++;
>                 }
> +
>                 terminal_print("\nTo get help on methods for each interface type:\n");
>                 terminal_print("\n\thelp <inerface>\n");
>                 terminal_print("\nBasic scenario:\n\tadapter init\n");
> @@ -138,11 +141,13 @@ static void help_p(int argc, const char **argv)
>                 terminal_print("\thandsfree init\n\n");
>                 return;
>         }
> +
>         i = get_interface(argv[1]);
>         if (i == NULL) {
>                 haltest_error("No such interface\n");
>                 return;
>         }
> +
>         help_print_interface(i);
>  }
>
> @@ -176,6 +181,7 @@ const char *interface_name(void *v, int i)
>  const char *command_name(void *v, int i)
>  {
>         int cmd_cnt = (int) (sizeof(commands)/sizeof(commands[0]) - 1);
> +
>         if (i >= cmd_cnt)
>                 return interface_name(v, i - cmd_cnt);
>         else
> @@ -188,8 +194,7 @@ const char *command_name(void *v, int i)
>   * Output argv is filled with pointers to arguments
>   * returns number of tokens parsed - argc
>   */
> -static int command_line_to_argv(char *line_buffer,
> -                               char *argv[], int argv_size)
> +static int command_line_to_argv(char *line_buffer, char *argv[], int argv_size)
>  {
>         static const char *token_breaks = "\r\n\t ";
>         char *token;
> @@ -220,15 +225,18 @@ static void process_line(char *line_buffer)
>                         i++;
>                         continue;
>                 }
> +
>                 if (argc < 2 || strcmp(argv[1], "?") == 0) {
>                         help_print_interface(interfaces[i]);
>                         return;
>                 }
> +
>                 m = get_method(interfaces[i]->methods, argv[1]);
>                 if (m != NULL) {
>                         m->func(argc, (const char **) argv);
>                         return;
>                 }
> +
>                 haltest_error("No function %s found\n", argv[1]);
>                 return;
>         }
> diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> index f5c84c1..dd5d12e 100644
> --- a/android/client/if-bt.c
> +++ b/android/client/if-bt.c
> @@ -82,13 +82,14 @@ static char *btproperty2str(bt_property_t property)
>         char *p;
>
>         p = buf + sprintf(buf, "type=%s len=%d val=",
> -                         bt_property_type_t2str(property.type), property.len);
> +                                       bt_property_type_t2str(property.type),
> +                                       property.len);
>
>         switch (property.type) {
>         case BT_PROPERTY_BDNAME:
>         case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
>                 sprintf(p, "%*s", property.len,
> -                       ((bt_bdname_t *) property.val)->name);
> +                                       ((bt_bdname_t *) property.val)->name);
>                 break;
>
>         case BT_PROPERTY_BDADDR:
> @@ -160,7 +161,7 @@ static char *btproperty2str(bt_property_t property)
>                         bt_service_record_t *rec = property.val;
>
>                         sprintf(p, "{%s, %d, %s}", btuuid2str(&rec->uuid),
> -                               rec->channel, rec->name);
> +                                               rec->channel, rec->name);
>                 }
>                 break;
>
> @@ -206,12 +207,14 @@ void add_remote_device(const bt_bdaddr_t *addr)
>                         remote_devices_capacity = 0;
>                         return;
>                 }
> +
>                 remote_devices_capacity = 4;
>         }
>
>         /* Array is sorted, search for right place */
>         for (i = 0; i < remote_devices_cnt; ++i) {
>                 int res = memcmp(&remote_devices[i], addr, sizeof(*addr));
> +
>                 if (res == 0)
>                         return; /* Already added */
>                 else if (res > 0)
> @@ -259,6 +262,7 @@ static void add_remote_device_from_props(int num_properties,
>                  * aligned buffer
>                  */
>                 bt_property_t property;
> +
>                 memcpy(&property, properties + i, sizeof(property));
>                 if (property.type == BT_PROPERTY_BDADDR)
>                         add_remote_device((bt_bdaddr_t *) property.val);
> @@ -270,21 +274,23 @@ static void adapter_state_changed_cb(bt_state_t state)
>         haltest_info("%s: state=%s\n", __func__, bt_state_t2str(state));
>  }
>
> -static void adapter_properties_cb(bt_status_t status,
> -       int num_properties, bt_property_t *properties)
> +static void adapter_properties_cb(bt_status_t status, int num_properties,
> +                                               bt_property_t *properties)
>  {
> -       haltest_info("%s: status=%s num_properties=%d\n",
> -              __func__, bt_status_t2str(status), num_properties);
> +       haltest_info("%s: status=%s num_properties=%d\n", __func__,
> +                               bt_status_t2str(status), num_properties);
>
>         dump_properties(num_properties, properties);
>  }
>
>  static void remote_device_properties_cb(bt_status_t status,
> -       bt_bdaddr_t *bd_addr, int num_properties, bt_property_t *properties)
> +                                       bt_bdaddr_t *bd_addr,
> +                                       int num_properties,
> +                                       bt_property_t *properties)
>  {
> -       haltest_info("%s: status=%s bd_addr=%s num_properties=%d\n",
> -              __func__, bt_status_t2str(status), bdaddr2str(bd_addr),
> -              num_properties);
> +       haltest_info("%s: status=%s bd_addr=%s num_properties=%d\n", __func__,
> +                       bt_status_t2str(status), bdaddr2str(bd_addr),
> +                       num_properties);
>
>         add_remote_device(bd_addr);
>
> @@ -303,7 +309,7 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
>  static void discovery_state_changed_cb(bt_discovery_state_t state)
>  {
>         haltest_info("%s: state=%s\n", __func__,
> -               bt_discovery_state_t2str(state));
> +                                       bt_discovery_state_t2str(state));
>  }
>
>  /*
> @@ -311,16 +317,16 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
>   * It's stored for command completion.
>   */
>  static char last_remote_addr[MAX_ADDR_STR_LEN];
> -static bt_ssp_variant_t last_ssp_variant = (bt_ssp_variant_t)-1;
> +static bt_ssp_variant_t last_ssp_variant = (bt_ssp_variant_t) -1;
>
>  static void pin_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
> -       uint32_t cod)
> +                                                               uint32_t cod)
>  {
>         /* Store for command completion */
>         bt_bdaddr_t2str(remote_bd_addr, last_remote_addr);
>
>         haltest_info("%s: remote_bd_addr=%s bd_name=%s cod=%06x\n", __func__,
> -                                      last_remote_addr, bd_name->name, cod);
> +                                       last_remote_addr, bd_name->name, cod);
>  }
>
>  static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
> @@ -332,26 +338,26 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
>         last_ssp_variant = pairing_variant;
>
>         haltest_info("%s: remote_bd_addr=%s bd_name=%s cod=%06x pairing_variant=%s pass_key=%d\n",
> -                    __func__, last_remote_addr, bd_name->name, cod,
> -                    bt_ssp_variant_t2str(pairing_variant), pass_key);
> +                       __func__, last_remote_addr, bd_name->name, cod,
> +                       bt_ssp_variant_t2str(pairing_variant), pass_key);
>  }
>
>  static void bond_state_changed_cb(bt_status_t status,
> -                                       bt_bdaddr_t *remote_bd_addr,
> -                                       bt_bond_state_t state)
> +                                               bt_bdaddr_t *remote_bd_addr,
> +                                               bt_bond_state_t state)
>  {
>         haltest_info("%s: status=%s remote_bd_addr=%s state=%s\n", __func__,
> -                      bt_status_t2str(status), bdaddr2str(remote_bd_addr),
> -                      bt_bond_state_t2str(state));
> +                       bt_status_t2str(status), bdaddr2str(remote_bd_addr),
> +                       bt_bond_state_t2str(state));
>  }
>
>  static void acl_state_changed_cb(bt_status_t status,
> -                                       bt_bdaddr_t *remote_bd_addr,
> -                                       bt_acl_state_t state)
> +                                               bt_bdaddr_t *remote_bd_addr,
> +                                               bt_acl_state_t state)
>  {
>         haltest_info("%s: status=%s remote_bd_addr=%s state=%s\n", __func__,
> -                      bt_status_t2str(status), bdaddr2str(remote_bd_addr),
> -                      bt_acl_state_t2str(state));
> +                       bt_status_t2str(status), bdaddr2str(remote_bd_addr),
> +                       bt_acl_state_t2str(state));
>  }
>
>  static void thread_evt_cb(bt_cb_thread_evt evt)
> @@ -409,7 +415,7 @@ static void init_p(int argc, const char **argv)
>         }
>
>         if_bluetooth =
> -           ((bluetooth_device_t *) device)->get_bluetooth_interface();
> +                   ((bluetooth_device_t *) device)->get_bluetooth_interface();
>         if (!if_bluetooth) {
>                 haltest_error("get_bluetooth_interface returned NULL\n");
>                 return;
> @@ -449,11 +455,11 @@ static void get_adapter_properties_p(int argc, const char **argv)
>  }
>
>  static void get_adapter_property_c(int argc, const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +                                       enum_func *enum_func, void **user)
>  {
>         if (argc == 3) {
> -               *puser = TYPE_ENUM(bt_property_type_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(bt_property_type_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -468,21 +474,22 @@ static void get_adapter_property_p(int argc, const char **argv)
>  }
>
>  static const char * const names[] = {
> -               "BT_PROPERTY_BDNAME",
> -               "BT_PROPERTY_ADAPTER_SCAN_MODE",
> -               "BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT", NULL
> +       "BT_PROPERTY_BDNAME",
> +       "BT_PROPERTY_ADAPTER_SCAN_MODE",
> +       "BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT",
> +       NULL
>  };
>
>  static void set_adapter_property_c(int argc, const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +                                       enum_func *enum_func, void **user)
>  {
>         if (argc == 3) {
> -               *puser = (void *) names;
> -               *penum_func = enum_strings;
> +               *user = (void *) names;
> +               *enum_func = enum_strings;
>         } else if (argc == 4) {
>                 if (0 == strcmp(argv[2], "BT_PROPERTY_ADAPTER_SCAN_MODE")) {
> -                       *puser = TYPE_ENUM(bt_scan_mode_t);
> -                       *penum_func = enum_defines;
> +                       *user = TYPE_ENUM(bt_scan_mode_t);
> +                       *enum_func = enum_defines;
>                 }
>         }
>  }
> @@ -529,12 +536,12 @@ static void set_adapter_property_p(int argc, const char **argv)
>  /*
>   * This function is to be used for completion methods that need only address
>   */
> -static void complete_addr_c(int argc, const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +static void complete_addr_c(int argc, const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *puser = NULL;
> -               *penum_func = enum_devices;
> +               *user = NULL;
> +               *enum_func = enum_devices;
>         }
>  }
>
> @@ -552,15 +559,15 @@ static void get_remote_device_properties_p(int argc, const char **argv)
>  }
>
>  static void get_remote_device_property_c(int argc, const char **argv,
> -                                               enum_func *penum_func,
> -                                                               void **puser)
> +                                                       enum_func *enum_func,
> +                                                       void **user)
>  {
>         if (argc == 3) {
> -               *puser = NULL;
> -               *penum_func = enum_devices;
> +               *user = NULL;
> +               *enum_func = enum_devices;
>         } else if (argc == 4) {
> -               *puser = TYPE_ENUM(bt_property_type_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(bt_property_type_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -596,7 +603,6 @@ static void set_remote_device_property_p(int argc, const char **argv)
>                 property.len = strlen(argv[4]);
>                 property.val = (char *) argv[4];
>                 break;
> -
>         default:
>                 return;
>         }
> @@ -621,6 +627,7 @@ static void get_remote_service_record_p(int argc, const char **argv)
>                 haltest_error("No uuid specified\n");
>                 return;
>         }
> +
>         str2bt_uuid_t(argv[3], &uuid);
>
>         EXEC(if_bluetooth->get_remote_service_record, &addr, &uuid);
> @@ -692,13 +699,14 @@ static void cancel_bond_p(int argc, const char **argv)
>         EXEC(if_bluetooth->cancel_bond, &addr);
>  }
>
> -static void pin_reply_c(int argc, const char **argv,
> -               enum_func *penum_func, void **puser)
> +static void pin_reply_c(int argc, const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         static const char *const completions[] = { last_remote_addr, NULL };
> +
>         if (argc == 3) {
> -               *puser = (void *) completions;
> -               *penum_func = enum_strings;
> +               *user = (void *) completions;
> +               *enum_func = enum_strings;
>         }
>  }
>
> @@ -721,22 +729,22 @@ static void pin_reply_p(int argc, const char **argv)
>         EXEC(if_bluetooth->pin_reply, &addr, accept, pin_len, &pin);
>  }
>
> -static void ssp_reply_c(int argc, const char **argv,
> -               enum_func *penum_func, void **puser)
> +static void ssp_reply_c(int argc, const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *puser = last_remote_addr;
> -               *penum_func = enum_one_string;
> +               *user = last_remote_addr;
> +               *enum_func = enum_one_string;
>         } else if (argc == 5) {
> -               *puser = "1";
> -               *penum_func = enum_one_string;
> +               *user = "1";
> +               *enum_func = enum_one_string;
>         } else if (argc == 4) {
>                 if (-1 != (int) last_ssp_variant) {
> -                       *puser = (void *) bt_ssp_variant_t2str(last_ssp_variant);
> -                       *penum_func = enum_one_string;
> +                       *user = (void *) bt_ssp_variant_t2str(last_ssp_variant);
> +                       *enum_func = enum_one_string;
>                 } else {
> -                       *puser = TYPE_ENUM(bt_ssp_variant_t);
> -                       *penum_func = enum_defines;
> +                       *user = TYPE_ENUM(bt_ssp_variant_t);
> +                       *enum_func = enum_defines;
>                 }
>         }
>  }
> @@ -755,11 +763,13 @@ static void ssp_reply_p(int argc, const char **argv)
>                 haltest_error("No ssp variant specified\n");
>                 return;
>         }
> +
>         var = str2btsspvariant(argv[3]);
>         if (argc < 5) {
>                 haltest_error("No accept value specified\n");
>                 return;
>         }
> +
>         accept = atoi(argv[4]);
>         passkey = 0;
>
> @@ -770,7 +780,7 @@ static void ssp_reply_p(int argc, const char **argv)
>  }
>
>  static void get_profile_interface_c(int argc, const char **argv,
> -               enum_func *penum_func, void **puser)
> +                                       enum_func *enum_func, void **user)
>  {
>         static const char *const profile_ids[] = {
>                 BT_PROFILE_HANDSFREE_ID,
> @@ -787,8 +797,8 @@ static void get_profile_interface_c(int argc, const char **argv,
>         };
>
>         if (argc == 3) {
> -               *puser = (void *) profile_ids;
> -               *penum_func = enum_strings;
> +               *user = (void *) profile_ids;
> +               *enum_func = enum_strings;
>         }
>  }
>
> @@ -803,22 +813,22 @@ static void get_profile_interface_p(int argc, const char **argv)
>         if (strcmp(BT_PROFILE_HANDSFREE_ID, id) == 0)
>                 pif = &dummy; /* TODO: change when if_hf is there */
>         else if (strcmp(BT_PROFILE_ADVANCED_AUDIO_ID, id) == 0)
> -               pif = (const void **)&if_av;
> +               pif = (const void **) &if_av;
>         else if (strcmp(BT_PROFILE_HEALTH_ID, id) == 0)
>                 pif = &dummy; /* TODO: change when if_hl is there */
>         else if (strcmp(BT_PROFILE_SOCKETS_ID, id) == 0)
> -               pif = (const void **)&if_sock;
> +               pif = (const void **) &if_sock;
>         else if (strcmp(BT_PROFILE_HIDHOST_ID, id) == 0)
> -               pif = (const void **)&if_hh;
> +               pif = (const void **) &if_hh;
>         else if (strcmp(BT_PROFILE_PAN_ID, id) == 0)
> -               pif = (const void **)&if_pan;
> +               pif = (const void **) &if_pan;
>  #if PLATFORM_SDK_VERSION > 17
>         else if (strcmp(BT_PROFILE_AV_RC_ID, id) == 0)
>                 pif = &dummy; /* TODO: change when if_rc is there */
>  #endif
>         else
>                 haltest_error("%s is not correct for get_profile_interface\n",
> -                    id);
> +                                                                       id);
>
>         if (pif != NULL) {
>                 *pif = if_bluetooth->get_profile_interface(id);
> @@ -836,6 +846,7 @@ static void dut_mode_configure_p(int argc, const char **argv)
>                 haltest_error("No dut mode specified\n");
>                 return;
>         }
> +
>         mode = strtol(argv[2], NULL, 0);
>
>         EXEC(if_bluetooth->dut_mode_configure, mode);
> @@ -851,7 +862,8 @@ static struct method methods[] = {
>         STD_METHODCH(set_adapter_property, "<prop_type> <prop_value>"),
>         STD_METHODCH(get_remote_device_properties, "<addr>"),
>         STD_METHODCH(get_remote_device_property, "<addr> <property_type>"),
> -       STD_METHODCH(set_remote_device_property, "<addr> <property_type> <value>"),
> +       STD_METHODCH(set_remote_device_property,
> +                                       "<addr> <property_type> <value>"),
>         STD_METHODCH(get_remote_service_record, "<addr> <uuid>"),
>         STD_METHODCH(get_remote_services, "<addr>"),
>         STD_METHOD(start_discovery),
> diff --git a/android/client/if-hh.c b/android/client/if-hh.c
> index e23e4d5..005b13a 100644
> --- a/android/client/if-hh.c
> +++ b/android/client/if-hh.c
> @@ -79,7 +79,7 @@ static void connection_state_cb(bt_bdaddr_t *bd_addr,
>         char addr[MAX_ADDR_STR_LEN];
>
>         haltest_info("%s: bd_addr=%s connection_state=%s\n", __func__,
> -                       bt_bdaddr_t2str(bd_addr, addr),
> +                                       bt_bdaddr_t2str(bd_addr, addr),
>                                         bthh_connection_state_t2str(state));
>         if (state == BTHH_CONN_STATE_CONNECTED)
>                 strcpy(connected_device_addr, addr);
> @@ -94,7 +94,7 @@ static void virtual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status)
>         char addr[MAX_ADDR_STR_LEN];
>
>         haltest_info("%s: bd_addr=%s hh_status=%s\n", __func__,
> -                       bt_bdaddr_t2str(bd_addr, addr),
> +                                               bt_bdaddr_t2str(bd_addr, addr),
>                                                 bthh_status_t2str(hh_status));
>  }
>
> @@ -122,9 +122,9 @@ static void protocol_mode_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status,
>         char addr[MAX_ADDR_STR_LEN];
>
>         haltest_info("%s: bd_addr=%s hh_status=%s mode=%s\n", __func__,
> -                       bt_bdaddr_t2str(bd_addr, addr),
> -                       bthh_status_t2str(hh_status),
> -                                               bthh_protocol_mode_t2str(mode));
> +                                       bt_bdaddr_t2str(bd_addr, addr),
> +                                       bthh_status_t2str(hh_status),
> +                                       bthh_protocol_mode_t2str(mode));
>  }
>
>  /*
> @@ -136,8 +136,8 @@ static void idle_time_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status,
>         char addr[MAX_ADDR_STR_LEN];
>
>         haltest_info("%s: bd_addr=%s hh_status=%s idle_rate=%d\n", __func__,
> -                       bt_bdaddr_t2str(bd_addr, addr),
> -                       bthh_status_t2str(hh_status), idle_rate);
> +                               bt_bdaddr_t2str(bd_addr, addr),
> +                               bthh_status_t2str(hh_status), idle_rate);
>  }
>
>
> @@ -152,8 +152,8 @@ static void get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status,
>
>         /* TODO: print actual report */
>         haltest_info("%s: bd_addr=%s hh_status=%s rpt_size=%d\n", __func__,
> -                       bt_bdaddr_t2str(bd_addr, addr),
> -                       bthh_status_t2str(hh_status), rpt_size);
> +                                       bt_bdaddr_t2str(bd_addr, addr),
> +                                       bthh_status_t2str(hh_status), rpt_size);
>  }
>
>  static bthh_callbacks_t bthh_callbacks = {
> @@ -177,12 +177,12 @@ static void init_p(int argc, const char **argv)
>
>  /* connect */
>
> -static void connect_c(int argc, const const char **argv,
> -                               enum_func *penum_func, void **puser)
> +static void connect_c(int argc, const const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *puser = (void *) connected_device_addr;
> -               *penum_func = enum_one_string;
> +               *user = (void *) connected_device_addr;
> +               *enum_func = enum_one_string;
>         }
>  }
>
> @@ -243,14 +243,14 @@ static void set_info_p(int argc, const char **argv)
>  /* get_protocol */
>
>  static void get_protocol_c(int argc, const const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +                                       enum_func *enum_func, void **user)
>  {
>         if (argc == 3) {
> -               *puser = connected_device_addr;
> -               *penum_func = enum_one_string;
> +               *user = connected_device_addr;
> +               *enum_func = enum_one_string;
>         } else if (argc == 4) {
> -               *puser = TYPE_ENUM(bthh_protocol_mode_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(bthh_protocol_mode_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -296,14 +296,14 @@ static void set_protocol_p(int argc, const char **argv)
>  /* get_report */
>
>  static void get_report_c(int argc, const const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +                                       enum_func *enum_func, void **user)
>  {
>         if (argc == 3) {
> -               *puser = connected_device_addr;
> -               *penum_func = enum_one_string;
> +               *user = connected_device_addr;
> +               *enum_func = enum_one_string;
>         } else if (argc == 4) {
> -               *puser = TYPE_ENUM(bthh_report_type_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(bthh_report_type_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -341,14 +341,14 @@ static void get_report_p(int argc, const char **argv)
>  /* set_report */
>
>  static void set_report_c(int argc, const const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +                                       enum_func *enum_func, void **user)
>  {
>         if (argc == 3) {
> -               *puser = connected_device_addr;
> -               *penum_func = enum_one_string;
> +               *user = connected_device_addr;
> +               *enum_func = enum_one_string;
>         } else if (argc == 4) {
> -               *puser = TYPE_ENUM(bthh_report_type_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(bthh_report_type_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -376,12 +376,12 @@ static void set_report_p(int argc, const char **argv)
>
>  /* send_data */
>
> -static void send_data_c(int argc, const const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +static void send_data_c(int argc, const const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *puser = connected_device_addr;
> -               *penum_func = enum_one_string;
> +               *user = connected_device_addr;
> +               *enum_func = enum_one_string;
>         }
>  }
>
> diff --git a/android/client/if-main.h b/android/client/if-main.h
> index f2d35d9..eaee914 100644
> --- a/android/client/if-main.h
> +++ b/android/client/if-main.h
> @@ -93,11 +93,11 @@ typedef const char *(*enum_func)(void *user, int i);
>
>  /*
>   * This is prototype of function that when given argc, argv will
> - * fill penum_func with pointer to function that will enumerate
> - * parameters for argc argument, puser will be passed to penum_func.
> + * fill enum_func with pointer to function that will enumerate
> + * parameters for argc argument, user will be passed to enum_func.
>   */
> -typedef void (*tab_complete)(int argc, const char **argv,
> -                                       enum_func *penum_func, void **puser);
> +typedef void (*tab_complete)(int argc, const char **argv, enum_func *enum_func,
> +                                                               void **user);
>
>  /*
>   * For each method there is name and two functions to parse command line
> @@ -145,9 +145,9 @@ struct method *get_command(const char *name);
>
>  #define VERIFY_ADDR_ARG(n, adr) \
>         do { \
> -               if (n < argc) \
> +               if (n < argc) {\
>                         str2bt_bdaddr_t(argv[n], adr); \
> -               else { \
> +               } else { \
>                         haltest_error("No address specified\n");\
>                         return;\
>                 } \
> diff --git a/android/client/if-pan.c b/android/client/if-pan.c
> index e9cfa23..dcc7e80 100644
> --- a/android/client/if-pan.c
> +++ b/android/client/if-pan.c
> @@ -45,12 +45,12 @@ static void control_state_cb(btpan_control_state_t state, bt_status_t error,
>                                         int local_role, const char *ifname)
>  {
>         haltest_info("%s: state=%s error=%s local_role=%s ifname=%s\n",
> -                      __func__, btpan_control_state_t2str(state),
> -                      bt_status_t2str(error), btpan_role_t2str(local_role),
> -                      ifname);
> +                       __func__, btpan_control_state_t2str(state),
> +                       bt_status_t2str(error), btpan_role_t2str(local_role),
> +                       ifname);
>  }
>
> -static char last_used_addr[18];
> +static char last_used_addr[MAX_ADDR_STR_LEN];
>
>  static void connection_state_cb(btpan_connection_state_t state,
>                                 bt_status_t error, const bt_bdaddr_t *bd_addr,
> @@ -79,12 +79,12 @@ static void init_p(int argc, const char **argv)
>
>  /* enable */
>
> -static void enable_c(int argc, const const char **argv, enum_func *penum_func,
> -                                                               void **puser)
> +static void enable_c(int argc, const const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *puser = TYPE_ENUM(btpan_role_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(btpan_role_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -120,15 +120,15 @@ static void get_local_role_p(int argc, const char **argv)
>
>  /* connect */
>
> -static void connect_c(int argc, const const char **argv, enum_func *penum_func,
> -                                                               void **puser)
> +static void connect_c(int argc, const const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *puser = NULL;
> -               *penum_func = enum_devices;
> +               *user = NULL;
> +               *enum_func = enum_devices;
>         } else if (argc == 4 || argc == 5) {
> -               *puser = TYPE_ENUM(btpan_role_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(btpan_role_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -165,11 +165,11 @@ static void connect_p(int argc, const char **argv)
>  /* disconnect */
>
>  static void disconnect_c(int argc, const const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +                                       enum_func *enum_func, void **user)
>  {
>         if (argc == 3) {
> -               *puser = last_used_addr;
> -               *penum_func = enum_one_string;
> +               *user = last_used_addr;
> +               *enum_func = enum_one_string;
>         }
>  }
>
> diff --git a/android/client/if-sock.c b/android/client/if-sock.c
> index f3125f8..dcaf048 100644
> --- a/android/client/if-sock.c
> +++ b/android/client/if-sock.c
> @@ -52,7 +52,6 @@ static void receive_from_client(struct pollfd *pollfd)
>                 haltest_error("Disconnected fd=%d\n", pollfd->fd);
>                 poll_unregister_fd(pollfd->fd, receive_from_client);
>         } else if (pollfd->revents & POLLIN) {
> -
>                 haltest_info("receiving from client fd=%d\n", pollfd->fd);
>
>                 do {
> @@ -95,9 +94,10 @@ static void receive_sock_connect_signal(struct pollfd *pollfd)
>                         haltest_info("Read on connect return %d\n", ret);
>                         return;
>                 }
> +
>                 haltest_info("Connection to %s channel %d status=%d\n",
>                                 bt_bdaddr_t2str(&cs.bd_addr, addr_str),
> -                                                       cs.channel, cs.status);
> +                               cs.channel, cs.status);
>
>                 if (cs.status == 0)
>                         poll_register_fd(pollfd->fd, POLLIN,
> @@ -106,7 +106,7 @@ static void receive_sock_connect_signal(struct pollfd *pollfd)
>
>         if (pollfd->revents & POLLHUP) {
>                 haltest_error("Disconnected fd=%d revents=0x%X\n", pollfd->fd,
> -                                                       pollfd->revents);
> +                               pollfd->revents);
>                 poll_unregister_fd(pollfd->fd, receive_sock_connect_signal);
>         }
>  }
> @@ -165,6 +165,7 @@ static void read_accepted(int fd)
>                 accepted_fd = descs[0];
>                 break;
>         }
> +
>         haltest_info("Incoming connection from %s channel %d status=%d fd=%d\n",
>                                         bt_bdaddr_t2str(&cs.bd_addr, addr_str),
>                                         cs.channel, cs.status, accepted_fd);
> @@ -184,12 +185,12 @@ static void client_connected(struct pollfd *pollfd)
>
>  /** listen */
>
> -static void listen_c(int argc, const char **argv, enum_func *penum_func,
> -                                                               void **puser)
> +static void listen_c(int argc, const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *puser = TYPE_ENUM(btsock_type_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(btsock_type_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -253,14 +254,14 @@ static void listen_p(int argc, const char **argv)
>
>  /** connect */
>
> -static void connect_c(int argc, const char **argv,
> -                                       enum_func *penum_func, void **puser)
> +static void connect_c(int argc, const char **argv, enum_func *enum_func,
> +                                                               void **user)
>  {
>         if (argc == 3) {
> -               *penum_func = enum_devices;
> +               *enum_func = enum_devices;
>         } else if (argc == 4) {
> -               *puser = TYPE_ENUM(btsock_type_t);
> -               *penum_func = enum_defines;
> +               *user = TYPE_ENUM(btsock_type_t);
> +               *enum_func = enum_defines;
>         }
>  }
>
> @@ -313,6 +314,7 @@ static void connect_p(int argc, const char **argv)
>         if (sock_fd > 0) {
>                 int channel = 0;
>                 int ret = read(sock_fd, &channel, 4);
> +
>                 if (ret != 4)
>                         haltest_info("Read channel failed\n");
>                 haltest_info("Channel returned from first read %d\n", channel);
> diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
> index 2b95591..69af609 100644
> --- a/android/client/tabcompletion.c
> +++ b/android/client/tabcompletion.c
> @@ -63,8 +63,8 @@ static void print_matches(enum_func f, void *user, const char *prefix, int len)
>   * buf - output buffer to keep splited arguments list
>   * buf_size_in_bytes - size of buf
>   */
> -static int split_command(const char *line_buffer, int size,
> -                                       split_arg_t *buf, int buf_size_in_bytes)
> +static int split_command(const char *line_buffer, int size, split_arg_t *buf,
> +                                                       int buf_size_in_bytes)
>  {
>         split_arg_t *prev = NULL;
>         split_arg_t *arg = buf;
> @@ -218,8 +218,8 @@ static void method_completion(const struct interface *iface, split_arg_t *arg)
>  static const char *bold = "\x1b[1m";
>  static const char *normal = "\x1b[0m";
>
> -static bool find_nth_argument(const char *str, int n,
> -                                               const char **s, const char **e)
> +static bool find_nth_argument(const char *str, int n, const char **s,
> +                                                               const char **e)
>  {
>         const char *p = str;
>         int argc = 0;
> diff --git a/android/client/terminal.c b/android/client/terminal.c
> index a57068a..88c963b 100644
> --- a/android/client/terminal.c
> +++ b/android/client/terminal.c
> @@ -214,6 +214,7 @@ static void terminal_line_replaced(void)
>                         putchar('\b');
>                         line_buf_ix--;
>                 }
> +
>                 /* If cursor was not at the end, move it to the end */
>                 if (line_buf_ix < line_len)
>                         printf("%.*s", line_len - line_buf_ix,
> @@ -222,6 +223,7 @@ static void terminal_line_replaced(void)
>                 while (line_len >= len++)
>                         putchar(' ');
>         }
> +
>         /* draw new line */
>         printf("\r%s%s", prompt, line_buf);
>         /* set up indexes to new line */
> @@ -321,6 +323,7 @@ static int terminal_convert_sequence(int c)
>                }
>                return c;
>         }
> +
>         /* Inside sequence */
>         current_sequence[current_sequence_len++] = c;
>         current_sequence[current_sequence_len] = '\0';
> @@ -338,6 +341,7 @@ static int terminal_convert_sequence(int c)
>                 /* partial match (not whole sequence yet) */
>                 return KEY_SEQUNCE_NOT_FINISHED;
>         }
> +
>         terminal_print("ansii char 0x%X %c\n", c);
>         /*
>          * Sequence does not match
> @@ -530,6 +534,7 @@ void terminal_process_char(int c, void (*process_line)(char *line))
>                         printf("char-0x%02x\n", c);
>                         break;
>                 }
> +
>                 if (line_buf_ix < LINE_BUF_MAX - 1) {
>                         if (line_len == line_buf_ix) {
>                                 putchar(c);
> diff --git a/android/client/textconv.h b/android/client/textconv.h
> index 056e706..085b141 100644
> --- a/android/client/textconv.h
> +++ b/android/client/textconv.h
> @@ -58,7 +58,7 @@ const char *enum_defines(void *v, int i);
>  const char *enum_strings(void *v, int i);
>  const char *enum_one_string(void *v, int i);
>
> -#define TYPE_ENUM(type) ((void *)&__##type##2str[0])
> +#define TYPE_ENUM(type) ((void *) &__##type##2str[0])
>  #define DECINTMAP(type) \
>  extern struct int2str __##type##2str[]; \
>  const char *type##2##str(type v); \
> --
> 1.7.9.5

Applied, thanks.


-- 
Luiz Augusto von Dentz
