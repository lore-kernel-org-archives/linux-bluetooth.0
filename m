Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBc=VRa9doQMDsOU+tBTZCrBjcsEkSD9Z_b37wO_CF15dg@mail.gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
	<1324051799-21439-2-git-send-email-sancane@gmail.com>
	<CAKT1EBc=VRa9doQMDsOU+tBTZCrBjcsEkSD9Z_b37wO_CF15dg@mail.gmail.com>
Date: Mon, 19 Dec 2011 15:35:42 +0100
Message-ID: <CACLukzLoHB5u-Vp6RW1rE1z3HDo1hexw5eVOivQHmfhCwJqzAg@mail.gmail.com>
Subject: Re: [PATCH 01/11] attrib-server: Initial steps to provide
 multi-adapter GATT server support
From: Santiago Carot <sancane@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

2011/12/19 Claudio Takahasi <claudio.takahasi@openbossa.org>:
> Hi Santiago,
>
> On Fri, Dec 16, 2011 at 1:09 PM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> This patch prepares the structures in att-server to start and stop
>> GATT server whenever an adapter is plugged or unplugged.
>> ---
>>  src/attrib-server.c |  168 +++++++++++++++++++++++++++++++++++----------------
>>  1 files changed, 116 insertions(+), 52 deletions(-)
>>
>> diff --git a/src/attrib-server.c b/src/attrib-server.c
>> index b767b72..e8dade8 100644
>> --- a/src/attrib-server.c
>> +++ b/src/attrib-server.c
>> @@ -71,12 +71,23 @@ struct group_elem {
>>        uint16_t len;
>>  };
>>
>> -static GIOChannel *l2cap_io = NULL;
>>  static GIOChannel *le_io = NULL;
> le_io is not being used anymore.
>
>>  static GSList *clients = NULL;
>>  static uint32_t gatt_sdp_handle = 0;
>>  static uint32_t gap_sdp_handle = 0;
>>
>> +struct gatt_adapter {
>> +       struct btd_adapter      *adapter;
>> +       GIOChannel              *l2cap_io;
>> +       GIOChannel              *le_io;
>> +       GSList                  *clients;
>> +       uint32_t                gatt_sdp_handle;
>> +       uint32_t                gap_sdp_handle;
>> +       GSList                  *database;
>
> I recommend to introduce new variable when the it is really being
> used. "database" and "clients" are used by free functions only, but
> new elements are not being added in the list by this patch.
>

These are a RFC patches, I put them in here so that everybody can see
at the first sight what I'm pretending to do. Anycase I agree with
you.

>> +};
>> +
>> +static GSList *adapters = NULL;
>> +
>>  /* GAP attribute handles */
>>  static uint16_t name_handle = 0x0000;
>>  static uint16_t appearance_handle = 0x0000;
>> @@ -94,6 +105,60 @@ static bt_uuid_t ccc_uuid = {
>>                        .value.u16 = GATT_CLIENT_CHARAC_CFG_UUID
>>  };
>>
>> +static void attrib_free(void *data)
>> +{
>> +       struct attribute *a = data;
>> +
>> +       g_free(a->data);
>> +       g_free(a);
>> +}
>> +
>> +static void channel_free(struct gatt_channel *channel)
>> +{
>> +       g_attrib_unref(channel->attrib);
>> +
>> +       g_free(channel);
>> +}
>> +
>> +static void free_gatt_adapter(struct gatt_adapter *gatt_adapter)
> the coding style is "free" at the end of the function name
>
>> +{
>> +       g_slist_free_full(gatt_adapter->database, attrib_free);
>> +
>> +       if (gatt_adapter->l2cap_io != NULL) {
>> +               g_io_channel_unref(gatt_adapter->l2cap_io);
>> +               g_io_channel_shutdown(gatt_adapter->l2cap_io, FALSE, NULL);
>> +       }
>> +
>> +       if (gatt_adapter->le_io != NULL) {
>> +               g_io_channel_unref(gatt_adapter->le_io);
>> +               g_io_channel_shutdown(gatt_adapter->le_io, FALSE, NULL);
>> +       }
>> +
>> +       g_slist_free_full(gatt_adapter->clients, (GDestroyNotify) channel_free);
>> +
>> +       if (gatt_adapter->gatt_sdp_handle > 0)
>> +               remove_record_from_server(gatt_adapter->gatt_sdp_handle);
>> +
>> +       if (gatt_adapter->gap_sdp_handle > 0)
>> +               remove_record_from_server(gatt_adapter->gap_sdp_handle);
>
> Removing gap_sdp_handle again
>
>> +
>> +       if (gatt_adapter->adapter != NULL)
>> +               btd_adapter_unref(gatt_adapter->adapter);
>> +
>> +       g_free(gatt_adapter);
>> +}
>> +
>> +static gint adapter_cmp(gconstpointer a, gconstpointer b)
>> +{
>> +       const struct gatt_adapter *gatt_adapter = a;
>> +       const struct btd_adapter *adapter = b;
>> +
>> +       if (gatt_adapter->adapter == adapter)
>> +               return 0;
>> +
>> +       return -1;
>> +}
>> +
>>  static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
>>  {
>>        sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
>> @@ -689,21 +754,6 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
>>        return enc_mtu_resp(old_mtu, pdu, len);
>>  }
>>
>> -static void attrib_free(void *data)
>> -{
>> -       struct attribute *a = data;
>> -
>> -       g_free(a->data);
>> -       g_free(a);
>> -}
>> -
>> -static void channel_free(struct gatt_channel *channel)
>> -{
>> -       g_attrib_unref(channel->attrib);
>> -
>> -       g_free(channel);
>> -}
>> -
>>  static void channel_disconnect(void *user_data)
>>  {
>>        struct gatt_channel *channel = user_data;
>> @@ -1012,74 +1062,88 @@ failed:
>>        return FALSE;
>>  }
>>
>> -int attrib_server_init(void)
>> +static int attrib_adapter_probe(struct btd_adapter *adapter)
>>  {
>> +       struct gatt_adapter *gatt_adapter;
>>        GError *gerr = NULL;
>> +       bdaddr_t addr;
>> +
>> +       DBG("Start GATT server in %s", adapter_get_path(adapter));
>> +
>> +       gatt_adapter = g_new0(struct gatt_adapter, 1);
>> +       gatt_adapter->adapter = btd_adapter_ref(adapter);
>> +
>> +       adapter_get_address(gatt_adapter->adapter, &addr);
>>
>>        /* BR/EDR socket */
>> -       l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
>> +       gatt_adapter->l2cap_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
>>                                        NULL, NULL, &gerr,
>> -                                       BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
>> +                                       BT_IO_OPT_SOURCE_BDADDR, &addr,
>>                                        BT_IO_OPT_PSM, ATT_PSM,
>>                                        BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>>                                        BT_IO_OPT_INVALID);
>> -       if (l2cap_io == NULL) {
>> +
>> +       if (gatt_adapter->l2cap_io == NULL) {
>>                error("%s", gerr->message);
>>                g_error_free(gerr);
>> +               free_gatt_adapter(gatt_adapter);
>>                return -1;
>>        }
>>
>> -       if (!register_core_services())
>> -               goto failed;
>> +       if (!register_core_services()) {
>> +               g_io_channel_unref(gatt_adapter->l2cap_io);
>> +               free_gatt_adapter(gatt_adapter);
>
> Two unref calls for l2cap_io here. free function also calls unref for l2cap_io
>
>> +               return -1;
>> +       }
>>
>>        /* LE socket */
>> -       le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
>> -                                       &le_io, NULL, &gerr,
>> -                                       BT_IO_OPT_SOURCE_BDADDR, BDADDR_ANY,
>> +       gatt_adapter->le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
>> +                                       &gatt_adapter->le_io, NULL, &gerr,
>> +                                       BT_IO_OPT_SOURCE_BDADDR, &addr,
>>                                        BT_IO_OPT_CID, ATT_CID,
>>                                        BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>>                                        BT_IO_OPT_INVALID);
>> -       if (le_io == NULL) {
>> +
>> +       if (gatt_adapter->le_io == NULL) {
>>                error("%s", gerr->message);
>>                g_error_free(gerr);
>>                /* Doesn't have LE support, continue */
>>        }
>>
>> +       adapters = g_slist_prepend(adapters, gatt_adapter);
>>        return 0;
>> -
>> -failed:
>> -       g_io_channel_unref(l2cap_io);
>> -       l2cap_io = NULL;
>> -
>> -       if (le_io) {
>> -               g_io_channel_unref(le_io);
>> -               le_io = NULL;
>> -       }
>> -
>> -       return -1;
>>  }
>>
>> -void attrib_server_exit(void)
>> +static void attrib_adapter_remove(struct btd_adapter *adapter)
>>  {
>> -       g_slist_free_full(database, attrib_free);
>> +       struct gatt_adapter *gatt_adapter;
>> +       GSList *l;
>>
>> -       if (l2cap_io) {
>> -               g_io_channel_unref(l2cap_io);
>> -               g_io_channel_shutdown(l2cap_io, FALSE, NULL);
>> -       }
>> +       l = g_slist_find_custom(adapters, adapter, adapter_cmp);
>> +       if (l == NULL)
>> +               return;
>>
>> -       if (le_io) {
>> -               g_io_channel_unref(le_io);
>> -               g_io_channel_shutdown(le_io, FALSE, NULL);
>> -       }
>> +       DBG("Stop GATT server in %s", adapter_get_path(adapter));
>>
>> -       g_slist_free_full(clients, (GDestroyNotify) channel_free);
>> +       gatt_adapter = l->data;
>> +       adapters = g_slist_remove(adapters, gatt_adapter);
>> +       free_gatt_adapter(gatt_adapter);
>> +}
>>
>> -       if (gatt_sdp_handle)
>> -               remove_record_from_server(gatt_sdp_handle);
>> +static struct btd_adapter_driver attrib_adapter_driver = {
>> +       .name   = "attrib-adapter-driver",
>> +       .probe  = attrib_adapter_probe,
>> +       .remove = attrib_adapter_remove,
>> +};
>
> Is there race condition here? Remember that plugins can also register
> an adapter driver.
> If a GATT "plugin" wants to register attributes during the probing the
> attribute server needs to be ready.
>

I know that, remember these are transactional patches towardas
multi-adapter support. They only prepare the environment to start
coding. The patch 11 fixes this issue. In fact, one could think that
it should in this place but when I started coding it I thought it was
easier to reutilize functions which were already implemented and
change it after multi-adapter started working.

Changing the order of patches or redo them is easy once I get an ack
to do that if the idea showed here is good. I'm just looking for
comments about the main idea behind them.

Thanks
