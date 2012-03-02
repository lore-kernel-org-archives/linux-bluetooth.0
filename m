Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120301223226.GA7133@x220.amr.corp.intel.com>
References: <1330636797-16171-1-git-send-email-andre.guedes@openbossa.org>
	<20120301223226.GA7133@x220.amr.corp.intel.com>
Date: Fri, 2 Mar 2012 10:48:06 -0300
Message-ID: <CACJA=fVFmGJFnkA1erCS+56DR+WSo1h2vBSNhpqnth3=pgmVRQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Don't force DISCOVERY_STOPPED state in inquiry_cache_flush
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Mar 1, 2012 at 7:32 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Thu, Mar 01, 2012, Andre Guedes wrote:
>> We are not supposed to force DISCOVERY_STOPPED in inquiry_cache_flush
>> because we may break the discovery state machine. For instance,
>> during interleaved discovery, when we are about to start inquiry,
>> the state machine forcibly goes to DISCOVERY_STOPPED while it
>> should stay in DISCOVERY_FINDING state.
>>
>> This problem results in unexpected behaviors such as sending two
>> mgmt_discovering events to userspace (when only one event is
>> expected) and Stop Discovery failures.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  net/bluetooth/hci_core.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index d3ddc0b..661d65f 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -413,7 +413,6 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
>>
>>       INIT_LIST_HEAD(&cache->unknown);
>>       INIT_LIST_HEAD(&cache->resolve);
>> -     cache->state = DISCOVERY_STOPPED;
>>  }
>
> Nack.
>
> The reason why this was there is hci_dev_do_close() and hci_dev_reset()
> which call inquiry_cache_flush(). If the discovery state is not set
> correctly through these code paths you might get into a situation where
> you can't start discovery again after doing "hciconfig hci0 reset" or
> "hciconfig hci0 down" while discovery was active. So I agree that some
> fix is needed but you need to ensure that you don't break these use
> cases.

This issue is already address by upstream patch "Bluetooth: Set
DISCOVERY_STOPPED if controller resets". So, the discovery state machine
will be right even if we run "hciconfig hci0 reset" or "hciconfig hci0
down" while discovery is active.

BR,

Andre
