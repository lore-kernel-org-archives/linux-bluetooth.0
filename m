Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B17741130B43C@SHSMSX104.ccr.corp.intel.com>
References: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com>
	<1411717728-15415-3-git-send-email-chao.jie.gu@intel.com>
	<CAN_7+YbQFq0=mvwhsHmduguDu-b0ji8L0+HqW-iDaHB_xO-3+g@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B17741130B43C@SHSMSX104.ccr.corp.intel.com>
Date: Mon, 29 Sep 2014 10:09:08 +0200
Message-ID: <CAN_7+YbGuVK4-d82BC6crXzjC+xp_3eRGFUpOLNtat2HdDLU5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] shared/gatt-client: Add CSRK part to support
 signed write
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Chaojie,

On Sat, Sep 27, 2014 at 11:36 AM, Gu, Chao Jie <chao.jie.gu@intel.com> wrote:
> Hi Lukasz,
>> > ---
>> >  src/shared/gatt-client.c |   27 ++++++++++++++++++++++-----
>> >  src/shared/gatt-client.h |    4 ++++
>> >  2 files changed, 26 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c index
>> > 6dc8e95..aee3969 100644
>> > --- a/src/shared/gatt-client.c
>> > +++ b/src/shared/gatt-client.c
>> > @@ -1753,19 +1753,26 @@ bool bt_gatt_client_read_long_value(struct
>> > bt_gatt_client *client,  bool bt_gatt_client_write_without_response(struct
>> bt_gatt_client *client,
>> >                                         uint16_t value_handle,
>> >                                         bool signed_write,
>> > -                                       uint8_t *value, uint16_t length) {
>> > +                                       uint8_t *value, uint16_t
>> > +length) {
>> >         uint8_t pdu[2 + length];
>> >
>> >         if (!client)
>> >                 return 0;
>> >
>> > -       /* TODO: Support this once bt_att_send supports signed writes. */
>> > -       if (signed_write)
>> > -               return 0;
>> > -
>> >         put_le16(value_handle, pdu);
>> >         memcpy(pdu + 2, value, length);
>> >
>> > +       if (signed_write) {
>> > +               if (bt_att_local_csrk_is_valid(client->att))
>>
>> In my opinion bt_att_local_csrk_is_valid API seems to be unnecessary as CSRK can
>> be checked inside bt_att_send function directly.
>>
>
> I agree with you that it is also ok to be checked inside bt_att_send function and have thought
> about this problem before.
> And I think there are two advantages of checking valid outside bt_att_send function
>
> 1. provide API to user to check CSRK status if they want.

Ok, the question is why user would like  to do it? Maybe I'm missing something.

> 2. if the CSRK is invalid , we can just return false quickly , there is no need to go on calling
> down bt_att_send then return false back. It will be more efficient I think.

If  bt_att_send() will check the CSRK on the beginning then there is
no difference.

>
> What's your point about this ?
>
> Best Regards
> Chaojie Gu
>
