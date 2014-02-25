Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140225042337.GA27803@localhost.P-661HNU-F1>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
 <1393281061-14320-7-git-send-email-andre.guedes@openbossa.org> <20140225042337.GA27803@localhost.P-661HNU-F1>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Tue, 25 Feb 2014 14:16:52 -0300
Message-ID: <CACJA=fW-A8GbT55_W43Xk50bu5nzwkPjxDB7fuMBKf0h=mmD7Q@mail.gmail.com>
Subject: Re: [RFC v11 06/15] Bluetooth: Introduce LE auto connection infrastructure
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Feb 25, 2014 at 1:23 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Mon, Feb 24, 2014, Andre Guedes wrote:
>> +             if (hci_update_random_address(&req, false, &own_addr_type))
>> +                     return;
>
> Don't we want require_privacy = true here?

require_privacy = true enables non-resolvable address. Since this is a
passive scanning (no SCAN_REQ is sent), I don't think this is
required.

>> +     if (addr_type == ADDR_LE_DEV_PUBLIC)
>> +             bdaddr_type = BDADDR_LE_PUBLIC;
>> +     else
>> +             bdaddr_type = BDADDR_LE_RANDOM;
>> +
>> +     conn = hci_connect(hdev, LE_LINK, addr, bdaddr_type, BT_SECURITY_LOW,
>> +                        HCI_AT_NO_BONDING);
>
> All hci_connect is is a very short wrapper to hci_connect_acl/le. The
> hci_connect_le function in turn does the following:
>
>         /* Convert from L2CAP channel address type to HCI address type */
>         if (dst_type == BDADDR_LE_PUBLIC)
>                 dst_type = ADDR_LE_DEV_PUBLIC;
>         else
>                 dst_type = ADDR_LE_DEV_RANDOM;
>
> So it seems a bit silly to do this kind of back and forth conversions.
> Instead, I think the hci_connect API should take the address type that's
> used for struct hci_conn, i.e. the HCI one (not the L2CAP/mgmt one).
>
> Also, since pretty much all places that are calling hci_connect pass an
> explicit value as the link type I think the most sensible thing to do
> would be to completely remove this function and export hci_connect_le &
> hci_connect_acl from hci_conn.c.

I agree. I can do this refactoring in the next version.

BR,

Andre
