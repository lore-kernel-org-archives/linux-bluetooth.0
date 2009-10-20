Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1256006947-19065-1-git-send-email-forrest.zhao@intel.com>
References: <1256006947-19065-1-git-send-email-forrest.zhao@intel.com>
Date: Tue, 20 Oct 2009 11:05:24 +0800
Message-ID: <ac8af0be0910192005t513eccf0q330568b1d858aee4@mail.gmail.com>
Subject: Re: [PATCH] Implements the OBEX server/SyncML client binding for
From: Zhao Forrest <forrest.zhao@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, patrick.ohly@intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There're some issues with email subject, please ignore this email.
Will send out the patch later.

On Tue, Oct 20, 2009 at 10:49 AM, Forrest Zhao <forrest.zhao@intel.com> wrote:
> In particular this patch supports Server Alerted Sync(SAN).
> With server alerted sync, the SyncML server initiates the OBEX link,
> so it is the OBEX client. On the other hand the SyncML client waits
> for the request from SyncML server, so it is the OBEX server.
>
> OBEX/SyncML binding spec is at http://www.openmobilealliance.net/
> Technical/release_program/docs/Common/V1_2_1-20070813-A/OMA-TS-SyncML_OBEXBinding-V1_2-20070221-A.pdf
> ---
>  Makefile.am         |    2 +-
>  src/main.c          |   16 ++-
>  src/manager.c       |   33 +++++
>  src/obex.c          |   47 +++++--
>  src/obex.h          |   10 ++
>  src/syncevolution.c |  362 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 457 insertions(+), 13 deletions(-)
>  create mode 100644 src/syncevolution.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 63f7478..49817ee 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -31,7 +31,7 @@ src_obexd_SOURCES = $(gdbus_sources) \
>                        src/main.c src/obexd.h src/plugin.h src/plugin.c \
>                        src/logging.h src/logging.c src/btio.h src/btio.c \
>                        src/dbus.h src/manager.c src/obex.h src/obex.c \
> -                       src/opp.c src/ftp.c src/pbap.c \
> +                       src/opp.c src/ftp.c src/pbap.c src/syncevolution.c \
>                        src/bluetooth.h src/bluetooth.c \
>                        src/phonebook.h src/phonebook.c
>
> diff --git a/src/main.c b/src/main.c
> index abd2bcc..36d814f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -53,6 +53,7 @@
>  #define OPP_CHANNEL    9
>  #define FTP_CHANNEL    10
>  #define PBAP_CHANNEL   15
> +#define SYNCEVOLUTION_CHANNEL  16
>  #define PCSUITE_CHANNEL        24
>
>  #define DEFAULT_ROOT_PATH "/tmp"
> @@ -172,6 +173,7 @@ static gboolean option_ftp = FALSE;
>  static gboolean option_pbap = FALSE;
>  static gboolean option_pcsuite = FALSE;
>  static gboolean option_symlinks = FALSE;
> +static gboolean option_syncevolution = FALSE;
>
>  static GOptionEntry options[] = {
>        { "nodaemon", 'n', G_OPTION_FLAG_REVERSE,
> @@ -199,6 +201,8 @@ static GOptionEntry options[] = {
>                                "Enable Phonebook Access server" },
>        { "pcsuite", 's', 0, G_OPTION_ARG_NONE, &option_pcsuite,
>                                "Enable PC Suite Services server" },
> +       { "syncevolution", 'e', 0, G_OPTION_ARG_NONE, &option_syncevolution,
> +                               "Enable OBEX server for Syncevolution client" },
>        { NULL },
>  };
>
> @@ -337,9 +341,9 @@ int main(int argc, char *argv[])
>                log_option |= LOG_PERROR;
>
>        if (option_opp == FALSE && option_ftp == FALSE &&
> -                                               option_pbap == FALSE) {
> +               option_pbap == FALSE && option_syncevolution == FALSE) {
>                fprintf(stderr, "No server selected (use either "
> -                                       "--opp or --ftp or both)\n");
> +                               "--opp, --ftp, --pbap or --syncevolution)\n");
>                exit(EXIT_FAILURE);
>        }
>
> @@ -408,6 +412,14 @@ int main(int argc, char *argv[])
>                                option_capability);
>        }
>
> +       if (option_syncevolution == TRUE) {
> +               services |= OBEX_SYNCEVOLUTION;
> +               bluetooth_init(OBEX_SYNCEVOLUTION, "OBEX server for"
> +                               " Syncevolution client", NULL,
> +                               SYNCEVOLUTION_CHANNEL, TRUE, FALSE, FALSE,
> +                               NULL);
> +       }
> +
>        if (option_devnode)
>                devnode_setup();
>
> diff --git a/src/manager.c b/src/manager.c
> index 24ed3db..c36ecfd 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -216,6 +216,35 @@ static const gchar *pcsuite_record =
>   </attribute>                                                                 \
>  </record>";
>
> +static const gchar *syncevolution_record =
> +"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>                                   \
> +<record>                                                                       \
> + <attribute id=\"0x0001\">                                                     \
> +    <sequence>                                                                 \
> +      <uuid value=\"00000002-0000-1000-8000-0002ee000002\"/>                   \
> +    </sequence>                                                                        \
> + </attribute>                                                                  \
> +                                                                               \
> + <attribute id=\"0x0004\">                                                     \
> +    <sequence>                                                                 \
> +      <sequence>                                                               \
> +        <uuid value=\"0x0100\"/>                                               \
> +      </sequence>                                                              \
> +      <sequence>                                                               \
> +        <uuid value=\"0x0003\"/>                                               \
> +        <uint8 value=\"%u\" name=\"channel\"/>                                 \
> +      </sequence>                                                              \
> +      <sequence>                                                               \
> +        <uuid value=\"0x0008\"/>                                               \
> +      </sequence>                                                              \
> +    </sequence>                                                                        \
> + </attribute>                                                                  \
> +                                                                               \
> + <attribute id=\"0x0100\">                                                     \
> +    <text value=\"%s\" name=\"name\"/>                                         \
> + </attribute>                                                                  \
> +</record>";
> +
>  #define TRANSFER_INTERFACE OPENOBEX_SERVICE ".Transfer"
>  #define SESSION_INTERFACE OPENOBEX_SERVICE ".Session"
>
> @@ -525,6 +554,10 @@ static gchar *create_xml_record(const char *name,
>        case OBEX_PCSUITE:
>                xml = g_markup_printf_escaped(pcsuite_record, channel, name);
>                break;
> +       case OBEX_SYNCEVOLUTION:
> +               xml = g_markup_printf_escaped(syncevolution_record, channel,
> +                                                               name);
> +               break;
>        default:
>                xml = NULL;
>                break;
> diff --git a/src/obex.c b/src/obex.c
> index 9ec9c5b..61fc5c5 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -53,6 +53,7 @@
>  #define DEFAULT_TX_MTU 32767
>
>  #define TARGET_SIZE 16
> +#define SYNCML_TARGET_SIZE 11
>
>  static const guint8 FTP_TARGET[TARGET_SIZE] = {
>                        0xF9, 0xEC, 0x7B, 0xC4,  0x95, 0x3C, 0x11, 0xD2,
> @@ -62,6 +63,10 @@ static const guint8 PBAP_TARGET[TARGET_SIZE] = {
>                        0x79, 0x61, 0x35, 0xF0,  0xF0, 0xC5, 0x11, 0xD8,
>                        0x09, 0x66, 0x08, 0x00,  0x20, 0x0C, 0x9A, 0x66  };
>
> +static const guint8 SYNCML_TARGET[SYNCML_TARGET_SIZE] = {
> +                       0x53, 0x59, 0x4E, 0x43, 0x4D, 0x4C, 0x2D, 0x53,
> +                       0x59, 0x4E, 0x43 };
> +
>  /* Connection ID */
>  static guint32 cid = 0x0000;
>
> @@ -91,6 +96,11 @@ struct obex_commands pbap = {
>        .setpath        = pbap_setpath,
>  };
>
> +struct obex_commands synce = {
> +       .put            = synce_put,
> +       .get            = synce_get,
> +};
> +
>  static void os_reset_session(struct obex_session *os)
>  {
>        if (os->fd > 0) {
> @@ -119,6 +129,7 @@ static void os_reset_session(struct obex_session *os)
>        os->offset = 0;
>        os->size = OBJECT_SIZE_DELETE;
>        os->finished = 0;
> +       os->reply_received = 0;
>  }
>
>  static void os_session_mark_aborted(struct obex_session *os)
> @@ -145,6 +156,9 @@ static void obex_session_free(struct obex_session *os)
>
>        if (os->target && !memcmp(os->target, PBAP_TARGET, TARGET_SIZE))
>                pbap_phonebook_context_destroy(os);
> +       else if (os->target && !memcmp(os->target, SYNCML_TARGET,
> +                                       SYNCML_TARGET_SIZE))
> +               synce_destroy(os);
>
>        g_free(os);
>  }
> @@ -202,7 +216,7 @@ static void cmd_connect(struct obex_session *os,
>        obex_connect_hdr_t *nonhdr;
>        obex_headerdata_t hd;
>        uint8_t *buffer;
> -       guint hlen, newsize;
> +       guint hlen, newsize, target_size;
>        guint16 mtu;
>        guint8 hi;
>
> @@ -227,8 +241,20 @@ static void cmd_connect(struct obex_session *os,
>        os->cid = ++cid;
>
>        while (OBEX_ObjectGetNextHeader(obex, obj, &hi, &hd, &hlen)) {
> -               if (hi != OBEX_HDR_TARGET || hlen != TARGET_SIZE)
> +               if (hi != OBEX_HDR_TARGET || (hlen != TARGET_SIZE &&
> +                                       hlen != SYNCML_TARGET_SIZE))
>                        continue;
> +               target_size = hlen;
> +
> +               if (memcmp(hd.bs, SYNCML_TARGET, SYNCML_TARGET_SIZE) == 0 &&
> +                               os->server->services & OBEX_SYNCEVOLUTION) {
> +                       if (!synce_connect(os))
> +                               break;
> +
> +                       os->target = SYNCML_TARGET;
> +                       os->cmds = &synce;
> +                       break;
> +               }
>
>                if (memcmp(hd.bs, FTP_TARGET, TARGET_SIZE) == 0 &&
>                                os->server->services &
> @@ -270,7 +296,7 @@ static void cmd_connect(struct obex_session *os,
>        /* Append received UUID in WHO header */
>        hd.bs = os->target;
>        OBEX_ObjectAddHeader(obex, obj,
> -                       OBEX_HDR_WHO, hd, TARGET_SIZE,
> +                       OBEX_HDR_WHO, hd, target_size,
>                        OBEX_FL_FIT_ONE_PACKET);
>        hd.bq4 = cid;
>        OBEX_ObjectAddHeader(obex, obj,
> @@ -337,7 +363,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
>                os->name = NULL;
>        }
>
> -       if (os->buf) {
> +       if (os->buf && memcmp(os->target, SYNCML_TARGET, SYNCML_TARGET_SIZE)) {
>                g_free(os->buf);
>                os->buf = NULL;
>        }
> @@ -599,15 +625,15 @@ static gint obex_read_stream(struct obex_session *os, obex_t *obex,
>        }
>
>        if (os->fd < 0 && size > 0) {
> -               if (os->buf) {
> +               if (os->buf && memcmp(os->target, SYNCML_TARGET,
> +                                       SYNCML_TARGET_SIZE)) {
>                        error("Got more data but there is still a pending buffer");
>                        return -EIO;
>                }
>
> -               os->buf = g_malloc0(os->rx_mtu);
> -               memcpy(os->buf, buffer, size);
> -               os->offset = size;
> -
> +               os->buf = g_realloc(os->buf, os->offset + size);
> +               memcpy(os->buf + os->offset, buffer, size);
> +               os->offset += size;
>                debug("Stored %u bytes into temporary buffer", size);
>
>                return 0;
> @@ -710,7 +736,8 @@ static gboolean check_put(obex_t *obex, obex_object_t *obj)
>
>        OBEX_ObjectReParseHeaders(obex, obj);
>
> -       if (!os->name) {
> +       if (!os->name && memcmp(os->target, SYNCML_TARGET,
> +                                       SYNCML_TARGET_SIZE)) {
>                OBEX_ObjectSetRsp(obj, OBEX_RSP_BAD_REQUEST,
>                                OBEX_RSP_BAD_REQUEST);
>                g_free(os->type);
> diff --git a/src/obex.h b/src/obex.h
> index 94a273e..b9af4ed 100644
> --- a/src/obex.h
> +++ b/src/obex.h
> @@ -27,6 +27,7 @@
>  #include <config.h>
>  #endif
>
> +#include <dbus/dbus.h>
>  #include <glib.h>
>
>  #include "phonebook.h"
> @@ -36,6 +37,7 @@
>  #define OBEX_BIP       (1 << 3)
>  #define OBEX_PBAP      (1 << 4)
>  #define OBEX_PCSUITE   (1 << 5)
> +#define OBEX_SYNCEVOLUTION     (1 << 6)
>
>  #define OBJECT_SIZE_UNKNOWN -1
>  #define OBJECT_SIZE_DELETE -2
> @@ -86,6 +88,9 @@ struct obex_session {
>        obex_t          *obex;
>        struct phonebook_context *pbctx;
>        gboolean        finished;
> +       DBusConnection  *dbus_conn;
> +       gchar           *conn_obj;
> +       gboolean        reply_received;
>  };
>
>  gint obex_session_start(GIOChannel *io, struct server *server);
> @@ -106,6 +111,11 @@ gboolean pbap_phonebook_context_create(struct obex_session *session);
>  void pbap_phonebook_context_destroy(struct obex_session *session);
>  struct obex_session *pbap_get_session(struct phonebook_context *context);
>
> +gboolean synce_connect(struct obex_session *os);
> +void synce_put(obex_t *obex, obex_object_t *obj);
> +void synce_get(obex_t *obex, obex_object_t *obj);
> +void synce_destroy(struct obex_session *os);
> +
>  gint os_prepare_get(struct obex_session *os, gchar *file, guint32 *size);
>  gint os_prepare_put(struct obex_session *os);
>
> diff --git a/src/syncevolution.c b/src/syncevolution.c
> new file mode 100644
> index 0000000..c65fce9
> --- /dev/null
> +++ b/src/syncevolution.c
> @@ -0,0 +1,362 @@
> +/*
> + *
> + *  OBEX Server
> + *
> + *  Copyright (C) 2007-2008  Intel Corporation
> + *  Copyright (C) 2007-2009  Marcel Holtmann <marcel@holtmann.org>
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <string.h>
> +#include <stdio.h>
> +#include <glib.h>
> +
> +#include <bluetooth/bluetooth.h>
> +
> +#include <openobex/obex.h>
> +#include <openobex/obex_const.h>
> +
> +#include "logging.h"
> +#include "obex.h"
> +#include "obexd.h"
> +#include "dbus.h"
> +#include "btio.h"
> +
> +#define SYNCE_BUS_NAME "org.syncevolution"
> +#define SYNCE_PATH     "/org/syncevolution/Server"
> +#define SYNCE_SERVER_INTERFACE "org.syncevolution.Server"
> +#define SYNCE_CONN_INTERFACE   "org.syncevolution.Connection"
> +
> +static char match_string[256];
> +
> +struct cb_data {
> +       struct obex_session *os;
> +       obex_object_t *obj;
> +} process_cb_data;
> +
> +static GSList *os_list = NULL;
> +
> +static void dbus_message_iter_append_dict_entry(DBusMessageIter *dict,
> +                               const char *key, int type, void *val)
> +{
> +       DBusMessageIter entry;
> +
> +       dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
> +                                               NULL, &entry);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
> +       dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &val);
> +       dbus_message_iter_close_container(dict, &entry);
> +}
> +
> +static void handle_connection_reply_signal(DBusMessage *msg,
> +                               const char *obj_path, void *data)
> +{
> +       struct obex_session *os = data;
> +       DBusMessageIter iter, array_iter;
> +       gchar *value;
> +       gint length = 0;
> +
> +       if (strcmp(os->conn_obj, obj_path))
> +               return;
> +
> +       dbus_message_iter_init(msg, &iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
> +               error("Unexpected signature in Reply signal");
> +       }
> +
> +       dbus_message_iter_recurse(&iter, &array_iter);
> +       dbus_message_iter_get_fixed_array(&array_iter, &value, &length);
> +
> +       if (length) {
> +               os->buf = g_try_malloc(length);
> +               memcpy(os->buf, value, length);
> +               os->size = length;
> +               os->reply_received = TRUE;
> +               os->finished = TRUE;
> +               OBEX_ResumeRequest(os->obex);
> +       }
> +}
> +
> +static void handle_connection_abort_signal(DBusMessage *msg,
> +                               const char *obj_path, void *data)
> +{
> +       struct obex_session *os = data;
> +
> +       OBEX_TransportDisconnect(os->obex);
> +}
> +
> +static DBusHandlerResult signal_filter(DBusConnection *conn,
> +                               DBusMessage *msg, void *data)
> +{
> +       const char *path = dbus_message_get_path(msg);
> +       struct obex_session *os = NULL;
> +       GSList *l;
> +
> +       if (dbus_message_get_type(msg) != DBUS_MESSAGE_TYPE_SIGNAL)
> +               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +
> +       for (l = os_list; l != NULL; l = l->next) {
> +               struct obex_session *tmp_os = l->data;
> +               if (!strcmp(tmp_os->conn_obj, path)) {
> +                       os = tmp_os;
> +                       break;
> +               }
> +       }
> +       if (!os)
> +               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +
> +       if (dbus_message_is_signal(msg, SYNCE_CONN_INTERFACE, "Reply")) {
> +               debug("Reply signal is received.");
> +               handle_connection_reply_signal(msg, path, os);
> +       } else if (dbus_message_is_signal(msg, SYNCE_CONN_INTERFACE, "Abort")) {
> +               debug("Abort signal is received.");
> +               handle_connection_abort_signal(msg, path, os);
> +       }
> +
> +       return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +}
> +
> +static void connect_cb(DBusPendingCall *call, void *user_data)
> +{
> +       static gboolean signal_filter_added = FALSE;
> +       struct obex_session *os = user_data;
> +       DBusConnection *conn = os->dbus_conn;
> +       DBusMessage *reply;
> +       gchar *path;
> +
> +       reply = dbus_pending_call_steal_reply(call);
> +
> +       dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> +                                               DBUS_TYPE_INVALID);
> +       info("Got conn object %s from syncevolution", path);
> +       os->conn_obj = g_strdup(path);
> +
> +       /* add signal filter */
> +       if (!signal_filter_added) {
> +               if (!dbus_connection_add_filter(conn, signal_filter,
> +                                                       os, NULL)) {
> +                       error("Can't add signal filter");
> +                       dbus_message_unref(reply);
> +                       return;
> +               }
> +               signal_filter_added = TRUE;
> +       }
> +       os_list = g_slist_append(os_list, os);
> +       snprintf(match_string, sizeof(match_string), "type=signal,interface=%s,"
> +                               "path=%s", SYNCE_CONN_INTERFACE, os->conn_obj);
> +       dbus_bus_add_match(conn, match_string, NULL);
> +       dbus_connection_flush(conn);
> +
> +       dbus_message_unref(reply);
> +}
> +
> +static void process_cb(DBusPendingCall *call, void *user_data)
> +{
> +       DBusMessage *reply;
> +       DBusError derr;
> +
> +       info("At the begin of process_cb().");
> +       reply = dbus_pending_call_steal_reply(call);
> +       dbus_error_init(&derr);
> +       if (dbus_set_error_from_message(&derr, reply)) {
> +               error("process_cb(): syncevolution replied with an error:"
> +                                       " %s, %s", derr.name, derr.message);
> +               dbus_error_free(&derr);
> +       }
> +       dbus_message_unref(reply);
> +}
> +
> +gboolean synce_connect(struct obex_session *os)
> +{
> +       DBusConnection *conn = NULL;
> +       GError *err = NULL;
> +       char address[18];
> +       guint8 channel;
> +       DBusMessage *msg;
> +       DBusMessageIter iter, dict;
> +       gchar id[36];
> +       gchar transport[36];
> +       gchar transport_description[24];
> +       gboolean authenticate = FALSE;
> +       char *session = "";
> +       DBusPendingCall *call;
> +
> +       conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (conn == NULL)
> +               return FALSE;
> +
> +       bt_io_get(os->io, BT_IO_RFCOMM, &err,
> +                       BT_IO_OPT_DEST, address,
> +                       BT_IO_OPT_CHANNEL, &channel,
> +                       BT_IO_OPT_INVALID);
> +
> +       msg = dbus_message_new_method_call(SYNCE_BUS_NAME, SYNCE_PATH,
> +                               SYNCE_SERVER_INTERFACE, "Connect");
> +       dbus_message_iter_init_append(msg, &iter);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +               DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +               DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_STRING_AS_STRING
> +               DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
> +
> +       snprintf(id, sizeof(id), "%s+%u", address, channel);
> +       dbus_message_iter_append_dict_entry(&dict, "id", DBUS_TYPE_STRING, id);
> +
> +       snprintf(transport, sizeof(transport), "%s.obexd",
> +                                       OPENOBEX_SERVICE);
> +       dbus_message_iter_append_dict_entry(&dict, "transport",
> +                               DBUS_TYPE_STRING, transport);
> +
> +       snprintf(transport_description, sizeof(transport_description),
> +                                       "version %s", VERSION);
> +       dbus_message_iter_append_dict_entry(&dict, "transport_description",
> +                               DBUS_TYPE_STRING, transport_description);
> +       dbus_message_iter_close_container(&iter, &dict);
> +       dbus_message_append_args(msg, DBUS_TYPE_BOOLEAN, &authenticate,
> +                       DBUS_TYPE_STRING, &session, DBUS_TYPE_INVALID);
> +
> +       if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
> +               error("D-Bus call to %s failed.", SYNCE_SERVER_INTERFACE);
> +               dbus_message_unref(msg);
> +               return FALSE;
> +       }
> +
> +       dbus_pending_call_set_notify(call, connect_cb, os, NULL);
> +
> +       os->dbus_conn = conn;
> +
> +       dbus_pending_call_unref(call);
> +       dbus_message_unref(msg);
> +       return TRUE;
> +}
> +
> +void synce_put(obex_t *obex, obex_object_t *obj)
> +{
> +       struct obex_session *os;
> +       DBusMessage *msg;
> +       DBusMessageIter iter, array_iter;
> +       DBusPendingCall *call;
> +
> +       os = OBEX_GetUserData(obex);
> +       if (os == NULL)
> +               return;
> +
> +       if (!os->conn_obj) {
> +               OBEX_ObjectSetRsp(obj, OBEX_RSP_SERVICE_UNAVAILABLE,
> +                                       OBEX_RSP_SERVICE_UNAVAILABLE);
> +               return;
> +       }
> +
> +       msg = dbus_message_new_method_call(SYNCE_BUS_NAME, os->conn_obj,
> +                                       SYNCE_CONN_INTERFACE, "Process");
> +       dbus_message_iter_init_append(msg, &iter);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                               DBUS_TYPE_BYTE_AS_STRING, &array_iter);
> +       dbus_message_iter_append_fixed_array(&array_iter, DBUS_TYPE_BYTE,
> +                                               &os->buf, os->offset);
> +       dbus_message_iter_close_container(&iter, &array_iter);
> +
> +       dbus_message_append_args(msg, DBUS_TYPE_STRING, &os->type,
> +                                               DBUS_TYPE_INVALID);
> +
> +       if (!dbus_connection_send_with_reply(os->dbus_conn, msg, &call, -1)) {
> +               error("D-Bus call to %s failed.", SYNCE_CONN_INTERFACE);
> +               dbus_message_unref(msg);
> +               OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
> +               return;
> +       }
> +
> +       dbus_pending_call_set_notify(call, process_cb, os, NULL);
> +
> +       dbus_message_unref(msg);
> +       dbus_pending_call_unref(call);
> +
> +       OBEX_ObjectSetRsp(obj, OBEX_RSP_CONTINUE, OBEX_RSP_SUCCESS);
> +       return;
> +}
> +
> +void synce_get(obex_t *obex, obex_object_t *obj)
> +{
> +       obex_headerdata_t hd;
> +       struct obex_session *os;
> +
> +       os = OBEX_GetUserData(obex);
> +       if (os == NULL)
> +               return;
> +
> +       if (!os->reply_received) {
> +               debug("in synce_get() OBEX_SuspendRequest() is called");
> +               OBEX_SuspendRequest(obex, obj);
> +       }
> +
> +       hd.bs = NULL;
> +       OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
> +                                       OBEX_FL_STREAM_START);
> +
> +       OBEX_ObjectSetRsp(obj, OBEX_RSP_CONTINUE, OBEX_RSP_SUCCESS);
> +       return;
> +}
> +
> +static void close_cb(DBusPendingCall *call, void *user_data)
> +{
> +       DBusMessage *reply;
> +       DBusError derr;
> +
> +       reply = dbus_pending_call_steal_reply(call);
> +       dbus_error_init(&derr);
> +       if (dbus_set_error_from_message(&derr, reply)) {
> +               error("close_cb(): syncevolution replied with an error:"
> +                                       " %s, %s", derr.name, derr.message);
> +               dbus_error_free(&derr);
> +       }
> +
> +       dbus_message_unref(reply);
> +}
> +
> +void synce_destroy(struct obex_session *os)
> +{
> +       DBusMessage *msg;
> +       gboolean normal = TRUE;
> +       gchar *error = "none";
> +       DBusPendingCall *call;
> +
> +       debug("At the begin of synce_destroy().");
> +       if (os->conn_obj) {
> +               msg = dbus_message_new_method_call(SYNCE_BUS_NAME, os->conn_obj,
> +                                               SYNCE_CONN_INTERFACE, "Close");
> +               dbus_message_append_args(msg, DBUS_TYPE_BOOLEAN, &normal,
> +                               DBUS_TYPE_STRING, &error, DBUS_TYPE_INVALID);
> +               dbus_connection_send_with_reply(os->dbus_conn, msg, &call, -1);
> +               dbus_pending_call_set_notify(call, close_cb, NULL, NULL);
> +               dbus_message_unref(msg);
> +               dbus_pending_call_unref(call);
> +
> +               snprintf(match_string, sizeof(match_string),
> +                       "type=signal,interface=%s,path=%s",
> +                       SYNCE_CONN_INTERFACE, os->conn_obj);
> +               dbus_bus_remove_match(os->dbus_conn, match_string, NULL);
> +               g_free(os->conn_obj);
> +               os->conn_obj = NULL;
> +       }
> +       dbus_connection_unref(os->dbus_conn);
> +       os_list = g_slist_remove(os_list, os);
> +}
> --
> 1.5.4.5
>
>
