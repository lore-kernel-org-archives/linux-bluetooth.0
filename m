Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <65AF22C1CD4D4E948B9A22A50C0B504D@sisodomain.com>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
	<1322265226-6404-6-git-send-email-andre.guedes@openbossa.org>
	<1322497442.29909.36.camel@aeonflux>
	<65E3B21D-EC4E-4443-ADAB-39576B981F70@openbossa.org>
	<65AF22C1CD4D4E948B9A22A50C0B504D@sisodomain.com>
Date: Fri, 2 Dec 2011 13:07:33 +0200
Message-ID: <CABBYNZL9qLM3aKk_pWBSMdR4VVGqCuUcdTA_rwh1mtXqB2QtyQ@mail.gmail.com>
Subject: Re: Query on Media Interface "RegisterPlayer" and Dbus signal "TrackChanged"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Dec 2, 2011 at 12:02 PM, Jaganath <jaganath.k@samsung.com> wrote:
> Hi,
>
> I have come across a scenario related to Media Interface meant for AVRCP 1.3
> features.
>
> Kindly please provide your opinions on this.
>
> If the Media Interface "RegisterPlayer" is called before the  headset
> connection, then player gets registered successfully and all the
> Vendor dependent commands are handled properly. And in case of any change in
> the track, through the "TrackChanged" Dbus signal
> shall be sent with information about "Change of track" and "Start of track".
> This scenario will work because we have registered for the
> callback  "state_changed"(audio/avrcp.c) through "avrcp_register_player"
> (audio/avrcp.c) API. When connection is ongoing "state_changed"
> callback shall be invoked with state as "AVCTP_STATE_CONNECTING" where in
> "player->session" will be initialized.
>
>
> However if the "RegisterPlayer" is called after the headset connection, then
> we will not be able to send the "TrackChanged" signal with
> information of "Change of track" and "Start of track". Since the headset is
> already connected,"state_changed" callback will not be
> invoked, hence in the avrcp_player_event" API "player->session" is NULL.
>
> Is it not necessary to handle the above the mentioned scenario?

Yes that is probably a valid and common scenario, so we probably need
to change the code to update the session when this happen but
apparently there is no way to notify the remote device about this
since the concept of players and EVENT_AVAILABLE_PLAYERS_CHANGED was
introduced only on 1.4. So for 1.3 we might have to pretend we have a
player without any metadata and as soon as one is registered we
assigned it to the active session and notify the metadata has changed
via events.

-- 
Luiz Augusto von Dentz
