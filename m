Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Zi_euJQ5SbZjeYHcP_ScyAAn4rAv_GFMR3sfHHeCNCw@mail.gmail.com>
References: <1482263413-85198-1-git-send-email-mcchou@chromium.org>
 <CABBYNZKZzvum3s8YcVzUYQME77UOAD_4FdnQSYHiRGSJ20noVA@mail.gmail.com>
 <CAHgsZ+gwVHZpU1kY++_U1SQnTF3EATAUwk4PN8dZKhj0bCrmTQ@mail.gmail.com> <CABBYNZ+Zi_euJQ5SbZjeYHcP_ScyAAn4rAv_GFMR3sfHHeCNCw@mail.gmail.com>
From: Miao-chen Chou <mcchou@google.com>
Date: Wed, 21 Dec 2016 15:09:16 -0800
Message-ID: <CAHgsZ+jKT__=W=vWM_Nk82POQN=Xmjq6De90Sc1wjJZq81UjcQ@mail.gmail.com>
Subject: Re: [PATCH v4] monitor/rfcomm: Fix a potential memory access issue
 for compatibility with LLVM
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Indeed, there is currently no such option in GCC.
http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=452024ba83452eee5accdbe5506ab3683cd4790c
has addressed the removal of packed attribute, but it missed out
struct rfcomm_rpn, and we still need to take care of the access to mtu
of struct rfcomm_pn. I will add more more description to the following
patch (v5).

Thanks,
Miao

On Wed, Dec 21, 2016 at 12:08 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Wed, Dec 21, 2016 at 9:26 PM, Miao-chen Chou <mcchou@google.com> wrote:
>> Hi Luiz,
>>
>> The unaligned error is raised when trying to access the address of mtu
>> of a packed struct where mtu's size is 2 bytes; which means accessing
>> the address of a packed member whose size is greater than 1 byte can
>> raised this error. So it is not true that there is no error as far as
>> the member is not accessed via void *(see the following function
>> signature).
>>
>> static inline bool l2cap_frame_get_le16(struct l2cap_frame *frame,
>> uint16_t *value)
>>
>> Here are the errors generated. The flags are "Werror" and
>> "Waddress-of-packed-member". I will also add these two errors into the
>> commit message.
>>
>> monitor/rfcomm.c:238:36: error: taking address of packed member 'pm'
>> of class or structure 'rfcomm_rpn' may result in an unaligned pointer
>> value [-Werror,-Waddress-of-packed-member]
>>         if (!l2cap_frame_get_le16(frame, &rpn.pm))
>> monitor/rfcomm.c:287:36: error: taking address of packed member 'mtu'
>> of class or structure 'rfcomm_pn' may result in an unaligned pointer
>> value [-Werror,-Waddress-of-packed-member]
>>         if (!l2cap_frame_get_le16(frame, &pn.mtu))
>
> Ive only found the following bug in GCC:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51628
>
> But there doesn't seem to have any option such as
> -Waddress-of-packed-member but it seems valid as explained in the bug.
> So we got to remove any use of packed struct that don't represent the
> PDU, iirc we did choose to parse individual members so we could tell
> exactly where it PDU failed to parse but that is not done in other
> layers which do use packed structs but they don't take addresses of
> members so they are safe. Imo we should not resort to packed in the
> monitor, specially since gcc don't seem to have a flag to catch
> addresses of packed member, for non-monitor it might be fine because
> they don't need to be decoding everything.
>
>> Thanks,
>> Miao
>>
>> On Wed, Dec 21, 2016 at 6:03 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi,
>>>
>>> On Tue, Dec 20, 2016 at 9:50 PM,  <mcchou@chromium.org> wrote:
>>>> From: Miao-chen Chou <mcchou@chromium.org>
>>>>
>>>> This patch removes "packed" attribute from the definition of struct rfcomm_rpn
>>>> to prevent the access to an unaligned struct member in mmc_rpn(). This patch
>>>> also introduces a temp variable in mcc_pn() to prevent unaligned access without
>>>> touching the definition of struct rfcomm_pn, since struct rfcomm_pn is used as
>>>> a PDU.
>>>> ---
>>>> v4 removes the unrelated change on the code format.
>>>>
>>>>  monitor/rfcomm.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
>>>> index b32ad40..4bd549c 100644
>>>> --- a/monitor/rfcomm.c
>>>> +++ b/monitor/rfcomm.c
>>>> @@ -106,7 +106,7 @@ struct rfcomm_rpn {
>>>>         uint8_t xon;
>>>>         uint8_t xoff;
>>>>         uint16_t pm;
>>>> -} __attribute__ ((packed));
>>>> +};
>>>>
>>>>  struct rfcomm_rls {
>>>>         uint8_t dlci;
>>>> @@ -265,6 +265,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>>>  {
>>>>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>>>>         struct rfcomm_pn pn;
>>>> +       uint16_t mtu;
>>>>
>>>>         /* rfcomm_pn struct is defined in rfcomm.h */
>>>>
>>>> @@ -284,8 +285,10 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>>>         if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
>>>>                 return false;
>>>>
>>>> -       if (!l2cap_frame_get_le16(frame, &pn.mtu))
>>>> +       /* prevent unaligned memory access */
>>>> +       if (!l2cap_frame_get_le16(frame, &mtu))
>>>>                 return false;
>>>> +       pn.mtu = mtu;
>>>
>>> Interesting, isn't this causing unaligned access anyway since it is
>>> assigning to pn.mtu which is packed? Or this is fine as far as it is
>>> not accessed via void *? Btw, please add the compiler output and flags
>>> it is being used, it is quite possible we can replicate the same
>>> errors on gcc or perhaps it is missing some flags used in gcc to make
>>> this aligned?
>>>
>>>>         if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
>>>>                 return false;
>>>> --
>>>> 2.8.0.rc3.226.g39d4020
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
