Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B17741130DDF2@SHSMSX104.ccr.corp.intel.com>
References: <1412758479-13214-1-git-send-email-chao.jie.gu@intel.com>
	<1412758479-13214-2-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZ+NW=1aW6_sMppq2kU4FUou0pK5DhHQ7ykhUFkf4dCCsw@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B17741130DD22@SHSMSX104.ccr.corp.intel.com>
	<CABBYNZLtwXrN1tYH+5vvPrcYq8Xaa5mdwba6vyQMvC0_s4Z0Cg@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B17741130DDF2@SHSMSX104.ccr.corp.intel.com>
Date: Thu, 9 Oct 2014 13:17:33 +0300
Message-ID: <CABBYNZKn-G2TRrLZZyB63mL8kcec6eUHR_A4fguKhx4Y9jc1sQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] shared/att.c: Add signed command outgoing and CSRK function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 9, 2014 at 12:38 PM, Gu, Chao Jie <chao.jie.gu@intel.com> wrote:
> Hi Luiz,
>> >
>> >> > @@ -77,6 +78,16 @@ struct bt_att {
>> >> >         bt_att_debug_func_t debug_callback;
>> >> >         bt_att_destroy_func_t debug_destroy;
>> >> >         void *debug_data;
>> >> > +
>> >> > +       struct bt_crypto *crypto;
>> >> > +
>> >> > +       bool valid_local_csrk;
>> >> > +       uint8_t local_csrk[16];
>> >> > +       uint32_t local_sign_cnt;
>> >> > +
>> >> > +       bool valid_remote_csrk;
>> >> > +       uint8_t remote_csrk[16];
>> >> > +       uint32_t remote_sign_cnt;
>> >>
>> >> Maybe it is better to have pointers to a structs so you can free the
>> >> data once it becomes invalid and it also removes the necessity of
>> >> extra flags just to tell if the data is still valid since you can check if the pointer is
>> not NULL then it must be valid.
>> >
>> > This is good idea to remove the extra flags. However, we define the
>> > struct to do this which would result in some problem. Now we
>> > initialize the local_sign_cnt in the bt_att_new function and only add
>> > local_sign_cnt value when signed write command outgoing. Meanwile, we
>> > set local CSRK in the bt_gatt_client_set_local_csrk function when there is valid
>> CSRK provided. This two Parameter set at different time now.
>>
>> Well I guess this was your design, it doesn't have to be this way, in fact I believe
>> there is no point of initializing the counter if there is no valid CSRK because one
>> depend on the other, also perhaps you have a bug in bt_gatt_client_set_local_csrk
>> since I believe every time you set CSRK you should reset the counter otherwise you
>> may be carrying the counters from the past CSRK which probably won't work.
>
> You said condition resuilt in bug which I want to avoid, because we use this command line
> By btgatt-client tool
> Write-value -w -c <CSRK> <value_handle> <value>
> If user write signed command twice, it would call bt_gatt_client_set_local_csrk twice.
> So it will restore sign_cnt, that's why I initialize the sign_cnt in bt_att_new to avoid this bug.

Considering what the spec says about SignCounter and that we do in
fact store the counter persistently I believe the counter is valid as
long as CSRK is valid, which means it is not per connection and
initializing it on bt_att_new is probably wrong since the counter will
probably be out of sync. We should either create a dedicate command to
set CSRK and the SignCounter or make write-value to take the counter
as well otherwise it wont work except with a fresh CSRK and
SignCounter which perhaps is the case of btgatt-client but not if we
want to reuse in the daemons.

> In fact, the only way is that we should tell user set CSRK once if CSRK did not change to
> resolve this problem.
>
>> Also don't to have to pass the counter when setting the key, the counter probably
>> need to be restored on every connection so bt_gatt_client_set_local_csrk and
>> bt_att_set_remote_csrk probably needs to take the counter and instead of having a
>> valid flag you can probably reset by setting NULL as key or an invalid counter if one
>> exists.
>
> If we define the new struct naming signed_info to store csrk and sign_cnt, what's your point?
>
>>
>> > If we have pointers to a struct including local_csrk and
>> > local_signd_cnt, we initialize the local_sign_cnt meanwhile the struct should not
>> be NULL because of incuding it. In fact, local_csrk is not valid at this time.
>> > If we initialize the local_signed_cnt when CSRK is valid , it would be
>> > risk to change local_signed_cnt by user calling bt_gatt_client_set_local_csrk.
>> >> >  };
>> >> >
>> >> >  enum att_op_type {
>> >> > @@ -176,6 +187,8 @@ struct att_send_op {
>> >> >         bt_att_response_func_t callback;
>> >> >         bt_att_destroy_func_t destroy;
>> >> >         void *user_data;
>> >> > +
>> >> > +       struct bt_att *att;
>> >> >  };
>> >> >
>> >> >  static void destroy_att_send_op(void *data) @@ -277,6 +290,10 @@
>> >> > static bool encode_pdu(struct att_send_op *op, const void *pdu,
>> >> >                                                 uint16_t length,
>> >> > uint16_t mtu)  {
>> >> >         uint16_t pdu_len = 1;
>> >> > +       struct bt_att *att = op->att;
>> >> > +
>> >> > +       if (op->opcode & ATT_OP_SIGNED_MASK)
>> >> > +               pdu_len += BT_ATT_SIGNATURE_LEN;
>> >> >
>> >> >         if (length && pdu)
>> >> >                 pdu_len += length;
>> >> > @@ -293,17 +310,32 @@ static bool encode_pdu(struct att_send_op
>> >> > *op, const
>> >> void *pdu,
>> >> >         if (pdu_len > 1)
>> >> >                 memcpy(op->pdu + 1, pdu, length);
>> >> >
>> >> > +       if (op->opcode & ATT_OP_SIGNED_MASK) {
>> >> > +               if (bt_crypto_sign_att(att->crypto,
>> >> > +                                       att->local_csrk,
>> >> > +                                       op->pdu,
>> >> > +                                       1 + length,
>> >> > +                                       att->local_sign_cnt,
>> >> > +                                       &((uint8_t *) op->pdu)[1 +
>> >> length]))
>> >> > +                       att->local_sign_cnt++;
>> >> > +               else
>> >> > +                       return false;
>> >> > +       }
>> >> > +
>> >>
>> >> You can probably bail out early if you check !(op->opcode &
>> >> ATT_OP_SIGNED_MASK), also perhaps it is a good idea to start defining
>> >> structs for the PDUs to simplify the access.
>> >>
>> > If we bail out this checking early , maybe we have to need two
>> > different encode_pdu function to implement it such as naming new
>> encode_signed_pdu function to do this.
>>
>> But you return true anyway after this code, no idea why you need a new function for
>> that, all I was suggesting is the following:
>>
>> if (!(op->opcode & ATT_OP_SIGNED_MASK))
>>     return true;
>>
>> if (!bt_crypto_sign_att...)
>>     return false;
>>
>> att->local_sign_cnt++;
>>
>> return true;
>>
>
> I got your meaning now. I have returned false when bt_crypto_sign_att. Failed
>
>  +               else
>  +                       return false;
>
> Your proposal is good so as to make code more clearer. I would accept that.
>
> Thanks
> Chaojie Gu



-- 
Luiz Augusto von Dentz
