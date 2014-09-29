Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3D02B219753AD44CBDDDE484323B17741130B41E@SHSMSX104.ccr.corp.intel.com>
References: <1411717728-15415-1-git-send-email-chao.jie.gu@intel.com>
	<1411717728-15415-2-git-send-email-chao.jie.gu@intel.com>
	<CAN_7+YYE4C-d-dnkS4GQqR9GoB44hqbpui9zCk9=GtmJHzyefg@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B17741130B41E@SHSMSX104.ccr.corp.intel.com>
Date: Mon, 29 Sep 2014 10:08:50 +0200
Message-ID: <CAN_7+YbmO_88_cyCq2Ysec-_WZFtREFNQkx4Pt6OGwUDzZo0Ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] shared/att.c: Add signed command outgoing and CSRK function
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

On Sat, Sep 27, 2014 at 11:26 AM, Gu, Chao Jie <chao.jie.gu@intel.com> wrote:
> Hi Lukasz,
>
>> > +
>> > +bool bt_att_get_local_csrk(struct bt_att *att, uint8_t key[16],
>> > +                                       uint32_t *local_sign_cnt)
>>
>>
>> Why we need that get function ? If we assume that signing is done in bt_att then
>> there is need only to feed bt_att with the CSRK.
>>  BTW. There should be a way to set sign_cnt as well as this shall be in same
>> storage as CSRK
>>
>> I can guess that idea behind this bt_att_get_ is that client of bt_att should have
>> possibility to update its sign_cnt after each transaction.
>> It is in order to update storage. If so  I would propose to have some callback
>> registered in bt_att for this purpose.
>>
> According to your proposal, I am not clear where and when you want to register
> callback to get sign_cnt,

At the same time and from the same place where CSRK is provided to bt_att.
I guess that both values (key and counter) will be stored in same database.

> and I think register new callback for only one signed_cnt
> Parameter, it make sense ?

Why not? :)

>
> In my thought , this method user also can get signd_cnt after signed_write_cmd.
> In encode_pdu function, after we encode pdu with CSRK, then it will update sign_cnt
> in the bt_att structure for next signed write command.
>
> If client of bt_att need to update its sign_cnt in the storage, when bt_att_send for
> SIGNED_WRITE_COMMAND return ture, user can call bt_att_get_local_csrk to
> get newest sign_cnt and store it.

The thing is that it is not "if".  We need to make sure that sign
counter is updated in the database
and I think that having callback is convenient for that. Of course you
can have some helper which
retrieves sign counter after each att transaction and then store it.

We need to remember  that local sign counter is valid as long as CSRK
is, so in order to do any sign write after
reconnect we need to have updated sing counter, otherwise remote will
reject write command.

BR
Lukasz
>
> Best Regards
> Chaojie Gu
