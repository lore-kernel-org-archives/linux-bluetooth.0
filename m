Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5B7F9F60.5090106@windriver.com>
References: <20180824053001.102917-1-mingli.yu@windriver.com>
 <5B7F979A.1060806@windriver.com> <5B7F9F60.5090106@windriver.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Aug 2018 10:42:58 +0300
Message-ID: <CABBYNZLMGcQ6_7REe-5nvptGAUW1XVn5YtJxzY+NiV6W_i9Khw@mail.gmail.com>
Subject: Re: [PATCH] unit/test-gatt: Fix hung issue
To: "Yu, Mingli" <mingli.yu@windriver.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 24, 2018 at 9:02 AM, Yu, Mingli <mingli.yu@windriver.com> wrote=
:
> Correct the commit author.
>
> Thanks,
>
>
> On 2018=E5=B9=B408=E6=9C=8824=E6=97=A5 13:28, Yu, Mingli wrote:
>>
>> Please ignore this.
>>
>> Thanks,
>>
>>
>> On 2018=E5=B9=B408=E6=9C=8824=E6=97=A5 13:30, mingli.yu@windriver.com wr=
ote:
>>>
>>> From: Brian Gix <brian.gix@intel.com>
>>>
>>> The below test hangs infinitely
>>> $ unit/test-gatt -p  /robustness/unkown-request -d
>>> /robustness/unkown-request - init
>>> /robustness/unkown-request - setup
>>> /robustness/unkown-request - setup complete
>>> /robustness/unkown-request - run
>>>    GATT: < 02 17 00                                         ...
>>>    bt_gatt_server:MTU exchange complete, with MTU: 23
>>>    GATT: > 03 00 02                                         ...
>>>    PDU: =3D 03 00 02                                         ...
>>>    GATT: < bf 00

/robustness/unkown-request - init
/robustness/unkown-request - setup
/robustness/unkown-request - setup complete
/robustness/unkown-request - run
  GATT: < 02 17 00                                         ...
  bt_gatt_server:MTU exchange complete, with MTU: 23
  GATT: > 03 00 02                                         ...
  PDU: =3D 03 00 02                                         ...
  GATT: < bf 00                                            ..
  GATT: > 01 bf 00 00 06                                   .....
  PDU: =3D 01 bf 00 00 06                                   .....
/robustness/unkown-request - test passed
/robustness/unkown-request - teardown
/robustness/unkown-request - teardown complete
/robustness/unkown-request - done


Test Summary
------------
/robustness/unkown-request                           Passed       0.001 sec=
onds

Total: 1, Passed: 1 (100.0%), Failed: 0,

>>> Actually, the /robustness/unkown-request test does
>>> no action.

Isn't that last PDU the actual error response, without that the
original intend of the test is lost.

>>> ---
>>>   unit/test-gatt.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
>>> index c7e28f865..b57373b07 100644
>>> --- a/unit/test-gatt.c
>>> +++ b/unit/test-gatt.c
>>> @@ -4463,7 +4463,7 @@ int main(int argc, char *argv[])
>>>               test_server, service_db_1, NULL,
>>>               raw_pdu(0x03, 0x00, 0x02),
>>>               raw_pdu(0xbf, 0x00),
>>> -            raw_pdu(0x01, 0xbf, 0x00, 0x00, 0x06));
>>> +            raw_pdu());
>>>
>>>       define_test_server("/robustness/unkown-command",
>>>               test_server, service_db_1, NULL,
>>>
>



--=20
Luiz Augusto von Dentz
