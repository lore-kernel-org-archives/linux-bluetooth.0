Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314100338-13410-1-git-send-email-prasadbhat22@gmail.com>
References: <1314100338-13410-1-git-send-email-prasadbhat22@gmail.com>
Date: Tue, 23 Aug 2011 13:52:06 +0300
Message-ID: <CABBYNZ+A+ngG+C8TsNBFonBm=JxAdVV4pVN1BNJ=uT9_2EbYDQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] This is the code refactoring for the vdp and a2dp.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prasad Bhat <prasadbhat22@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 23, 2011 at 2:52 PM, Prasad Bhat <prasadbhat22@gmail.com> wrote:
> diff --git a/audio/sep.h b/audio/sep.h
> new file mode 100644
> index 0000000..8a662f4
> --- /dev/null
> +++ b/audio/sep.h
> @@ -0,0 +1,207 @@
> +#define RECONFIGURE_TIMEOUT 500
> +#define SUSPEND_TIMEOUT 5
> +
> +GSList *servers = NULL;
> +GSList *setups = NULL;
> +unsigned int cb_id = 0;
> +
> +struct sep {
> +       struct avdtp_server *server;
> +       struct avdtp_endpoint *endpoint;
> +       uint8_t type;
> +       uint8_t codec;
> +       struct avdtp_local_sep *lsep;
> +       struct avdtp *session;
> +       struct avdtp_stream *stream;
> +       guint suspend_timer;
> +       gboolean delay_reporting;
> +       gboolean locked;
> +       gboolean suspending;
> +       gboolean starting;
> +       void *user_data;
> +       GDestroyNotify destroy;
> +};
> +
> +struct avdtp_setup {
> +       struct audio_device *dev;
> +       struct avdtp *session;
> +       struct sep *sep;
> +       struct avdtp_remote_sep *rsep;
> +       struct avdtp_stream *stream;
> +       struct avdtp_error *err;
> +       avdtp_set_configuration_cb setconf_cb;
> +       GSList *caps;
> +       gboolean reconfigure;
> +       gboolean start;
> +       GSList *cb;
> +       int ref;
> +};
> +
> +struct avdtp_server {
> +       bdaddr_t src;
> +       GSList *sinks;
> +       GSList *sources;
> +       uint32_t source_record_id;
> +       uint32_t sink_record_id;
> +       uint16_t version;
> +       gboolean sink_enabled;
> +       gboolean source_enabled;
> +};

Those structure should probably be kept private, also please use sep_
as a prefix.

> +typedef void (*avdtp_endpoint_select_t) (struct sep *sep, guint setup_id,
> +                                                        void *ret, int size);
> +typedef void (*avdtp_endpoint_config_t) (struct sep *sep, guint setup_id,
> +                                                                gboolean ret);
> +
> +struct avdtp_endpoint {
> +        const char *(*get_name) (struct sep *sep, void *user_data);
> +        size_t (*get_capabilities) (struct sep *sep,
> +                                                uint8_t **capabilities,
> +                                                void *user_data);
> +        int (*select_configuration) (struct sep *sep,
> +                                                uint8_t *capabilities,
> +                                                size_t length,
> +                                                guint setup_id,
> +                                                avdtp_endpoint_select_t cb,
> +                                                void *user_data);
> +        int (*set_configuration) (struct sep *sep,
> +                                                struct audio_device *dev,
> +                                                uint8_t *configuration,
> +                                                size_t length,
> +                                                guint setup_id,
> +                                                avdtp_endpoint_config_t cb,
> +                                                void *user_data);
> +        void (*clear_configuration) (struct sep *sep, void *user_data);
> +        void (*set_delay) (struct sep *sep, uint16_t delay,
> +                                                        void *user_data);
> +};
> +
> +typedef void (*avdtp_select_cb_t) (struct avdtp *session,
> +                                        struct sep *sep, GSList *caps,
> +                                        void *user_data);
> +typedef void (*avdtp_config_cb_t) (struct avdtp *session, struct sep *sep,
> +                                        struct avdtp_stream *stream,
> +                                        struct avdtp_error *err,
> +                                        void *user_data);
> +typedef void (*avdtp_stream_cb_t) (struct avdtp *session,
> +                                        struct avdtp_error *err,
> +                                        void *user_data);
> +
> +
> +struct avdtp_setup_cb {
> +        struct avdtp_setup *setup;
> +        avdtp_select_cb_t select_cb;
> +        avdtp_config_cb_t config_cb;
> +        avdtp_stream_cb_t resume_cb;
> +        avdtp_stream_cb_t suspend_cb;
> +        guint source_id;
> +        void *user_data;
> +        unsigned int id;
> +};

Here too.

> +void remove_sep(struct sep *sep);
> +struct sep *select_sep(struct avdtp *session, uint8_t type,
> +                                        const char *sender);
> +gboolean sep_get_lock(struct sep *sep);
> +struct sep *avdtp_get_sep(struct avdtp *session,
> +                               struct avdtp_stream *stream);
> +void unregister_sep(struct sep *sep);
> +
> +
> +gboolean auto_config(gpointer data);
> +gboolean finalize_config(gpointer data);
> +//gboolean auto_select(gpointer data);
> +void setup_cb_free(struct avdtp_setup_cb *cb);
> +
> +void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                                struct avdtp_stream *stream,
> +                                struct avdtp_error *err, void *user_data);
> +
> +struct avdtp_setup *setup_get(struct avdtp *session);
> +struct avdtp_setup *setup_new(struct avdtp *session);
> +struct avdtp_setup *setup_ref(struct avdtp_setup *setup);
> +
> +void avdtp_stream_state_changed(struct avdtp_stream *stream,
> +                                       avdtp_state_t old_state,
> +                                       avdtp_state_t new_state,
> +                                       struct avdtp_error *err,
> +                                       void *user_data);
> +
> +struct avdtp_server *find_server(GSList *list, const bdaddr_t *src);
> +struct audio_device *get_dev(struct avdtp *session);
> +struct avdtp_setup_cb *setup_cb_new(struct avdtp_setup *setup);
> +struct avdtp_setup *find_setup_by_session(struct avdtp *session);
> +struct avdtp_setup *find_setup_by_dev(struct audio_device *dev);
> +void setup_unref(struct avdtp_setup *setup);
> +gboolean endpoint_delayreport_ind(struct avdtp *session,
> +                                               struct avdtp_local_sep *sep,
> +                                               uint8_t rseid, uint16_t delay,
> +                                               uint8_t *err, void *user_data);
> +
> +gboolean delayreport_ind(struct avdtp *session,
> +                               struct avdtp_local_sep *sep,
> +                               uint8_t rseid, uint16_t delay,
> +                               uint8_t *err, void *user_data);
> +
> +gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> +                               uint8_t *err, void *user_data);
> +
> +gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> +                               struct avdtp_stream *stream, uint8_t *err,
> +                               void *user_data);
> +
> +gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> +                               struct avdtp_stream *stream, uint8_t *err,
> +                               void *user_data);
> +
> +gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> +                               struct avdtp_stream *stream, uint8_t *err,
> +                               void *user_data);
> +
> +gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> +                               struct avdtp_stream *stream, uint8_t *err,
> +                               void *user_data);
> +
> +gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> +                               struct avdtp_stream *stream, uint8_t *err,
> +                               void *user_data);
> +
> +gboolean getconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
> +                               uint8_t *err, void *user_data);
> +
> +gboolean endpoint_setconf_ind(struct avdtp *session,
> +                                               struct avdtp_local_sep *sep,
> +                                               struct avdtp_stream *stream,
> +                                               GSList *caps,
> +                                               avdtp_set_configuration_cb cb,
> +                                               void *user_data);
> +gboolean endpoint_getcap_ind(struct avdtp *session,
> +                                        struct avdtp_local_sep *sep,
> +                                        gboolean get_all, GSList **caps,
> +                                        uint8_t *err, void *user_data);
> +void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                        struct avdtp_stream *stream, struct avdtp_error *err,
> +                        void *user_data);
> +void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                        struct avdtp_stream *stream, struct avdtp_error *err,
> +                        void *user_data);
> +void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                        struct avdtp_stream *stream, struct avdtp_error *err,
> +                        void *user_data);
> +void delay_report_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                                struct avdtp_stream *stream,
> +                                struct avdtp_error *err, void *user_data);
> +void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                        struct avdtp_stream *stream, struct avdtp_error *err,
> +                        void *user_data);
> +void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                        struct avdtp_stream *stream, struct avdtp_error *err,
> +                        void *user_data);
> +void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                        struct avdtp_stream *stream, struct avdtp_error *err,
> +                        void *user_data);
> +void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
> +                        struct avdtp_stream *stream, struct avdtp_error *err,
> +                        void *user_data);
> +
> +

The idea is to reuse code as much as possible, but it doesn't mean we
should make everything public, perhaps we can check for NULL callbacks
or reuse the callback mechanism created for media e.g.
avdtp.c(ind->set_configuration)->sep.c(endpoint->set_configuration)->media.c,a2dp.c,vdp.c.
I guess the sep setup should be kept private to sep.c which means
a2dp.c and vdp.c only need to implement codec configurations.

-- 
Luiz Augusto von Dentz
