Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJpANcHQuJ=Mcpst+KWXARpvPvYX7CFygB1_KevEoEGnQ@mail.gmail.com>
References: <CABBYNZ+_=ihEO+sVwUV-w5eNOs2FB=7OpjMPTdik_jLHCR29Jw@mail.gmail.com>
 <1480730912-41560-1-git-send-email-mcchou@chromium.org> <CABBYNZJpANcHQuJ=Mcpst+KWXARpvPvYX7CFygB1_KevEoEGnQ@mail.gmail.com>
From: Miao-chen Chou <mcchou@google.com>
Date: Wed, 7 Dec 2016 12:27:41 -0800
Message-ID: <CAHgsZ+iww2CLrw==650Aq4FfQNiZJigVboc7ZTqsmV_1=3yKgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] monitor/rfcomm: Fix a potential memory access issue
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

The intention is to prevent accessing the addresses of pn.mtu and
rpn.pm, where the LLVM compiler complains about the potential
unaligned pointer value, and the use of temp variables ensures the
alignment. The error message are
monitor/rfcomm.c:241:36: error: taking address of packed member 'pm'
of class or structure 'rfcomm_rpn' may result in an unaligned pointer
value [-Werror,-Waddress-of-packed-member]

[18/1998]
        if (!l2cap_frame_get_le16(frame, &rpn.pm))
                                          ^~~~~~
monitor/rfcomm.c:293:36: error: taking address of packed member 'mtu'
of class or structure 'rfcomm_pn' may result in an unaligned pointer
value [-Werror,-Waddress-of-packed-member]
        if (!l2cap_frame_get_le16(frame, &pn.mtu))

Thanks,
Miao

On Wed, Dec 7, 2016 at 6:12 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Sat, Dec 3, 2016 at 4:08 AM,  <mcchou@chromium.org> wrote:
>> From: Miao-chen Chou <mcchou@chromium.org>
>>
>> This patch introduces a temp variable to prevent the access to an unaligned
>> struct member. Since the struct rfcomm_rpn is used from PDU, enforcing alignment
>> is not a solution due to padding.
>> ---
>>  monitor/rfcomm.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
>> index b32ad40..7f1f23e 100644
>> --- a/monitor/rfcomm.c
>> +++ b/monitor/rfcomm.c
>> @@ -199,6 +199,7 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>  {
>>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>>         struct rfcomm_rpn rpn;
>> +       uint16_t pm;
>>
>>         if (!l2cap_frame_get_u8(frame, &rpn.dlci))
>>                 return false;
>> @@ -235,8 +236,11 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>                 GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
>>                 rpn.xoff);
>>
>> -       if (!l2cap_frame_get_le16(frame, &rpn.pm))
>> +       /* prevent unaligned memory access */
>> +       pm = rpn.pm;
>> +       if (!l2cap_frame_get_le16(frame, &pm))
>>                 return false;
>> +       rpn.pm = pm;
>
> Not sure what was the intention here but if you were to introduce a
> new variable for pm then we don't need rpn struct anymore.
>
>>
>>         print_field("%*cpm 0x%04x", indent, ' ', rpn.pm);
>>
>> @@ -265,6 +269,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>  {
>>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>>         struct rfcomm_pn pn;
>> +       uint16_t mtu;
>>
>>         /* rfcomm_pn struct is defined in rfcomm.h */
>>
>> @@ -284,8 +289,11 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>>         if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
>>                 return false;
>>
>> -       if (!l2cap_frame_get_le16(frame, &pn.mtu))
>> +       /* prevent unaligned memory access */
>> +       mtu = pn.mtu;
>> +       if (!l2cap_frame_get_le16(frame, &mtu))
>>                 return false;
>> +       pn.mtu = mtu;
>
> Similar problem here, but Im not exactly sure why this is a problem
> since l2cap_frame_get_le16 does already takes care of unligned access.
>
>>         if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
>>                 return false;
>> --
>> 2.8.0.rc3.226.g39d4020
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
