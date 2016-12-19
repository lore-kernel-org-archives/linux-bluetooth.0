Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+NScyi8K9CJvwmM_6GngGCHLB=--PQa9s_4w1qOc=4JQ@mail.gmail.com>
References: <CABBYNZKzAbRHLBMU_WGH_aht_-ycU1OOuqJ_4M1RDovFd8z8tw@mail.gmail.com>
 <1481317184-173403-1-git-send-email-mcchou@chromium.org> <CAHgsZ+iWHFDNOqA4JBRpboKoOaCg5qxxJURa7apPyvuGqVJ38w@mail.gmail.com>
 <CABBYNZ+NScyi8K9CJvwmM_6GngGCHLB=--PQa9s_4w1qOc=4JQ@mail.gmail.com>
From: Miao-chen Chou <mcchou@chromium.org>
Date: Mon, 19 Dec 2016 11:13:41 -0800
Message-ID: <CAHgsZ+ihp5pBtXqJ-fE=dg9xEpq=TuGS1tqCeF6FFf05mu4dww@mail.gmail.com>
Subject: Re: [PATCH v3] monitor/rfcomm: Fix a potential memory access issue
 for compatibility with LLVM
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Yes, I saw that patch
(http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=452024ba83452eee5accdbe5506ab3683cd4790c).
I found that 452024 doesn't fix the issue, since it doesn't remove the
packed attribute from rfcomm_rpn structure in monitor/rfcomm.c.
Therefore, we still need this patch.

Thanks,
Miao

On Thu, Dec 15, 2016 at 4:05 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Tue, Dec 13, 2016 at 11:34 PM, Miao-chen Chou <mcchou@chromium.org> wrote:
>> Hello Luiz,
>>
>> Is there any comment on this patch?
>
> Ive sent a similar patch removing the remaining packed attribute from
> the RFCOMM, not sure if you have seen it? There is actually no reason
> to keep them packed since it is not used to stored the raw packets, so
> if you can please test the patch and let me know if that fixes the
> LLVM problem.
>
>> Thanks,
>> Miao
>>
>> On Sat, Dec 10, 2016 at 4:59 AM,  <mcchou@chromium.org> wrote:
>>> From: Miao-chen Chou <mcchou@chromium.org>
>>>
>>> This patch removes "packed" attribute from the definition of struct rfcomm_rpn
>>> to prevent the access to an unaligned struct member in mmc_rpn(). This patch
>>> also introduces a temp variable in mcc_pn() to prevent unaligned access without
>>> touching the definition of struct rfcomm_pn, since struct rfcomm_pn is used as
>>> a PDU.
>>> ---
>>>  monitor/rfcomm.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
>>> index b32ad40..08f3e36 100644
>>> --- a/monitor/rfcomm.c
>>> +++ b/monitor/rfcomm.c
>>> @@ -106,7 +106,7 @@ struct rfcomm_rpn {
>>>         uint8_t xon;
>>>         uint8_t xoff;
>>>         uint16_t pm;
>>> -} __attribute__ ((packed));
>>> +};
>>>
>>>  struct rfcomm_rls {
>>>         uint8_t dlci;
>>> @@ -232,8 +232,7 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>>
>>>         print_field("%*crtri %d rtro %d rtci %d rtco %d xon %d xoff %d",
>>>                 indent, ' ', GET_RPN_RTRI(rpn.io), GET_RPN_RTRO(rpn.io),
>>> -               GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
>>> -               rpn.xoff);
>>> +               GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon, rpn.xoff);
>>>
>>>         if (!l2cap_frame_get_le16(frame, &rpn.pm))
>>>                 return false;
>>> @@ -265,6 +264,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>>  {
>>>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>>>         struct rfcomm_pn pn;
>>> +       uint16_t mtu;
>>>
>>>         /* rfcomm_pn struct is defined in rfcomm.h */
>>>
>>> @@ -284,8 +284,10 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>>         if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
>>>                 return false;
>>>
>>> -       if (!l2cap_frame_get_le16(frame, &pn.mtu))
>>> +       /* prevent unaligned memory access */
>>> +       if (!l2cap_frame_get_le16(frame, &mtu))
>>>                 return false;
>>> +       pn.mtu = mtu;
>>>
>>>         if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
>>>                 return false;
>>> --
>>> 2.8.0.rc3.226.g39d4020
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
