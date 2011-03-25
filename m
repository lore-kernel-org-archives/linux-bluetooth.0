Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301059544-6200-1-git-send-email-johan.hedberg@gmail.com>
References: <1301059544-6200-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 25 Mar 2011 11:36:18 -0400
Message-ID: <AANLkTinhC8-1fe0KYBb+Tz-x7RZSC3FtometdNw05xgX@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add local Extended Inquiry Response (EIR) support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 25, 2011 at 9:25 AM,  <johan.hedberg@gmail.com> wrote:
> +static u8 bluetooth_base_uuid[] = {
> +                       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +                       0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
> +};
> +
> +static u16 get_uuid16(u8 *uuid128)
> +{
> +       u8 *b = bluetooth_base_uuid;
> +       u32 val;
> +       int i;
> +
> +       for (i = 4; i < 16; i++) {
> +               if (b[i] != uuid128[i])
> +                       return 0;

Don't you need to check bytes 0 and 1 as well, i.e. only bytes 2 and 3
are changed?

> +       }
> +
> +       memcpy(&val, uuid128, 4);
> +
> +       val = be32_to_cpu(val);

I noticed just know the those UUID handling functions from management
API are assuming UUIDs in network order. We will need to change this,
or take extra care when reusing them for Advertising Data and GATT
uuids.

> +       if (val > 0xffff)
> +               return 0;
> +
> +       return (u16) val;
> +}
> +
> +static void create_eir(struct hci_dev *hdev, u8 *data)
> +{
> +       u8 *ptr = data;
> +       u16 eir_len = 0;
> +       u16 uuid16_list[HCI_MAX_EIR_LENGTH / sizeof(u16)];
> +       int i, truncated = 0;
> +       struct list_head *p;
> +       size_t name_len;
> +
> +       name_len = strlen(hdev->dev_name);
> +
> +       if (name_len > 0) {
> +               /* EIR Data type */
> +               if (name_len > 48) {
> +                       name_len = 48;
> +                       ptr[1] = EIR_NAME_SHORT;
> +               } else
> +                       ptr[1] = EIR_NAME_COMPLETE;
> +
> +               /* EIR Data length */
> +               ptr[0] = name_len + 1;
> +
> +               memcpy(ptr + 2, hdev->dev_name, name_len);
> +
> +               eir_len += (name_len + 2);
> +               ptr += (name_len + 2);
> +       }
> +
> +       memset(uuid16_list, 0, sizeof(uuid16_list));
> +
> +       /* Group all UUID16 types */
> +       list_for_each(p, &hdev->uuids) {
> +               struct bt_uuid *uuid = list_entry(p, struct bt_uuid, list);
> +               u16 uuid16;
> +
> +               uuid16 = get_uuid16(uuid->uuid);
> +               if (uuid16 == 0)
> +                       return;
> +
> +               if (uuid16 < 0x1100)
> +                       continue;
> +
> +               if (uuid16 == PNP_INFO_SVCLASS_ID)
> +                       continue;
> +
> +               /* Stop if not enough space to put next UUID */
> +               if (eir_len + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
> +                       truncated = 1;
> +                       break;
> +               }
> +
> +               /* Check for duplicates */
> +               for (i = 0; uuid16_list[i] != 0; i++)
> +                       if (uuid16_list[i] == uuid16)
> +                               break;
> +
> +               if (uuid16_list[i] == 0) {
> +                       uuid16_list[i] = uuid16;
> +                       eir_len += sizeof(u16);
> +               }
> +       }
> +
> +       if (uuid16_list[0] != 0) {
> +               u8 *length = ptr;
> +
> +               /* EIR Data type */
> +               ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
> +
> +               ptr += 2;
> +               eir_len += 2;

Here you increment eir_len but does not use it anymore. Maybe it would
be nice to add some assert (BUG_ON ?) on it just to check for
programming errors if someone tries to change this code later.

> +
> +               for (i = 0; uuid16_list[i] != 0; i++) {
> +                       *ptr++ = (uuid16_list[i] & 0x00ff);
> +                       *ptr++ = (uuid16_list[i] & 0xff00) >> 8;
> +               }
> +
> +               /* EIR Data length */
> +               *length = (i * sizeof(u16)) + 1;
> +       }
> +}
> +
> +static int update_eir(struct hci_dev *hdev)
> +{
> +       struct hci_cp_write_eir cp;
> +
> +       if (!(hdev->features[6] & LMP_EXT_INQ))
> +               return 0;
> +
> +       if (hdev->ssp_mode == 0)
> +               return 0;
> +
> +       if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
> +               return 0;
> +
> +       memset(&cp, 0, sizeof(cp));
> +
> +       create_eir(hdev, cp.data);
> +
> +       if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
> +               return 0;

What about making create_eir() return "int" and check for eir_len and
the end? That would avoid the memcmp() here.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
