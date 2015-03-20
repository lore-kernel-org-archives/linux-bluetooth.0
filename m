Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAAJ3CJuu5A-FKg+gwXeRmB6PRhwEaoUr98-YeXAj8VZrU-Khw@mail.gmail.com>
References: <CAAAJ3CJEXf+mYvst26fHasYsAvrXffhXFkEAO0a2Di=BLrxGOg@mail.gmail.com>
	<CABBYNZJA1hjO4chzFffYHRKsTJHKaGca+5O8U493kbTq=9CRPg@mail.gmail.com>
	<CAAAJ3C+JOP6rABtsfi274bKfe_Y9FB4uh-K7zs6Hmi30JB+TRQ@mail.gmail.com>
	<CAAAJ3C+MfihmVWyaR3EgY3YvF0AV2HeX+7MAi7jDUu1m=NXf2A@mail.gmail.com>
	<CABBYNZ+aPxS4p_LFDtS-eDDBMjTCvLnqUOCD5u_SXKQ46tO9Ug@mail.gmail.com>
	<CAAAJ3CL-WRRXr0cofDCeRM46H-jNf7L=dcZ5Uo7C6xp=K2QFyw@mail.gmail.com>
	<CABBYNZLAFKWQB8EYtSt-S49rcqw-TdX_vLjvXU7LSWaxq_xq2g@mail.gmail.com>
	<CABBYNZ+Dekw2OKPb-3Ej9p0dKF3VUnNe4URrPwvuSaofkudAYg@mail.gmail.com>
	<CAAAJ3C+=WKi46Rm7YnX2Hi=vQu=au_xxEAsy3k6VCVJnOUEY+g@mail.gmail.com>
	<CAAAJ3CKv0FrQ0eOv40Umfy-W0_h7XmD+fXBC=hQNHDF1uA5U1Q@mail.gmail.com>
	<CAAAJ3CJuu5A-FKg+gwXeRmB6PRhwEaoUr98-YeXAj8VZrU-Khw@mail.gmail.com>
Date: Fri, 20 Mar 2015 17:05:04 +0800
Message-ID: <CAAAJ3CL+77Tuw0+18GM5uTLJqwb60LUU+_-YA+UHTmp-j4Zq3A@mail.gmail.com>
Subject: Re: Bluetoothd crash/segfault when Chrombook creates connection with
 Samsung gear circle
From: Ethan <ethancsge@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks, I found this patch in upstream.

2015-03-19 10:57 GMT+08:00 Ethan <ethancsge@gmail.com>:
> Hi Luiz,
>
> Good news, issue is unable to reproduce with your patch. And may I
> know why struct avrcp *session got invalid address in this case?
> And does this patch will commit to upstream? Thanks.
>
> Regards,
> Ethan
>
> 2015-03-18 14:08 GMT+08:00 Ethan <ethancsge@gmail.com>:
>> Hi Luiz,
>>
>> Good news, issue is unable to reproduce with your patch. And may I know why
>> struct avrcp *session got invalid address in this case?
>>
>> Regards,
>> Ethan
>>
>> 2015-03-17 19:44 GMT+08:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>>
>>> Hi Ethan,
>>>
>>> On Tue, Mar 17, 2015 at 12:51 PM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>> > Hi Ethan,
>>> >
>>> > On Tue, Mar 17, 2015 at 12:13 PM, Ethan <ethancsge@gmail.com> wrote:
>>> >> Hi Luiz,
>>> >>
>>> >> OK, I will follow the rule.
>>> >> And actually, there have three crashes in function as
>>> >> "avrcp_player_value_rsp", "avrcp_get_play_status_rsp" and
>>> >> "avrcp_get_element_attributes_rsp". I tried to mark all code of
>>> >> function
>>> >> "avrcp_get_play_status_rsp" and return FALSE while finding first crash.
>>> >> Then I built bluetoothd, and it crashed again in
>>> >> avrcp_get_play_status_rsp.
>>> >> The same way, next crash is in avrcp_get_element_attributes_rsp.
>>> >>
>>> >> I traced code and check issue log as attached message file, it seems
>>> >> that
>>> >> code "struct avrcp *session = user_data;" get invalid address in
>>> >> function
>>> >> avrcp_get_capabilities_resp. Also, I tried to create a same type
>>> >> structure
>>> >> and assign to session as below, and issue can not be reproduced. Hope
>>> >> these
>>> >> information can help you to find root cause. Thanks.
>>> >>
>>> >> --- a/profiles/audio/avrcp.c
>>> >> +++ b/profiles/audio/avrcp.c
>>> >> @@ -3222,10 +3222,12 @@ static gboolean
>>> >> avrcp_get_capabilities_resp(struct
>>> >> avctp *conn,
>>> >>                      uint8_t *operands, size_t operand_count,
>>> >>                      void *user_data)
>>> >>  {
>>> >> -    struct avrcp *session = user_data;
>>> >> +        struct avrcp  test;
>>> >> +    struct avrcp *session = &test;
>>> >>
>>> >>
>>> >> The attached file is backtrace for three crash by GDB
>>> >>
>>> >>
>>> >> static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
>>> >>                     uint8_t code, uint8_t subunit,
>>> >>                     uint8_t *operands, size_t operand_count,
>>> >>                     void *user_data)
>>> >> {
>>> >>     struct avrcp *session = user_data;
>>> >>     struct avrcp_player *player = session->controller->player;
>>> >>     struct media_player *mp = player->user_data;                  /*
>>> >> --->crash */
>>> >>
>>> >>
>>> >>
>>> >> static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
>>> >>                         uint8_t code, uint8_t subunit,
>>> >>                         uint8_t *operands,
>>> >>                         size_t operand_count,
>>> >>                         void *user_data)
>>> >> {
>>> >>     struct avrcp *session = user_data;
>>> >>     struct avrcp_player *player = session->controller->player;   /*
>>> >> --->crash */
>>> >>
>>> >> static gboolean avrcp_player_value_rsp(struct avctp *conn,
>>> >>                     uint8_t code, uint8_t subunit,
>>> >>                     uint8_t *operands, size_t operand_count,
>>> >>                     void *user_data)
>>> >> {
>>> >>     struct avrcp *session = user_data;
>>> >>     struct avrcp_player *player = session->controller->player;
>>> >>     struct media_player *mp = player->user_data;                   /*
>>> >> --->crash */
>>> >>
>>> >>
>>> >> 2015-03-17T20:52:23.347640+11:00 DEBUG bluetoothd[21717]:
>>> >> profiles/audio/avctp.c:avctp_connect_cb() AVCTP: connected to
>>> >> A0:B4:A5:1F:56:B9
>>> >> 2015-03-17T20:52:23.348292+11:00 DEBUG bluetoothd[21717]:
>>> >> profiles/audio/avctp.c:init_uinput() AVRCP: uinput initialized for
>>> >> A0:B4:A5:1F:56:B9
>>> >> 2015-03-17T20:52:23.348337+11:00 DEBUG bluetoothd[21717]:
>>> >> profiles/audio/avrcp.c:target_init() 0x7f601c964a20 version 0x0105
>>> >
>>> > Here seems to be the problem, it seems we only are initiating the
>>> > target not the controller, which should be fine except that the remote
>>> > will not be able to qualify with support of absolute volume control
>>> > since that requires both records. Anyway there is no reason for us to
>>> > crash even if the remote device is doing some strange stuff, we might
>>> > need to check if controller is not initialized just volume control
>>> > should be enabled.
>>>
>>> Could you try with these changes:
>>>
>>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>>> index 414ee25..cc26eed 100644
>>> --- a/profiles/audio/avrcp.c
>>> +++ b/profiles/audio/avrcp.c
>>> @@ -3252,12 +3252,18 @@ static gboolean
>>> avrcp_get_capabilities_resp(struct avctp *conn,
>>>                 case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
>>>                 case AVRCP_EVENT_UIDS_CHANGED:
>>>                 case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
>>> +                       /* These events above are controller specific */
>>> +                       if (!session->controller)
>>> +                               break;
>>>                 case AVRCP_EVENT_VOLUME_CHANGED:
>>>                         avrcp_register_notification(session, event);
>>>                         break;
>>>                 }
>>>         }
>>>
>>> +       if (!session->controller)
>>> +               return FALSE;
>>> +
>>>         if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>>>                 avrcp_list_player_attributes(session);
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>
>>
>>
