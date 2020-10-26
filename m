Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD56C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D2522404
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/2Rm2VR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784321AbgJZPmK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:42:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40955 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784320AbgJZPmK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 11:42:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id h140so8726732qke.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=flcLSz9qqMlK5qnW6L0e21niYcKQbe4yFD+KKKfAkHs=;
        b=k/2Rm2VR6hNLG+GLmkrdg7LRARvfzYq8LShj6xymZ9BZ8y0nWyyF5nimjJakXs7666
         lrWw6qHqPEFzciHOyd6Lgv4ArTkotHbGHlqPGpmxwzQ2ctD6LJ8BdWn9SwsFs9jjX2FQ
         Mkd/cJ1p01G9SGgcAoQUvT5jP/eHeNaA3K6KQcJEiwqxj9wMp7KKlp7zpjk8IBsJPwT1
         /CqubgxM3Uu1m5ZejfSkC713JDK1T9Elhy2dMkczxli5bbY/2WAM8+IzohOHrEq0SfxR
         GsxZR/jSM42ElEM39/ExoU9fb9fRnvnyNG9KqGZH2qDJ6LSi42qqjz3I6lSnqMKByd4N
         hS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=flcLSz9qqMlK5qnW6L0e21niYcKQbe4yFD+KKKfAkHs=;
        b=EfiWwiMFFjCGssuJZr7DpBV2ySKoRERTgPAeqosoFD1Agg1d/UvtIZ7YoF3E1uKZeZ
         E8busx25XAVvwR+u1coSCI/kbLcfnaM/BSWePB+1iS5bZujIgtWu4PDAI0/UQJ8+1x7t
         P/MNhIS01HE5c3Tx7EBe53r4OLz54feQWKTgqUQjZEqoBHEOxVnb0pcZkcg3B5aHBazY
         oE4UzkvTrlWcwG0uNaXlsAP9DUK+Uy3bRe/jckzJ2rCHQEYB4r6f8o9czMEHhOVix1mR
         NUzsqBznoWdHM6eeMVi6KIJIFvApjRy960wfqApvSwT2RCYIdVs1ghqe93PbQQMKlLMM
         6xJA==
X-Gm-Message-State: AOAM5313pOvsB5KlzGky7LtedwD2i8QVEVj+3qvA4cICllO4BT/sn4ND
        c0+BsPs2Ke4LhhSwQuflRgZKGIevHJICZAkcIpLr7Kch
X-Google-Smtp-Source: ABdhPJzNRE9PMF2grNZ09xpFakpF8lT87hGNgbWivOOABHLvb2QM/ChP/k08zd15HYr6K2RIS2DQdup/j98I2uLBTis=
X-Received: by 2002:a37:641:: with SMTP id 62mr18418857qkg.473.1603726926166;
 Mon, 26 Oct 2020 08:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANX-K3v87MKJB-TCpATMP3D-RO0dSduJgSbbho4RY9TK+a-CRw@mail.gmail.com>
 <20201021221931.931878-1-marijns95@gmail.com> <CABBYNZKrJUXrfz6K5Oa7dui6ERVMZp6C6pDJWz9ZJOfwSjhMyQ@mail.gmail.com>
 <CANX-K3v_q0zU1n552EAxZff9ge+U68vuhou5MH6g9OstmL8bfA@mail.gmail.com> <CAOOgLvqeubfcOPx49s_jvf=yi4rWWe98MS-vygdczyEw0c1Oxg@mail.gmail.com>
In-Reply-To: <CAOOgLvqeubfcOPx49s_jvf=yi4rWWe98MS-vygdczyEw0c1Oxg@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Mon, 26 Oct 2020 16:41:54 +0100
Message-ID: <CANX-K3tJqXR7+8PAEO98eBdtSUyKeK-dfGZvO-5qTgRmEVMrSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio: avrcp: Split supported events between target
 and controller
To:     Marek Czerski <ma.czerski@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz, Marek,

I have to apologize upfront for prioritizing replying to Luiz' review
of this patch before checking Marek's message in the other mail
thread.  As it turns out my expectation that CT/TG are orthogonal from
the Remote Control and Remote Control Target service is completely
wrong; they are in fact analogous.  That explains all the
misunderstandings thus far.  I will revise this patch and resend it
with the new insights I have right now.

This means that the code in BlueZ currently is correct.
AVRCP_REGISTER_NOTIFICATION will only ever be sent from CT to TG,
supported_events can thus only be defined by whatever the CT service
supports (and implicitly encodes what BlueZ as TG supports; if it is
not supported, the code to add the event to supported_events simply
won't be there).  I have unfortunately lost and cannot find the
specification for older AVRCP versions anymore, but the 1.5 and 1.6.2
spec mention nothing about requiring at least version 0x104 for
Absolute Volume.  This is instead unambiguously clarified in "4.5
AVRCP specific commands": the Absolute Volume event and notification
are mandatory when CATEGORY_2 is reported.  For what it's worth I
think the sink/source distinction I tried to make in previous mails is
instead defined by these categories.

Luiz what do you reckon: is it a quirk of Android to report version
0x103 while also reporting CATEGORY_2, and is it okay to solve this by
removing the version check and enable EVENT_VOLUME_CHANGED when the C2
feature is reported by the CT?

Also, sending get_capabilities from target_init doesn't make much
sense.  If session->controller is NULL that means the remote doesn't
have the TG profile and thus can't handle the command?

Marek, I'll omit replying to most of your points after understanding
this finally, for convenience.

On Fri, 23 Oct 2020 at 10:43, Marek Czerski <ma.czerski@gmail.com> wrote:
>
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {=
Hi Marijn, Luiz,
>
> I tested this patch in a use case where bluez acts as a2dp sink and an
> andorid phone as a2dp source.
> It is working as expected.
>
> czw., 22 pa=C5=BA 2020 o 23:59 Marijn Suijten <marijns95@gmail.com> napis=
a=C5=82(a):
> >
> > Luiz,
> >
> > On Thu, 22 Oct 2020 at 22:11, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Marijn,
> > >
> > > On Wed, Oct 21, 2020 at 3:19 PM Marijn Suijten <marijns95@gmail.com> =
wrote:
> > > >
> > > > supported_events was previously initialized based on whatever the A=
V
> > > > Remote Controller profile running on the peer device could request =
based
> > > > on its version, and assumes BlueZ is running in the AV Remote Targe=
t
> > > > profile.
> > > > If however BlueZ runs the Remote Controller profile (is an audio si=
nk)
> > > > against a Remote Target profile on the peer (the audio source) this
> > > > version is incorrectly taken into account: a Remote Controller prof=
ile
> > > > on the peer is not involved in this connection.  If its version is =
too
> > > > low supported_events will not contain all events the peer might
> > > > rightfully attempt to register.
>
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {
>
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {
> > > >
> > > > This is particularly problematic with Android phones as an A2DP aud=
io
> > > > source playing back to BlueZ which is the sink.  Most Android phone=
s
> > > > report their Remote Controller profile version as 1.3 when initiali=
zing
> > > > as audio source [1] meaning that AVRCP_EVENT_VOLUME_CHANGED is
> > > > inadvertently rejected in avrcp_handle_register_notification.  As
> > > > mentioned above this profile is of no relevance to the connection, =
only
> > > > the Remote Target on the phone (source) and Remote Controller on Bl=
ueZ
> > > > (sink) take part.
> > > >
> > > > The problem is addressed by splitting supported_events in two varia=
bles:
> > > > target_supported_events containing all events the peer Remote Contr=
oller
> > > > might attempt to register with the local Remote Target profile, and
> > > > controller_supported_events containing all events the Remote Target
> > > > might attempt to register with the local Remote Controller profile.
> > > >
> > > > In addition the possible notifications going either way have been
> > > > limited.  An audio source is in control over media playback and wil=
l
> > > > never request playback state changes from the Remote Controller.
> > > > Likewise the audio sink is in control over its rendering volume and=
 will
>
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {
> > > > never have to request volume notifications from the Remote Target.
> > > > This does however still allow the Remote Controller to send playbac=
k
> > > > control messages to the source, and the Remote Target to send
> > > > SetAbsoluteVolume to the sink; both of which are not notifications.
> > > >
> > > > [1]: https://android.googlesource.com/platform/system/bt/+/android-=
11.0.0_r4/bta/av/bta_av_main.cc#761
> > > >
> > > > ---
> > > >
> > > > Hi Luiz, Marek,
> > > >
> > > > This is a preliminary version of the patch that aims to address the
> > > > issues covered in our mail thread.  Keep in mind it is "intentional=
ly"
> > > > messy; I commented out unexpected events based on logically derivin=
g the
> > > > possibilities (as described in the message above) without checking =
if
> > > > this is in accordance with the documentation.
> > > >
> > > > I still have to test this between two devices that can both run an =
audio
> > > > sink and source, such as two machines running BlueZ.  Playing back =
audio
> > > > both ways should never make this collapse on its own, though I thin=
k at
> > > > that point multiple transports are associated with a device and
> > > > media_transport_is_source would be lying, based on whichever transp=
ort
> > > > comes first in the list.  Likewise registered_events needs to be sp=
lit
> > > > in two variables as well.
> > > >
> > > > I'm not sure what's causing the race condition Marek was observing.=
  I
> > > > assume the call to avrcp_get_capabilities or avrcp_connect_browsing=
 in
> > > > controller_init triggers the peer to start requesting capabilities =
and
> > > > registering for notifications, before target_init is called (which =
would
> > > > previously be too late to initialize supported_events).  That case =
will
> > > > also be addressed in this patch, but if it happens "at random" beca=
use
> > > > the pdu handler is registered before supported_events is assigned I
> > > > propose to split session_init_control in 3 steps instead:
> > > >
> > > > 1. Retrieve remote profile versions and set up *_supported_events;
> > > > 2. Register pdu and passthrough handler;
> > > > 3. The rest from {controller,target}_init.
> > > >
> > > > Looking forward to hearing your suggestions.
> > > >
> > > > Best regards,
> > > > Marijn Suijten
> > > >
> > > >  profiles/audio/avrcp.c     | 58 +++++++++++++++++++++++++++++++---=
----
> > > >  profiles/audio/transport.c | 20 +++++++++++++
> > > >  profiles/audio/transport.h |  1 +
> > > >  3 files changed, 69 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > > index c093deac8..af5dc4212 100644
> > > > --- a/profiles/audio/avrcp.c
> > > > +++ b/profiles/audio/avrcp.c
> > > > @@ -269,7 +269,13 @@ struct avrcp {
> > > >         unsigned int control_id;
> > > >         unsigned int browsing_id;
> > > >         unsigned int browsing_timer;
> > > > -       uint16_t supported_events;
> > > > +       // TODO: Swap names to make them represent the name of the =
peer profile,
> > >
> > > Please do not use c++ tyle when commenting use /* */
> >
> > This is a preliminary patch to aid our discussions and show a
> > potential solution to the problem.  If you want to enforce commenting
> > style there as well I'll clean that up next time.  It wasn't my intent
> > to get this merged at all anyway.
> >
> > >
> > > > +       // instead of the opposite local profile?
> > > > +       /* Events the Remote Target expects based on peer Remote Co=
ntroller version */
> > > > +       uint16_t target_supported_events;
> > > > +       /* Events the Remote Controller expects based on peer Remot=
e Target version */
> > > > +       uint16_t controller_supported_events;
> > > > +       // TODO: Registered_events should be split across controlle=
r/target too!
> > > >         uint16_t registered_events;
> > >
> > > I'd prefer to have a separate struct:
> > >
> > > struct avrcp_role {
> > >         uint16_t version;
> > >         uint16_t supported_events;
> > >         uint16_t registered_events;
> > > };
> >
> > Agreed, though I don't know if we need the version. Perhaps this comes
> > in handy in other places.
> >
> > > struct avrcp {
> > > ...
> > >         struct avrcp_role ct;
> > >         struct avrcp_role tg;
> >
> > CT/TG? I've read section 2.2.1 of the 1.6.2 over and over again, this
> > doesn't make sense.

It makes sense now: we don't need to separate out *_events between CT
and TG at all.

> >
> > >
> > > >         uint8_t transaction;
> > > >         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
> > > > @@ -1060,7 +1066,7 @@ static uint8_t avrcp_handle_get_capabilities(=
struct avrcp *session,
> > > >                                                 struct avrcp_header=
 *pdu,
> > > >                                                 uint8_t transaction=
)
> > > >  {
> > > > -       uint16_t len =3D ntohs(pdu->params_len);
> > > > +       uint16_t len =3D ntohs(pdu->params_len), supported_events;
> > > >         unsigned int i;
> > > >
> > > >         if (len !=3D 1)
> > > > @@ -1068,6 +1074,11 @@ static uint8_t avrcp_handle_get_capabilities=
(struct avrcp *session,
> > > >
> > > >         DBG("id=3D%u", pdu->params[0]);
> > > >
> > > > +       if (media_transport_is_source(session->dev))
> > > > +               supported_events =3D session->target_supported_even=
ts;
> > > > +       else
> > > > +               supported_events =3D session->controller_supported_=
events;
> > >
> > > I guess you did not fully understand my comments regarding AVRCP
> > > roles, the roles are solely based on client/server, so here it is a
> > > server/target no matter the A2DP role since we are receiving a
> > > command.
> >
>
> I think that we all have correct understanding and only wording is mislea=
ding.
> What I believe Marijn wants to express in this piece of code is that:
> AVRCP_GET_CAPABILITIES command can be sent only from the peer acting
> as a CT role, but local device capabilities are depending on a2dp
> role. It means that if the local device is acting an a2dp sink role in
> this specific session it should present capabilities that it actually
> can handle as a2dp sink which is only the absolute volume. And if the
> local device is acting an a2dp source role in this specific session it
> should present capabilities for playback control such as play or
> pause.

Turns out we can and should base this information on the categories
supported by the CT instead, which _may_ loosely resemble who is able
to be source and sink.

> I'm assuming here that the scenario where both devices (local
> and peer) are acting both a2dp roles (which means that audio is
> flowing in both directions) is not realistic and maybe not even
> allowed by the specification.

I had a lot of trouble switching around source and sink on two
machines running BlueZ and pulseaudio, even after using Pali's
excellent A2DP codec work.  Tracking down and resolving these issues
took the better part of the weekend and explains why this mail is
late.

There's a proprietary "protocol" called FastStream that allows
bi-directional (SBC) audio streams but I do not have any existing
device to test volume on.  The protocol should work between two
BlueZ+PulseAudio devices but that doesn't represent any conclusive
testing.

A more realistic scenario is swapping around source and sink which
works properly after aforementioned fixes (between two devices with
speakers, running BlueZ+PulseAudio).  As expected merely the
SEP/transport is recreated, the AVRCP connection is not set up again
meaning the capabilities/features must be static.  In other words, we
can't make the distinction between A2DP sink and source profiles in
most of the code here.  We'll have to do with exposing the right
category features right from the get-go.
Other than that it appears absolute volume keeps working properly, at
least on the BlueZ side.  This requires more intricate testing after I
resolve all issues with my A2DP Absolute Volume implementation in
PulseAudio when used in conjunction with codec- and side-switching.

> Maybe renaming target_supported_events and controller_supported_events
> names for source_supported_events and sink_supported_events would be
> more readable. Because the supported events clearly depend on the a2dp
> role of the local device (and on the avrcp version of the peer).

I don't think we need to separate events out anymore.

> > Indeed, I don't understand this anymore at all.  The A2DP role should
> > map directly to the AV Remote (0x110e) and AV Remote Target (0x110c).
> No, where is that written in the specification ? A2DP sink can act
> both AVRCP roles.
>
> > It is my understanding that these define what _direction_ events could
> > possibly go in.
> Yes, "AV Remote (0x110e) and AV Remote Target (0x110c)" define the
> direction of the events.
> AV Remote (0x110e) is the one that sends commands and receives
> notifications and AV Remote Target (0x110c) is the one that receives
> commands and sends notifications.
>
> >For example in 6.13.2 SetAbsoluteVolume we find:
> >
> >     It is expected that the audio sink will perform as the TG for this =
command.
> >
> Exactly, for playback control a2dp sink plays the CT role, but for
> absolute volume it must play TG role. This is exactly proving that the
> a2dp sink role does not force avrcp role. The avrcp role depends on
> the action (playback control or volume control).
>
> > Then, in 6.13.3 Notify Volume Change:
> >
> >     This Register Notification event is used by the CT to detect when
> > the volume has been changed locally on the TG, or what the actual
> > volume level is following use of relative volume commands.
> >     [...]
> >     It is expected for this command that the audio sink fulfills the TG=
 role.
> >
> Another proof for duality of AVRCP roles. For playback control local
> device act the CT role, and for absolute volume the local device act
> TG role.
>
> > That matches what I am trying to explain in all these mails.  We
> > cannot assume in this function that we are always the server or TG;
> If we are in any of the control_handlers (for example in
> avrcp_handle_get_capabilities) we for sure are TG (AVRCP target)
> because only CT is allowed to send commands. We just don't know if we
> are a2dp source or sink.
>
> >if
> > we are the audio source, we must be the CT (when Absolute Volume is
> > concerned).
> When we are the audio source we must implement CT role for controlling
> the absolute volume, but that does not mean that in
> avrcp_handle_get_capabilities we play this role.
>
> >This is in accordance with the logical expectation that
> > the sink is in control of the volume.
> Yes, but the sink is not the one that is sending SetAbsoluteVolume
> commands, it is the source that is sending those commands.
>
> >The target (source) can change
> > it by sending SetAbsoluteVolume
> No, target cannot send commands.
>
> >, or ask the controller (sink) to
> > update it about volume changes by means of registering this event.
> No, target cannot send commands so it cannot register events on controlle=
r.
>
> > Not the other way around (what would happen if the sink starts sending
> > SetAbsoluteVolume to the source?).
> Yes, sink is not supposed to send SetAbsoluteVolume command, but the
> source act as a CT role in the context of absolute volume. I guess
> that here is the confusion.

Not really, I have always said that the CT is the sender and in case
of SetAbsoluteVolume the source is the sender. I just never made the
link between CT and the RemoteControl service as explained above.

> > What can we do to clarify the difference between CT/TG,
> > target/controller (the profiles), source/sink, client/server?
> > Terminology is going all over the place to the point that I don't know
> > how to express my understanding of the system (nor specs) anymore.
> >
> We should stick strictly to specification terminology.
> 1. target/controller are not profiles, they are roles of the AVRCP
> profile. So the profile is only one which has two roles.

1.1. CT and TG are abbreviations for the controller and target roles
respectively.

> 2. These roles are represented by the services "AV Remote (0x110e)"
> and "AV Remote Target (0x110c)" in the service records. So if one
> device is including  "AV Remote (0x110e)" service in one of its
> service records it means it can act the CT role (but this is not
> defining what a2dp role it plays !).
> 3. source/sink are the roles of the A2DP profile. So there is one A2DP
> profile with two roles.
> 4. client/server - don't use that, there is nothing like that in the
> specification.
>
> So bottom line, the way I understand this is that in case when we are
> the a2dp sink:
> 1. if we want to control playback on the a2dp source we must implement
> AVRCP CT role for sending playback commands
> 2, if we want our volume to be controlled by the a2dp source we must
> implement AVRCP TG role for receiving commands.

To clarify, I simply wasn't expecting separate services to denote
whether a peer can send or receive a command.  Indeed, it is correct
this way.

> > > >         switch (pdu->params[0]) {
> > > >         case CAP_COMPANY_ID:
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {
>
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {
>
> > > >                 for (i =3D 0; i < G_N_ELEMENTS(company_ids); i++) {
> > > > @@ -1082,7 +1093,7 @@ static uint8_t avrcp_handle_get_capabilities(=
struct avrcp *session,
> > > >         case CAP_EVENTS_SUPPORTED:
> > > >                 pdu->params[1] =3D 0;
> > > >                 for (i =3D 1; i <=3D AVRCP_EVENT_LAST; i++) {
> > > > -                       if (session->supported_events & (1 << i)) {
> > > > +                       if (supported_events & (1 << i)) {
> > > >                                 pdu->params[1]++;
> > > >                                 pdu->params[pdu->params[1] + 1] =3D=
 i;
> > > >                         }
> > > > @@ -1607,7 +1618,7 @@ static uint8_t avrcp_handle_register_notifica=
tion(struct avrcp *session,
> > > >  {
> > > >         struct avrcp_player *player =3D target_get_player(session);
> > > >         struct btd_device *dev =3D session->dev;
> > > > -       uint16_t len =3D ntohs(pdu->params_len);
> > > > +       uint16_t len =3D ntohs(pdu->params_len), supported_events;
> > > >         uint64_t uid;
> > > >         int8_t volume;
> > > >
> > > > @@ -1620,7 +1631,12 @@ static uint8_t avrcp_handle_register_notific=
ation(struct avrcp *session,
> > > >                 goto err;
> > > >
> > > >         /* Check if event is supported otherwise reject */
> > > > -       if (!(session->supported_events & (1 << pdu->params[0])))
> > > > +       if (media_transport_is_source(session->dev))
> > > > +               supported_events =3D session->target_supported_even=
ts;
> > > > +       else
> > > > +               supported_events =3D session->controller_supported_=
events;
> > > > +
> > > > +       if (!(supported_events & (1 << pdu->params[0])))
> > > >                 goto err;
> > >
> > > Ditto.
> >
> > How do you propose to figure out what "role" we are providing when
> > this function is called?  As explained above it depends if we are
> > sink/controller or source/target what events we are expecting to be
> > registered.
> >
> Here we are for sure TG because we are receiving a command. This is
> the A2DP role which is unknown and on which our capabilities depends.
> But I believe that the code here is exactly doing that, it checks if
> we are a2dp source or sink.
>
> > >
> > > >         switch (pdu->params[0]) {
> > > > @@ -4129,7 +4145,11 @@ static void target_init(struct avrcp *sessio=
n)
> > > >                 media_transport_update_device_volume(session->dev, =
init_volume);
> > > >         }
> > > >
> > > > -       session->supported_events |=3D (1 << AVRCP_EVENT_STATUS_CHA=
NGED) |
> > > > +       if (target->version < 0x0103)
> > > > +               return;
> > > > +
> > > > +       session->target_supported_events |=3D
> > > > +                               (1 << AVRCP_EVENT_STATUS_CHANGED) |
> > > >                                 (1 << AVRCP_EVENT_TRACK_CHANGED) |
> > > >                                 (1 << AVRCP_EVENT_TRACK_REACHED_STA=
RT) |
> > > >                                 (1 << AVRCP_EVENT_TRACK_REACHED_END=
) |
> > > > @@ -4138,10 +4158,13 @@ static void target_init(struct avrcp *sessi=
on)
> > > >         if (target->version < 0x0104)
> > > >                 return;
> > > >
> > > > -       session->supported_events |=3D
> > > > +       session->target_supported_events |=3D
> > > >                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_=
CHANGED) |
> > > > -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS=
_CHANGED) |
> > > > -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > > > +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS=
_CHANGED);
> > > > +                               // Does not make sense here; the re=
mote is the
> > > > +                               // rendering device and in control,=
 it'll never
> > > > +                               // request this notification.
> > > > +                               // (1 << AVRCP_EVENT_VOLUME_CHANGED=
);
> > >
> > > Again you are think the roles are based on A2DP roles when they are
> > > not, target supported events should reflect what events we support as
> > > server,
> >
> > I think you are confusing what these variables represent.  In the
> > original BlueZ code this value is based on the version of the peer
> > AVRCP_REMOTE_UUID.  That to me means we are checking whether we are
> > expecting our peer to register for that particular event, and
> > rejecting it otherwise.  I simply extended this to do the same for the
> > remote version of the AVRCP_TARGET_UUID profile as well.
> > What you are suggesting is implicitly encoded as well: if we cannot
> > handle an event registration even though the peer could realistically
> > request it based on its version, it's not in the list.
> >
> supported_events are used only when receiving commands
> (get_capabilietes or register_event) and while receiving those
> commands we play the TG role. So the peer act as CT so it should
> declare AVRCP_REMOTE_UUID(0x110e) service. So only if the peer has
> AVRCP_REMOTE_UUID declared supported_events should be initialised. If
> we are the a2dp source we should declare that we support playback
> control events. If we are a2dp sink we should declare that we support
> absolute volume event.
> So what I believe Luiz is saying is that both supported_events fields
> (target and controller or better name then source and sink) should be
> initialized in target_init.
> But then we have the problem that peer controller wants to register
> absolute volume event before target_init is called.

I guess we have to assign supported_events before setting up the pdu
handler, or at least before sending anything to the peer (like
get_capabilities in controller_init).

> I think that those supported_events should be statically initialised
> separately for a2dp sink and source roles. I cannot understand the
> need for checking the peer side avrcp version, is it against the
> specification if we declare events that are not supported by the peer
> version ? If the peer has avrcp version 1.3 and sends registration
> command of absolute volume event then the peer is not consistent with
> the specification already.

Indeed.  I asked the same question at the beginning of this mail but
want to reiterate it as it is core to the problem I tried to fix back
in January.  The 1.5 and 1.6.2 versions of the spec mention _nothing_
about the version of the peer CT profile.  Instead, absolute volume is
mandatory when the peer CT reports it is a category 2 device.

> > > so we should indicate that we support volume changed even when
> > > acting as a A2DP Source although this seems to be always omitting
> > > volume changed which would be a regression.
> >
> > It does not regress, and was tested with a bluetooth headset to
> > confirm.  This is indeed rejecting EVENT_VOLUME_CHANGED, and for a
> > good reason as explained above.  If BlueZ is the source, _it_ will
> > register this notification with the headset, not the other way around.
> > Note that get_capabilities_resp/register_notification do not check
> > *_supported_events, and they shouldn't.
> >
> > However, say we flip the roles around and make BlueZ a sink, playing
> > back from an Android phone.  Now avrcp_handle_register_notification
> > takes controller_supported_events and will happily comply when the
> > source (the Android phone) registers EVENT_VOLUME_CHANGED.
> >
> > To make this even more explicit insert some log lines in
> > get_capabilities_resp: this clearly shows when connecting headphones
> > as sink it only supports EVENT_VOLUME_CHANGED - when connecting an
> > Android phone as source it reports a bunch of playback/player related
> > events but not EVENT_VOLUME_CHANGED.
> >
> > >
> > > >         /* Only check capabilities if controller is not supported *=
/
> > > >         if (session->controller =3D=3D NULL)
> > > > @@ -4180,11 +4203,26 @@ static void controller_init(struct avrcp *s=
ession)
> > > >         if (controller->version < 0x0103)
> > > >                 return;
> > > >
> > > > -       avrcp_get_capabilities(session);
> > > > +       // Players should only run on the remote target; they
> > > > +       // should never request notifications about their own
> > > > +       // playback status.
> > > > +       // session->controller_supported_events |=3D
> > > > +       //                      (1 << AVRCP_EVENT_STATUS_CHANGED) |
> > > > +       //                      (1 << AVRCP_EVENT_TRACK_CHANGED) |
> > > > +       //                      (1 << AVRCP_EVENT_TRACK_REACHED_STA=
RT) |
> > > > +       //                      (1 << AVRCP_EVENT_TRACK_REACHED_END=
) |
> > > > +       //                      (1 << AVRCP_EVENT_SETTINGS_CHANGED)=
;
> > >
> > > The controller/client supported_events should reflect what the remote
> > > target/server supports, so here we should probably not initialize wit=
h
> > > anything (or perhaps initialize with the mandatory ones if there are
> > > any events that the spec indicates as mandatory) but read the
> > > supported events from the remote with avrcp_get_capabilities.
> >
> > I think we can initialize this list (as well as
> > target_supported_events) based on what we expect (as explained above),
> > and AND it as soon as get_capabilities_resp tells us what the remote
> > can comply with.
> >
> > > >         if (controller->version < 0x0104)
> > > >                 return;
> > > >
> > > > +       session->controller_supported_events |=3D
> > > > +                               // (1 << AVRCP_EVENT_ADDRESSED_PLAY=
ER_CHANGED) |
> > > > +                               // (1 << AVRCP_EVENT_AVAILABLE_PLAY=
ERS_CHANGED) |
> > > > +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > > > +
> > > > +       avrcp_get_capabilities(session);
> > > > +
> > > >         if (!(controller->features & AVRCP_FEATURE_BROWSING))
> > > >                 return;
> > > >
> > > > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.=
c
> > > > index 8248014ae..f5226776f 100644
> > > > --- a/profiles/audio/transport.c
> > > > +++ b/profiles/audio/transport.c
> > > > @@ -980,3 +980,23 @@ void media_transport_update_device_volume(stru=
ct btd_device *dev,
> > > >                         media_transport_update_volume(transport, vo=
lume);
> > > >         }
> > > >  }
> > > > +
> > > > +gboolean media_transport_is_source(struct btd_device *dev)
> > > > +{
> > > > +       GSList *l;
> > > > +       const char *uuid;
> > > > +
> > > > +       if (dev =3D=3D NULL)
> > > > +               return FALSE;
> > > > +
> > > > +       for (l =3D transports; l; l =3D l->next) {
> > > > +               struct media_transport *transport =3D l->data;
> > > > +               if (transport->device !=3D dev)
> > > > +                       continue;
> > > > +
> > > > +               uuid =3D media_endpoint_get_uuid(transport->endpoin=
t);
> > > > +               return strcasecmp(uuid, A2DP_SOURCE_UUID) =3D=3D 0;
> > > > +       }
> > > > +
> > > > +       return FALSE;
> > > > +}
> > > > diff --git a/profiles/audio/transport.h b/profiles/audio/transport.=
h
> > > > index 51a67ea74..eb1621813 100644
> > > > --- a/profiles/audio/transport.h
> > > > +++ b/profiles/audio/transport.h
> > > > @@ -30,3 +30,4 @@ void transport_get_properties(struct media_transp=
ort *transport,
> > > >  int8_t media_transport_get_device_volume(struct btd_device *dev);
> > > >  void media_transport_update_device_volume(struct btd_device *dev,
> > > >                                                                 int=
8_t volume);
> > > > +gboolean media_transport_is_source(struct btd_device *dev);
> > > > --
> > > > 2.29.0
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >  - Marijn
>
>
>
> --
> mgr in=C5=BC. Marek Czerski
> +48 696 842 686

- Marijn
