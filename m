Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2172179.Nvf6HcAWOB@athlon>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1412858714-2845-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<2172179.Nvf6HcAWOB@athlon>
Date: Tue, 14 Oct 2014 11:02:56 +0200
Message-ID: <CAMv5GbebN8pm2EKq7OzYxW=f+8YoTgzX+1MTcwUcZmWf7avAJw@mail.gmail.com>
Subject: Re: [PATCH 04/10] android/ipc-tester: Add missing service opcode
 boundries test cases
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 13 October 2014 22:32, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Grzegorz,
>
> On Thursday 09 October 2014 14:45:08 Grzegorz Kolodziejczyk wrote:
>> This patch adds tests sending out of range opcode for each service.
>> ---
>>  android/ipc-tester.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/android/ipc-tester.c b/android/ipc-tester.c
>> index ea71c8d..161777d 100644
>> --- a/android/ipc-tester.c
>> +++ b/android/ipc-tester.c
>> @@ -919,9 +919,23 @@ int main(int argc, char *argv[])
>>       test_opcode_valid("PAN", HAL_SERVICE_ID_PAN, 0x05, 0,
>>                       HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_PAN);
>>
>> +     test_opcode_valid("HANDSFREE", HAL_SERVICE_ID_HANDSFREE, 0x0f, 0,
>> +                                             HAL_SERVICE_ID_BLUETOOTH,
>> +                                             HAL_SERVICE_ID_HANDSFREE);
>> +
>>       test_opcode_valid("A2DP", HAL_SERVICE_ID_A2DP, 0x03, 0,
>>                       HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_A2DP);
>>
>> +     test_opcode_valid("HEALTH", HAL_SERVICE_ID_HEALTH, 0x06, 0,
>> +                                             HAL_SERVICE_ID_BLUETOOTH,
>> +                                             HAL_SERVICE_ID_HEALTH);
>> +
>> +     test_opcode_valid("AVRCP", HAL_SERVICE_ID_AVRCP, 0x0b, 0,
>> +                             HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_AVRCP);
>> +
>> +     test_opcode_valid("GATT", HAL_SERVICE_ID_GATT, 0x24, 0,
>> +                             HAL_SERVICE_ID_BLUETOOTH, HAL_SERVICE_ID_GATT);
>> +
>>       test_opcode_valid("HF_CLIENT", HAL_SERVICE_ID_HANDSFREE_CLIENT, 0x10, 0,
>>                       HAL_SERVICE_ID_BLUETOOTH,
>>                       HAL_SERVICE_ID_HANDSFREE_CLIENT);
>
> In future please don't send unrelated patches as part of serie. This makes
> review easier and also makes no unnecessary delays in getting such patches
> merged.
>
> Applied. Thanks.
>

Ok, sorry, I must forgot to move this patch to another set.

> --
> Szymon K. Janc
> szymon.janc@gmail.com


Best regards,
Grzegorz
