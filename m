Return-Path: <cyrus@holtmann.org>
Message-id: <65AF22C1CD4D4E948B9A22A50C0B504D@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
 <1322265226-6404-6-git-send-email-andre.guedes@openbossa.org>
 <1322497442.29909.36.camel@aeonflux>
 <65E3B21D-EC4E-4443-ADAB-39576B981F70@openbossa.org>
In-reply-to: <65E3B21D-EC4E-4443-ADAB-39576B981F70@openbossa.org>
Subject: Query on Media Interface "RegisterPlayer" and Dbus signal
 "TrackChanged"
Date: Fri, 02 Dec 2011 15:32:15 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have come across a scenario related to Media Interface meant for AVRCP 1.3 
features.

Kindly please provide your opinions on this.

If the Media Interface "RegisterPlayer" is called before the  headset 
connection, then player gets registered successfully and all the
Vendor dependent commands are handled properly. And in case of any change in 
the track, through the "TrackChanged" Dbus signal
shall be sent with information about "Change of track" and "Start of track". 
This scenario will work because we have registered for the
callback  "state_changed"(audio/avrcp.c) through "avrcp_register_player" 
(audio/avrcp.c) API. When connection is ongoing "state_changed"
callback shall be invoked with state as "AVCTP_STATE_CONNECTING" where in 
"player->session" will be initialized.


However if the "RegisterPlayer" is called after the headset connection, then 
we will not be able to send the "TrackChanged" signal with
information of "Change of track" and "Start of track". Since the headset is 
already connected,"state_changed" callback will not be
invoked, hence in the avrcp_player_event" API "player->session" is NULL.

Is it not necessary to handle the above the mentioned scenario?

Thanks and Regards
Jaganath
 

