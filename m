Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110713202610.GE23921@joana>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
	<1310418719-12296-10-git-send-email-andre.guedes@openbossa.org>
	<20110713202610.GE23921@joana>
Date: Thu, 14 Jul 2011 11:31:23 -0300
Message-ID: <CACJA=fV5Sa7m7n=gXJkdhhMuKupqJAKDTb2g1639hddwtWNDYQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] Bluetooth: Prepare for full support discovery procedures
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jul 13, 2011 at 5:26 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>> @@ -202,6 +202,7 @@ enum {
>>
>>  #define LMP_EV4              0x01
>>  #define LMP_EV5              0x02
>> +#define LMP_NO_BREDR 0x20
>>  #define LMP_LE               0x40
>>
>>  #define LMP_SNIFF_SUBR       0x02
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 1ff59f2..fc75c61 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -597,6 +597,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>>  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>>  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
>>  #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
>> +#define lmp_no_bredr_capable(dev)  ((dev)->features[4] & LMP_NO_BREDR)
>
> It's more logic call this lmp_bredr_capable() regardless what the bit really
> means.

I agree. I was concerned about having a *_capable macro with different
meaning from the LMP bit. Since you agree too, I'll change this. Thanks.

Andre
