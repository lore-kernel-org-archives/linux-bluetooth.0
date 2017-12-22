Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1718429.lz8PR2LJZV@ix>
References: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20171221164720.20925-5-grzegorz.kolodziejczyk@codecoup.pl> <1718429.lz8PR2LJZV@ix>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Fri, 22 Dec 2017 14:53:19 +0100
Message-ID: <CALevQMZkF7_YkJvxpv7NBCLjjkUCQTPSVP9Nf7Wr2SmrEhp24w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/6] tools/btpclient: Add start, stop discovery commands
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2017-12-22 11:48 GMT+01:00 Szymon Janc <szymon.janc@codecoup.pl>:
> On Thursday, 21 December 2017 17:47:19 CET Grzegorz Kolodziejczyk wrote:
>> This patch adds start and stop discovery command for btp client.
>> ---
>>  tools/btpclient.c | 220
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 2=
20
>> insertions(+)
>>
>> diff --git a/tools/btpclient.c b/tools/btpclient.c
>> index c0ad03b68..f4b930a51 100644
>> --- a/tools/btpclient.c
>> +++ b/tools/btpclient.c
>> @@ -122,6 +122,8 @@ static void btp_gap_read_commands(uint8_t index, con=
st
>> void *param, commands |=3D (1 << BTP_OP_GAP_SET_POWERED);
>>       commands |=3D (1 << BTP_OP_GAP_SET_DISCOVERABLE);
>>       commands |=3D (1 << BTP_OP_GAP_SET_BONDABLE);
>> +     commands |=3D (1 << BTP_OP_GAP_START_DISCOVERY);
>> +     commands |=3D (1 << BTP_OP_GAP_STOP_DISCOVERY);
>>
>>       commands =3D L_CPU_TO_LE16(commands);
>>
>> @@ -399,6 +401,218 @@ failed:
>>       btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>>  }
>>
>> +static void start_discovery_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_proxy(proxy);
>> +
>> +     if (!adapter) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROL=
LER,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name, *desc;
>> +
>> +             l_dbus_message_get_error(result, &name, &desc);
>> +             l_error("Failed to start discovery (%s), %s", name, desc);
>> +
>> +             btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_DISCOVERY,
>> +                                             adapter->index, 0, NULL);
>> +}
>> +
>> +static void set_start_discovery_filter_setup(struct l_dbus_message
>> *message, +                                                   void *user=
_data)
>> +{
>> +     uint8_t flags =3D L_PTR_TO_UINT(user_data);
>> +     struct l_dbus_message_builder *builder;
>
> Add basic sanity check here for flags ie at least one of LE or BR should =
be
> set.
Ok
>
>> +
>> +     builder =3D l_dbus_message_builder_new(message);
>> +
>> +     l_dbus_message_builder_enter_array(builder, "{sv}");
>> +     l_dbus_message_builder_enter_dict(builder, "sv");
>> +
>> +     /* Be in observer mode or in general mode (default in Bluez) */
>> +     if (flags & BTP_GAP_DISCOVERY_FLAG_OBSERVATION) {
>> +             l_dbus_message_builder_append_basic(builder, 's', "Transpo=
rt");
>> +             l_dbus_message_builder_enter_variant(builder, "s");
>> +
>> +             if (flags & (BTP_GAP_DISCOVERY_FLAG_LE |
>> +                                             BTP_GAP_DISCOVERY_FLAG_BRE=
DR))
>> +                     l_dbus_message_builder_append_basic(builder, 's',
>> +                                                                     "a=
uto");
>> +             else if (flags & BTP_GAP_DISCOVERY_FLAG_LE)
>> +                     l_dbus_message_builder_append_basic(builder, 's', =
"le");
>> +             else if (flags & BTP_GAP_DISCOVERY_FLAG_BREDR)
>> +                     l_dbus_message_builder_append_basic(builder, 's',
>> +                                                             "bredr");
>> +
>> +             l_dbus_message_builder_leave_variant(builder);
>> +     }
>> +
>> +     l_dbus_message_builder_leave_dict(builder);
>> +     l_dbus_message_builder_leave_array(builder);
>> +
>> +     /* TODO add passive, limited discovery */
>> +     l_dbus_message_builder_finalize(builder);
>> +     l_dbus_message_builder_destroy(builder);
>> +}
>> +
>> +static void set_start_discovery_filter_reply(struct l_dbus_proxy *proxy=
,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_proxy(proxy);
>> +
>> +     if (!adapter) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROL=
LER,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name, *desc;
>> +
>> +             l_dbus_message_get_error(result, &name, &desc);
>> +             l_error("Failed to set discovery filter (%s), %s", name, d=
esc);
>> +
>> +             btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     l_dbus_proxy_method_call(adapter->proxy, "StartDiscovery", NULL,
>> +                                     start_discovery_reply, NULL, NULL)=
;
>> +}
>> +
>> +static void btp_gap_start_discovery(uint8_t index, const void *param,
>> +                                     uint16_t length, void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_index(index);
>> +     const struct btp_gap_start_discovery_cp *cp =3D param;
>> +     bool prop;
>> +
>> +     if (!adapter) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, index,
>> +                                             BTP_ERROR_INVALID_INDEX);
>> +             return;
>> +     }
>> +
>> +     /* Adapter needs to be powered to start discovery */
>> +     if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &pr=
op) ||
>> +                                                                     !p=
rop) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, index, BTP_ERROR_FAIL=
);
>> +             return;
>> +     }
>> +
>> +     l_dbus_proxy_method_call(adapter->proxy, "SetDiscoveryFilter",
>> +                                     set_start_discovery_filter_setup,
>> +                                     set_start_discovery_filter_reply,
>
> nitpick: Name it set_discovery_filer_setup/reply.
Ok, I'll correct it
>
>> +                                     L_UINT_TO_PTR(cp->flags), NULL);
>> +}
>> +
>> +static void set_stop_discovery_filter_setup(struct l_dbus_message *mess=
age,
>> +                                                     void *user_data)
>> +{
>> +     struct l_dbus_message_builder *builder;
>> +
>> +     builder =3D l_dbus_message_builder_new(message);
>> +
>> +     /* Clear discovery filter setup */
>> +     l_dbus_message_builder_enter_array(builder, "{sv}");
>> +     l_dbus_message_builder_enter_dict(builder, "sv");
>> +     l_dbus_message_builder_leave_dict(builder);
>> +     l_dbus_message_builder_leave_array(builder);
>> +     l_dbus_message_builder_finalize(builder);
>> +     l_dbus_message_builder_destroy(builder);
>> +}
>> +
>> +static void set_stop_discovery_filter_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_proxy(proxy);
>> +
>> +     if (!adapter) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROL=
LER,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name, *desc;
>> +
>> +             l_dbus_message_get_error(result, &name, &desc);
>> +             l_error("Failed to set discovery filter (%s), %s", name, d=
esc);
>> +
>> +             btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_DISCOVERY,
>> +                                             adapter->index, 0, NULL);
>> +}
>> +
>> +static void stop_discovery_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_proxy(proxy);
>> +
>> +     if (!adapter) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROL=
LER,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name;
>> +
>> +             l_dbus_message_get_error(result, &name, NULL);
>> +             l_error("Failed to stop discovery (%s)", name);
>> +
>> +             btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     l_dbus_proxy_method_call(adapter->proxy, "SetDiscoveryFilter",
>> +                                             set_stop_discovery_filter_=
setup,
>> +                                             set_stop_discovery_filter_=
reply,
>
> Name those clear_discovery_filter_setup/reply.
Ok, I'll correct it
>
>> +                                             NULL, NULL);
>> +}
>> +
>> +static void btp_gap_stop_discovery(uint8_t index, const void *param,
>> +                                     uint16_t length, void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_index(index);
>> +     bool prop;
>> +
>> +     if (!adapter) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, index,
>> +                                             BTP_ERROR_INVALID_INDEX);
>> +             return;
>> +     }
>> +
>> +     /* Adapter needs to be powered to be able to remove devices */
>> +     if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &pr=
op) ||
>> +                                                                     !p=
rop) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, index, BTP_ERROR_FAIL=
);
>> +             return;
>> +     }
>> +
>> +     l_dbus_proxy_method_call(adapter->proxy, "StopDiscovery", NULL,
>> +                                     stop_discovery_reply, NULL, NULL);
>> +}
>> +
>>  static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
>>  {
>>       struct btp_device_found_ev ev;
>> @@ -453,6 +667,12 @@ static void register_gap_service(void)
>>
>>       btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_BONDABLE,
>>                                       btp_gap_set_bondable, NULL, NULL);
>> +
>> +     btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_DISCOVERY,
>> +                                     btp_gap_start_discovery, NULL, NUL=
L);
>> +
>> +     btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_DISCOVERY,
>> +                                     btp_gap_stop_discovery, NULL, NULL=
);
>>  }
>>
>>  static void btp_core_read_commands(uint8_t index, const void *param,
>
>
> --
> pozdrawiam
> Szymon Janc

pozdrawiam,
Grzegorz Ko=C5=82odziejczyk
