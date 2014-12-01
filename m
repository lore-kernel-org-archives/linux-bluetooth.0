Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKRpgrdfFqKaeXwUSR6njnYaUFzfAE=gGX+JkVQ9yviNA@mail.gmail.com>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
	<1417196962-3876-4-git-send-email-armansito@chromium.org>
	<CABBYNZ+16OLiVHB5msL7uXErhbKCR022J=jKbXNCsPeu-6uaZw@mail.gmail.com>
	<CAHrH25TBYTioi7NXb6utMHqtzUhaFg_DvNRnRaEsUdLz_r3yow@mail.gmail.com>
	<CABBYNZKRpgrdfFqKaeXwUSR6njnYaUFzfAE=gGX+JkVQ9yviNA@mail.gmail.com>
Date: Mon, 1 Dec 2014 08:37:30 -0800
Message-ID: <CAHrH25Q3ZYB6PKoStwcG_gUSgR2BJHqt1_Wvf0ZPrK3NQ7mZrw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/8] shared/gatt-client: Store services in gatt_db.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Mon Dec 01 2014 at 8:02:47 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> Hi Arman,
>
> On Mon, Dec 1, 2014 at 4:50 PM, Arman Uguray <armansito@chromium.org> wrote:
> > Hi Luiz,
> >
> >> On Mon, Dec 1, 2014 at 1:45 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >> Hi Arman,
> >>
> >> On Fri, Nov 28, 2014 at 7:49 PM, Arman Uguray <armansito@chromium.org> wrote:
> >>> This patch rewrites the service discovery logic inside
> >>> shared/gatt-client. The internal service_list structure has been
> >>> entirely removed and services are stored in a gatt_db instance.
> >>> Initially, gatt-client creates and owns the life-time of the gatt_db.
> >>
> >> Im trying to figure out the reason why you want to start with your own
> >> gatt_db, is it because it lacks reference counting, if that is the
> >> case it should be trivial to add it.
> >>
> >
> > Initially, yes, the lack of reference counting is one reason, which I
> > was thinking of adding to gatt-db eventually. Though, what I had in
> > mind was that, the gatt-db would be created by gatt-client if you want
> > it to perform discovery, otherwise if you construct it with gatt-db
> > then it wouldn't do discovery, which would address the permanent cache
> > case. So, we would have two "new" functions:
> >
> >    bt_gatt_client_new
> >    bt_gatt_client_new_from_db
> >
> > In the first case, if the upper layer wants to make the gatt-db
> > outlive the gatt-client, in the future they can just add a reference
> > to it and own it and in the next connection they can create the client
> > using that same db instance. This is kind of a rough idea right now
> > but I think it makes sense.
> >
> > We can also keep both functions but have both accept a gatt-db as a
> > parameter. Not sure what's best here really.
>
> For unit test maybe we can have bt_gatt_client_new_default, iirc
> Marcel suggested something like this for naming, but for the core
> daemon it can create a empty db when pairing so even the initial
> discovery would use it. This comes back to the idea of having the
> callbacks in the db to attribute added/removed, with this logic we
> could start creating D-Bus objects by the time a services is
> discovered (provided we discover everything necessary) and not only
> when bt_gatt_client signals it is done discovering, actually with the
> current concept we could be spamming the bus a little too much since
> the objects would be created all at same time this would cause several
> InterfacesAdded signals in a row at the end of pairing.
>

I don't know about "_default" naming but are we talking about something like:

  bt_gatt_client_new(att, mtu, db)  /* Does discovery */
  bt_gatt_client_new_from_cache(att, mtu, db)  /* No discovery */

So both functions get passed a db either way?

As for the signals, I think there will be several InterfacesAdded
signals in a row regardless, as objects for characteristics and
descriptors get exported, though either way is fine with me.

I think having these callbacks is OK but to me it makes more sense to
send a service_added signal with all of its attributes already
available in the database. Then the core can just act on that signal
by going through all characteristics and exporting objects for them.
If we're talking about an attribute_added signal for each attribute
then I don't think that will be easy to work with.

> Actually to be more clear, what Im thinking is that we could register
> org.bluez.GattService1 with empty Characteristics and Includes, same
> thing for org.bluez.GattCharacteristic1, or if we want to really do
> per service could register when a service becomes active, meaning the
> bt_gatt_client would control when a service can be registered by
> calling gatt_db_service_set_active thus causing a notification back to
> the core.
>

We can do this in an event driven way, though it's probably simpler to
have a service_added event, where the client can add all the
characteristics, includes, etc and then call set_active to trigger it.

> >>> ---
> >>>  src/shared/gatt-client.c | 942 +++++++++++++++++++++--------------------------
> >>>  src/shared/gatt-client.h |   2 +
> >>>  2 files changed, 430 insertions(+), 514 deletions(-)
> >>>
> >>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> >>> index 033cba1..2dc6735 100644
> >>> --- a/src/shared/gatt-client.c
> >>> +++ b/src/shared/gatt-client.c
> >>> @@ -27,6 +27,7 @@
> >>>  #include "src/shared/gatt-helpers.h"
> >>>  #include "src/shared/util.h"
> >>>  #include "src/shared/queue.h"
> >>> +#include "src/shared/gatt-db.h"
> >>>
> >>>  #include <assert.h>
> >>>  #include <limits.h>
> >>> @@ -65,15 +66,6 @@ struct chrc_data {
> >>>         unsigned int ccc_write_id;
> >>>  };
> >>>
> >>> -struct service_list {
> >>> -       bt_gatt_service_t service;
> >>> -       struct chrc_data *chrcs;
> >>> -       size_t num_chrcs;
> >>> -       bt_gatt_included_service_t *includes;
> >>> -       size_t num_includes;
> >>> -       struct service_list *next;
> >>> -};
> >>> -
> >>>  struct bt_gatt_client {
> >>>         struct bt_att *att;
> >>>         int ref_count;
> >>> @@ -90,7 +82,7 @@ struct bt_gatt_client {
> >>>         bt_gatt_client_destroy_func_t debug_destroy;
> >>>         void *debug_data;
> >>>
> >>> -       struct service_list *svc_head, *svc_tail;
> >>> +       struct gatt_db *db;
> >>>         bool in_init;
> >>>         bool ready;
> >>>
> >>> @@ -114,9 +106,6 @@ struct bt_gatt_client {
> >>>          * value handle. These will have the value 0 if they are not present on
> >>>          * the remote peripheral.
> >>>          */
> >>> -       uint16_t gatt_svc_handle;
> >>> -       uint16_t svc_chngd_val_handle;
> >>> -       uint16_t svc_chngd_ccc_handle;
> >>>         unsigned int svc_chngd_ind_id;
> >>>         struct queue *svc_chngd_queue;  /* Queued service changed events */
> >>>         bool in_svc_chngd;
> >>> @@ -203,161 +192,6 @@ static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
> >>>                 notify_data->invalid = true;
> >>>  }
> >>>
> >>> -static struct service_list *new_service_list(uint16_t start, uint16_t end,
> >>> -                                               bool primary,
> >>> -                                               uint8_t uuid[BT_GATT_UUID_SIZE])
> >>> -{
> >>> -       struct service_list *list;
> >>> -
> >>> -       list = new0(struct service_list, 1);
> >>> -       if (!list)
> >>> -               return NULL;
> >>> -
> >>> -       list->service.primary = primary;
> >>> -       list->service.start_handle = start;
> >>> -       list->service.end_handle = end;
> >>> -       memcpy(list->service.uuid, uuid, UUID_BYTES);
> >>> -
> >>> -       return list;
> >>> -}
> >>> -
> >>> -static bool service_list_add_service(struct service_list **head,
> >>> -                                               struct service_list **tail,
> >>> -                                               bool primary, uint16_t start,
> >>> -                                               uint16_t end,
> >>> -                                               uint8_t uuid[BT_GATT_UUID_SIZE])
> >>> -{
> >>> -       struct service_list *list;
> >>> -
> >>> -       list = new_service_list(start, end, primary, uuid);
> >>> -       if (!list)
> >>> -               return false;
> >>> -
> >>> -       if (!(*head))
> >>> -               *head = *tail = list;
> >>> -       else {
> >>> -               (*tail)->next = list;
> >>> -               *tail = list;
> >>> -       }
> >>> -
> >>> -       return true;
> >>> -}
> >>> -
> >>> -static void service_destroy_characteristics(struct service_list *service)
> >>> -{
> >>> -       unsigned int i;
> >>> -
> >>> -       for (i = 0; i < service->num_chrcs; i++) {
> >>> -               free(service->chrcs[i].descs);
> >>> -               queue_destroy(service->chrcs[i].reg_notify_queue,
> >>> -                                                       notify_data_unref);
> >>> -       }
> >>> -
> >>> -       free(service->chrcs);
> >>> -}
> >>> -
> >>> -static void service_destroy_includes(struct service_list *service)
> >>> -{
> >>> -       free(service->includes);
> >>> -
> >>> -       service->includes = NULL;
> >>> -       service->num_includes = 0;
> >>> -}
> >>> -
> >>> -static void service_list_clear(struct service_list **head,
> >>> -                                               struct service_list **tail)
> >>> -{
> >>> -       struct service_list *l, *tmp;
> >>> -
> >>> -       if (!(*head) || !(*tail))
> >>> -               return;
> >>> -
> >>> -       l = *head;
> >>> -
> >>> -       while (l) {
> >>> -               service_destroy_characteristics(l);
> >>> -               service_destroy_includes(l);
> >>> -               tmp = l;
> >>> -               l = tmp->next;
> >>> -               free(tmp);
> >>> -       }
> >>> -
> >>> -       *head = *tail = NULL;
> >>> -}
> >>> -
> >>> -static void service_list_clear_range(struct service_list **head,
> >>> -                                               struct service_list **tail,
> >>> -                                               uint16_t start, uint16_t end)
> >>> -{
> >>> -       struct service_list *cur, *prev, *tmp;
> >>> -
> >>> -       if (!(*head) || !(*tail))
> >>> -               return;
> >>> -
> >>> -       prev = NULL;
> >>> -       cur = *head;
> >>> -       while (cur) {
> >>> -               if (cur->service.end_handle < start ||
> >>> -                                       cur->service.start_handle > end) {
> >>> -                       prev = cur;
> >>> -                       cur = cur->next;
> >>> -                       continue;
> >>> -               }
> >>> -
> >>> -               service_destroy_characteristics(cur);
> >>> -               service_destroy_includes(cur);
> >>> -
> >>> -               if (!prev)
> >>> -                       *head = cur->next;
> >>> -               else
> >>> -                       prev->next = cur->next;
> >>> -
> >>> -               if (*tail == cur)
> >>> -                       *tail = prev;
> >>> -
> >>> -               tmp = cur;
> >>> -               cur = cur->next;
> >>> -               free(tmp);
> >>> -       }
> >>> -}
> >>> -
> >>> -static void service_list_insert_services(struct service_list **head,
> >>> -                                               struct service_list **tail,
> >>> -                                               struct service_list *svc_head,
> >>> -                                               struct service_list *svc_tail)
> >>> -{
> >>> -       struct service_list *cur, *prev;
> >>> -
> >>> -       if (!(*head) || !(*tail)) {
> >>> -               *head = svc_head;
> >>> -               *tail = svc_tail;
> >>> -               return;
> >>> -       }
> >>> -
> >>> -       prev = NULL;
> >>> -       cur = *head;
> >>> -       while (cur) {
> >>> -               if (svc_tail->service.end_handle < cur->service.start_handle) {
> >>> -                       if (!prev)
> >>> -                               *head = svc_head;
> >>> -                       else
> >>> -                               prev->next = svc_head;
> >>> -
> >>> -                       svc_tail->next = cur;
> >>> -                       return;
> >>> -               }
> >>> -
> >>> -               prev = cur;
> >>> -               cur = cur->next;
> >>> -       }
> >>> -
> >>> -       if (prev != *tail)
> >>> -               return;
> >>> -
> >>> -       prev->next = svc_head;
> >>> -       *tail = svc_tail;
> >>> -}
> >>> -
> >>>  static void gatt_client_remove_all_notify_in_range(
> >>>                                 struct bt_gatt_client *client,
> >>>                                 uint16_t start_handle, uint16_t end_handle)
> >>> @@ -379,25 +213,71 @@ static void gatt_client_remove_all_notify_in_range(
> >>>                                                 &range, notify_data_unref);
> >>>  }
> >>>
> >>> -static void gatt_client_clear_services(struct bt_gatt_client *client)
> >>> -{
> >>> +struct discovery_op;
> >>>
> >>> -       gatt_client_remove_all_notify_in_range(client, 0x0001, 0xffff);
> >>> -       service_list_clear(&client->svc_head, &client->svc_tail);
> >>> -}
> >>> +typedef void (*discovery_op_complete_func_t)(struct discovery_op *op,
> >>> +                                                       bool success,
> >>> +                                                       uint8_t att_ecode);
> >>> +typedef void (*discovery_op_fail_func_t)(struct discovery_op *op);
> >>>
> >>>  struct discovery_op {
> >>>         struct bt_gatt_client *client;
> >>> -       struct service_list *result_head, *result_tail, *cur_service;
> >>> -       struct chrc_data *cur_chrc;
> >>> +       struct queue *pending_svcs;
> >>> +       struct queue *pending_chrcs;
> >>> +       struct queue *tmp_queue;
> >>> +       struct gatt_db_attribute *cur_svc;
> >>> +       bool success;
> >>>         uint16_t start;
> >>>         uint16_t end;
> >>> -       int cur_chrc_index;
> >>>         int ref_count;
> >>> -       void (*complete_func)(struct discovery_op *op, bool success,
> >>> -                                                       uint8_t att_ecode);
> >>> +       discovery_op_complete_func_t complete_func;
> >>> +       discovery_op_fail_func_t failure_func;
> >>>  };
> >>>
> >>> +static void discovery_op_free(struct discovery_op *op)
> >>> +{
> >>> +       queue_destroy(op->pending_svcs, NULL);
> >>> +       queue_destroy(op->pending_chrcs, free);
> >>> +       queue_destroy(op->tmp_queue, NULL);
> >>> +       free(op);
> >>> +}
> >>> +
> >>> +static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
> >>> +                               uint16_t start, uint16_t end,
> >>> +                               discovery_op_complete_func_t complete_func,
> >>> +                               discovery_op_fail_func_t failure_func)
> >>> +{
> >>> +       struct discovery_op *op;
> >>> +
> >>> +       op = new0(struct discovery_op, 1);
> >>> +       if (!op)
> >>> +               return NULL;
> >>> +
> >>> +       op->pending_svcs = queue_new();
> >>> +       if (!op->pending_svcs)
> >>> +               goto fail;
> >>> +
> >>> +       op->pending_chrcs = queue_new();
> >>> +       if (!op->pending_chrcs)
> >>> +               goto fail;
> >>> +
> >>> +       op->tmp_queue = queue_new();
> >>> +       if (!op->tmp_queue)
> >>> +               goto fail;
> >>> +
> >>> +       op->client = client;
> >>> +       op->complete_func = complete_func;
> >>> +       op->failure_func = failure_func;
> >>> +       op->start = start;
> >>> +       op->end = end;
> >>> +
> >>> +       return op;
> >>> +
> >>> +fail:
> >>> +       discovery_op_free(op);
> >>> +       return NULL;
> >>> +}
> >>> +
> >>>  static struct discovery_op *discovery_op_ref(struct discovery_op *op)
> >>>  {
> >>>         __sync_fetch_and_add(&op->ref_count, 1);
> >>> @@ -412,45 +292,27 @@ static void discovery_op_unref(void *data)
> >>>         if (__sync_sub_and_fetch(&op->ref_count, 1))
> >>>                 return;
> >>>
> >>> -       service_list_clear(&op->result_head, &op->result_tail);
> >>> -
> >>> -       free(data);
> >>> -}
> >>> -
> >>> -static void uuid_to_string(const uint8_t uuid[BT_GATT_UUID_SIZE],
> >>> -                                               char str[MAX_LEN_UUID_STR])
> >>> -{
> >>> -       bt_uuid_t tmp;
> >>> +       if (!op->success)
> >>> +               op->failure_func(op);
> >>>
> >>> -       tmp.type = BT_UUID128;
> >>> -       memcpy(tmp.value.u128.data, uuid, UUID_BYTES);
> >>> -       bt_uuid_to_string(&tmp, str, MAX_LEN_UUID_STR * sizeof(char));
> >>> +       discovery_op_free(op);
> >>>  }
> >>>
> >>>  static void discover_chrcs_cb(bool success, uint8_t att_ecode,
> >>>                                                 struct bt_gatt_result *result,
> >>>                                                 void *user_data);
> >>>
> >>> -static int uuid_cmp(const uint8_t uuid128[16], uint16_t uuid16)
> >>> -{
> >>> -       uint8_t rhs_uuid[16] = {
> >>> -               0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> >>> -               0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
> >>> -       };
> >>> -
> >>> -       put_be16(uuid16, rhs_uuid + 2);
> >>> -
> >>> -       return memcmp(uuid128, rhs_uuid, sizeof(rhs_uuid));
> >>> -}
> >>> -
> >>>  static void discover_incl_cb(bool success, uint8_t att_ecode,
> >>>                                 struct bt_gatt_result *result, void *user_data)
> >>>  {
> >>>         struct discovery_op *op = user_data;
> >>>         struct bt_gatt_client *client = op->client;
> >>>         struct bt_gatt_iter iter;
> >>> +       struct gatt_db_attribute *attr, *tmp;
> >>> +       uint16_t handle, start, end;
> >>> +       uint128_t u128;
> >>> +       bt_uuid_t uuid;
> >>>         char uuid_str[MAX_LEN_UUID_STR];
> >>> -       bt_gatt_included_service_t *includes;
> >>>         unsigned int includes_count, i;
> >>>
> >>>         if (!success) {
> >>> @@ -460,6 +322,11 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
> >>>                 goto failed;
> >>>         }
> >>>
> >>> +       /* Get the currently processed service */
> >>> +       attr = op->cur_svc;
> >>> +       if (!attr)
> >>> +               goto failed;
> >>> +
> >>>         if (!result || !bt_gatt_iter_init(&iter, result))
> >>>                 goto failed;
> >>>
> >>> @@ -467,42 +334,68 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
> >>>         if (includes_count == 0)
> >>>                 goto failed;
> >>>
> >>> -       includes = new0(bt_gatt_included_service_t, includes_count);
> >>> -       if (!includes)
> >>> -               goto failed;
> >>> -
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>>                                                 "Included services found: %u",
> >>>                                                 includes_count);
> >>>
> >>>         for (i = 0; i < includes_count; i++) {
> >>> -               if (!bt_gatt_iter_next_included_service(&iter,
> >>> -                                               &includes[i].handle,
> >>> -                                               &includes[i].start_handle,
> >>> -                                               &includes[i].end_handle,
> >>> -                                               includes[i].uuid))
> >>> +               if (!bt_gatt_iter_next_included_service(&iter, &handle, &start,
> >>> +                                                       &end, u128.data))
> >>>                         break;
> >>>
> >>> -               uuid_to_string(includes[i].uuid, uuid_str);
> >>> +               bt_uuid128_create(&uuid, u128);
> >>> +
> >>> +               /* Log debug message */
> >>> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>>                                 "handle: 0x%04x, start: 0x%04x, end: 0x%04x,"
> >>> -                               "uuid: %s", includes[i].handle,
> >>> -                               includes[i].start_handle,
> >>> -                               includes[i].end_handle, uuid_str);
> >>> -       }
> >>> +                               "uuid: %s", handle, start, end, uuid_str);
> >>>
> >>> -       op->cur_service->includes = includes;
> >>> -       op->cur_service->num_includes = includes_count;
> >>> +               tmp = gatt_db_get_attribute(client->db, start);
> >>> +               if (!tmp)
> >>> +                       goto failed;
> >>> +
> >>> +               tmp = gatt_db_service_add_included(attr, tmp);
> >>> +               if (!tmp)
> >>> +                       goto failed;
> >>> +
> >>> +               /*
> >>> +                * GATT requires that all include definitions precede
> >>> +                * characteristic declarations. Based on the order we're adding
> >>> +                * these entries, the correct handle must be assigned to the new
> >>> +                * attribute.
> >>> +                */
> >>> +               if (gatt_db_attribute_get_handle(tmp) != handle)
> >>> +                       goto failed;
> >>> +       }
> >>>
> >>>  next:
> >>> -       if (!op->cur_service->next) {
> >>> -               op->cur_service = op->result_head;
> >>> +       /* Move on to the next service */
> >>> +       attr = queue_pop_head(op->pending_svcs);
> >>> +       if (!attr) {
> >>> +               struct queue *tmp_queue;
> >>> +
> >>> +               tmp_queue = op->pending_svcs;
> >>> +               op->pending_svcs = op->tmp_queue;
> >>> +               op->tmp_queue = tmp_queue;
> >>> +
> >>> +               /*
> >>> +                * We have processed all include definitions. Move on to
> >>> +                * characteristics.
> >>> +                */
> >>> +               attr = queue_pop_head(op->pending_svcs);
> >>> +               if (!attr)
> >>> +                       goto failed;
> >>> +
> >>> +               if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
> >>> +                       goto failed;
> >>> +
> >>> +               op->cur_svc = attr;
> >>>                 if (bt_gatt_discover_characteristics(client->att,
> >>> -                                       op->cur_service->service.start_handle,
> >>> -                                       op->cur_service->service.end_handle,
> >>> -                                       discover_chrcs_cb,
> >>> -                                       discovery_op_ref(op),
> >>> -                                       discovery_op_unref))
> >>> +                                                       start, end,
> >>> +                                                       discover_chrcs_cb,
> >>> +                                                       discovery_op_ref(op),
> >>> +                                                       discovery_op_unref))
> >>>                         return;
> >>>
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>> @@ -511,13 +404,15 @@ next:
> >>>                 goto failed;
> >>>         }
> >>>
> >>> -       op->cur_service = op->cur_service->next;
> >>> -       if (bt_gatt_discover_included_services(client->att,
> >>> -                               op->cur_service->service.start_handle,
> >>> -                               op->cur_service->service.end_handle,
> >>> -                               discover_incl_cb,
> >>> -                               discovery_op_ref(op),
> >>> -                               discovery_op_unref))
> >>> +       queue_push_tail(op->tmp_queue, attr);
> >>> +       op->cur_svc = attr;
> >>> +       if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
> >>> +               goto failed;
> >>> +
> >>> +       if (bt_gatt_discover_included_services(client->att, start, end,
> >>> +                                                       discover_incl_cb,
> >>> +                                                       discovery_op_ref(op),
> >>> +                                                       discovery_op_unref))
> >>>                 return;
> >>>
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>> @@ -525,9 +420,78 @@ next:
> >>>         discovery_op_unref(op);
> >>>
> >>>  failed:
> >>> +       op->success = false;
> >>>         op->complete_func(op, false, att_ecode);
> >>>  }
> >>>
> >>> +struct chrc {
> >>> +       uint16_t start_handle;
> >>> +       uint16_t end_handle;
> >>> +       uint16_t value_handle;
> >>> +       uint8_t properties;
> >>> +       bt_uuid_t uuid;
> >>> +};
> >>> +
> >>> +static void discover_descs_cb(bool success, uint8_t att_ecode,
> >>> +                                               struct bt_gatt_result *result,
> >>> +                                               void *user_data);
> >>> +
> >>> +static int discover_descs(struct discovery_op *op)
> >>> +{
> >>> +       struct bt_gatt_client *client = op->client;
> >>> +       struct gatt_db_attribute *attr;
> >>> +       struct chrc *chrc_data;
> >>> +       uint16_t desc_start;
> >>> +
> >>> +       /*
> >>> +        * This method returns the following three values:
> >>> +        *    -1: Failure
> >>> +        *     0: No discovery started
> >>> +        *     1: Discovery started
> >>> +        */
> >>
> >> This is a bad sign if you have to explain what the return are, Id say
> >> it would probably be better if you return errno such as -EINVAL for
> >> errors and 0 for success and the caller can check if pending_chrcs is
> >> empty before calling this one.
> >>
> >
> > Hmm, pending_chrcs can be empty and discovery may have been initiated.
> > I'll just add a boolean parameter to indicate whether descriptor
> > discovery was started.
>
> Btw is there a reason we are not requesting every descriptor at once?
> Would it be a problem if we fail to discover some descriptors but
> proceed to discover the others? Because it looks like that this could
> be queued by bt_att itself but perhaps we need some way to
> cancel/abort if something goes wrong.
>

The bt_gatt_discover_descriptors function will call the callback once
all the descriptors within the given range have been discovered. In
other words, we are discovering all descriptors per characteristic
following the GATT spec.

If you're asking why we aren't just calling
bt_gatt_discover_descriptors for each characteristic in one loop
instead of having this step function, that's because attributes need
to be inserted into gatt-db in a certain order. Doing things in
sequence this way just makes keeping track of insertion order
straightforward. Otherwise, since each discovery procedure might
return at a different time, we would probably have to maintain a
separate list of descriptors per characteristic, keep track of when
all procedures have been completed, and then insert everything in
order then. This way seemed simpler to me.

> >>> +       while ((chrc_data = queue_pop_head(op->pending_chrcs))) {
> >>> +               attr = gatt_db_service_add_characteristic(op->cur_svc,
> >>> +                                                       &chrc_data->uuid, 0,
> >>> +                                                       chrc_data->properties,
> >>> +                                                       NULL, NULL, NULL);
> >>> +
> >>> +               if (!attr)
> >>> +                       goto failed;
> >>> +
> >>> +               if (gatt_db_attribute_get_handle(attr) !=
> >>> +                                                       chrc_data->value_handle)
> >>> +                       goto failed;
> >>> +
> >>> +               desc_start = chrc_data->value_handle + 1;
> >>> +
> >>> +               if (desc_start > chrc_data->end_handle)
> >>> +                       continue;
> >>> +
> >>> +               if (bt_gatt_discover_descriptors(client->att, desc_start,
> >>> +                                                       chrc_data->end_handle,
> >>> +                                                       discover_descs_cb,
> >>> +                                                       discovery_op_ref(op),
> >>> +                                                       discovery_op_unref)) {
> >>> +                       free(chrc_data);
> >>> +                       return 1;
> >>> +               }
> >>> +
> >>> +               util_debug(client->debug_callback, client->debug_data,
> >>> +                                       "Failed to start descriptor discovery");
> >>> +               discovery_op_unref(op);
> >>> +
> >>> +               goto failed;
> >>> +       }
> >>> +
> >>> +       free(chrc_data);
> >>> +       return 0;
> >>> +
> >>> +failed:
> >>> +       free(chrc_data);
> >>> +       return -1;
> >>> +}
> >>> +
> >>>  static void discover_descs_cb(bool success, uint8_t att_ecode,
> >>>                                                 struct bt_gatt_result *result,
> >>>                                                 void *user_data)
> >>> @@ -535,11 +499,13 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
> >>>         struct discovery_op *op = user_data;
> >>>         struct bt_gatt_client *client = op->client;
> >>>         struct bt_gatt_iter iter;
> >>> +       struct gatt_db_attribute *attr;
> >>> +       uint16_t handle, start, end;
> >>> +       uint128_t u128;
> >>> +       bt_uuid_t uuid;
> >>>         char uuid_str[MAX_LEN_UUID_STR];
> >>>         unsigned int desc_count;
> >>> -       uint16_t desc_start;
> >>> -       unsigned int i;
> >>> -       bt_gatt_descriptor_t *descs;
> >>> +       int status;
> >>>
> >>>         if (!success) {
> >>>                 if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
> >>> @@ -550,94 +516,69 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
> >>>                 goto done;
> >>>         }
> >>>
> >>> -       if (!result || !bt_gatt_iter_init(&iter, result)) {
> >>> -               success = false;
> >>> -               goto done;
> >>> -       }
> >>> +       if (!result || !bt_gatt_iter_init(&iter, result))
> >>> +               goto failed;
> >>>
> >>>         desc_count = bt_gatt_result_descriptor_count(result);
> >>> -       if (desc_count == 0) {
> >>> -               success = false;
> >>> -               goto done;
> >>> -       }
> >>> +       if (desc_count == 0)
> >>> +               goto failed;
> >>>
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>>                                         "Descriptors found: %u", desc_count);
> >>>
> >>> -       descs = new0(bt_gatt_descriptor_t, desc_count);
> >>> -       if (!descs) {
> >>> -               success = false;
> >>> -               goto done;
> >>> -       }
> >>> +       while (bt_gatt_iter_next_descriptor(&iter, &handle, u128.data)) {
> >>> +               bt_uuid128_create(&uuid, u128);
> >>>
> >>> -       i = 0;
> >>> -       while (bt_gatt_iter_next_descriptor(&iter, &descs[i].handle,
> >>> -                                                       descs[i].uuid)) {
> >>> -               uuid_to_string(descs[i].uuid, uuid_str);
> >>> +               /* Log debug message */
> >>> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>>                                                 "handle: 0x%04x, uuid: %s",
> >>> -                                               descs[i].handle, uuid_str);
> >>> +                                               handle, uuid_str);
> >>>
> >>> -               if (uuid_cmp(descs[i].uuid, GATT_CLIENT_CHARAC_CFG_UUID) == 0) {
> >>> -                       op->cur_chrc->ccc_handle = descs[i].handle;
> >>> -
> >>> -                       if (uuid_cmp(op->cur_chrc->chrc_external.uuid,
> >>> -                                                       SVC_CHNGD_UUID) == 0)
> >>> -                               client->svc_chngd_ccc_handle = descs[i].handle;
> >>> -               }
> >>> +               attr = gatt_db_service_add_descriptor(op->cur_svc, &uuid, 0,
> >>> +                                                       NULL, NULL, NULL);
> >>> +               if (!attr)
> >>> +                       goto failed;
> >>>
> >>> -               i++;
> >>> +               if (gatt_db_attribute_get_handle(attr) != handle)
> >>> +                       goto failed;
> >>>         }
> >>>
> >>> -       op->cur_chrc->chrc_external.num_descs = desc_count;
> >>> -       op->cur_chrc->descs = descs;
> >>> -       op->cur_chrc->chrc_external.descs = descs;
> >>> -
> >>> -       for (i = op->cur_chrc_index + 1; i < op->cur_service->num_chrcs; i++) {
> >>> -               op->cur_chrc_index = i;
> >>> -               op->cur_chrc++;
> >>> -               desc_start = op->cur_chrc->chrc_external.value_handle + 1;
> >>> -               if (desc_start > op->cur_chrc->chrc_external.end_handle)
> >>> -                       continue;
> >>> -
> >>> -               if (bt_gatt_discover_descriptors(client->att, desc_start,
> >>> -                                       op->cur_chrc->chrc_external.end_handle,
> >>> -                                       discover_descs_cb, discovery_op_ref(op),
> >>> -                                       discovery_op_unref))
> >>> -                       return;
> >>> -
> >>> -               util_debug(client->debug_callback, client->debug_data,
> >>> -                                       "Failed to start descriptor discovery");
> >>> -               discovery_op_unref(op);
> >>> -               success = false;
> >>> +       status = discover_descs(op);
> >>> +       if (status < 0)
> >>> +               goto failed;
> >>>
> >>> -               goto done;
> >>> -       }
> >>> +       if (status > 0)
> >>> +               return;
> >>>
> >>>  next:
> >>> -       if (!op->cur_service->next)
> >>> +       attr = queue_pop_head(op->pending_svcs);
> >>> +       if (!attr)
> >>>                 goto done;
> >>>
> >>> +       if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
> >>> +               goto failed;
> >>> +
> >>>         /* Move on to the next service */
> >>> -       op->cur_service = op->cur_service->next;
> >>> -       if (bt_gatt_discover_characteristics(client->att,
> >>> -                                       op->cur_service->service.start_handle,
> >>> -                                       op->cur_service->service.end_handle,
> >>> -                                       discover_chrcs_cb,
> >>> -                                       discovery_op_ref(op),
> >>> -                                       discovery_op_unref))
> >>> +       op->cur_svc = attr;
> >>> +       if (bt_gatt_discover_characteristics(client->att, start, end,
> >>> +                                                       discover_chrcs_cb,
> >>> +                                                       discovery_op_ref(op),
> >>> +                                                       discovery_op_unref))
> >>>                 return;
> >>>
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>>                                 "Failed to start characteristic discovery");
> >>>         discovery_op_unref(op);
> >>> +
> >>> +failed:
> >>>         success = false;
> >>>
> >>>  done:
> >>> +       op->success = success;
> >>>         op->complete_func(op, success, att_ecode);
> >>>  }
> >>>
> >>> -
> >>>  static void discover_chrcs_cb(bool success, uint8_t att_ecode,
> >>>                                                 struct bt_gatt_result *result,
> >>>                                                 void *user_data)
> >>> @@ -645,11 +586,15 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
> >>>         struct discovery_op *op = user_data;
> >>>         struct bt_gatt_client *client = op->client;
> >>>         struct bt_gatt_iter iter;
> >>> +       struct gatt_db_attribute *attr;
> >>> +       struct chrc *chrc_data;
> >>> +       uint16_t start, end, value;
> >>> +       uint8_t properties;
> >>> +       uint128_t u128;
> >>> +       bt_uuid_t uuid;
> >>>         char uuid_str[MAX_LEN_UUID_STR];
> >>>         unsigned int chrc_count;
> >>> -       unsigned int i;
> >>> -       uint16_t desc_start;
> >>> -       struct chrc_data *chrcs;
> >>> +       int status;
> >>>
> >>>         if (!success) {
> >>>                 if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
> >>> @@ -660,98 +605,76 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
> >>>                 goto done;
> >>>         }
> >>>
> >>> -       if (!result || !bt_gatt_iter_init(&iter, result)) {
> >>> -               success = false;
> >>> -               goto done;
> >>> -       }
> >>> +       if (!op->cur_svc || !result || !bt_gatt_iter_init(&iter, result))
> >>> +               goto failed;
> >>>
> >>>         chrc_count = bt_gatt_result_characteristic_count(result);
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>>                                 "Characteristics found: %u", chrc_count);
> >>>
> >>>         if (chrc_count == 0)
> >>> -               goto next;
> >>> +               goto failed;
> >>>
> >>> -       chrcs = new0(struct chrc_data, chrc_count);
> >>> -       if (!chrcs) {
> >>> -               success = false;
> >>> -               goto done;
> >>> -       }
> >>> +       while (bt_gatt_iter_next_characteristic(&iter, &start, &end, &value,
> >>> +                                               &properties, u128.data)) {
> >>> +               bt_uuid128_create(&uuid, u128);
> >>>
> >>> -       i = 0;
> >>> -       while (bt_gatt_iter_next_characteristic(&iter,
> >>> -                                       &chrcs[i].chrc_external.start_handle,
> >>> -                                       &chrcs[i].chrc_external.end_handle,
> >>> -                                       &chrcs[i].chrc_external.value_handle,
> >>> -                                       &chrcs[i].chrc_external.properties,
> >>> -                                       chrcs[i].chrc_external.uuid)) {
> >>> -               uuid_to_string(chrcs[i].chrc_external.uuid, uuid_str);
> >>> +               /* Log debug message */
> >>> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>>                                 "start: 0x%04x, end: 0x%04x, value: 0x%04x, "
> >>>                                 "props: 0x%02x, uuid: %s",
> >>> -                               chrcs[i].chrc_external.start_handle,
> >>> -                               chrcs[i].chrc_external.end_handle,
> >>> -                               chrcs[i].chrc_external.value_handle,
> >>> -                               chrcs[i].chrc_external.properties,
> >>> -                               uuid_str);
> >>> -
> >>> -               chrcs[i].reg_notify_queue = queue_new();
> >>> -               if (!chrcs[i].reg_notify_queue) {
> >>> -                       success = false;
> >>> -                       goto done;
> >>> -               }
> >>> -
> >>> -               if (uuid_cmp(chrcs[i].chrc_external.uuid, SVC_CHNGD_UUID) == 0)
> >>> -                       client->svc_chngd_val_handle =
> >>> -                                       chrcs[i].chrc_external.value_handle;
> >>> +                               start, end, value, properties, uuid_str);
> >>>
> >>> -               i++;
> >>> -       }
> >>> +               chrc_data = new0(struct chrc, 1);
> >>> +               if (!chrc_data)
> >>> +                       goto failed;
> >>>
> >>> -       op->cur_service->chrcs = chrcs;
> >>> -       op->cur_service->num_chrcs = chrc_count;
> >>> +               chrc_data->start_handle = start;
> >>> +               chrc_data->end_handle = end;
> >>> +               chrc_data->value_handle = value;
> >>> +               chrc_data->properties = properties;
> >>> +               chrc_data->uuid = uuid;
> >>>
> >>> -       for (i = 0; i < chrc_count; i++) {
> >>> -               op->cur_chrc_index = i;
> >>> -               op->cur_chrc = chrcs + i;
> >>> -               desc_start = chrcs[i].chrc_external.value_handle;
> >>> -               if (desc_start++ == chrcs[i].chrc_external.end_handle)
> >>> -                       continue;
> >>> -
> >>> -               if (bt_gatt_discover_descriptors(client->att, desc_start,
> >>> -                                       chrcs[i].chrc_external.end_handle,
> >>> -                                       discover_descs_cb, discovery_op_ref(op),
> >>> -                                       discovery_op_unref))
> >>> -                       return;
> >>> +               queue_push_tail(op->pending_chrcs, chrc_data);
> >>> +       }
> >>>
> >>> -               util_debug(client->debug_callback, client->debug_data,
> >>> -                                       "Failed to start descriptor discovery");
> >>> -               discovery_op_unref(op);
> >>> -               success = false;
> >>> +       /*
> >>> +        * Sequentially discover descriptors for each characteristic and insert
> >>> +        * the characteristics into the database as we proceed.
> >>> +        */
> >>> +       status = discover_descs(op);
> >>> +       if (status < 0)
> >>> +               goto failed;
> >>>
> >>> -               goto done;
> >>> -       }
> >>> +       if (status > 0)
> >>> +               return;
> >>>
> >>>  next:
> >>> -       if (!op->cur_service->next)
> >>> +       attr = queue_pop_head(op->pending_svcs);
> >>> +       if (!attr)
> >>>                 goto done;
> >>>
> >>> +       if (!gatt_db_attribute_get_service_handles(attr, &start, &end))
> >>> +               goto failed;
> >>> +
> >>>         /* Move on to the next service */
> >>> -       op->cur_service = op->cur_service->next;
> >>> -       if (bt_gatt_discover_characteristics(client->att,
> >>> -                                       op->cur_service->service.start_handle,
> >>> -                                       op->cur_service->service.end_handle,
> >>> -                                       discover_chrcs_cb,
> >>> -                                       discovery_op_ref(op),
> >>> -                                       discovery_op_unref))
> >>> +       op->cur_svc = attr;
> >>> +       if (bt_gatt_discover_characteristics(client->att, start, end,
> >>> +                                                       discover_chrcs_cb,
> >>> +                                                       discovery_op_ref(op),
> >>> +                                                       discovery_op_unref))
> >>>                 return;
> >>>
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>>                                 "Failed to start characteristic discovery");
> >>>         discovery_op_unref(op);
> >>> +
> >>> +failed:
> >>>         success = false;
> >>>
> >>>  done:
> >>> +       op->success = success;
> >>>         op->complete_func(op, success, att_ecode);
> >>>  }
> >>>
> >>> @@ -762,10 +685,11 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
> >>>         struct discovery_op *op = user_data;
> >>>         struct bt_gatt_client *client = op->client;
> >>>         struct bt_gatt_iter iter;
> >>> +       struct gatt_db_attribute *attr;
> >>>         uint16_t start, end;
> >>> -       uint8_t uuid[BT_GATT_UUID_SIZE];
> >>> +       uint128_t u128;
> >>> +       bt_uuid_t uuid;
> >>>         char uuid_str[MAX_LEN_UUID_STR];
> >>> -       struct service_list *service;
> >>>
> >>>         if (!success) {
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>> @@ -780,40 +704,61 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
> >>>                 }
> >>>         }
> >>>
> >>> -       if (!result || !bt_gatt_iter_init(&iter, result))
> >>> +       if (!result || !bt_gatt_iter_init(&iter, result)) {
> >>> +               success = false;
> >>>                 goto done;
> >>> +       }
> >>>
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>>                                         "Secondary services found: %u",
> >>>                                         bt_gatt_result_service_count(result));
> >>>
> >>> -       while (bt_gatt_iter_next_service(&iter, &start, &end, uuid)) {
> >>> -               uuid_to_string(uuid, uuid_str);
> >>> +       while (bt_gatt_iter_next_service(&iter, &start, &end, u128.data)) {
> >>> +               bt_uuid128_create(&uuid, u128);
> >>> +
> >>> +               /* Log debug message */
> >>> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>>                                 "start: 0x%04x, end: 0x%04x, uuid: %s",
> >>>                                 start, end, uuid_str);
> >>>
> >>>                 /* Store the service */
> >>> -               service = new_service_list(start, end, false, uuid);
> >>> -               if (!service) {
> >>> +               attr = gatt_db_insert_service(client->db, start, &uuid, false,
> >>> +                                                       end - start + 1);
> >>> +               if (!attr) {
> >>>                         util_debug(client->debug_callback, client->debug_data,
> >>>                                                 "Failed to create service");
> >>> +                       success = false;
> >>>                         goto done;
> >>>                 }
> >>>
> >>> -               service_list_insert_services(&op->result_head, &op->result_tail,
> >>> -                                                       service, service);
> >>> +               gatt_db_service_set_active(attr, true);
> >>> +               queue_push_tail(op->pending_svcs, attr);
> >>>         }
> >>>
> >>>  next:
> >>>         /* Sequentially discover included services */
> >>> -       op->cur_service = op->result_head;
> >>> -       if (bt_gatt_discover_included_services(client->att,
> >>> -                                       op->cur_service->service.start_handle,
> >>> -                                       op->cur_service->service.end_handle,
> >>> -                                       discover_incl_cb,
> >>> -                                       discovery_op_ref(op),
> >>> -                                       discovery_op_unref))
> >>> +       attr = queue_pop_head(op->pending_svcs);
> >>> +
> >>> +       /* Complete with success if queue is empty */
> >>> +       if (!attr)
> >>> +               goto done;
> >>> +
> >>> +       /* Store the service in the current queue to be reused during
> >>> +        * characteristics discovery later.
> >>> +        */
> >>> +       queue_push_tail(op->tmp_queue, attr);
> >>> +       op->cur_svc = attr;
> >>> +
> >>> +       if (!gatt_db_attribute_get_service_handles(attr, &start, &end)) {
> >>> +               success = false;
> >>> +               goto done;
> >>> +       }
> >>> +
> >>> +       if (bt_gatt_discover_included_services(client->att, start, end,
> >>> +                                                       discover_incl_cb,
> >>> +                                                       discovery_op_ref(op),
> >>> +                                                       discovery_op_unref))
> >>>                 return;
> >>>
> >>>         util_debug(client->debug_callback, client->debug_data,
> >>> @@ -821,7 +766,8 @@ next:
> >>>         discovery_op_unref(op);
> >>>
> >>>  done:
> >>> -       op->complete_func(op, false, att_ecode);
> >>> +       op->success = success;
> >>> +       op->complete_func(op, success, att_ecode);
> >>>  }
> >>>
> >>>  static void discover_primary_cb(bool success, uint8_t att_ecode,
> >>> @@ -831,8 +777,10 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
> >>>         struct discovery_op *op = user_data;
> >>>         struct bt_gatt_client *client = op->client;
> >>>         struct bt_gatt_iter iter;
> >>> +       struct gatt_db_attribute *attr;
> >>>         uint16_t start, end;
> >>> -       uint8_t uuid[BT_GATT_UUID_SIZE];
> >>> +       uint128_t u128;
> >>> +       bt_uuid_t uuid;
> >>>         char uuid_str[MAX_LEN_UUID_STR];
> >>>
> >>>         if (!success) {
> >>> @@ -851,33 +799,29 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
> >>>                                         "Primary services found: %u",
> >>>                                         bt_gatt_result_service_count(result));
> >>>
> >>> -       while (bt_gatt_iter_next_service(&iter, &start, &end, uuid)) {
> >>> +       while (bt_gatt_iter_next_service(&iter, &start, &end, u128.data)) {
> >>> +               bt_uuid128_create(&uuid, u128);
> >>> +
> >>>                 /* Log debug message. */
> >>> -               uuid_to_string(uuid, uuid_str);
> >>> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>>                                 "start: 0x%04x, end: 0x%04x, uuid: %s",
> >>>                                 start, end, uuid_str);
> >>>
> >>> -               /* Store the service */
> >>> -               if (!service_list_add_service(&op->result_head,
> >>> -                                       &op->result_tail, true, start, end,
> >>> -                                       uuid)) {
> >>> +               attr = gatt_db_insert_service(client->db, start, &uuid, true,
> >>> +                                                       end - start + 1);
> >>> +               if (!attr) {
> >>>                         util_debug(client->debug_callback, client->debug_data,
> >>>                                                 "Failed to store service");
> >>>                         success = false;
> >>>                         goto done;
> >>>                 }
> >>>
> >>> -               if (uuid_cmp(uuid, GATT_SVC_UUID) == 0)
> >>> -                       client->gatt_svc_handle = start;
> >>> +               gatt_db_service_set_active(attr, true);
> >>> +               queue_push_tail(op->pending_svcs, attr);
> >>>         }
> >>>
> >>> -       /* Complete the process if the service list is empty */
> >>> -       if (!op->result_head)
> >>> -               goto done;
> >>> -
> >>>         /* Discover secondary services */
> >>> -       op->cur_service = op->result_head;
> >>>         if (bt_gatt_discover_secondary_services(client->att, NULL,
> >>>                                                         op->start, op->end,
> >>>                                                         discover_secondary_cb,
> >>> @@ -891,6 +835,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
> >>>         success = false;
> >>>
> >>>  done:
> >>> +       op->success = success;
> >>>         op->complete_func(op, success, att_ecode);
> >>>  }
> >>>
> >>> @@ -971,7 +916,9 @@ static void service_changed_complete(struct discovery_op *op, bool success,
> >>>         struct service_changed_op *next_sc_op;
> >>>         uint16_t start_handle = op->start;
> >>>         uint16_t end_handle = op->end;
> >>> -       bool services_found = false;
> >>> +       struct gatt_db_attribute *attr;
> >>> +       bt_uuid_t uuid;
> >>> +       struct queue *q;
> >>>
> >>>         client->in_svc_chngd = false;
> >>>
> >>> @@ -979,25 +926,10 @@ static void service_changed_complete(struct discovery_op *op, bool success,
> >>>                 util_debug(client->debug_callback, client->debug_data,
> >>>                         "Failed to discover services within changed range - "
> >>>                         "error: 0x%02x", att_ecode);
> >>> -               goto next;
> >>> -       }
> >>> -
> >>> -       /* No new services in the modified range */
> >>> -       if (!op->result_head || !op->result_tail)
> >>> -               goto next;
> >>>
> >>> -       services_found = true;
> >>> -
> >>> -       /* Insert all newly discovered services in their correct place as a
> >>> -        * contiguous chunk */
> >>> -       service_list_insert_services(&client->svc_head, &client->svc_tail,
> >>> -                                       op->result_head, op->result_tail);
> >>> -
> >>> -       /* Relinquish ownership of services, as the client now owns them */
> >>> -       op->result_head = NULL;
> >>> -       op->result_tail = NULL;
> >>> +               gatt_db_clear_range(client->db, start_handle, end_handle);
> >>> +       }
> >>>
> >>> -next:
> >>>         /* Notify the upper layer of changed services */
> >>>         if (client->svc_chngd_callback)
> >>>                 client->svc_chngd_callback(start_handle, end_handle,
> >>> @@ -1012,26 +944,41 @@ next:
> >>>                 return;

-Arman
