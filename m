Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MNFaHO0eVaDuh+P7cEnv0UQ75sMrbVLZDnSVt-=b17sg@mail.gmail.com>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
	<1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
	<1395689143-11091-21-git-send-email-claudio.takahasi@openbossa.org>
	<20140324201729.GB31654@t440s.P-661HNU-F1>
	<CAJdJm_MNFaHO0eVaDuh+P7cEnv0UQ75sMrbVLZDnSVt-=b17sg@mail.gmail.com>
Date: Tue, 25 Mar 2014 08:37:23 -0300
Message-ID: <CAKT1EBfdTcTQ6E4JU4L3_ynTHQ2D7VGuyaByb+4TNsqDCTZ-_Q@mail.gmail.com>
Subject: Re: [PATCH v1 20/22] tools: Use unaligned access macros from util.h
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Lizardo:

On Mon, Mar 24, 2014 at 5:42 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Johan,
>
> On Mon, Mar 24, 2014 at 4:17 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Claudio,
>>
>> On Mon, Mar 24, 2014, Claudio Takahasi wrote:
>>> ---
>>>  tools/parser/hci.c    | 1 -
>>>  tools/parser/l2cap.c  | 1 -
>>>  tools/parser/parser.h | 9 ++++-----
>>>  tools/parser/ppp.c    | 2 +-
>>>  4 files changed, 5 insertions(+), 8 deletions(-)
>>
>> I've applied all patches until this one.
>>
>> This patch has a quite severe bug in it (which to be honest makes me a
>> bit nervous of the earlier ones I applied):
>>
>>>  static inline uint16_t get_u16(struct frame *frm)
>>>  {
>>> -     uint16_t *u16_ptr = frm->ptr;
>>>       frm->ptr += 2;
>>>       frm->len -= 2;
>>> -     return ntohs(bt_get_unaligned(u16_ptr));
>>> +     return get_be16(frm->ptr);
>>>  }
>>>
>>>  static inline uint32_t get_u32(struct frame *frm)
>>>  {
>>> -     uint32_t *u32_ptr = frm->ptr;
>>>       frm->ptr += 4;
>>>       frm->len -= 4;
>>> -     return ntohl(bt_get_unaligned(u32_ptr));
>>> +     return get_be32(frm->ptr);
>>>  }
>>
>> Note that the value passed to ntohl before your patch is the pointer
>> before it is incremented. However after your patch it's the pointer
>> after it has been incremented, so you're changing the behavior of these
>> two functions.
>
> To be clear, I reviewed this code internally, and I missed this bug. I
> believe the correct change is something like:
>
> -     uint32_t *u32_ptr = frm->ptr;
> +    uint32_t u32 = get_be32(frm->ptr);
>
> and then "return u32" at the end. Sorry about the double mistake
> (given that both me and Claudio missed it).

It is my negligence. I will send a new patch.

Claudio.
