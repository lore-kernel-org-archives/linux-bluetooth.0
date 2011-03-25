Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 18:35:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add local Extended Inquiry Response (EIR)
 support
Message-ID: <20110325163549.GA9894@jh-x301>
References: <1301059544-6200-1-git-send-email-johan.hedberg@gmail.com>
 <AANLkTinhC8-1fe0KYBb+Tz-x7RZSC3FtometdNw05xgX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinhC8-1fe0KYBb+Tz-x7RZSC3FtometdNw05xgX@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Mar 25, 2011, Anderson Lizardo wrote:
> > +static u16 get_uuid16(u8 *uuid128)
> > +{
> > +       u8 *b = bluetooth_base_uuid;
> > +       u32 val;
> > +       int i;
> > +
> > +       for (i = 4; i < 16; i++) {
> > +               if (b[i] != uuid128[i])
> > +                       return 0;
> 
> Don't you need to check bytes 0 and 1 as well, i.e. only bytes 2 and 3
> are changed?

The first four bytes can have any value for Bluetooth UUIDs. The purpose
of this part of the function is to determine whether it's a Bluetooth
UUID or not (i.e. derived from the Bluetooth base UUID), so the four
first bytes don't matter.

> > +       }
> > +
> > +       memcpy(&val, uuid128, 4);
> > +
> > +       val = be32_to_cpu(val);
> 
> I noticed just know the those UUID handling functions from management
> API are assuming UUIDs in network order. We will need to change this,
> or take extra care when reusing them for Advertising Data and GATT
> uuids.

Right. This code is pretty much a copy of what user space already has
(hciops.c), and that code is relying on SDP (i.e. network) byte order
UUID-128s.

> > +       /* Group all UUID16 types */
> > +       list_for_each(p, &hdev->uuids) {
> > +               struct bt_uuid *uuid = list_entry(p, struct bt_uuid, list);
> > +               u16 uuid16;
> > +
> > +               uuid16 = get_uuid16(uuid->uuid);
> > +               if (uuid16 == 0)
> > +                       return;
> > +
> > +               if (uuid16 < 0x1100)
> > +                       continue;
> > +
> > +               if (uuid16 == PNP_INFO_SVCLASS_ID)
> > +                       continue;
> > +
> > +               /* Stop if not enough space to put next UUID */
> > +               if (eir_len + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
> > +                       truncated = 1;
> > +                       break;
> > +               }
> > +
> > +               /* Check for duplicates */
> > +               for (i = 0; uuid16_list[i] != 0; i++)
> > +                       if (uuid16_list[i] == uuid16)
> > +                               break;
> > +
> > +               if (uuid16_list[i] == 0) {
> > +                       uuid16_list[i] = uuid16;
> > +                       eir_len += sizeof(u16);
> > +               }
> > +       }
> > +
> > +       if (uuid16_list[0] != 0) {
> > +               u8 *length = ptr;
> > +
> > +               /* EIR Data type */
> > +               ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
> > +
> > +               ptr += 2;
> > +               eir_len += 2;
> 
> Here you increment eir_len but does not use it anymore. Maybe it would
> be nice to add some assert (BUG_ON ?) on it just to check for
> programming errors if someone tries to change this code later.

This is a straight copy from user space with UUID-128, TX power and
Device ID info support stripped away. Once those get added the eir_len
variable will be important later in the function.

> > +static int update_eir(struct hci_dev *hdev)
> > +{
> > +       struct hci_cp_write_eir cp;
> > +
> > +       if (!(hdev->features[6] & LMP_EXT_INQ))
> > +               return 0;
> > +
> > +       if (hdev->ssp_mode == 0)
> > +               return 0;
> > +
> > +       if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
> > +               return 0;
> > +
> > +       memset(&cp, 0, sizeof(cp));
> > +
> > +       create_eir(hdev, cp.data);
> > +
> > +       if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
> > +               return 0;
> 
> What about making create_eir() return "int" and check for eir_len and
> the end? That would avoid the memcmp() here.

I'm not completely sure what you're proposing, but if it's to check for
matching lengths of cp.data and hdev->eir before doing the memcmp then
hdev would need a new eir_length member in addition to eir. Could be
worth it, but it does slightly increase the complexity and since this is
not a performance critical piece of code (won't be called too often) I'm
not sure if it's worth it.

Johan
