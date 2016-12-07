Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161207210708.GA28060@x1c.P-661HNU-F1>
References: <CABBYNZ+_=ihEO+sVwUV-w5eNOs2FB=7OpjMPTdik_jLHCR29Jw@mail.gmail.com>
 <1480730912-41560-1-git-send-email-mcchou@chromium.org> <CABBYNZJpANcHQuJ=Mcpst+KWXARpvPvYX7CFygB1_KevEoEGnQ@mail.gmail.com>
 <CAHgsZ+iww2CLrw==650Aq4FfQNiZJigVboc7ZTqsmV_1=3yKgw@mail.gmail.com> <20161207210708.GA28060@x1c.P-661HNU-F1>
From: Miao-chen Chou <mcchou@google.com>
Date: Wed, 7 Dec 2016 15:20:45 -0800
Message-ID: <CAHgsZ+j5darazR39cgi34sK=STEfP0sUnTHMUoVGa6kvqnCW7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] monitor/rfcomm: Fix a potential memory access issue
To: Miao-chen Chou <mcchou@google.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan and Luiz,

I agree with Johan's comment on the rfcomm_rpn struct. struct
rfcomm_rpn is only used on mcc_rpn(), and it causes the potential
alignment issue. Removing it and replacing the use with normal stack
variables seems to be a good way to go. Since the related patch
"gobex: Fix a compilation error for the compatibility with LLVM" has
been adopted. I will upload the next patch in a new thread. Thanks.

-Miao

On Wed, Dec 7, 2016 at 1:07 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Miao,
>
> On Wed, Dec 07, 2016, Miao-chen Chou wrote:
>> The intention is to prevent accessing the addresses of pn.mtu and
>> rpn.pm, where the LLVM compiler complains about the potential
>> unaligned pointer value, and the use of temp variables ensures the
>> alignment. The error message are
>> monitor/rfcomm.c:241:36: error: taking address of packed member 'pm'
>> of class or structure 'rfcomm_rpn' may result in an unaligned pointer
>> value [-Werror,-Waddress-of-packed-member]
>>
>> [18/1998]
>>         if (!l2cap_frame_get_le16(frame, &rpn.pm))
>>                                           ^~~~~~
>> monitor/rfcomm.c:293:36: error: taking address of packed member 'mtu'
>> of class or structure 'rfcomm_pn' may result in an unaligned pointer
>> value [-Werror,-Waddress-of-packed-member]
>>         if (!l2cap_frame_get_le16(frame, &pn.mtu))
>
> It seems to me like there's no point in mcc_rpn() using the packed
> rfcomm_rpn struct, since what it really wants is normal properly aligned
> stack variables. So a more appropriate fix is probably to remote the
> rfcomm_rpn struct usage and instead just declare the necessary "normal"
> variables to fetch the necessary values from the frame. Another, perhaps
> better alternative, is to use a struct rfcomm_rpn pointer to frame->data
> and use l2cap_frame_pull() to advance the data pointer, i.e. something
> like:
>
>         struct rfcomm_rpn *rpn;
>
>         if (frame->size < sizeof(*rpn))
>                 return false;
>
>         rpn = frame->data;
>         l2cap_frame_pull(frame, frame, sizeof(*rpn))
>
>         ...print content of rpn, utilizing get_le16() etc...
>
> The downside of the above is that if you get an incomplete frame we
> don't decode even the parts that we did receive. I'm not sure what's the
> preferred policy with btmon decoding.
>
> Johan
