Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5JAENx0xCVYN9C1apdukhqrBEsRsX+ffNAirXuP_aUTA@mail.gmail.com>
References: <1337865771-11777-1-git-send-email-luiz.dentz@gmail.com>
	<1337865771-11777-5-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v5JAENx0xCVYN9C1apdukhqrBEsRsX+ffNAirXuP_aUTA@mail.gmail.com>
Date: Fri, 25 May 2012 11:30:03 +0300
Message-ID: <CABBYNZK6TynjJb2x0Unw9z0ZqxD0CWhveVuBMkFJ_cNZAav+7g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/6] AVRCP: Add support for sending SetAbsoluteVolume
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, May 24, 2012 at 8:08 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>>        if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
>>                return FALSE;
>>
>> +       if (pdu->pdu_id == AVRCP_REGISTER_NOTIFICATION)
>> +               volume = pdu->params[1] & 0x7F;
>> +       else
>> +               volume = pdu->params[0] & 0x7F;
>> +
>>        if (player->cb->set_volume != NULL)
>> -               player->cb->set_volume(abs_volume, player->dev, player->user_data);
>> +               player->cb->set_volume(volume, player->dev, player->user_data);
>>
>> -       return TRUE;
>> +       return pdu->pdu_id == AVRCP_REGISTER_NOTIFICATION ? TRUE : FALSE;
>
> I don't think tweaking this function to handle both callbacks as you
> did is a good idea. One of the reasons is something is already missing
> in this function: when you receive a "changed notification" you need
> to re-register it for receiving subsequent notifications... i.e. in
> this function you need to call register_volume_notification() again.
> See the end of avrcp_player_event() function and section 6.7.2 of
> AVRCP 1.4 spec:
>
> "A registered notification gets changed on receiving CHANGED event
> notification. For a new notification additional NOTIFY command is
> expected to be sent. Only one EventID shall be used per notification
> registration."

Yep, spec authors always surprises me, apparently they choose racy
design of one shot notification instead of normal
subscribe/unsubscribe mechanism.

>>  }
>>
>>  static void register_volume_notification(struct avrcp_player *player)
>> @@ -1404,3 +1410,36 @@ void avrcp_unregister_player(struct avrcp_player *player)
>>
>>        player_destroy(player);
>>  }
>> +
>> +int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
>> +{
>> +       struct avrcp_server *server;
>> +       struct avrcp_player *player;
>> +       uint8_t buf[AVRCP_HEADER_LENGTH + 1];
>> +       struct avrcp_header *pdu = (void *) buf;
>> +
>> +       server = find_server(servers, &dev->src);
>> +       if (server == NULL)
>> +               return -EINVAL;
>> +
>> +       player = server->active_player;
>> +       if (player == NULL)
>> +               return -ENOTSUP;
>> +
>> +       if (player->session == NULL)
>> +               return -ENOTCONN;
>> +
>> +       memset(buf, 0, sizeof(buf));
>> +
>> +       set_company_id(pdu->company_id, IEEEID_BTSIG);
>> +
>> +       pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
>> +       pdu->params[0] = volume;
>> +       pdu->params_len = htons(1);
>> +
>> +       DBG("volume=%u", volume);
>> +
>> +       return avctp_send_vendordep_req(player->session, AVC_CTYPE_CHANGED,
>
> wrong CTYPE... it should be CONTROL

Gonna fix it.



-- 
Luiz Augusto von Dentz
