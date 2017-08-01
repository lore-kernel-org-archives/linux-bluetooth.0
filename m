Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLhS+-ugFxXKZ6mmk2BvCHmLG8sxWhfdnW1U05OMqqNHA@mail.gmail.com>
References: <CALvjcs8cbrO1sE_bgKXsLZ6C5omO=Y_duXjkRC1Rww-z156v9w@mail.gmail.com>
 <CABBYNZLhS+-ugFxXKZ6mmk2BvCHmLG8sxWhfdnW1U05OMqqNHA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Aug 2017 13:48:15 +0300
Message-ID: <CABBYNZL98uajaq0+GHyKWBsp_aZPNxQkG0YCimzu0510vVR=cw@mail.gmail.com>
Subject: Re: how to add local name in scan response when setting
 MGMT_ADV_FLAG_LOCAL_NAME in Bluez
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Tue, Aug 1, 2017 at 1:21 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Yunhan,
>
> On Tue, Aug 1, 2017 at 10:37 AM, Yunhan Wang <yunhanw@google.com> wrote:
>> Hi
>>
>> I am trying to do some small experiments that add local name in the
>> scan response,  should I use data[0] to store both adv_data and
>> scan_rsp?
>>
>> I tried to add local name(=E2=80=99TEST=E2=80=99) in data[0] under
>> mgmt_cp_add_advertising on
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/advertising.=
c#n484,
>> it seems it does not work, any idea?
>
> Seems to be a limitation in the kernel, also setting the adapter name
> doesn't change anything either so it seems it simply does not include
> any scan response. I guess we would have to add support for that.

Actually the kernel does seem to set the scan response data, but is empty:

< HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32
#8499 13:40:40.663565
        Length: 0
> HCI Event: Command Complete (0x0e) plen 4                         #8500 1=
3:40:40.664554
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)

>> Thanks
>> Best wishes
>> Yunhan
>>
>> static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
>> {
>> struct mgmt_cp_add_advertising *cp;
>> uint8_t param_len;
>> uint8_t *adv_data;
>> size_t adv_data_len;
>> uint32_t flags =3D 0;
>>
>> uint8_t scan_rsp[] =3D {
>> =E2=80=99T=E2=80=99,
>> =E2=80=99E=E2=80=99,
>> =E2=80=99S=E2=80=99,
>> =E2=80=99T=E2=80=99
>> };
>> size_t scan_rsp_len =3D sizeof(scan_rsp);
>>
>> DBG("Refreshing advertisement: %s", client->path);
>>
>> if (client->type =3D=3D AD_TYPE_PERIPHERAL)
>> flags =3D MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV |
>> MGMT_ADV_FLAG_LOCAL_NAME;
>>
>> if (client->include_tx_power)
>> flags |=3D MGMT_ADV_FLAG_TX_POWER;
>>
>> adv_data =3D bt_ad_generate(client->data, &adv_data_len);
>>
>> if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
>> error("Advertising data too long or couldn't be generated.");
>>
>> return g_dbus_create_error(client->reg, ERROR_INTERFACE
>> ".InvalidLength",
>> "Advertising data too long.");
>> }
>>
>> param_len =3D sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
>> scan_rsp_len;
>>
>> cp =3D malloc0(param_len);
>>
>> if (!cp) {
>> error("Couldn't allocate for MGMT!");
>>
>> free(adv_data);
>>
>> return btd_error_failed(client->reg, "Failed");
>> }
>>
>> cp->flags =3D htobl(flags);
>> cp->instance =3D client->instance;
>> cp->adv_data_len =3D adv_data_len;
>> cp->scan_rsp_len =3D scan_rsp_len;
>> memcpy(cp->data, adv_data, adv_data_len);
>> memcpy(cp->data + adv_data_len, scan_rsp_data, scan_rsp_len);
>> free(adv_data);
>>
>> if (!mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
>> client->manager->mgmt_index, param_len, cp,
>> add_adv_callback, client, NULL)) {
>> DBG("Failed to add Advertising Data");
>>
>> free(cp);
>>
>> return btd_error_failed(client->reg, "Failed");
>> }
>>
>> free(cp);
>>
>> return NULL;
>> }
>>
>> Reference:
>> In lib/mgmt.h,
>>
>> #define MGMT_OP_ADD_ADVERTISING 0x003E
>> struct mgmt_cp_add_advertising {
>> uint8_t  instance;
>> uint32_t flags;
>> uint16_t duration;
>> uint16_t timeout;
>> uint8_t  adv_data_len;
>> uint8_t  scan_rsp_len;
>> uint8_t  data[0];
>> } __packed;
>> From mgmt-api.txt, I am
>>
>> Add Advertising Command
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Command Code: 0x003e
>> Controller Index: <controller id>
>> Command Parameters: Instance (1 Octet)
>> Flags (4 Octets)
>> Duration (2 Octets)
>> Timeout (2 Octets)
>> Adv_Data_Len (1 Octet)
>> Scan_Rsp_len (1 Octet)
>> Adv_Data (0-255 Octets)
>> Scan_Rsp (0-255 Octets)
>> =E2=80=A6...
>> With the Flags value the type of advertising is controlled and
>> the following flags are defined:
>>
>> 0 Switch into Connectable mode
>> 1 Advertise as Discoverable
>> 2 Advertise as Limited Discoverable
>> 3 Add Flags field to Adv_Data
>> 4 Add TX Power field to Adv_Data
>> 5 Add Appearance field to Scan_Rsp
>> 6 Add Local Name in Scan_Rsp
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
