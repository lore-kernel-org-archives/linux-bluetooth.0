Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDCC105.6070803@globaledgesoft.com>
Date: Mon, 05 Dec 2011 18:33:01 +0530
From: sathish <sathish.n@globaledgesoft.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Jaganath <jaganath.k@samsung.com>, linux-bluetooth@vger.kernel.org
Subject: Re: Query on Media Interface "RegisterPlayer" and Dbus signal "TrackChanged"
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>	<1322265226-6404-6-git-send-email-andre.guedes@openbossa.org>	<1322497442.29909.36.camel@aeonflux>	<65E3B21D-EC4E-4443-ADAB-39576B981F70@openbossa.org>	<65AF22C1CD4D4E948B9A22A50C0B504D@sisodomain.com> <CABBYNZL9qLM3aKk_pWBSMdR4VVGqCuUcdTA_rwh1mtXqB2QtyQ@mail.gmail.com>
In-Reply-To: <CABBYNZL9qLM3aKk_pWBSMdR4VVGqCuUcdTA_rwh1mtXqB2QtyQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  On Friday 02 December 2011 04:37 PM, Luiz Augusto von Dentz wrote:
> Hi Jaganath,
>
> On Fri, Dec 2, 2011 at 12:02 PM, Jaganath<jaganath.k@samsung.com>  wrote:
>> Hi,
>>
>> I have come across a scenario related to Media Interface meant for AVRCP 1.3
>> features.
>>
>> Kindly please provide your opinions on this.
>>
>> If the Media Interface "RegisterPlayer" is called before the  headset
>> connection, then player gets registered successfully and all the
>> Vendor dependent commands are handled properly. And in case of any change in
>> the track, through the "TrackChanged" Dbus signal
>> shall be sent with information about "Change of track" and "Start of track".
>> This scenario will work because we have registered for the
>> callback  "state_changed"(audio/avrcp.c) through "avrcp_register_player"
>> (audio/avrcp.c) API. When connection is ongoing "state_changed"
>> callback shall be invoked with state as "AVCTP_STATE_CONNECTING" where in
>> "player->session" will be initialized.
>>
>>
>> However if the "RegisterPlayer" is called after the headset connection, then
>> we will not be able to send the "TrackChanged" signal with
>> information of "Change of track" and "Start of track". Since the headset is
>> already connected,"state_changed" callback will not be
>> invoked, hence in the avrcp_player_event" API "player->session" is NULL.
>>
>> Is it not necessary to handle the above the mentioned scenario?
> Yes that is probably a valid and common scenario, so we probably need
> to change the code to update the session when this happen but
> apparently there is no way to notify the remote device about this
> since the concept of players and EVENT_AVAILABLE_PLAYERS_CHANGED was
> introduced only on 1.4. So for 1.3 we might have to pretend we have a
> player without any metadata and as soon as one is registered we
> assigned it to the active session and notify the metadata has changed
> via events.
>
Hi,
     Please provide the information about how to use mpris 2.0 spec , 
can u please provide me detail of platform that register player worked 
successfully. I am also working on getting these information .

Thanks & regards ,
sathish N

-- 
Thanks&  Regards,
Sathish N

