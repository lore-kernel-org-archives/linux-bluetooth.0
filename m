Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJpsdAfqSt3eKy=13HQB04oHFbzgXd2+e1HE1iLnHb2YQ@mail.gmail.com>
References: <1411998438-26914-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1411998438-26914-2-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZJpsdAfqSt3eKy=13HQB04oHFbzgXd2+e1HE1iLnHb2YQ@mail.gmail.com>
Date: Tue, 30 Sep 2014 10:41:44 +0200
Message-ID: <CAMudyAtmF9Fo3-wsn02fxNN8DXvG7XG+qrUo0t2mPFGRJwDX=g@mail.gmail.com>
Subject: Re: [PATCH 1/6] shared/hfp: Extract common struct hfp struct out of
 struct hfp_gw
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 29 September 2014 16:55, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Mon, Sep 29, 2014 at 4:47 PM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> Part of hfp_gw members are going to be common between gw and hf roles.
>> Let's extract them into separate struct which will be a member of hfp_gw
>> and future hfp_hf
>> ---
>>  src/shared/hfp.c | 177 +++++++++++++++++++++++++++++--------------------------
>>  1 file changed, 92 insertions(+), 85 deletions(-)
>>
>> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
>> index efc981f..6176514 100644
>> --- a/src/shared/hfp.c
>> +++ b/src/shared/hfp.c
>> @@ -37,19 +37,15 @@
>>  #include "src/shared/io.h"
>>  #include "src/shared/hfp.h"
>>
>> -struct hfp_gw {
>> +struct hfp {
>>         int ref_count;
>>         int fd;
>>         bool close_on_unref;
>>         struct io *io;
>>         struct ringbuf *read_buf;
>>         struct ringbuf *write_buf;
>> -       struct queue *cmd_handlers;
>>         bool writer_active;
>> -       bool result_pending;
>> -       hfp_command_func_t command_callback;
>> -       hfp_destroy_func_t command_destroy;
>> -       void *command_data;
>> +
>>         hfp_debug_func_t debug_callback;
>>         hfp_destroy_func_t debug_destroy;
>>         void *debug_data;
>> @@ -62,6 +58,15 @@ struct hfp_gw {
>>         bool destroyed;
>>  };
>>
>> +struct hfp_gw {
>> +       struct hfp hfp; /* Shall be first in the wrapping struct */
>
> Im very much against this type of design, although it might be safe
> here since it is not a public API it not our practice to inline struct
> members like that just to be able to cast so I would suggest using a
> pointer.

As discussed on IRC with you and Marcel, we skip that part and start
with simple copy of _gw

 Btw I thought a lot of the AT command engine would be common
> anyway since either side should be able to send commands and respond
> and in any case is not likely that we will be using the same instance
> for both roles.

Also as discussed on IRC, it is not that trivial. Parsers are
different for HF who sends
commands and GW who can send responses and  unsolicited responses
which are different in
construction.

BR
Lukasz
>
>> +       bool result_pending;
>> +       struct queue *cmd_handlers;
>> +       hfp_command_func_t command_callback;
>> +       hfp_destroy_func_t command_destroy;
>> +       void *command_data;
>> +};
>> +
>>  struct cmd_handler {
>>         char *prefix;
>>         void *user_data;
>> @@ -104,7 +109,7 @@ static void write_watch_destroy(void *user_data)
>>  {
>>         struct hfp_gw *hfp = user_data;
>>
>> -       hfp->writer_active = false;
>> +       hfp->hfp.writer_active = false;
>>  }
>>
>>  static bool can_write_data(struct io *io, void *user_data)
>> @@ -112,11 +117,11 @@ static bool can_write_data(struct io *io, void *user_data)
>>         struct hfp_gw *hfp = user_data;
>>         ssize_t bytes_written;
>>
>> -       bytes_written = ringbuf_write(hfp->write_buf, hfp->fd);
>> +       bytes_written = ringbuf_write(hfp->hfp.write_buf, hfp->hfp.fd);
>>         if (bytes_written < 0)
>>                 return false;
>>
>> -       if (ringbuf_len(hfp->write_buf) > 0)
>> +       if (ringbuf_len(hfp->hfp.write_buf) > 0)
>>                 return true;
>>
>>         return false;
>> @@ -124,17 +129,17 @@ static bool can_write_data(struct io *io, void *user_data)
>>
>>  static void wakeup_writer(struct hfp_gw *hfp)
>>  {
>> -       if (hfp->writer_active)
>> +       if (hfp->hfp.writer_active)
>>                 return;
>>
>> -       if (!ringbuf_len(hfp->write_buf))
>> +       if (!ringbuf_len(hfp->hfp.write_buf))
>>                 return;
>>
>> -       if (!io_set_write_handler(hfp->io, can_write_data,
>> +       if (!io_set_write_handler(hfp->hfp.io, can_write_data,
>>                                         hfp, write_watch_destroy))
>>                 return;
>>
>> -       hfp->writer_active = true;
>> +       hfp->hfp.writer_active = true;
>>  }
>>
>>  static void skip_whitespace(struct hfp_gw_result *result)
>> @@ -382,7 +387,7 @@ static void process_input(struct hfp_gw *hfp)
>>         size_t len, count;
>>         bool free_ptr = false;
>>
>> -       str = ringbuf_peek(hfp->read_buf, 0, &len);
>> +       str = ringbuf_peek(hfp->hfp.read_buf, 0, &len);
>>         if (!str)
>>                 return;
>>
>> @@ -394,10 +399,10 @@ static void process_input(struct hfp_gw *hfp)
>>                 /* If there is no more data in ringbuffer,
>>                  * it's just an incomplete command.
>>                  */
>> -               if (len == ringbuf_len(hfp->read_buf))
>> +               if (len == ringbuf_len(hfp->hfp.read_buf))
>>                         return;
>>
>> -               str2 = ringbuf_peek(hfp->read_buf, len, &len2);
>> +               str2 = ringbuf_peek(hfp->hfp.read_buf, len, &len2);
>>                 if (!str2)
>>                         return;
>>
>> @@ -423,7 +428,7 @@ static void process_input(struct hfp_gw *hfp)
>>                         hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
>>         }
>>
>> -       len = ringbuf_drain(hfp->read_buf, count + 1);
>> +       len = ringbuf_drain(hfp->hfp.read_buf, count + 1);
>>
>>         if (free_ptr)
>>                 free(ptr);
>> @@ -438,7 +443,7 @@ static bool can_read_data(struct io *io, void *user_data)
>>         struct hfp_gw *hfp = user_data;
>>         ssize_t bytes_read;
>>
>> -       bytes_read = ringbuf_read(hfp->read_buf, hfp->fd);
>> +       bytes_read = ringbuf_read(hfp->hfp.read_buf, hfp->hfp.fd);
>>         if (bytes_read < 0)
>>                 return false;
>>
>> @@ -461,51 +466,51 @@ struct hfp_gw *hfp_gw_new(int fd)
>>         if (!hfp)
>>                 return NULL;
>>
>> -       hfp->fd = fd;
>> -       hfp->close_on_unref = false;
>> +       hfp->hfp.fd = fd;
>> +       hfp->hfp.close_on_unref = false;
>>
>> -       hfp->read_buf = ringbuf_new(4096);
>> -       if (!hfp->read_buf) {
>> +       hfp->hfp.read_buf = ringbuf_new(4096);
>> +       if (!hfp->hfp.read_buf) {
>>                 free(hfp);
>>                 return NULL;
>>         }
>>
>> -       hfp->write_buf = ringbuf_new(4096);
>> -       if (!hfp->write_buf) {
>> -               ringbuf_free(hfp->read_buf);
>> +       hfp->hfp.write_buf = ringbuf_new(4096);
>> +       if (!hfp->hfp.write_buf) {
>> +               ringbuf_free(hfp->hfp.read_buf);
>>                 free(hfp);
>>                 return NULL;
>>         }
>>
>> -       hfp->io = io_new(fd);
>> -       if (!hfp->io) {
>> -               ringbuf_free(hfp->write_buf);
>> -               ringbuf_free(hfp->read_buf);
>> +       hfp->hfp.io = io_new(fd);
>> +       if (!hfp->hfp.io) {
>> +               ringbuf_free(hfp->hfp.write_buf);
>> +               ringbuf_free(hfp->hfp.read_buf);
>>                 free(hfp);
>>                 return NULL;
>>         }
>>
>>         hfp->cmd_handlers = queue_new();
>>         if (!hfp->cmd_handlers) {
>> -               io_destroy(hfp->io);
>> -               ringbuf_free(hfp->write_buf);
>> -               ringbuf_free(hfp->read_buf);
>> +               io_destroy(hfp->hfp.io);
>> +               ringbuf_free(hfp->hfp.write_buf);
>> +               ringbuf_free(hfp->hfp.read_buf);
>>                 free(hfp);
>>                 return NULL;
>>         }
>>
>> -       if (!io_set_read_handler(hfp->io, can_read_data,
>> +       if (!io_set_read_handler(hfp->hfp.io, can_read_data,
>>                                         hfp, read_watch_destroy)) {
>>                 queue_destroy(hfp->cmd_handlers,
>>                                                 destroy_cmd_handler);
>> -               io_destroy(hfp->io);
>> -               ringbuf_free(hfp->write_buf);
>> -               ringbuf_free(hfp->read_buf);
>> +               io_destroy(hfp->hfp.io);
>> +               ringbuf_free(hfp->hfp.write_buf);
>> +               ringbuf_free(hfp->hfp.read_buf);
>>                 free(hfp);
>>                 return NULL;
>>         }
>>
>> -       hfp->writer_active = false;
>> +       hfp->hfp.writer_active = false;
>>         hfp->result_pending = false;
>>
>>         return hfp_gw_ref(hfp);
>> @@ -516,7 +521,7 @@ struct hfp_gw *hfp_gw_ref(struct hfp_gw *hfp)
>>         if (!hfp)
>>                 return NULL;
>>
>> -       __sync_fetch_and_add(&hfp->ref_count, 1);
>> +       __sync_fetch_and_add(&hfp->hfp.ref_count, 1);
>>
>>         return hfp;
>>  }
>> @@ -526,52 +531,54 @@ void hfp_gw_unref(struct hfp_gw *hfp)
>>         if (!hfp)
>>                 return;
>>
>> -       if (__sync_sub_and_fetch(&hfp->ref_count, 1))
>> +       if (__sync_sub_and_fetch(&hfp->hfp.ref_count, 1))
>>                 return;
>>
>>         hfp_gw_set_command_handler(hfp, NULL, NULL, NULL);
>>
>> -       io_set_write_handler(hfp->io, NULL, NULL, NULL);
>> -       io_set_read_handler(hfp->io, NULL, NULL, NULL);
>> -       io_set_disconnect_handler(hfp->io, NULL, NULL, NULL);
>> +       io_set_write_handler(hfp->hfp.io, NULL, NULL, NULL);
>> +       io_set_read_handler(hfp->hfp.io, NULL, NULL, NULL);
>> +       io_set_disconnect_handler(hfp->hfp.io, NULL, NULL, NULL);
>>
>> -       io_destroy(hfp->io);
>> -       hfp->io = NULL;
>> +       io_destroy(hfp->hfp.io);
>> +       hfp->hfp.io = NULL;
>>
>> -       if (hfp->close_on_unref)
>> -               close(hfp->fd);
>> +       if (hfp->hfp.close_on_unref)
>> +               close(hfp->hfp.fd);
>>
>>         hfp_gw_set_debug(hfp, NULL, NULL, NULL);
>>
>> -       ringbuf_free(hfp->read_buf);
>> -       hfp->read_buf = NULL;
>> +       ringbuf_free(hfp->hfp.read_buf);
>> +       hfp->hfp.read_buf = NULL;
>>
>> -       ringbuf_free(hfp->write_buf);
>> -       hfp->write_buf = NULL;
>> +       ringbuf_free(hfp->hfp.write_buf);
>> +       hfp->hfp.write_buf = NULL;
>>
>>         queue_destroy(hfp->cmd_handlers, destroy_cmd_handler);
>>         hfp->cmd_handlers = NULL;
>>
>> -       if (!hfp->in_disconnect) {
>> +       if (!hfp->hfp.in_disconnect) {
>>                 free(hfp);
>>                 return;
>>         }
>>
>> -       hfp->destroyed = true;
>> +       hfp->hfp.destroyed = true;
>>  }
>>
>>  static void read_tracing(const void *buf, size_t count, void *user_data)
>>  {
>>         struct hfp_gw *hfp = user_data;
>>
>> -       util_hexdump('>', buf, count, hfp->debug_callback, hfp->debug_data);
>> +       util_hexdump('>', buf, count, hfp->hfp.debug_callback,
>> +                                                       hfp->hfp.debug_data);
>>  }
>>
>>  static void write_tracing(const void *buf, size_t count, void *user_data)
>>  {
>>         struct hfp_gw *hfp = user_data;
>>
>> -       util_hexdump('<', buf, count, hfp->debug_callback, hfp->debug_data);
>> +       util_hexdump('<', buf, count, hfp->hfp.debug_callback,
>> +                                                       hfp->hfp.debug_data);
>>  }
>>
>>  bool hfp_gw_set_debug(struct hfp_gw *hfp, hfp_debug_func_t callback,
>> @@ -580,19 +587,19 @@ bool hfp_gw_set_debug(struct hfp_gw *hfp, hfp_debug_func_t callback,
>>         if (!hfp)
>>                 return false;
>>
>> -       if (hfp->debug_destroy)
>> -               hfp->debug_destroy(hfp->debug_data);
>> +       if (hfp->hfp.debug_destroy)
>> +               hfp->hfp.debug_destroy(hfp->hfp.debug_data);
>>
>> -       hfp->debug_callback = callback;
>> -       hfp->debug_destroy = destroy;
>> -       hfp->debug_data = user_data;
>> +       hfp->hfp.debug_callback = callback;
>> +       hfp->hfp.debug_destroy = destroy;
>> +       hfp->hfp.debug_data = user_data;
>>
>> -       if (hfp->debug_callback) {
>> -               ringbuf_set_input_tracing(hfp->read_buf, read_tracing, hfp);
>> -               ringbuf_set_input_tracing(hfp->write_buf, write_tracing, hfp);
>> +       if (hfp->hfp.debug_callback) {
>> +               ringbuf_set_input_tracing(hfp->hfp.read_buf, read_tracing, hfp);
>> +               ringbuf_set_input_tracing(hfp->hfp.write_buf, write_tracing, hfp);
>>         } else {
>> -               ringbuf_set_input_tracing(hfp->read_buf, NULL, NULL);
>> -               ringbuf_set_input_tracing(hfp->write_buf, NULL, NULL);
>> +               ringbuf_set_input_tracing(hfp->hfp.read_buf, NULL, NULL);
>> +               ringbuf_set_input_tracing(hfp->hfp.write_buf, NULL, NULL);
>>         }
>>
>>         return true;
>> @@ -603,7 +610,7 @@ bool hfp_gw_set_close_on_unref(struct hfp_gw *hfp, bool do_close)
>>         if (!hfp)
>>                 return false;
>>
>> -       hfp->close_on_unref = do_close;
>> +       hfp->hfp.close_on_unref = do_close;
>>
>>         return true;
>>  }
>> @@ -626,7 +633,7 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
>>                 return false;
>>         }
>>
>> -       if (ringbuf_printf(hfp->write_buf, "\r\n%s\r\n", str) < 0)
>> +       if (ringbuf_printf(hfp->hfp.write_buf, "\r\n%s\r\n", str) < 0)
>>                 return false;
>>
>>         wakeup_writer(hfp);
>> @@ -641,7 +648,7 @@ bool hfp_gw_send_error(struct hfp_gw *hfp, enum hfp_error error)
>>         if (!hfp)
>>                 return false;
>>
>> -       if (ringbuf_printf(hfp->write_buf, "\r\n+CME ERROR: %u\r\n", error) < 0)
>> +       if (ringbuf_printf(hfp->hfp.write_buf, "\r\n+CME ERROR: %u\r\n", error) < 0)
>>                 return false;
>>
>>         wakeup_writer(hfp);
>> @@ -664,7 +671,7 @@ bool hfp_gw_send_info(struct hfp_gw *hfp, const char *format, ...)
>>                 return false;
>>
>>         va_start(ap, format);
>> -       len = ringbuf_vprintf(hfp->write_buf, fmt, ap);
>> +       len = ringbuf_vprintf(hfp->hfp.write_buf, fmt, ap);
>>         va_end(ap);
>>
>>         free(fmt);
>> @@ -753,10 +760,10 @@ static void disconnect_watch_destroy(void *user_data)
>>  {
>>         struct hfp_gw *hfp = user_data;
>>
>> -       if (hfp->disconnect_destroy)
>> -               hfp->disconnect_destroy(hfp->disconnect_data);
>> +       if (hfp->hfp.disconnect_destroy)
>> +               hfp->hfp.disconnect_destroy(hfp->hfp.disconnect_data);
>>
>> -       if (hfp->destroyed)
>> +       if (hfp->hfp.destroyed)
>>                 free(hfp);
>>  }
>>
>> @@ -764,12 +771,12 @@ static bool io_disconnected(struct io *io, void *user_data)
>>  {
>>         struct hfp_gw *hfp = user_data;
>>
>> -       hfp->in_disconnect = true;
>> +       hfp->hfp.in_disconnect = true;
>>
>> -       if (hfp->disconnect_callback)
>> -               hfp->disconnect_callback(hfp->disconnect_data);
>> +       if (hfp->hfp.disconnect_callback)
>> +               hfp->hfp.disconnect_callback(hfp->hfp.disconnect_data);
>>
>> -       hfp->in_disconnect = false;
>> +       hfp->hfp.in_disconnect = false;
>>
>>         return false;
>>  }
>> @@ -782,20 +789,20 @@ bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
>>         if (!hfp)
>>                 return false;
>>
>> -       if (hfp->disconnect_destroy)
>> -               hfp->disconnect_destroy(hfp->disconnect_data);
>> +       if (hfp->hfp.disconnect_destroy)
>> +               hfp->hfp.disconnect_destroy(hfp->hfp.disconnect_data);
>>
>> -       if (!io_set_disconnect_handler(hfp->io, io_disconnected, hfp,
>> +       if (!io_set_disconnect_handler(hfp->hfp.io, io_disconnected, hfp,
>>                                                 disconnect_watch_destroy)) {
>> -               hfp->disconnect_callback = NULL;
>> -               hfp->disconnect_destroy = NULL;
>> -               hfp->disconnect_data = NULL;
>> +               hfp->hfp.disconnect_callback = NULL;
>> +               hfp->hfp.disconnect_destroy = NULL;
>> +               hfp->hfp.disconnect_data = NULL;
>>                 return false;
>>         }
>>
>> -       hfp->disconnect_callback = callback;
>> -       hfp->disconnect_destroy = destroy;
>> -       hfp->disconnect_data = user_data;
>> +       hfp->hfp.disconnect_callback = callback;
>> +       hfp->hfp.disconnect_destroy = destroy;
>> +       hfp->hfp.disconnect_data = user_data;
>>
>>         return true;
>>  }
>> @@ -805,5 +812,5 @@ bool hfp_gw_disconnect(struct hfp_gw *hfp)
>>         if (!hfp)
>>                 return false;
>>
>> -       return io_shutdown(hfp->io);
>> +       return io_shutdown(hfp->hfp.io);
>>  }
>> --
>> 1.8.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
