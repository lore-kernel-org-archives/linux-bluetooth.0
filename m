Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CF3B8D5D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555095; cv=none; b=EAXRLGL/kfHvp5jsRJJPNbR5CuNrJLhMregsFEYojeiyyGPyOKdJjmtiKJCyZ3SkbEoua37SGL0u2rSzCxdRNIl3THRIPW1xF8DM0xTiHK/+1Rf35VeymSLoF09wmM/8xUtuBTa/6lKH7E4gZ6SgZhTSp94SvQTk93gM1f578Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555095; c=relaxed/simple;
	bh=EreJvkVscMHTwfWE+ZLqdLtYQJROrFrUJNc1gNFPYM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzsodmWXswXBuC6oegEuG2UE0RVOv0GSs334Yoif9FYE95u0z9mwWaTwwHkaSYUpCmD91zUTXMCd5+1H+23B10CbkYy+a3GMaSXT4U4MkH08GA45sT1B5Cg0HBsyo7x3aFViWgG1mdGqBuDgzn7CoubU/CxY4yjlkGhf54WLSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BngAxDCl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BngAxDCl"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37e578d04b5so17000441fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 07:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765555091; x=1766159891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhiWVdICclqTnD+AumfKAHONKTFjh4RoicZdEIHzfsk=;
        b=BngAxDClZMX6vHgTsjA8el2Frq6fB08lfrZcLHQrs0fta1Ye1/bGv5tYXu1nHZpa9G
         7EycCJ5oejrcrJI8QsBVtUrx/95ltzVmBAzZ/j4LCEdJ5VE9UcLWZ80R/BELxD1AzY5d
         H5Qwhkb3PsDZ/K8ySCOts+SSZP1pTwZZv51DTiAgtAjKlTwi8sbixQyir0faxQRvyi5H
         IXhirDm2wiolyYwn/BLesVRKWyCLpc3wrW+B+fpjcTFOrjXyj2h7lnZvTswSpqSbFSza
         PQHYjyLTiraVg0Vxk/f7DHykYOS4cKSjsXAanbcFv4WcRMTmmyO14hDDmXw97vBQcYcZ
         aEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765555091; x=1766159891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhiWVdICclqTnD+AumfKAHONKTFjh4RoicZdEIHzfsk=;
        b=KJc7r1Z04KJCMozrnADCNHK4W4kajVR3xJsqeMDqyik9gs7t9R++K9n+ixeWkvZGBi
         Mp6x8vOSZZVt9g5OS20CkZG4LBm2orV+P9kyytSu5dsh6s2NLKKE/GuK3vYr3Ghf5CnT
         5zKErhfYbkq1ilh83B+0iFZ9SpxQHmt9BQ/N14sirEbuFIxfSIylwanKLUvSTwcBNWka
         EfQh/x6fefpjVRYoSnHpOZGQOAOUVm7t6m7m+02lpADLwUGMzE72j0fsT0WgIutH33gJ
         OUWkYCSc2QMiJl03No7tX5ShMN2PBJzarg5Sl3/ZXHaEkIKE1hgyp3OjYBQU2jTLj0mK
         zsDg==
X-Gm-Message-State: AOJu0YxvAOxx9+4Oa9awvBCjsufTO7zvqnY8Aikht3OolwGO2hFY8r37
	ivM1g0qpFAW/wB47gQhxEtrcZfkiU5u4X067o74NJYeeQSVJw/+uguPniamRRkVRiJgGbnWGRgN
	8915YqDZFYiua9g6wz6bCTek0AfRPqL8=
X-Gm-Gg: AY/fxX7SE8awdPFwOh5+z+QAh4H2x3WYJDfjlAhMtQcblDd4rXSeqa9dvSPyU2AeEBP
	Ap2O2RWa3Rdn98J9napKtKyo3bMDGAtr8AL63czv3FlJfp8kRWNigCKQ3xzzwgrhOBAxNMNXEpE
	hpiArKEE9XmNtmwi4DOgRn4jkJqQ4kpvEHpARUErq4uCFp+BE7WY5EBIAEKWqViUnlhT8aGobJS
	Iy1vRPW9omwo28aTqveMt7PJ0MaBenaAnif2Jl16EyfS68sVIT4rdLQrGqiPpv+vE8p5w==
X-Google-Smtp-Source: AGHT+IGHIjqz+IUzm7tYdxAVg2N7l/SbgHqBkpIt4IchqstM0wDmAM7JMHa9yETZ47x0GZ1nee4rd4EPRRoIG4R4GOE=
X-Received: by 2002:a05:651c:19a6:b0:37f:b2d7:8a0e with SMTP id
 38308e7fff4ca-37fd070b348mr7361251fa.5.1765555090455; Fri, 12 Dec 2025
 07:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765484150.git.pav@iki.fi> <f343a41406876428005288982a73bc20ae5d10b7.1765484150.git.pav@iki.fi>
 <CABBYNZJq4A+SgGsk6HiGx-ydfGikpqW5O_W4o72efgGr9mYYUA@mail.gmail.com> <278086C1-29C0-4AC6-9044-114D128DFC5D@iki.fi>
In-Reply-To: <278086C1-29C0-4AC6-9044-114D128DFC5D@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Dec 2025 10:57:58 -0500
X-Gm-Features: AQt7F2pzzApyH3FN9OHD6Fd16XnX4a88lYe9DLv63nK891gHFV7-utwM2eSBQK0
Message-ID: <CABBYNZJpaTRJ3F8ZtMqj48YAqPo34AGEkR0nmjMPKEQH=2QS+A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 1/7] shared/mcp: support multiple MCP, and add
 non-stub MCS server
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Dec 12, 2025 at 10:50=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
>
>
> 12. joulukuuta 2025 15.17.18 UTC Luiz Augusto von Dentz <luiz.dentz@gmail=
.com> kirjoitti:
> >Hi Pauli,
> >
> >On Thu, Dec 11, 2025 at 3:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >>
> >> For Media Control Client, add support for multiple GMCS / MCS services
> >> on the server. Revise the API accordingly.
> >>
> >> For Media Control Server, make it a complete implementation (OTS still
> >> missing), and add an API the profile can use.
> >>
> >> This is mostly a complete rewrite.
> >> ---
> >>  lib/bluetooth/uuid.h |   27 +-
> >>  src/shared/mcp.c     | 3216 ++++++++++++++++++++++++-----------------=
-
> >>  src/shared/mcp.h     |  186 ++-
> >>  src/shared/mcs.h     |   51 +-
> >>  4 files changed, 2086 insertions(+), 1394 deletions(-)
> >>
> >> diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
> >> index 805366c3d..74bd83742 100644
> >> --- a/lib/bluetooth/uuid.h
> >> +++ b/lib/bluetooth/uuid.h
> >> @@ -198,20 +198,21 @@ extern "C" {
> >>  #define        AICS_AUDIO_INPUT_CP_CHRC_UUID           0X2B7B
> >>  #define        AICS_INPUT_DESCR_CHAR_UUID              0X2B7C
> >>
> >> +#define MCS_UUID
>
> [clip]
>
> >>  /* MCP Control Point Opcodes */
> >>  #define BT_MCS_CMD_PLAY                            0x01
> >> --
> >> 2.51.1
> >
> >There quite a few build errors when build each patch:
>
> Yes, this is known as noted in cover letter, the profile is updated in th=
e later patch, as there are significant API changes.
>
> If it is a requirement that individual patches have to produce buildable =
state, easiest fix would be to combine the shared/mcp: and  mcp: commits. A=
nother would be to remove the earlier profile/mcp.c first.

Yep, in fact the CI should actually check that but it seems it doesn't
for some reason.

> I suppose one could invent intermediate series of changes to arrive at th=
e same code. Not sure much is gained, given the initial implementation was =
not complete.
>
> What do you prefer?

I guess squashing the changes would be better, that is how I normally
address the building of each commit individually.

> >
> >profiles/audio/mcp.c: In function =E2=80=98mcp_status_val_to_string=E2=
=80=99:
> >profiles/audio/mcp.c:91:14: error: =E2=80=98BT_MCS_STATUS_PLAYING=E2=80=
=99 undeclared
> >(first use in this function); did you mean =E2=80=98BT_MCS_STATE_PLAYING=
=E2=80=99?
> >   91 |         case BT_MCS_STATUS_PLAYING:
> >      |              ^~~~~~~~~~~~~~~~~~~~~
> >      |              BT_MCS_STATE_PLAYING
> >profiles/audio/mcp.c:91:14: note: each undeclared identifier is
> >reported only once for each function it appears in
> >profiles/audio/mcp.c:93:14: error: =E2=80=98BT_MCS_STATUS_PAUSED=E2=80=
=99 undeclared
> >(first use in this function); did you mean =E2=80=98BT_MCS_STATE_PAUSED=
=E2=80=99?
> >   93 |         case BT_MCS_STATUS_PAUSED:
> >      |              ^~~~~~~~~~~~~~~~~~~~
> >      |              BT_MCS_STATE_PAUSED
> >profiles/audio/mcp.c:95:14: error: =E2=80=98BT_MCS_STATUS_INACTIVE=E2=80=
=99 undeclared
> >(first use in this function); did you mean =E2=80=98BT_MCS_STATE_INACTIV=
E=E2=80=99?
> >   95 |         case BT_MCS_STATUS_INACTIVE:
> >      |              ^~~~~~~~~~~~~~~~~~~~~~
> >      |              BT_MCS_STATE_INACTIVE
> >profiles/audio/mcp.c:97:14: error: =E2=80=98BT_MCS_STATUS_SEEKING=E2=80=
=99 undeclared
> >(first use in this function); did you mean =E2=80=98BT_MCS_STATE_SEEKING=
=E2=80=99?
> >   97 |         case BT_MCS_STATUS_SEEKING:
> >      |              ^~~~~~~~~~~~~~~~~~~~~
> >      |              BT_MCS_STATE_SEEKING
> >profiles/audio/mcp.c: In function =E2=80=98cb_player_name=E2=80=99:
> >profiles/audio/mcp.c:121:35: error: implicit declaration of function
> >=E2=80=98bt_mcp_get_user_data=E2=80=99; did you mean =E2=80=98btd_servic=
e_get_user_data=E2=80=99?
> >[-Wimplicit-function-declaration]
> >  121 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> >      |                                   ^~~~~~~~~~~~~~~~~~~~
> >      |                                   btd_service_get_user_data
> >profiles/audio/mcp.c:121:35: error: initialization of =E2=80=98struct
> >media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from in=
teger without a cast
> >[-Wint-conversion]
> >profiles/audio/mcp.c: In function =E2=80=98cb_track_title=E2=80=99:
> >profiles/audio/mcp.c:144:35: error: initialization of =E2=80=98struct
> >media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from in=
teger without a cast
> >[-Wint-conversion]
> >  144 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> >      |                                   ^~~~~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98cb_track_duration=E2=80=99:
> >profiles/audio/mcp.c:159:35: error: initialization of =E2=80=98struct
> >media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from in=
teger without a cast
> >[-Wint-conversion]
> >  159 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> >      |                                   ^~~~~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98cb_track_position=E2=80=99:
> >profiles/audio/mcp.c:170:35: error: initialization of =E2=80=98struct
> >media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from in=
teger without a cast
> >[-Wint-conversion]
> >  170 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> >      |                                   ^~~~~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98cb_media_state=E2=80=99:
> >profiles/audio/mcp.c:178:35: error: initialization of =E2=80=98struct
> >media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from in=
teger without a cast
> >[-Wint-conversion]
> >  178 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
> >      |                                   ^~~~~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c: At top level:
> >profiles/audio/mcp.c:183:21: error: variable =E2=80=98cbs=E2=80=99 has i=
nitializer but
> >incomplete type
> >  183 | static const struct bt_mcp_event_callback cbs =3D {
> >      |                     ^~~~~~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c:184:10: error: =E2=80=98const struct
> >bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98player_name=
=E2=80=99
> >  184 |         .player_name                    =3D cb_player_name,
> >      |          ^~~~~~~~~~~
> >profiles/audio/mcp.c:184:43: error: excess elements in struct
> >initializer [-Werror]
> >  184 |         .player_name                    =3D cb_player_name,
> >      |                                           ^~~~~~~~~~~~~~
> >profiles/audio/mcp.c:184:43: note: (near initialization for =E2=80=98cbs=
=E2=80=99)
> >profiles/audio/mcp.c:185:10: error: =E2=80=98const struct
> >bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_change=
d=E2=80=99
> >  185 |         .track_changed                  =3D cb_track_changed,
> >      |          ^~~~~~~~~~~~~
> >profiles/audio/mcp.c:185:43: error: excess elements in struct
> >initializer [-Werror]
> >  185 |         .track_changed                  =3D cb_track_changed,
> >      |                                           ^~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c:185:43: note: (near initialization for =E2=80=98cbs=
=E2=80=99)
> >profiles/audio/mcp.c:186:10: error: =E2=80=98const struct
> >bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_title=
=E2=80=99
> >  186 |         .track_title                    =3D cb_track_title,
> >      |          ^~~~~~~~~~~
> >profiles/audio/mcp.c:186:43: error: excess elements in struct
> >initializer [-Werror]
> >  186 |         .track_title                    =3D cb_track_title,
> >      |                                           ^~~~~~~~~~~~~~
> >profiles/audio/mcp.c:186:43: note: (near initialization for =E2=80=98cbs=
=E2=80=99)
> >profiles/audio/mcp.c:187:10: error: =E2=80=98const struct
> >bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_durati=
on=E2=80=99
> >  187 |         .track_duration                 =3D cb_track_duration,
> >      |          ^~~~~~~~~~~~~~
> >profiles/audio/mcp.c:187:43: error: excess elements in struct
> >initializer [-Werror]
> >  187 |         .track_duration                 =3D cb_track_duration,
> >      |                                           ^~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c:187:43: note: (near initialization for =E2=80=98cbs=
=E2=80=99)
> >profiles/audio/mcp.c:188:10: error: =E2=80=98const struct
> >bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_positi=
on=E2=80=99
> >  188 |         .track_position                 =3D cb_track_position,
> >      |          ^~~~~~~~~~~~~~
> >profiles/audio/mcp.c:188:43: error: excess elements in struct
> >initializer [-Werror]
> >  188 |         .track_position                 =3D cb_track_position,
> >      |                                           ^~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c:188:43: note: (near initialization for =E2=80=98cbs=
=E2=80=99)
> >profiles/audio/mcp.c:189:10: error: =E2=80=98const struct
> >bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98media_state=
=E2=80=99
> >  189 |         .media_state                    =3D cb_media_state,
> >      |          ^~~~~~~~~~~
> >profiles/audio/mcp.c:189:43: error: excess elements in struct
> >initializer [-Werror]
> >  189 |         .media_state                    =3D cb_media_state,
> >      |                                           ^~~~~~~~~~~~~~
> >profiles/audio/mcp.c:189:43: note: (near initialization for =E2=80=98cbs=
=E2=80=99)
> >profiles/audio/mcp.c: In function =E2=80=98ct_play=E2=80=99:
> >profiles/audio/mcp.c:196:16: error: too few arguments to function
> >=E2=80=98bt_mcp_play=E2=80=99; expected 2, have 1
> >  196 |         return bt_mcp_play(mcp);
> >      |                ^~~~~~~~~~~
> >In file included from profiles/audio/mcp.c:42:
> >./src/shared/mcp.h:56:14: note: declared here
> >   56 | unsigned int bt_mcp_play(struct bt_mcp *mcp, uint8_t ccid);
> >      |              ^~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98ct_pause=E2=80=99:
> >profiles/audio/mcp.c:203:16: error: too few arguments to function
> >=E2=80=98bt_mcp_pause=E2=80=99; expected 2, have 1
> >  203 |         return bt_mcp_pause(mcp);
> >      |                ^~~~~~~~~~~~
> >./src/shared/mcp.h:57:14: note: declared here
> >   57 | unsigned int bt_mcp_pause(struct bt_mcp *mcp, uint8_t ccid);
> >      |              ^~~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98ct_stop=E2=80=99:
> >profiles/audio/mcp.c:210:16: error: too few arguments to function
> >=E2=80=98bt_mcp_stop=E2=80=99; expected 2, have 1
> >  210 |         return bt_mcp_stop(mcp);
> >      |                ^~~~~~~~~~~
> >./src/shared/mcp.h:60:14: note: declared here
> >   60 | unsigned int bt_mcp_stop(struct bt_mcp *mcp, uint8_t ccid);
> >      |              ^~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98ct_next=E2=80=99:
> >profiles/audio/mcp.c:217:16: error: too few arguments to function
> >=E2=80=98bt_mcp_next_track=E2=80=99; expected 2, have 1
> >  217 |         return bt_mcp_next_track(mcp);
> >      |                ^~~~~~~~~~~~~~~~~
> >./src/shared/mcp.h:71:14: note: declared here
> >   71 | unsigned int bt_mcp_next_track(struct bt_mcp *mcp, uint8_t ccid)=
;
> >      |              ^~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98ct_previous=E2=80=99:
> >profiles/audio/mcp.c:224:16: error: too few arguments to function
> >=E2=80=98bt_mcp_previous_track=E2=80=99; expected 2, have 1
> >  224 |         return bt_mcp_previous_track(mcp);
> >      |                ^~~~~~~~~~~~~~~~~~~~~
> >./src/shared/mcp.h:70:14: note: declared here
> >   70 | unsigned int bt_mcp_previous_track(struct bt_mcp *mcp, uint8_t c=
cid);
> >      |              ^~~~~~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98mcp_probe=E2=80=99:
> >profiles/audio/mcp.c:255:21: error: implicit declaration of function
> >=E2=80=98bt_mcp_new=E2=80=99; did you mean =E2=80=98bt_att_new=E2=80=99?
> >[-Wimplicit-function-declaration]
> >  255 |         data->mcp =3D bt_mcp_new(btd_gatt_database_get_db(databa=
se),
> >      |                     ^~~~~~~~~~
> >      |                     bt_att_new
> >profiles/audio/mcp.c:255:19: error: assignment to =E2=80=98struct bt_mcp=
 *=E2=80=99
> >from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
> >[-Wint-conversion]
> >  255 |         data->mcp =3D bt_mcp_new(btd_gatt_database_get_db(databa=
se),
> >      |                   ^
> >profiles/audio/mcp.c:258:9: error: implicit declaration of function
> >=E2=80=98bt_mcp_set_debug=E2=80=99; did you mean =E2=80=98bt_att_set_deb=
ug=E2=80=99?
> >[-Wimplicit-function-declaration]
> >  258 |         bt_mcp_set_debug(data->mcp, mcp_debug, NULL, NULL);
> >      |         ^~~~~~~~~~~~~~~~
> >      |         bt_att_set_debug
> >profiles/audio/mcp.c: In function =E2=80=98mcp_data_free=E2=80=99:
> >profiles/audio/mcp.c:270:17: error: implicit declaration of function
> >=E2=80=98bt_mcp_set_user_data=E2=80=99; did you mean =E2=80=98btd_servic=
e_set_user_data=E2=80=99?
> >[-Wimplicit-function-declaration]
> >  270 |                 bt_mcp_set_user_data(data->mcp, NULL);
> >      |                 ^~~~~~~~~~~~~~~~~~~~
> >      |                 btd_service_set_user_data
> >profiles/audio/mcp.c:278:9: error: implicit declaration of function
> >=E2=80=98bt_mcp_unref=E2=80=99; did you mean =E2=80=98bt_att_unref=E2=80=
=99?
> >[-Wimplicit-function-declaration]
> >  278 |         bt_mcp_unref(data->mcp);
> >      |         ^~~~~~~~~~~~
> >      |         bt_att_unref
> >profiles/audio/mcp.c: In function =E2=80=98mcp_accept=E2=80=99:
> >profiles/audio/mcp.c:317:27: error: passing argument 1 of
> >=E2=80=98bt_mcp_attach=E2=80=99 from incompatible pointer type
> >[-Wincompatible-pointer-types]
> >  317 |         bt_mcp_attach(data->mcp, client);
> >      |                       ~~~~^~~~~
> >      |                           |
> >      |                           struct bt_mcp *
> >./src/shared/mcp.h:96:53: note: expected =E2=80=98struct bt_gatt_client =
*=E2=80=99 but
> >argument is of type =E2=80=98struct bt_mcp *=E2=80=99
> >   96 | struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool=
 gmcs,
> >      |                              ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> >profiles/audio/mcp.c:317:9: error: too few arguments to function
> >=E2=80=98bt_mcp_attach=E2=80=99; expected 4, have 2
> >  317 |         bt_mcp_attach(data->mcp, client);
> >      |         ^~~~~~~~~~~~~
> >./src/shared/mcp.h:96:16: note: declared here
> >   96 | struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool=
 gmcs,
> >      |                ^~~~~~~~~~~~~
> >profiles/audio/mcp.c:329:9: error: implicit declaration of function
> >=E2=80=98bt_mcp_set_event_callbacks=E2=80=99 [-Wimplicit-function-declar=
ation]
> >  329 |         bt_mcp_set_event_callbacks(data->mcp, &cbs, data->mp);
> >      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >profiles/audio/mcp.c: In function =E2=80=98media_control_server_probe=E2=
=80=99:
> >profiles/audio/mcp.c:372:9: error: implicit declaration of function
> >=E2=80=98bt_mcp_register=E2=80=99; did you mean =E2=80=98bt_mcs_register=
=E2=80=99?
> >[-Wimplicit-function-declaration]
> >  372 |         bt_mcp_register(btd_gatt_database_get_db(database));
> >      |         ^~~~~~~~~~~~~~~
> >      |         bt_mcs_register
> >profiles/audio/mcp.c: At top level:
> >profiles/audio/mcp.c:183:43: error: storage size of =E2=80=98cbs=E2=80=
=99 isn=E2=80=99t known
> >  183 | static const struct bt_mcp_event_callback cbs =3D {
> >      |                                           ^~~
> >cc1: all warnings being treated as errors
> >
> >It looks like it is only fixed in the follow up changes, which means
> >it breaks the likes of bisect.
> >



--=20
Luiz Augusto von Dentz
