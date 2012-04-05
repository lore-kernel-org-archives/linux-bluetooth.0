Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120405102208.GC32212@x220>
References: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
	<1333570570-1288-4-git-send-email-andre.guedes@openbossa.org>
	<20120405102208.GC32212@x220>
Date: Thu, 5 Apr 2012 07:17:30 -0400
Message-ID: <CAJdJm_O0Qf07kfXP9ReyDtasL6d3fnRiCCnbpvwoYUWE+me2LA@mail.gmail.com>
Subject: Re: [RFC v2 3/5] Bluetooth: Add dst_type parameter to hci_connect
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Apr 5, 2012 at 6:22 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
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

About this alignment, should it be done with spaces when necessary
(i.e. when using just tabs does not align)?

I think I have missed discussions about this (maybe because I don't
follow LKML closely).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
