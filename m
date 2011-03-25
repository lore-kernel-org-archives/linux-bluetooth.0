Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110325163549.GA9894@jh-x301>
References: <1301059544-6200-1-git-send-email-johan.hedberg@gmail.com>
	<AANLkTinhC8-1fe0KYBb+Tz-x7RZSC3FtometdNw05xgX@mail.gmail.com>
	<20110325163549.GA9894@jh-x301>
Date: Fri, 25 Mar 2011 13:23:19 -0400
Message-ID: <AANLkTi=Yebkv+B=8WvaPkV1-Q+UifKX+UohN5p=977pq@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add local Extended Inquiry Response (EIR) support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Mar 25, 2011 at 12:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Fri, Mar 25, 2011, Anderson Lizardo wrote:
>> > +static u16 get_uuid16(u8 *uuid128)
>> > +{
>> > +       u8 *b = bluetooth_base_uuid;
>> > +       u32 val;
>> > +       int i;
>> > +
>> > +       for (i = 4; i < 16; i++) {
>> > +               if (b[i] != uuid128[i])
>> > +                       return 0;
>>
>> Don't you need to check bytes 0 and 1 as well, i.e. only bytes 2 and 3
>> are changed?
>
> The first four bytes can have any value for Bluetooth UUIDs. The purpose
> of this part of the function is to determine whether it's a Bluetooth
> UUID or not (i.e. derived from the Bluetooth base UUID), so the four
> first bytes don't matter.

At least for UUIDs used in attribute types I see this on the spec (page 1835):

"Or, to put it more simply, the 16-bit Attribute UUID replaces the x’s
in the follow-
ing:
0000xxxx-0000-1000-8000-00805F9B34FB"

I.e. , only third and fourth bytes being part of 16-bit UUID.

>> > +static int update_eir(struct hci_dev *hdev)
>> > +{
>> > +       struct hci_cp_write_eir cp;
>> > +
>> > +       if (!(hdev->features[6] & LMP_EXT_INQ))
>> > +               return 0;
>> > +
>> > +       if (hdev->ssp_mode == 0)
>> > +               return 0;
>> > +
>> > +       if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
>> > +               return 0;
>> > +
>> > +       memset(&cp, 0, sizeof(cp));
>> > +
>> > +       create_eir(hdev, cp.data);
>> > +
>> > +       if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
>> > +               return 0;
>>
>> What about making create_eir() return "int" and check for eir_len and
>> the end? That would avoid the memcmp() here.
>
> I'm not completely sure what you're proposing, but if it's to check for
> matching lengths of cp.data and hdev->eir before doing the memcmp then
> hdev would need a new eir_length member in addition to eir. Could be
> worth it, but it does slightly increase the complexity and since this is
> not a performance critical piece of code (won't be called too often) I'm
> not sure if it's worth it.

Actually I was proposing to get rid of the memcmp(), but now I see it
is necessary to not do HCI_OP_WRITE_EIR if EIR has not changed.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
