Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130417083005.GE6637@x220>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
	<1365117675-2202-6-git-send-email-andre.guedes@openbossa.org>
	<20130417083005.GE6637@x220>
Date: Wed, 17 Apr 2013 19:17:52 -0300
Message-ID: <CACJA=fV5LM7BMD25OL==7rkQ=ConQMJYfK8_Zk39tYw4vPp2FQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] Bluetooth: Make inquiry_cache_flush non-static
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 17, 2013 at 5:30 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Thu, Apr 04, 2013, Andre Guedes wrote:
>> In order to use HCI request framework in start_discovery, we'll need
>> to call inquiry_cache_flush in mgmt.c. Therefore, this patch makes
>> inquiry_cache_flush non-static
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  include/net/bluetooth/hci_core.h | 1 +
>>  net/bluetooth/hci_core.c         | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 0e7ee89..4713514 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -431,6 +431,7 @@ void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
>>                                     struct inquiry_entry *ie);
>>  bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
>>                             bool name_known, bool *ssp);
>> +void inquiry_cache_flush(struct hci_dev *hdev);
>>
>>  /* ----- HCI Connections ----- */
>>  enum {
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 43ea7e3..eecab8e 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -630,7 +630,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
>>       hdev->discovery.state = state;
>>  }
>>
>> -static void inquiry_cache_flush(struct hci_dev *hdev)
>> +void inquiry_cache_flush(struct hci_dev *hdev)
>>  {
>>       struct discovery_state *cache = &hdev->discovery;
>>       struct inquiry_entry *p, *n;
>
> Making this public means that you also have to prefix it with hci_.

Sure, I'll fix this.

Thanks,

Andre
