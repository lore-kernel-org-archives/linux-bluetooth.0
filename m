Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTik_xC9M+MneZnnozXdwYYJ+keSVoxmCreg9TkQz@mail.gmail.com>
References: <1294046076-3712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1294046076-3712-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<AANLkTik_xC9M+MneZnnozXdwYYJ+keSVoxmCreg9TkQz@mail.gmail.com>
Date: Tue, 11 Jan 2011 10:40:00 +0200
Message-ID: <AANLkTindoD8_WMdg_2QHNkMF-1vbv9pm9y-09D4WR1tm@mail.gmail.com>
Subject: Re: [PATCHv4] Bluetooth: Use non-flushable by default L2CAP data packets
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Mon, Jan 10, 2011 at 6:38 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Andrei,
>
> On Mon, Jan 3, 2011 at 5:14 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index c791fcd..ff191b9 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -362,13 +362,19 @@ static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
>>  static inline void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
>>  {
>>        struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
>> +       u8 flags;
>>
>>        BT_DBG("code 0x%2.2x", code);
>>
>>        if (!skb)
>>                return;
>>
>> -       hci_send_acl(conn->hcon, skb, 0);
>> +       if (lmp_no_flush_capable(conn->hcon->hdev))
>> +               flags = ACL_START_NO_FLUSH;
>> +       else
>> +               flags = ACL_START;
>> +
>> +       hci_send_acl(conn->hcon, skb, flags);
>>  }
>
> Looks like you can't control the "no flush" flag here using the new
> BT_FLUSHABLE setsockopt() option.

The flag is used when sending data packets, when sending l2cap commands we
set ACL_START_NO_FLUSH when host supports it.

Regards,
Andrei

>> @@ -414,7 +421,12 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
>>                put_unaligned_le16(fcs, skb_put(skb, 2));
>>        }
>>
>> -       hci_send_acl(pi->conn->hcon, skb, 0);
>> +       if (lmp_no_flush_capable(conn->hcon->hdev))
>> +               flags = ACL_START_NO_FLUSH;
>> +       else
>> +               flags = ACL_START;
>> +
>> +       hci_send_acl(pi->conn->hcon, skb, flags);
>>  }
>
> Same here.
>
> Regards,
> --
> Anderson Lizardo
> OpenBossa Labs - INdT
> Manaus - Brazil
>
