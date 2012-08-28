Return-Path: <cyrus@holtmann.org>
Message-ID: <503C92D3.5050408@tieto.com>
Date: Tue, 28 Aug 2012 11:43:47 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Fix enabling LE while powered off
References: <1346078850-32704-1-git-send-email-andrzej.kaczmarek@tieto.com> <1346078850-32704-2-git-send-email-andrzej.kaczmarek@tieto.com> <20120828074008.GA4602@aemeltch-MOBL1>
In-Reply-To: <20120828074008.GA4602@aemeltch-MOBL1>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 08/28/2012 09:40 AM, Andrei Emeltchenko wrote:
> Hi Andrzej,
>
> On Mon, Aug 27, 2012 at 04:47:30PM +0200, Andrzej Kaczmarek wrote:
>> Set LE called when hdev is up but still has HCI_AUTO_OFF flag set will
>> only change dev_flags and enable feature in host but won't enable feature
>> in controller. As a resulit it's not possible to e.g. start LE only or
>> interleaved discovery due to missing LE Supported flag in local features.
>>
>> This patch ensures HCI Write LE Host Supported is sent when Set Powered is
>> called to clear HCI_AUTO_OFF flag.
>>
>> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
>> ---
>>   net/bluetooth/mgmt.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index ccc6716..f73441f 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2897,6 +2897,17 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
>>   			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
>>   		}
>>
>> +		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
>> +			struct hci_cp_write_le_host_supported cp;
>> +
>> +			memset(&cp, 0, sizeof(cp));
>
> Why memset is needed here?

Not really needed, I forgot to remove it after copy&paste from other 
code. I'll send v2 later with memset removed.

BR,
Andrzej

