Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2235722.RxNYXpmJdV@ix>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180119164133.16767-8-grzegorz.kolodziejczyk@codecoup.pl> <2235722.RxNYXpmJdV@ix>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Tue, 23 Jan 2018 16:09:27 +0100
Message-ID: <CALevQMY_o0mb=j3f74ppqfP7CRwC+_5FNFegcax2aLBQ0caApg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 8/8] tools/btpclient: Add passkey confirm ev and
 passkey confirm rsp cmd
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,


2018-01-23 15:03 GMT+01:00 Szymon Janc <szymon.janc@codecoup.pl>:
> Hi Grzegorz,
>
> On Friday, 19 January 2018 17:41:33 CET Grzegorz Kolodziejczyk wrote:
>> This patch adds passkey confirm command handler and passkey confirm
>> event.
>> ---
>>  tools/btpclient.c | 94
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, =
94
>> insertions(+)
>>
>> diff --git a/tools/btpclient.c b/tools/btpclient.c
>> index 55e5170a7..780c2a8db 100644
>> --- a/tools/btpclient.c
>> +++ b/tools/btpclient.c
>> @@ -1703,11 +1703,43 @@ static struct l_dbus_message
>> *ag_request_confirmation_call(struct l_dbus *dbus, struct l_dbus_message
>> *message,
>>                                               void *user_data)
>>  {
>> +     struct btp_gap_passkey_confirm_ev ev;
>> +     struct btp_device *device;
>> +     struct btp_adapter *adapter;
>>       struct l_dbus_message *reply;
>> +     const char *path, *str_addr, *str_addr_type;
>> +     uint32_t passkey;
>>
>>       reply =3D l_dbus_message_new_method_return(message);
>>       l_dbus_message_set_arguments(reply, "");
>>
>> +     l_dbus_message_get_arguments(message, "ou", &path, &passkey);
>> +
>> +     device =3D find_device_by_path(path);
>> +
>> +     if (!l_dbus_proxy_get_property(device->proxy, "Address", "s", &str=
_addr)
>> +             || !l_dbus_proxy_get_property(device->proxy, "AddressType"=
, "s",
>> +             &str_addr_type)) {
>> +             l_info("Cannot get device properties");
>> +
>> +             return reply;
>> +     }
>> +
>> +     ev.passkey =3D L_CPU_TO_LE32(passkey);
>> +     ev.address_type =3D strcmp(str_addr_type, "public") ?
>> +                                                     BTP_GAP_ADDR_RANDO=
M :
>> +                                                     BTP_GAP_ADDR_PUBLI=
C;
>> +     if (str2ba(str_addr, &ev.address) < 0) {
>> +             l_info("Incorrect device address");
>> +
>> +             return reply;
>> +     }
>> +
>> +     adapter =3D find_adapter_by_device(device);
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_PASSKEY_CONFIRM,
>> +                                     adapter->index, sizeof(ev), &ev);
>> +
>>       return reply;
>
> So ag.pending request should be stored here. And reply here should be ret=
urned
> only in case of error.
Will fix it
>
>>  }
>>
>> @@ -2082,6 +2114,65 @@ failed:
>>       btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>>  }
>>
>> +static void passkey_confirm_rsp_reply(struct l_dbus_message *result,
>> +                                                             void *user=
_data)
>> +{
>> +     struct btp_adapter *adapter =3D user_data;
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name, *desc;
>> +
>> +             l_dbus_message_get_error(result, &name, &desc);
>> +             l_error("Failed to confirm passkey (%s), %s", name, desc);
>> +
>> +             btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     l_dbus_message_unref(ag.pending_req);
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
>> +                                             adapter->index, 0, NULL);
>> +}
>> +
>> +static void btp_gap_confirm_entry_rsp(uint8_t index, const void *param,
>> +                                     uint16_t length, void *user_data)
>> +{
>> +     const struct btp_gap_passkey_confirm_rsp_cp *cp =3D param;
>> +     struct btp_adapter *adapter =3D find_adapter_by_index(index);
>> +     struct l_dbus_message *reply;
>> +     uint8_t status =3D BTP_ERROR_FAIL;
>> +     bool prop;
>> +
>> +     if (!adapter) {
>> +             status =3D BTP_ERROR_INVALID_INDEX;
>> +             goto failed;
>> +     }
>> +
>> +     /* Adapter needs to be powered to be able to confirm passkey */
>> +     if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &pr=
op) ||
>> +                                             !prop || !ag.pending_req)
>> +             goto failed;
>> +
>> +     if (cp->match) {
>> +             reply =3D l_dbus_message_new_method_return(ag.pending_req)=
;
>> +             l_dbus_message_set_arguments(reply, "");
>> +     } else {
>> +             reply =3D l_dbus_message_new_error(ag.pending_req,
>> +                                             "org.bluez.Error.Rejected"=
,
>> +                                             "Passkey missmatch");
>> +     }
>> +
>> +     l_dbus_send_with_reply(dbus, ag.pending_req, passkey_confirm_rsp_r=
eply,
>> +                                                             adapter, N=
ULL);
>> +
>> +     return;
>> +
>> +failed:
>> +     btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>> +}
>> +
>>  static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
>>  {
>>       struct btp_device_found_ev ev;
>> @@ -2215,6 +2306,9 @@ static void register_gap_service(void)
>>
>>       btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_ENTRY_RSP,
>>                                       btp_gap_passkey_entry_rsp, NULL, N=
ULL);
>> +
>> +     btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
>> +                                     btp_gap_confirm_entry_rsp, NULL, N=
ULL);
>>  }
>>
>>  static void btp_core_read_commands(uint8_t index, const void *param,
>
>
> --
> pozdrawiam
> Szymon Janc
>
>

pozdrawiam,
Grzegorz Ko=C5=82odziejczyk
