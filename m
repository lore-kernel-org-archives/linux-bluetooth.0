Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120405102208.GC32212@x220>
References: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
	<1333570570-1288-4-git-send-email-andre.guedes@openbossa.org>
	<20120405102208.GC32212@x220>
Date: Thu, 5 Apr 2012 11:04:59 -0300
Message-ID: <CACJA=fXatQpOx72d3mSAeNt7iRRbzHK7Gs+sxagpnih0++GpjQ@mail.gmail.com>
Subject: Re: [RFC v2 3/5] Bluetooth: Add dst_type parameter to hci_connect
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Apr 5, 2012 at 7:22 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Wed, Apr 04, 2012, Andre Guedes wrote:
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 542fea2..9083a95 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -574,7 +574,7 @@ int hci_chan_del(struct hci_chan *chan);
>>  void hci_chan_list_flush(struct hci_conn *conn);
>>
>>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
>> -                                             __u8 sec_level, __u8 auth_type);
>> +                             __u8 dst_type, __u8 sec_level, __u8 auth_type);
>
> It seems like you're not using the "new" style of aligning with the
> opening parenthesis here.
>
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -1911,11 +1911,11 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>>               auth_type = HCI_AT_DEDICATED_BONDING_MITM;
>>
>>       if (cp->addr.type == BDADDR_BREDR)
>> -             conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr, sec_level,
>> -                                auth_type);
>> +             conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr,
>> +                                     cp->addr.type, sec_level, auth_type);
>>       else
>> -             conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr, sec_level,
>> -                                auth_type);
>> +             conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr,
>> +                                     cp->addr.type, sec_level, auth_type);
>
> Same issue with the above two cases.
>
>> --- a/net/bluetooth/sco.c
>> +++ b/net/bluetooth/sco.c
>> @@ -196,7 +196,8 @@ static int sco_connect(struct sock *sk)
>>       else
>>               type = SCO_LINK;
>>
>> -     hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
>> +     hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
>> +                             HCI_AT_NO_BONDING);
>
> And here as well.

I'll fix all aligning style issues from this series and send a new version.

Thanks,

Andre
