Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <542A9706.6000504@tieto.com>
References: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1411713077-19757-2-git-send-email-jakub.tyszkowski@tieto.com>
	<CABBYNZJwTo-hQ4LuaxbmQt8WGoPCrM-a_W1NQdf8AvJboNyu2w@mail.gmail.com>
	<542A9706.6000504@tieto.com>
Date: Tue, 30 Sep 2014 15:10:30 +0300
Message-ID: <CABBYNZKQRr8JCcq_Qgp8rrALiN1sHNNDv9ukvBsaMYsGOyM3Vw@mail.gmail.com>
Subject: Re: [PATCHv2 01/16] android/tester: Expose gatt-tester's pdu
 definition to other testers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Sep 30, 2014 at 2:41 PM, Tyszkowski Jakub
<jakub.tyszkowski@tieto.com> wrote:
>>> +struct pdu {
>>> +       uint8_t *data;
>>> +       uint16_t size;
>>
>>
>> The size should probably be size_t, or even better use struct iovec
>> directly here since it is about the same.
>
>
> I wouldn't go that far and use iovec's here.
>
> I actually had one patch on top of this set which replaces this struct with
> iovec but in the end the only benefit was one struct definition less as
> bthost API does not take iovecs:

Im working on it already, internally bthost already uses iovec so it
makes sense to expose it if we can benefit from it.

> void bthost_send_cid(struct bthost *bthost, uint16_t handle,
>                         uint16_t cid, const void *data, uint16_t len)
>
> And this function is also a reason for 'size' being uint16_t.
>
> BTW I think 'pdu.data' looks better than 'pdu.iov_base' and we shouldn't
> make it look more complicated than it is without the real benefit.

Well this is not exactly the point, it might look better but struct
iovec is a standard interface so it only make sense to introduce
another design if the standard does not attend our needs which does
not seems to be the case here.

>>
>>> +};
>>> +
>>> +#define raw_data(args...) ((unsigned char[]) { args })
>>> +
>>> +#define raw_pdu(args...)                                       \
>>> +       {                                                       \
>>> +               .data = raw_data(args),                         \
>>> +               .size = sizeof(raw_data(args)),                 \
>>> +       }
>>> +
>>> +#define null_pdu { .data = NULL }
>>> +
>>>   #define TEST_CASE_BREDR(text, ...) { \
>>>                  HCIEMU_TYPE_BREDR, \
>>>                  text, \
>>> --
>>> 1.9.1
>>
>>
>>
>>
>
> Regards,
> Jakub



-- 
Luiz Augusto von Dentz
