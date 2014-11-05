Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJLTA8j=ESQ9UPnzDayuCN6qvKxXfMW7JuSATjE9TOoJzNLtcw@mail.gmail.com>
References: <1415135999-8792-1-git-send-email-jamuraa@chromium.org>
	<1415135999-8792-5-git-send-email-jamuraa@chromium.org>
	<CABBYNZJQF6omOPWLxk33oPJ0P-cxsm=82n=ayjR+PnbEX-9yRA@mail.gmail.com>
	<CAJLTA8j=ESQ9UPnzDayuCN6qvKxXfMW7JuSATjE9TOoJzNLtcw@mail.gmail.com>
Date: Wed, 5 Nov 2014 22:30:32 +0200
Message-ID: <CABBYNZ+xNZZkTODfT_jkb68Kn6xnxhb3E==q3SHm2Y6d7Mq7ZA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] GATT shim to src/shared bt_att
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Nov 5, 2014 at 5:17 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> Hi Luiz,
>
> On Wed, Nov 5, 2014 at 6:49 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Michael,
>>
>> On Tue, Nov 4, 2014 at 11:19 PM, Michael Janssen <jamuraa@chromium.org> wrote:
>>> This patch implements a version of GAttrib which is backed by
>>> bt_att, which enables the simultaneous use of GAttrib and bt_att.
>>>
>>> This should enable smooth transition of profiles from the GAttrib
>>> API to the src/shared bt_att API.
>>> ---
>>>  attrib/gattrib.c | 734 +++++++++++--------------------------------------------
>>>  1 file changed, 147 insertions(+), 587 deletions(-)
>>>
>>> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
>>> index fa51b6d..63f219d 100644
>>> --- a/attrib/gattrib.c
>>> +++ b/attrib/gattrib.c
>>> @@ -2,8 +2,7 @@
>>>   *
>>>   *  BlueZ - Bluetooth protocol stack for Linux
>>>   *
>>> - *  Copyright (C) 2010  Nokia Corporation
>>> - *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
>>> + *  Copyright (C) 2014  Google, Inc.
>>
>> You got to be super careful with copyright changes, because of that we
>> usually request this to be in a separate patch, except for newly
>> created files of course. To speed up this I would suggest you leave
>> this for later.
>
> To be clear: this looking like a change of a bunch of lines of a
> single file is an artifact of the patch process - I created this from
> an empty file by copying the headers from gattrib.h and implementing
> them.  It was originally a new file called gattrib-shared.c.  Normally
> I wouldn't change this copyright stuff and have no issue keeping the
> changes for v2.

You can try -B option of format patch, that should show up as a
complete rewrite.

>>>   *
>>>   *
>>>   *  This program is free software; you can redistribute it and/or modify
>>> @@ -36,227 +35,124 @@
>>>  #include <bluetooth/bluetooth.h>
>>>
>>>  #include "btio/btio.h"
>>> -#include "lib/uuid.h"
>>> -#include "src/shared/util.h"
>>>  #include "src/log.h"
>>> -#include "attrib/att.h"
>>> +#include "src/shared/util.h"
>>> +#include "src/shared/att.h"
>>>  #include "attrib/gattrib.h"
>>>
>>> -#define GATT_TIMEOUT 30
>>> -
>>>  struct _GAttrib {
>>> +       int ref_count;
>>> +       struct bt_att *att;
>>>         GIOChannel *io;
>>> -       int refs;
>>> -       uint8_t *buf;
>>> -       size_t buflen;
>>> -       guint read_watch;
>>> -       guint write_watch;
>>> -       guint timeout_watch;
>>> -       GQueue *requests;
>>> -       GQueue *responses;
>>> -       GSList *events;
>>> -       guint next_cmd_id;
>>>         GDestroyNotify destroy;
>>>         gpointer destroy_user_data;
>>> -       bool stale;
>>> +       GQueue *callbacks;
>>> +       uint8_t *buf;
>>> +       int buflen;
>>>  };
>>>
>>> -struct command {
>>> -       guint id;
>>> -       guint8 opcode;
>>> -       guint8 *pdu;
>>> -       guint16 len;
>>> -       guint8 expected;
>>> -       bool sent;
>>> -       GAttribResultFunc func;
>>> -       gpointer user_data;
>>> -       GDestroyNotify notify;
>>> -};
>>>
>>> -struct event {
>>> -       guint id;
>>> -       guint8 expected;
>>> -       guint16 handle;
>>> -       GAttribNotifyFunc func;
>>> +struct attrib_callbacks {
>>> +       GAttribResultFunc result_func;
>>> +       GAttribNotifyFunc notify_func;
>>> +       GDestroyNotify destroy_func;
>>>         gpointer user_data;
>>> -       GDestroyNotify notify;
>>> +       GAttrib *parent;
>>> +       uint16_t notify_handle;
>>>  };
>>>
>>> -static guint8 opcode2expected(guint8 opcode)
>>> +GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
>>>  {
>>> -       switch (opcode) {
>>> -       case ATT_OP_MTU_REQ:
>>> -               return ATT_OP_MTU_RESP;
>>> -
>>> -       case ATT_OP_FIND_INFO_REQ:
>>> -               return ATT_OP_FIND_INFO_RESP;
>>> -
>>> -       case ATT_OP_FIND_BY_TYPE_REQ:
>>> -               return ATT_OP_FIND_BY_TYPE_RESP;
>>> -
>>> -       case ATT_OP_READ_BY_TYPE_REQ:
>>> -               return ATT_OP_READ_BY_TYPE_RESP;
>>> -
>>> -       case ATT_OP_READ_REQ:
>>> -               return ATT_OP_READ_RESP;
>>> -
>>> -       case ATT_OP_READ_BLOB_REQ:
>>> -               return ATT_OP_READ_BLOB_RESP;
>>> -
>>> -       case ATT_OP_READ_MULTI_REQ:
>>> -               return ATT_OP_READ_MULTI_RESP;
>>> +       gint fd;
>>> +       GAttrib *attr;
>>>
>>> -       case ATT_OP_READ_BY_GROUP_REQ:
>>> -               return ATT_OP_READ_BY_GROUP_RESP;
>>> +       if (!io)
>>> +               return NULL;
>>>
>>> -       case ATT_OP_WRITE_REQ:
>>> -               return ATT_OP_WRITE_RESP;
>>> +       fd = g_io_channel_unix_get_fd(io);
>>> +       attr = new0(GAttrib, 1);
>>> +       if (!attr)
>>> +               return NULL;
>>>
>>> -       case ATT_OP_PREP_WRITE_REQ:
>>> -               return ATT_OP_PREP_WRITE_RESP;
>>> +       g_io_channel_ref(io);
>>> +       attr->io = io;
>>>
>>> -       case ATT_OP_EXEC_WRITE_REQ:
>>> -               return ATT_OP_EXEC_WRITE_RESP;
>>> +       attr->att = bt_att_new(fd);
>>> +       if (!attr->att)
>>> +               goto fail;
>>>
>>> -       case ATT_OP_HANDLE_IND:
>>> -               return ATT_OP_HANDLE_CNF;
>>> -       }
>>> +       attr->buf = g_malloc0(mtu);
>>> +       attr->buflen = mtu;
>>> +       if (!attr->buf)
>>> +               goto fail;
>>>
>>> -       return 0;
>>> -}
>>> +       attr->callbacks = g_queue_new();
>>> +       if (!attr->callbacks)
>>> +               goto fail;
>>>
>>> -static bool is_response(guint8 opcode)
>>> -{
>>> -       switch (opcode) {
>>> -       case ATT_OP_ERROR:
>>> -       case ATT_OP_MTU_RESP:
>>> -       case ATT_OP_FIND_INFO_RESP:
>>> -       case ATT_OP_FIND_BY_TYPE_RESP:
>>> -       case ATT_OP_READ_BY_TYPE_RESP:
>>> -       case ATT_OP_READ_RESP:
>>> -       case ATT_OP_READ_BLOB_RESP:
>>> -       case ATT_OP_READ_MULTI_RESP:
>>> -       case ATT_OP_READ_BY_GROUP_RESP:
>>> -       case ATT_OP_WRITE_RESP:
>>> -       case ATT_OP_PREP_WRITE_RESP:
>>> -       case ATT_OP_EXEC_WRITE_RESP:
>>> -       case ATT_OP_HANDLE_CNF:
>>> -               return true;
>>> -       }
>>> +       return g_attrib_ref(attr);
>>>
>>> -       return false;
>>> -}
>>> -
>>> -static bool is_request(guint8 opcode)
>>> -{
>>> -       switch (opcode) {
>>> -       case ATT_OP_MTU_REQ:
>>> -       case ATT_OP_FIND_INFO_REQ:
>>> -       case ATT_OP_FIND_BY_TYPE_REQ:
>>> -       case ATT_OP_READ_BY_TYPE_REQ:
>>> -       case ATT_OP_READ_REQ:
>>> -       case ATT_OP_READ_BLOB_REQ:
>>> -       case ATT_OP_READ_MULTI_REQ:
>>> -       case ATT_OP_READ_BY_GROUP_REQ:
>>> -       case ATT_OP_WRITE_REQ:
>>> -       case ATT_OP_WRITE_CMD:
>>> -       case ATT_OP_PREP_WRITE_REQ:
>>> -       case ATT_OP_EXEC_WRITE_REQ:
>>> -               return true;
>>> -       }
>>> -
>>> -       return false;
>>> +fail:
>>> +       free(attr->buf);
>>> +       bt_att_unref(attr->att);
>>> +       g_io_channel_unref(io);
>>> +       free(attr);
>>> +       return NULL;
>>>  }
>>>
>>>  GAttrib *g_attrib_ref(GAttrib *attrib)
>>>  {
>>> -       int refs;
>>> -
>>>         if (!attrib)
>>>                 return NULL;
>>>
>>> -       refs = __sync_add_and_fetch(&attrib->refs, 1);
>>> +       __sync_fetch_and_add(&attrib->ref_count, 1);
>>>
>>> -       DBG("%p: ref=%d", attrib, refs);
>>> +       DBG("%p: g_attrib_ref=%d ", attrib, attrib->ref_count);
>>>
>>>         return attrib;
>>>  }
>>>
>>> -static void command_destroy(struct command *cmd)
>>> +static void attrib_callbacks_destroy(void *user_data)
>>>  {
>>> -       if (cmd->notify)
>>> -               cmd->notify(cmd->user_data);
>>> +       struct attrib_callbacks *cb;
>>>
>>> -       g_free(cmd->pdu);
>>> -       g_free(cmd);
>>> -}
>>> +       cb = (struct attrib_callbacks *)user_data;
>>> +       if (!user_data || !g_queue_remove(cb->parent->callbacks, user_data))
>>> +               return;
>>>
>>> -static void event_destroy(struct event *evt)
>>> -{
>>> -       if (evt->notify)
>>> -               evt->notify(evt->user_data);
>>> +       if (cb->destroy_func)
>>> +               cb->destroy_func(cb->user_data);
>>>
>>> -       g_free(evt);
>>> +       free(user_data);
>>>  }
>>>
>>> -static void attrib_destroy(GAttrib *attrib)
>>> +void g_attrib_unref(GAttrib *attrib)
>>>  {
>>> -       GSList *l;
>>> -       struct command *c;
>>> -
>>> -       while ((c = g_queue_pop_head(attrib->requests)))
>>> -               command_destroy(c);
>>> -
>>> -       while ((c = g_queue_pop_head(attrib->responses)))
>>> -               command_destroy(c);
>>> -
>>> -       g_queue_free(attrib->requests);
>>> -       attrib->requests = NULL;
>>> -
>>> -       g_queue_free(attrib->responses);
>>> -       attrib->responses = NULL;
>>> +       struct attrib_callbacks *cb;
>>>
>>> -       for (l = attrib->events; l; l = l->next)
>>> -               event_destroy(l->data);
>>> -
>>> -       g_slist_free(attrib->events);
>>> -       attrib->events = NULL;
>>> -
>>> -       if (attrib->timeout_watch > 0)
>>> -               g_source_remove(attrib->timeout_watch);
>>> -
>>> -       if (attrib->write_watch > 0)
>>> -               g_source_remove(attrib->write_watch);
>>> -
>>> -       if (attrib->read_watch > 0)
>>> -               g_source_remove(attrib->read_watch);
>>> +       if (!attrib)
>>> +               return;
>>>
>>> -       if (attrib->io)
>>> -               g_io_channel_unref(attrib->io);
>>> +       DBG("%p: g_attrib_unref=%d ", attrib, attrib->ref_count-1);
>>>
>>> -       g_free(attrib->buf);
>>> +       if (__sync_sub_and_fetch(&attrib->ref_count, 1))
>>> +               return;
>>>
>>>         if (attrib->destroy)
>>>                 attrib->destroy(attrib->destroy_user_data);
>>>
>>> -       g_free(attrib);
>>> -}
>>> +       while ((cb = g_queue_peek_head(attrib->callbacks)))
>>> +               attrib_callbacks_destroy(cb);
>>>
>>> -void g_attrib_unref(GAttrib *attrib)
>>> -{
>>> -       int refs;
>>> +       g_queue_free(attrib->callbacks);
>>>
>>> -       if (!attrib)
>>> -               return;
>>> -
>>> -       refs = __sync_sub_and_fetch(&attrib->refs, 1);
>>> +       g_free(attrib->buf);
>>>
>>> -       DBG("%p: ref=%d", attrib, refs);
>>> +       bt_att_unref(attrib->att);
>>>
>>> -       if (refs > 0)
>>> -               return;
>>> +       g_io_channel_unref(attrib->io);
>>>
>>> -       attrib_destroy(attrib);
>>> +       g_free(attrib);
>>>  }
>>>
>>>  GIOChannel *g_attrib_get_channel(GAttrib *attrib)
>>> @@ -270,7 +166,7 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib)
>>>  gboolean g_attrib_set_destroy_function(GAttrib *attrib,
>>>                 GDestroyNotify destroy, gpointer user_data)
>>>  {
>>> -       if (attrib == NULL)
>>> +       if (!attrib)
>>>                 return FALSE;
>>>
>>>         attrib->destroy = destroy;
>>> @@ -279,380 +175,116 @@ gboolean g_attrib_set_destroy_function(GAttrib *attrib,
>>>         return TRUE;
>>>  }
>>>
>>> -static gboolean disconnect_timeout(gpointer data)
>>> -{
>>> -       struct _GAttrib *attrib = data;
>>> -       struct command *c;
>>> -
>>> -       g_attrib_ref(attrib);
>>> -
>>> -       c = g_queue_pop_head(attrib->requests);
>>> -       if (c == NULL)
>>> -               goto done;
>>> -
>>> -       if (c->func)
>>> -               c->func(ATT_ECODE_TIMEOUT, NULL, 0, c->user_data);
>>> -
>>> -       command_destroy(c);
>>> -
>>> -       while ((c = g_queue_pop_head(attrib->requests))) {
>>> -               if (c->func)
>>> -                       c->func(ATT_ECODE_ABORTED, NULL, 0, c->user_data);
>>> -               command_destroy(c);
>>> -       }
>>> -
>>> -done:
>>> -       attrib->stale = true;
>>> -
>>> -       g_attrib_unref(attrib);
>>> -
>>> -       return FALSE;
>>> -}
>>> -
>>> -static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
>>> -                                                               gpointer data)
>>> -{
>>> -       struct _GAttrib *attrib = data;
>>> -       struct command *cmd;
>>> -       GError *gerr = NULL;
>>> -       gsize len;
>>> -       GIOStatus iostat;
>>> -       GQueue *queue;
>>> -
>>> -       if (attrib->stale)
>>> -               return FALSE;
>>> -
>>> -       if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
>>> -               return FALSE;
>>> -
>>> -       queue = attrib->responses;
>>> -       cmd = g_queue_peek_head(queue);
>>> -       if (cmd == NULL) {
>>> -               queue = attrib->requests;
>>> -               cmd = g_queue_peek_head(queue);
>>> -       }
>>> -       if (cmd == NULL)
>>> -               return FALSE;
>>> -
>>> -       /*
>>> -        * Verify that we didn't already send this command. This can only
>>> -        * happen with elementes from attrib->requests.
>>> -        */
>>> -       if (cmd->sent)
>>> -               return FALSE;
>>> -
>>> -       iostat = g_io_channel_write_chars(io, (char *) cmd->pdu, cmd->len,
>>> -                                                               &len, &gerr);
>>> -       if (iostat != G_IO_STATUS_NORMAL) {
>>> -               if (gerr) {
>>> -                       error("%s", gerr->message);
>>> -                       g_error_free(gerr);
>>> -               }
>>> -
>>> -               return FALSE;
>>> -       }
>>> -
>>> -       if (cmd->expected == 0) {
>>> -               g_queue_pop_head(queue);
>>> -               command_destroy(cmd);
>>>
>>> -               return TRUE;
>>> -       }
>>> -
>>> -       cmd->sent = true;
>>> -
>>> -       if (attrib->timeout_watch == 0)
>>> -               attrib->timeout_watch = g_timeout_add_seconds(GATT_TIMEOUT,
>>> -                                               disconnect_timeout, attrib);
>>> -
>>> -       return FALSE;
>>> -}
>>> -
>>> -static void destroy_sender(gpointer data)
>>> +static void attrib_callback_result(uint8_t opcode, const void *pdu,
>>> +                                  uint16_t length, void *user_data)
>>>  {
>>> -       struct _GAttrib *attrib = data;
>>> -
>>> -       attrib->write_watch = 0;
>>> -       g_attrib_unref(attrib);
>>> -}
>>> +       uint8_t *buf;
>>> +       struct attrib_callbacks *cb = user_data;
>>>
>>> -static void wake_up_sender(struct _GAttrib *attrib)
>>> -{
>>> -       if (attrib->write_watch > 0)
>>> +       if (!cb)
>>>                 return;
>>>
>>> -       attrib = g_attrib_ref(attrib);
>>> -       attrib->write_watch = g_io_add_watch_full(attrib->io,
>>> -                               G_PRIORITY_DEFAULT, G_IO_OUT,
>>> -                               can_write_data, attrib, destroy_sender);
>>> -}
>>> -
>>> -static bool match_event(struct event *evt, const uint8_t *pdu, gsize len)
>>> -{
>>> -       guint16 handle;
>>> -
>>> -       if (is_request(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
>>> -               return true;
>>> -
>>> -       if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
>>> -               return true;
>>> -
>>> -       if (len < 3)
>>> -               return false;
>>> +       buf = g_malloc0(length+1);
>>> +       if (!buf)
>>> +               return;
>>>
>>> -       handle = get_le16(&pdu[1]);
>>> +       buf[0] = opcode;
>>> +       memcpy(buf+1, pdu, length);
>>>
>>> -       if (evt->expected == pdu[0] && evt->handle == handle)
>>> -               return true;
>>> +       if (cb->result_func)
>>> +               cb->result_func(0, buf, length+1, cb->user_data);
>>>
>>> -       return false;
>>> +       g_free(buf);
>>>  }
>>>
>>> -static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
>>> -{
>>> -       struct _GAttrib *attrib = data;
>>> -       struct command *cmd = NULL;
>>> -       GSList *l;
>>> -       uint8_t buf[512], status;
>>> -       gsize len;
>>> -       GIOStatus iostat;
>>> -
>>> -       if (attrib->stale)
>>> -               return FALSE;
>>> -
>>> -       if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
>>> -               struct command *c;
>>> -
>>> -               while ((c = g_queue_pop_head(attrib->requests))) {
>>> -                       if (c->func)
>>> -                               c->func(ATT_ECODE_IO, NULL, 0, c->user_data);
>>> -                       command_destroy(c);
>>> -               }
>>> -
>>> -               attrib->read_watch = 0;
>>> -
>>> -               return FALSE;
>>> -       }
>>> -
>>> -       memset(buf, 0, sizeof(buf));
>>>
>>> -       iostat = g_io_channel_read_chars(io, (char *) buf, sizeof(buf),
>>> -                                                               &len, NULL);
>>> -       if (iostat != G_IO_STATUS_NORMAL) {
>>> -               status = ATT_ECODE_IO;
>>> -               goto done;
>>> -       }
>>> -
>>> -       for (l = attrib->events; l; l = l->next) {
>>> -               struct event *evt = l->data;
>>> -
>>> -               if (match_event(evt, buf, len))
>>> -                       evt->func(buf, len, evt->user_data);
>>> -       }
>>> -
>>> -       if (!is_response(buf[0]))
>>> -               return TRUE;
>>> -
>>> -       if (attrib->timeout_watch > 0) {
>>> -               g_source_remove(attrib->timeout_watch);
>>> -               attrib->timeout_watch = 0;
>>> -       }
>>> -
>>> -       cmd = g_queue_pop_head(attrib->requests);
>>> -       if (cmd == NULL) {
>>> -               /* Keep the watch if we have events to report */
>>> -               return attrib->events != NULL;
>>> -       }
>>> -
>>> -       if (buf[0] == ATT_OP_ERROR) {
>>> -               status = buf[4];
>>> -               goto done;
>>> -       }
>>> -
>>> -       if (cmd->expected != buf[0]) {
>>> -               status = ATT_ECODE_IO;
>>> -               goto done;
>>> -       }
>>> -
>>> -       status = 0;
>>> -
>>> -done:
>>> -       if (!g_queue_is_empty(attrib->requests) ||
>>> -                                       !g_queue_is_empty(attrib->responses))
>>> -               wake_up_sender(attrib);
>>> -
>>> -       if (cmd) {
>>> -               if (cmd->func)
>>> -                       cmd->func(status, buf, len, cmd->user_data);
>>> -
>>> -               command_destroy(cmd);
>>> -       }
>>> +static void attrib_callback_notify(uint8_t opcode, const void *pdu,
>>> +                               uint16_t length, void *user_data)
>>> +{
>>> +       uint8_t *buf;
>>> +       struct attrib_callbacks *cb = user_data;
>>>
>>> -       return TRUE;
>>> -}
>>> +       if (!cb)
>>> +               return;
>>>
>>> -GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
>>> -{
>>> -       struct _GAttrib *attrib;
>>> +       if (cb->notify_func == NULL)
>>> +               return;
>>>
>>> -       g_io_channel_set_encoding(io, NULL, NULL);
>>> -       g_io_channel_set_buffered(io, FALSE);
>>> +       if (cb->notify_handle != GATTRIB_ALL_HANDLES && length < 2)
>>> +               return;
>>>
>>> -       attrib = g_try_new0(struct _GAttrib, 1);
>>> -       if (attrib == NULL)
>>> -               return NULL;
>>> +       if (cb->notify_handle != GATTRIB_ALL_HANDLES &&
>>> +                                            cb->notify_handle != get_le16(pdu))
>>> +               return;
>>>
>>> -       attrib->buf = g_malloc0(mtu);
>>> -       attrib->buflen = mtu;
>>> +       buf = g_malloc0(length+1);
>>> +       if (!buf)
>>> +               return;
>>>
>>> -       attrib->io = g_io_channel_ref(io);
>>> -       attrib->requests = g_queue_new();
>>> -       attrib->responses = g_queue_new();
>>> +       buf[0] = opcode;
>>> +       memcpy(buf+1, pdu, length);
>>>
>>> -       attrib->read_watch = g_io_add_watch(attrib->io,
>>> -                       G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>>> -                       received_data, attrib);
>>> +       cb->notify_func(buf, length+1, cb->user_data);
>>>
>>> -       return g_attrib_ref(attrib);
>>> +       g_free(buf);
>>>  }
>>>
>>>  guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
>>>                         GAttribResultFunc func, gpointer user_data,
>>>                         GDestroyNotify notify)
>>>  {
>>> -       struct command *c;
>>> -       GQueue *queue;
>>> -       uint8_t opcode;
>>> -
>>> -       if (attrib->stale)
>>> -               return 0;
>>> -
>>> -       c = g_try_new0(struct command, 1);
>>> -       if (c == NULL)
>>> -               return 0;
>>> -
>>> -       opcode = pdu[0];
>>> -
>>> -       c->opcode = opcode;
>>> -       c->expected = opcode2expected(opcode);
>>> -       c->pdu = g_malloc(len);
>>> -       memcpy(c->pdu, pdu, len);
>>> -       c->len = len;
>>> -       c->func = func;
>>> -       c->user_data = user_data;
>>> -       c->notify = notify;
>>> -
>>> -       if (is_response(opcode))
>>> -               queue = attrib->responses;
>>> -       else
>>> -               queue = attrib->requests;
>>> -
>>> -       if (id) {
>>> -               c->id = id;
>>> -               if (!is_response(opcode))
>>> -                       g_queue_push_head(queue, c);
>>> -               else
>>> -                       /* Don't re-order responses even if an ID is given */
>>> -                       g_queue_push_tail(queue, c);
>>> -       } else {
>>> -               c->id = ++attrib->next_cmd_id;
>>> -               g_queue_push_tail(queue, c);
>>> +       struct attrib_callbacks *cb = NULL;
>>> +       bt_att_response_func_t response_cb = NULL;
>>> +       bt_att_destroy_func_t destroy_cb = NULL;
>>> +
>>> +       if (func || notify) {
>>> +               cb = new0(struct attrib_callbacks, 1);
>>> +               if (cb == 0)
>>> +                       return 0;
>>> +               cb->result_func = func;
>>> +               cb->user_data = user_data;
>>> +               cb->destroy_func = notify;
>>> +               cb->parent = attrib;
>>> +               g_queue_push_head(attrib->callbacks, cb);
>>> +               response_cb = attrib_callback_result;
>>> +               destroy_cb = attrib_callbacks_destroy;
>>>         }
>>>
>>> -       /*
>>> -        * If a command was added to the queue and it was empty before, wake up
>>> -        * the sender. If the sender was already woken up by the second queue,
>>> -        * wake_up_sender will just return.
>>> -        */
>>> -       if (g_queue_get_length(queue) == 1)
>>> -               wake_up_sender(attrib);
>>> -
>>> -       return c->id;
>>> -}
>>> -
>>> -static int command_cmp_by_id(gconstpointer a, gconstpointer b)
>>> -{
>>> -       const struct command *cmd = a;
>>> -       guint id = GPOINTER_TO_UINT(b);
>>> -
>>> -       return cmd->id - id;
>>> +       return bt_att_send(attrib->att, pdu[0], (void *)pdu+1, len-1,
>>> +                                                  response_cb, cb, destroy_cb);
>>>  }
>>>
>>>  gboolean g_attrib_cancel(GAttrib *attrib, guint id)
>>>  {
>>> -       GList *l = NULL;
>>> -       struct command *cmd;
>>> -       GQueue *queue;
>>> -
>>> -       if (attrib == NULL)
>>> -               return FALSE;
>>> -
>>> -       queue = attrib->requests;
>>> -       if (queue)
>>> -               l = g_queue_find_custom(queue, GUINT_TO_POINTER(id),
>>> -                                       command_cmp_by_id);
>>> -       if (l == NULL) {
>>> -               queue = attrib->responses;
>>> -               if (!queue)
>>> -                       return FALSE;
>>> -               l = g_queue_find_custom(queue, GUINT_TO_POINTER(id),
>>> -                                       command_cmp_by_id);
>>> -       }
>>> -
>>> -       if (l == NULL)
>>> -               return FALSE;
>>> -
>>> -       cmd = l->data;
>>> -
>>> -       if (cmd == g_queue_peek_head(queue) && cmd->sent)
>>> -               cmd->func = NULL;
>>> -       else {
>>> -               g_queue_remove(queue, cmd);
>>> -               command_destroy(cmd);
>>> -       }
>>> -
>>> -       return TRUE;
>>> +       return bt_att_cancel(attrib->att, id);
>>>  }
>>>
>>> -static gboolean cancel_all_per_queue(GQueue *queue)
>>> +gboolean g_attrib_cancel_all(GAttrib *attrib)
>>>  {
>>> -       struct command *c, *head = NULL;
>>> -       gboolean first = TRUE;
>>> -
>>> -       if (queue == NULL)
>>> -               return FALSE;
>>> -
>>> -       while ((c = g_queue_pop_head(queue))) {
>>> -               if (first && c->sent) {
>>> -                       /* If the command was sent ignore its callback ... */
>>> -                       c->func = NULL;
>>> -                       head = c;
>>> -                       continue;
>>> -               }
>>> -
>>> -               first = FALSE;
>>> -               command_destroy(c);
>>> -       }
>>> -
>>> -       if (head) {
>>> -               /* ... and put it back in the queue */
>>> -               g_queue_push_head(queue, head);
>>> -       }
>>> -
>>> -       return TRUE;
>>> +       return bt_att_cancel_all(attrib->att);
>>>  }
>>>
>>> -gboolean g_attrib_cancel_all(GAttrib *attrib)
>>> +guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
>>> +                               GAttribNotifyFunc func, gpointer user_data,
>>> +                               GDestroyNotify notify)
>>>  {
>>> -       gboolean ret;
>>> -
>>> -       if (attrib == NULL)
>>> -               return FALSE;
>>> -
>>> -       ret = cancel_all_per_queue(attrib->requests);
>>> -       ret = cancel_all_per_queue(attrib->responses) && ret;
>>> +       struct attrib_callbacks *cb = NULL;
>>> +
>>> +       if (func || notify) {
>>> +               cb = new0(struct attrib_callbacks, 1);
>>> +               if (cb == 0)
>>> +                       return 0;
>>> +               cb->notify_func = func;
>>> +               cb->notify_handle = handle;
>>> +               cb->user_data = user_data;
>>> +               cb->destroy_func = notify;
>>> +               cb->parent = attrib;
>>> +               g_queue_push_head(attrib->callbacks, cb);
>>> +       }
>>>
>>> -       return ret;
>>> +       return bt_att_register(attrib->att, opcode, attrib_callback_notify,
>>> +                              cb, attrib_callbacks_destroy);
>>>  }
>>>
>>>  uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
>>> @@ -661,98 +293,26 @@ uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
>>>                 return NULL;
>>>
>>>         *len = attrib->buflen;
>>> -
>>>         return attrib->buf;
>>>  }
>>>
>>>  gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
>>>  {
>>> -       if (mtu < ATT_DEFAULT_LE_MTU)
>>> -               return FALSE;
>>> -
>>> -       attrib->buf = g_realloc(attrib->buf, mtu);
>>> -
>>> -       attrib->buflen = mtu;
>>> -
>>> -       return TRUE;
>>> -}
>>> -
>>> -guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
>>> -                               GAttribNotifyFunc func, gpointer user_data,
>>> -                               GDestroyNotify notify)
>>> -{
>>> -       static guint next_evt_id = 0;
>>> -       struct event *event;
>>> -
>>> -       event = g_try_new0(struct event, 1);
>>> -       if (event == NULL)
>>> -               return 0;
>>> -
>>> -       event->expected = opcode;
>>> -       event->handle = handle;
>>> -       event->func = func;
>>> -       event->user_data = user_data;
>>> -       event->notify = notify;
>>> -       event->id = ++next_evt_id;
>>> -
>>> -       attrib->events = g_slist_append(attrib->events, event);
>>> -
>>> -       return event->id;
>>> -}
>>> -
>>> -static int event_cmp_by_id(gconstpointer a, gconstpointer b)
>>> -{
>>> -       const struct event *evt = a;
>>> -       guint id = GPOINTER_TO_UINT(b);
>>> +       /* Clients of this expect a buffer to use. */
>>> +       if (mtu > attrib->buflen) {
>>> +               attrib->buf = g_realloc(attrib->buf, mtu);
>>> +               attrib->buflen = mtu;
>>> +       }
>>>
>>> -       return evt->id - id;
>>> +       return bt_att_set_mtu(attrib->att, mtu);
>>>  }
>>>
>>>  gboolean g_attrib_unregister(GAttrib *attrib, guint id)
>>>  {
>>> -       struct event *evt;
>>> -       GSList *l;
>>> -
>>> -       if (id == 0) {
>>> -               warn("%s: invalid id", __func__);
>>> -               return FALSE;
>>> -       }
>>> -
>>> -       l = g_slist_find_custom(attrib->events, GUINT_TO_POINTER(id),
>>> -                                                       event_cmp_by_id);
>>> -       if (l == NULL)
>>> -               return FALSE;
>>> -
>>> -       evt = l->data;
>>> -
>>> -       attrib->events = g_slist_remove(attrib->events, evt);
>>> -
>>> -       if (evt->notify)
>>> -               evt->notify(evt->user_data);
>>> -
>>> -       g_free(evt);
>>> -
>>> -       return TRUE;
>>> +       return bt_att_unregister(attrib->att, id);
>>>  }
>>>
>>>  gboolean g_attrib_unregister_all(GAttrib *attrib)
>>>  {
>>> -       GSList *l;
>>> -
>>> -       if (attrib->events == NULL)
>>> -               return FALSE;
>>> -
>>> -       for (l = attrib->events; l; l = l->next) {
>>> -               struct event *evt = l->data;
>>> -
>>> -               if (evt->notify)
>>> -                       evt->notify(evt->user_data);
>>> -
>>> -               g_free(evt);
>>> -       }
>>> -
>>> -       g_slist_free(attrib->events);
>>> -       attrib->events = NULL;
>>> -
>>> -       return TRUE;
>>> +       return bt_att_unregister_all(attrib->att);
>>>  }
>>> --
>>> 2.1.0.rc2.206.gedb03e5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
