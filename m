Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] unit/test-gatt: Fix hung issue
To: <linux-bluetooth@vger.kernel.org>
References: <20180824053001.102917-1-mingli.yu@windriver.com>
 <5B7F979A.1060806@windriver.com>
From: "Yu, Mingli" <mingli.yu@windriver.com>
Message-ID: <5B7F9F60.5090106@windriver.com>
Date: Fri, 24 Aug 2018 14:02:08 +0800
MIME-Version: 1.0
In-Reply-To: <5B7F979A.1060806@windriver.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Correct the commit author.

Thanks,

On 2018年08月24日 13:28, Yu, Mingli wrote:
> Please ignore this.
>
> Thanks,
>
>
> On 2018年08月24日 13:30, mingli.yu@windriver.com wrote:
>> From: Brian Gix <brian.gix@intel.com>
>>
>> The below test hangs infinitely
>> $ unit/test-gatt -p  /robustness/unkown-request -d
>> /robustness/unkown-request - init
>> /robustness/unkown-request - setup
>> /robustness/unkown-request - setup complete
>> /robustness/unkown-request - run
>>    GATT: < 02 17 00                                         ...
>>    bt_gatt_server:MTU exchange complete, with MTU: 23
>>    GATT: > 03 00 02                                         ...
>>    PDU: = 03 00 02                                         ...
>>    GATT: < bf 00
>>
>> Actually, the /robustness/unkown-request test does
>> no action.
>> ---
>>   unit/test-gatt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
>> index c7e28f865..b57373b07 100644
>> --- a/unit/test-gatt.c
>> +++ b/unit/test-gatt.c
>> @@ -4463,7 +4463,7 @@ int main(int argc, char *argv[])
>>               test_server, service_db_1, NULL,
>>               raw_pdu(0x03, 0x00, 0x02),
>>               raw_pdu(0xbf, 0x00),
>> -            raw_pdu(0x01, 0xbf, 0x00, 0x00, 0x06));
>> +            raw_pdu());
>>
>>       define_test_server("/robustness/unkown-command",
>>               test_server, service_db_1, NULL,
>>
