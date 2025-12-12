Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79268258ED5
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554651; cv=pass; b=ltJQvisWB6hCzvCxX2H/WhyZ2Oy4B9prjJZ2ysmmTL3nhNp965740pfWWvRdsozFFAyiY8XRNF1BbThoub5W00F2FOlZ43vM0jX/H+84lhu4Qv/9vKWACZ85Pb2f/UKClJmIbYLt4NkvKjbWjPVFNvqnXBdrpCEATOc5BWWkjdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554651; c=relaxed/simple;
	bh=+x7Ehlibrl6F6wZJDIJ6z1pncPtJiBrzF0mGlpsHGEU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LzENF8YaHau7c1EiKsK/b3b2CrTohdSbsWuoS+1MJKW0b9OWRSQOWfWcib8Ij3ctcyQ0pkZRGqiHM1M+myIjSltRG/66QHbw1RzN+hXZzGA9ooExsRZFuPMDaeWO6V4mWlcgtVaVwrqvzTvZO0BFkqqI66HJkY985gvCbVdokA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=EWhpJmzt; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="EWhpJmzt"
Received: from ehlo.thunderbird.net (unknown [193.138.7.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dSYnr6FVQzyYC;
	Fri, 12 Dec 2025 17:50:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765554641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3n+ZCJ4GwxI/C4JkJ7U+chW+2NynYWEmwQZllF9N4qs=;
	b=EWhpJmztlGivPyuwDSkgRMhtwHZlTq73opBe1aG5dmL0eL4lHuVTnmJsym6vIIBYj+CYwS
	NhpqyOLU5jJYgEH9UqRT8Kne5bqxVAK5zwXk9S8JvKdegVz/CXVAp1BduQa/8VBZiHCCsq
	uFNMSCAC+ISMUD+Pt5/iQkuLSrILp1Y=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765554641;
	b=r691K+wRVZKtXrI2WzJPFQ63RFQzcdz/FNY2gxDllbKpsbzV6iCR+OajUbR480S/3+PH/x
	nAB9mabuuxk4jqJRQ0Zwqm5idiFJvkqQpAAhQ59kCr/33JMkt3fUEYom0coQ7OsT0abA6+
	tqJBYggbDc7IN0QtF3ITvt48XxlOcO0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765554641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3n+ZCJ4GwxI/C4JkJ7U+chW+2NynYWEmwQZllF9N4qs=;
	b=we6kp+XzpIrN6FyGjk8N0T7Xa836Qk6Zf+BM2eXZ3Zgl09HtwjTb1SSQtFyDHd+aZCMuf7
	8MOaSCpOm2/7h73fiDCncejUYP8gUoMJQ2XWldbxS6rmjG8ZA/TnfuhvMjZ7NxAEcxqFqN
	GgKnzxVEu+u6ynBbO0V42IRXQxTvJ6Q=
Date: Fri, 12 Dec 2025 15:50:40 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_BlueZ_v5_1/7=5D_shared/mcp=3A_suppor?=
 =?US-ASCII?Q?t_multiple_MCP=2C_and_add_non-stub_MCS_server?=
In-Reply-To: <CABBYNZJq4A+SgGsk6HiGx-ydfGikpqW5O_W4o72efgGr9mYYUA@mail.gmail.com>
References: <cover.1765484150.git.pav@iki.fi> <f343a41406876428005288982a73bc20ae5d10b7.1765484150.git.pav@iki.fi> <CABBYNZJq4A+SgGsk6HiGx-ydfGikpqW5O_W4o72efgGr9mYYUA@mail.gmail.com>
Message-ID: <278086C1-29C0-4AC6-9044-114D128DFC5D@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



12=2E joulukuuta 2025 15=2E17=2E18 UTC Luiz Augusto von Dentz <luiz=2Edent=
z@gmail=2Ecom> kirjoitti:
>Hi Pauli,
>
>On Thu, Dec 11, 2025 at 3:16=E2=80=AFPM Pauli Virtanen <pav@iki=2Efi> wro=
te:
>>
>> For Media Control Client, add support for multiple GMCS / MCS services
>> on the server=2E Revise the API accordingly=2E
>>
>> For Media Control Server, make it a complete implementation (OTS still
>> missing), and add an API the profile can use=2E
>>
>> This is mostly a complete rewrite=2E
>> ---
>>  lib/bluetooth/uuid=2Eh |   27 +-
>>  src/shared/mcp=2Ec     | 3216 ++++++++++++++++++++++++----------------=
--
>>  src/shared/mcp=2Eh     |  186 ++-
>>  src/shared/mcs=2Eh     |   51 +-
>>  4 files changed, 2086 insertions(+), 1394 deletions(-)
>>
>> diff --git a/lib/bluetooth/uuid=2Eh b/lib/bluetooth/uuid=2Eh
>> index 805366c3d=2E=2E74bd83742 100644
>> --- a/lib/bluetooth/uuid=2Eh
>> +++ b/lib/bluetooth/uuid=2Eh
>> @@ -198,20 +198,21 @@ extern "C" {
>>  #define        AICS_AUDIO_INPUT_CP_CHRC_UUID           0X2B7B
>>  #define        AICS_INPUT_DESCR_CHAR_UUID              0X2B7C
>>
>> +#define MCS_UUID                =20
              =20
[clip]

>>  /* MCP Control Point Opcodes */
>>  #define BT_MCS_CMD_PLAY                            0x01
>> --
>> 2=2E51=2E1
>
>There quite a few build errors when build each patch:

Yes, this is known as noted in cover letter, the profile is updated in the=
 later patch, as there are significant API changes=2E

If it is a requirement that individual patches have to produce buildable s=
tate, easiest fix would be to combine the shared/mcp: and  mcp: commits=2E =
Another would be to remove the earlier profile/mcp=2Ec first=2E

I suppose one could invent intermediate series of changes to arrive at the=
 same code=2E Not sure much is gained, given the initial implementation was=
 not complete=2E=20

What do you prefer?

>
>profiles/audio/mcp=2Ec: In function =E2=80=98mcp_status_val_to_string=E2=
=80=99:
>profiles/audio/mcp=2Ec:91:14: error: =E2=80=98BT_MCS_STATUS_PLAYING=E2=80=
=99 undeclared
>(first use in this function); did you mean =E2=80=98BT_MCS_STATE_PLAYING=
=E2=80=99?
>   91 |         case BT_MCS_STATUS_PLAYING:
>      |              ^~~~~~~~~~~~~~~~~~~~~
>      |              BT_MCS_STATE_PLAYING
>profiles/audio/mcp=2Ec:91:14: note: each undeclared identifier is
>reported only once for each function it appears in
>profiles/audio/mcp=2Ec:93:14: error: =E2=80=98BT_MCS_STATUS_PAUSED=E2=80=
=99 undeclared
>(first use in this function); did you mean =E2=80=98BT_MCS_STATE_PAUSED=
=E2=80=99?
>   93 |         case BT_MCS_STATUS_PAUSED:
>      |              ^~~~~~~~~~~~~~~~~~~~
>      |              BT_MCS_STATE_PAUSED
>profiles/audio/mcp=2Ec:95:14: error: =E2=80=98BT_MCS_STATUS_INACTIVE=E2=
=80=99 undeclared
>(first use in this function); did you mean =E2=80=98BT_MCS_STATE_INACTIVE=
=E2=80=99?
>   95 |         case BT_MCS_STATUS_INACTIVE:
>      |              ^~~~~~~~~~~~~~~~~~~~~~
>      |              BT_MCS_STATE_INACTIVE
>profiles/audio/mcp=2Ec:97:14: error: =E2=80=98BT_MCS_STATUS_SEEKING=E2=80=
=99 undeclared
>(first use in this function); did you mean =E2=80=98BT_MCS_STATE_SEEKING=
=E2=80=99?
>   97 |         case BT_MCS_STATUS_SEEKING:
>      |              ^~~~~~~~~~~~~~~~~~~~~
>      |              BT_MCS_STATE_SEEKING
>profiles/audio/mcp=2Ec: In function =E2=80=98cb_player_name=E2=80=99:
>profiles/audio/mcp=2Ec:121:35: error: implicit declaration of function
>=E2=80=98bt_mcp_get_user_data=E2=80=99; did you mean =E2=80=98btd_service=
_get_user_data=E2=80=99?
>[-Wimplicit-function-declaration]
>  121 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
>      |                                   ^~~~~~~~~~~~~~~~~~~~
>      |                                   btd_service_get_user_data
>profiles/audio/mcp=2Ec:121:35: error: initialization of =E2=80=98struct
>media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cast
>[-Wint-conversion]
>profiles/audio/mcp=2Ec: In function =E2=80=98cb_track_title=E2=80=99:
>profiles/audio/mcp=2Ec:144:35: error: initialization of =E2=80=98struct
>media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cast
>[-Wint-conversion]
>  144 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
>      |                                   ^~~~~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98cb_track_duration=E2=80=99:
>profiles/audio/mcp=2Ec:159:35: error: initialization of =E2=80=98struct
>media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cast
>[-Wint-conversion]
>  159 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
>      |                                   ^~~~~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98cb_track_position=E2=80=99:
>profiles/audio/mcp=2Ec:170:35: error: initialization of =E2=80=98struct
>media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cast
>[-Wint-conversion]
>  170 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
>      |                                   ^~~~~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98cb_media_state=E2=80=99:
>profiles/audio/mcp=2Ec:178:35: error: initialization of =E2=80=98struct
>media_player *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cast
>[-Wint-conversion]
>  178 |         struct media_player *mp =3D bt_mcp_get_user_data(mcp);
>      |                                   ^~~~~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec: At top level:
>profiles/audio/mcp=2Ec:183:21: error: variable =E2=80=98cbs=E2=80=99 has =
initializer but
>incomplete type
>  183 | static const struct bt_mcp_event_callback cbs =3D {
>      |                     ^~~~~~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:184:10: error: =E2=80=98const struct
>bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98player_name=
=E2=80=99
>  184 |         =2Eplayer_name                    =3D cb_player_name,
>      |          ^~~~~~~~~~~
>profiles/audio/mcp=2Ec:184:43: error: excess elements in struct
>initializer [-Werror]
>  184 |         =2Eplayer_name                    =3D cb_player_name,
>      |                                           ^~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:184:43: note: (near initialization for =E2=80=98cb=
s=E2=80=99)
>profiles/audio/mcp=2Ec:185:10: error: =E2=80=98const struct
>bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_changed=
=E2=80=99
>  185 |         =2Etrack_changed                  =3D cb_track_changed,
>      |          ^~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:185:43: error: excess elements in struct
>initializer [-Werror]
>  185 |         =2Etrack_changed                  =3D cb_track_changed,
>      |                                           ^~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:185:43: note: (near initialization for =E2=80=98cb=
s=E2=80=99)
>profiles/audio/mcp=2Ec:186:10: error: =E2=80=98const struct
>bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_title=
=E2=80=99
>  186 |         =2Etrack_title                    =3D cb_track_title,
>      |          ^~~~~~~~~~~
>profiles/audio/mcp=2Ec:186:43: error: excess elements in struct
>initializer [-Werror]
>  186 |         =2Etrack_title                    =3D cb_track_title,
>      |                                           ^~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:186:43: note: (near initialization for =E2=80=98cb=
s=E2=80=99)
>profiles/audio/mcp=2Ec:187:10: error: =E2=80=98const struct
>bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_duratio=
n=E2=80=99
>  187 |         =2Etrack_duration                 =3D cb_track_duration,
>      |          ^~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:187:43: error: excess elements in struct
>initializer [-Werror]
>  187 |         =2Etrack_duration                 =3D cb_track_duration,
>      |                                           ^~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:187:43: note: (near initialization for =E2=80=98cb=
s=E2=80=99)
>profiles/audio/mcp=2Ec:188:10: error: =E2=80=98const struct
>bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98track_positio=
n=E2=80=99
>  188 |         =2Etrack_position                 =3D cb_track_position,
>      |          ^~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:188:43: error: excess elements in struct
>initializer [-Werror]
>  188 |         =2Etrack_position                 =3D cb_track_position,
>      |                                           ^~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:188:43: note: (near initialization for =E2=80=98cb=
s=E2=80=99)
>profiles/audio/mcp=2Ec:189:10: error: =E2=80=98const struct
>bt_mcp_event_callback=E2=80=99 has no member named =E2=80=98media_state=
=E2=80=99
>  189 |         =2Emedia_state                    =3D cb_media_state,
>      |          ^~~~~~~~~~~
>profiles/audio/mcp=2Ec:189:43: error: excess elements in struct
>initializer [-Werror]
>  189 |         =2Emedia_state                    =3D cb_media_state,
>      |                                           ^~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:189:43: note: (near initialization for =E2=80=98cb=
s=E2=80=99)
>profiles/audio/mcp=2Ec: In function =E2=80=98ct_play=E2=80=99:
>profiles/audio/mcp=2Ec:196:16: error: too few arguments to function
>=E2=80=98bt_mcp_play=E2=80=99; expected 2, have 1
>  196 |         return bt_mcp_play(mcp);
>      |                ^~~~~~~~~~~
>In file included from profiles/audio/mcp=2Ec:42:
>=2E/src/shared/mcp=2Eh:56:14: note: declared here
>   56 | unsigned int bt_mcp_play(struct bt_mcp *mcp, uint8_t ccid);
>      |              ^~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98ct_pause=E2=80=99:
>profiles/audio/mcp=2Ec:203:16: error: too few arguments to function
>=E2=80=98bt_mcp_pause=E2=80=99; expected 2, have 1
>  203 |         return bt_mcp_pause(mcp);
>      |                ^~~~~~~~~~~~
>=2E/src/shared/mcp=2Eh:57:14: note: declared here
>   57 | unsigned int bt_mcp_pause(struct bt_mcp *mcp, uint8_t ccid);
>      |              ^~~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98ct_stop=E2=80=99:
>profiles/audio/mcp=2Ec:210:16: error: too few arguments to function
>=E2=80=98bt_mcp_stop=E2=80=99; expected 2, have 1
>  210 |         return bt_mcp_stop(mcp);
>      |                ^~~~~~~~~~~
>=2E/src/shared/mcp=2Eh:60:14: note: declared here
>   60 | unsigned int bt_mcp_stop(struct bt_mcp *mcp, uint8_t ccid);
>      |              ^~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98ct_next=E2=80=99:
>profiles/audio/mcp=2Ec:217:16: error: too few arguments to function
>=E2=80=98bt_mcp_next_track=E2=80=99; expected 2, have 1
>  217 |         return bt_mcp_next_track(mcp);
>      |                ^~~~~~~~~~~~~~~~~
>=2E/src/shared/mcp=2Eh:71:14: note: declared here
>   71 | unsigned int bt_mcp_next_track(struct bt_mcp *mcp, uint8_t ccid);
>      |              ^~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98ct_previous=E2=80=99:
>profiles/audio/mcp=2Ec:224:16: error: too few arguments to function
>=E2=80=98bt_mcp_previous_track=E2=80=99; expected 2, have 1
>  224 |         return bt_mcp_previous_track(mcp);
>      |                ^~~~~~~~~~~~~~~~~~~~~
>=2E/src/shared/mcp=2Eh:70:14: note: declared here
>   70 | unsigned int bt_mcp_previous_track(struct bt_mcp *mcp, uint8_t cc=
id);
>      |              ^~~~~~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98mcp_probe=E2=80=99:
>profiles/audio/mcp=2Ec:255:21: error: implicit declaration of function
>=E2=80=98bt_mcp_new=E2=80=99; did you mean =E2=80=98bt_att_new=E2=80=99?
>[-Wimplicit-function-declaration]
>  255 |         data->mcp =3D bt_mcp_new(btd_gatt_database_get_db(databas=
e),
>      |                     ^~~~~~~~~~
>      |                     bt_att_new
>profiles/audio/mcp=2Ec:255:19: error: assignment to =E2=80=98struct bt_mc=
p *=E2=80=99
>from =E2=80=98int=E2=80=99 makes pointer from integer without a cast
>[-Wint-conversion]
>  255 |         data->mcp =3D bt_mcp_new(btd_gatt_database_get_db(databas=
e),
>      |                   ^
>profiles/audio/mcp=2Ec:258:9: error: implicit declaration of function
>=E2=80=98bt_mcp_set_debug=E2=80=99; did you mean =E2=80=98bt_att_set_debu=
g=E2=80=99?
>[-Wimplicit-function-declaration]
>  258 |         bt_mcp_set_debug(data->mcp, mcp_debug, NULL, NULL);
>      |         ^~~~~~~~~~~~~~~~
>      |         bt_att_set_debug
>profiles/audio/mcp=2Ec: In function =E2=80=98mcp_data_free=E2=80=99:
>profiles/audio/mcp=2Ec:270:17: error: implicit declaration of function
>=E2=80=98bt_mcp_set_user_data=E2=80=99; did you mean =E2=80=98btd_service=
_set_user_data=E2=80=99?
>[-Wimplicit-function-declaration]
>  270 |                 bt_mcp_set_user_data(data->mcp, NULL);
>      |                 ^~~~~~~~~~~~~~~~~~~~
>      |                 btd_service_set_user_data
>profiles/audio/mcp=2Ec:278:9: error: implicit declaration of function
>=E2=80=98bt_mcp_unref=E2=80=99; did you mean =E2=80=98bt_att_unref=E2=80=
=99?
>[-Wimplicit-function-declaration]
>  278 |         bt_mcp_unref(data->mcp);
>      |         ^~~~~~~~~~~~
>      |         bt_att_unref
>profiles/audio/mcp=2Ec: In function =E2=80=98mcp_accept=E2=80=99:
>profiles/audio/mcp=2Ec:317:27: error: passing argument 1 of
>=E2=80=98bt_mcp_attach=E2=80=99 from incompatible pointer type
>[-Wincompatible-pointer-types]
>  317 |         bt_mcp_attach(data->mcp, client);
>      |                       ~~~~^~~~~
>      |                           |
>      |                           struct bt_mcp *
>=2E/src/shared/mcp=2Eh:96:53: note: expected =E2=80=98struct bt_gatt_clie=
nt *=E2=80=99 but
>argument is of type =E2=80=98struct bt_mcp *=E2=80=99
>   96 | struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool =
gmcs,
>      |                              ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
>profiles/audio/mcp=2Ec:317:9: error: too few arguments to function
>=E2=80=98bt_mcp_attach=E2=80=99; expected 4, have 2
>  317 |         bt_mcp_attach(data->mcp, client);
>      |         ^~~~~~~~~~~~~
>=2E/src/shared/mcp=2Eh:96:16: note: declared here
>   96 | struct bt_mcp *bt_mcp_attach(struct bt_gatt_client *client, bool =
gmcs,
>      |                ^~~~~~~~~~~~~
>profiles/audio/mcp=2Ec:329:9: error: implicit declaration of function
>=E2=80=98bt_mcp_set_event_callbacks=E2=80=99 [-Wimplicit-function-declara=
tion]
>  329 |         bt_mcp_set_event_callbacks(data->mcp, &cbs, data->mp);
>      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>profiles/audio/mcp=2Ec: In function =E2=80=98media_control_server_probe=
=E2=80=99:
>profiles/audio/mcp=2Ec:372:9: error: implicit declaration of function
>=E2=80=98bt_mcp_register=E2=80=99; did you mean =E2=80=98bt_mcs_register=
=E2=80=99?
>[-Wimplicit-function-declaration]
>  372 |         bt_mcp_register(btd_gatt_database_get_db(database));
>      |         ^~~~~~~~~~~~~~~
>      |         bt_mcs_register
>profiles/audio/mcp=2Ec: At top level:
>profiles/audio/mcp=2Ec:183:43: error: storage size of =E2=80=98cbs=E2=80=
=99 isn=E2=80=99t known
>  183 | static const struct bt_mcp_event_callback cbs =3D {
>      |                                           ^~~
>cc1: all warnings being treated as errors
>
>It looks like it is only fixed in the follow up changes, which means
>it breaks the likes of bisect=2E
>
