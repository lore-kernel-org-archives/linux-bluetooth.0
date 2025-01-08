Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBC19F133
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350062; cv=none; b=JeC+SYxhIfKUbjPkQ/Rc9quW29JwOZVAe62H6D8eVI2zWARL/Q09U959weomKl4rxPBDPwh33V+yoD015QY/mYVqsAO77ylm+n/Dan1Rv8PqEqsCOIgGfwPp4oVaiNjwiwTX3j/PNVoG9vm7cH7DsS3vxMuUFGD9/PLZ66daVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350062; c=relaxed/simple;
	bh=n08uhvOrkXvdbv30jIAKnDlSthacxgfxsIL+c6w8Jxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erWo969SIFZ1FbBQM5hYihkyhKEAsM18Q/XDTc//EYdZ/h18oiiHilBHBYToqqPQrJtFGLx7qMkMNBQAjVw7+5qT1hy5VWMzMJEEsYEalYSET7zACIPC1K2KfErxVucwxCnupWkZFGE46IR3hxv8X6Ls6Wo5SRw1OEJa90qkU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBj5ctwM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBj5ctwM"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-304d760f118so49389301fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736350058; x=1736954858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ggN6a2ZOd/2aJ4bh+k2x3nrjKk8CmO6wgI0Cd2o+5M=;
        b=lBj5ctwMqCBoizQizClm3lPeYknGWoDg4WLXKk5MFSsFaU6zYFBRk+XFuVuzoSvGc1
         3Sa0YSYdQIZIRkJBiKE3QLSgeQIGCJaJFSe2ZgfqXYdmjpOIgz/QzRLZHjzOTXqaC3de
         gUTrHcBT9H5nCs4gzqIjPn4oA5t7L96vtwcq2f/GAta/vnvAfmU9pAG1UOrDVZbBEAmx
         HfM+xItHiJec8sY8+V8djNOv/OnhZkZQhSI1Iix3X4bpy8GHLWriU63RLrfYilWCdhp1
         GUKeF4gVLIGnZEF6rCdP7sLUlGzNWYewvhD733l/D/1NJ3Sm4p82RwNYWoGWrnrrM+Oz
         uLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736350058; x=1736954858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ggN6a2ZOd/2aJ4bh+k2x3nrjKk8CmO6wgI0Cd2o+5M=;
        b=bkvZgqbhvXIE6F+fMb017zl096m34HMR15wkEAmEfeqvJYZCI0DK7v0+cu+5V1jJze
         ZJlN/iWuHl4LKF/KGuRZNJzVcmQxOpgyl5FMg0Fvn+m0ny9jZLEAlQL8uAhxsD8fWJMR
         rIjV8cHokb50dGawx/RePMSJp3hFASeX8gTJjykmbCCgcIOCb2qDIn4ZTqcQV1mZQFhO
         Qi1FXRS1exlb/FhZ0/v1QCuno7ZsE8VAQJJ+UL9ZAQpCwpr9lOYGvlnL+V2mbDnaFjBv
         YCnKS3oBOMarBLYuJm1FVh+AAF7IfqoGsTSGcNN3uNWPx9ERf9mCYwTQNU0fGMI5MOlc
         ct7g==
X-Forwarded-Encrypted: i=1; AJvYcCWGWFELdLXSCj2VBb2nBWaVDQaVfpwbknsTK+9+KkbPcz40HMTEm1KD7zoAF6ktMoPBLoAEuxU+XlMluEjJSwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1Ce0FxldM5cY8IUyOg9sDyqAmmrIZ9+R1BhmN5luj26Eemm2
	/5k470snLfuxHfVBByWBaGlQkDu1+DtpA+RUkVXEwNovPcoSwoaneOnnm8OA/N413XlHf2h+sn9
	Onc+miqu0N4/aYrdXoMYy0pi9AxE=
X-Gm-Gg: ASbGnctSCRMacoLP5nshGYsDM5al37ld3KpCyFCscPCndX0v6O6fmfvR5xQjQlamqBl
	Zsp0wgvoM80+BnkQUmE8PUmJkO2HAFcfiUQCeaeA=
X-Google-Smtp-Source: AGHT+IGxY6QeuK5SMYTIKg+WFJ8iopRlyKSD1moKAOmpj6i1IDv9VeMwAb7rxQC4BSUJ4CKJm9ycC1Gqw9eCPov91OA=
X-Received: by 2002:a05:651c:4006:b0:302:251a:bd21 with SMTP id
 38308e7fff4ca-305f45747c9mr4188981fa.15.1736350058050; Wed, 08 Jan 2025
 07:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
 <CABBYNZJzjKQFA7gaQ2m+PEO_vbMgAZ4wy4fp--Rc4JFAQqAU_A@mail.gmail.com> <5c94f8e5-bb47-4a38-b60c-8cb8d9c309c4@amlogic.com>
In-Reply-To: <5c94f8e5-bb47-4a38-b60c-8cb8d9c309c4@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Jan 2025 10:27:25 -0500
X-Gm-Features: AbW1kvZlcKbwpCdb_h43Svs8lR0J-PrsNutDGDgh-yehw0eTmfpfU-qpkvt0KHU
Message-ID: <CABBYNZL34vfUEdsS0NhQJp56B69aGAa7KLo=zxSsynfCwYOSyQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bap: fixed issue of muting music silent after
 pause and resume.
To: Yang Li <Yang.Li@amlogic.com>
Cc: "pav@iki.fi" <pav@iki.fi>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Tue, Jan 7, 2025 at 8:50=E2=80=AFPM Yang Li <Yang.Li@amlogic.com> wrote:
>
> Hi Luiz & Pauli,
>
> ASCS v1.0.1 =C2=A75.9 introduces two operation processes for the server t=
o
> handle the released state:
> ----------------
> If the server wants to cache a codec configuration:
> - Transition the ASE to the Codec Configured state and write a value of
> 0x01 (Codec Configured) to the ASE_State field
> - Write the configured values or the server=E2=80=99s preferred values fo=
r the
> Codec_ID, Codec_Specific_Configuration_Length, and
> Codec_Specific_Configuration parameters to the matching
> Additional_ASE_Parameters fields defined in Table 4.3
> <https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/23=
166-ASCS-html5/out/en/index-en.html#UUID-8e961f8e-98b7-23b8-53d7-59cc88762f=
c0_N1661460117035>.
> - Write the server=E2=80=99s preferred values for the remaining
> Additional_ASE_Parameters fields defined in Table 4.3
> <https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/23=
166-ASCS-html5/out/en/index-en.html#UUID-8e961f8e-98b7-23b8-53d7-59cc88762f=
c0_N1661460117035>.
>
> If the server does not want to cache a codec configuration:
> - Transition the ASE to the Idle state and write a value of 0x00 (Idle)
> to the ASE_State field.
> - Delete any Additional_ASE_Parameters fields present.
> ----------------
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/231=
66-ASCS-html5/out/en/index-en.html#UUID-9d5221b2-eadd-1bde-09d4-5b3bb9e6d7b=
8
> Currently BlueZ only uses non-cached operation, It seems that the
> Android platform is not compatible with the non-cached Codec
> Configuration scenario,
> I raised an issue when testing playback and pause using a Pixel phone.
> https://github.com/bluez/bluez/issues/1053
> So I tried modifying the code to use a cached Codec Configuration
> (referencing the process for Pixel + Redmi Buds 5Pro headphones).
> I believe there are two issues that need to be confirmed:
> - Does BlueZ need to support both operations and how to decide which one
> to use? (cached or non-cached);
> - Whether the Android platform will be compatible with non-cached in the
> future.
>
> > [ EXTERNAL EMAIL ]
> >
> > Hi Yang,
> >
> > On Sun, Jan 5, 2025 at 9:50=E2=80=AFPM Yang Li via B4 Relay
> > <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> CIS sink need caching the Codec Configured when releasing by Pixel,
> >> state machine is releasing -> Codec. If streamming -> idle, CIS sink
> >> was silent after resume music.
> > You need to work on the commit message, perhaps quote the spec if
> > there is a description of the state transition.
> Well, I got it.
> >
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >>   src/shared/bap.c | 43 +++++++++++++++++++++++++++++++------------
> >>   1 file changed, 31 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/src/shared/bap.c b/src/shared/bap.c
> >> index 167501282..a7f5dec92 100644
> >> --- a/src/shared/bap.c
> >> +++ b/src/shared/bap.c
> >> @@ -1063,6 +1063,28 @@ static void stream_notify_metadata(struct bt_ba=
p_stream *stream)
> >>          free(status);
> >>   }
> >>
> >> +static void stream_notify_release(struct bt_bap_stream *stream)
> >> +{
> >> +       struct bt_bap_endpoint *ep =3D stream->ep;
> >> +       struct bt_ascs_ase_status *status;
> >> +       size_t len;
> >> +
> >> +       DBG(stream->bap, "stream %p", stream);
> >> +
> >> +       len =3D sizeof(*status);
> >> +       status =3D malloc(len);
> > Just use a stack variable instead of using malloc.
>
> I will do it.
>
> I just referred to other function flows, like stream_notify_metadata()
>
> >
> >> +
> >> +       memset(status, 0, len);
> >> +       status->id =3D ep->id;
> >> +       ep->state =3D BT_BAP_STREAM_STATE_RELEASING;
> >> +       status->state =3D ep->state;
> >> +
> >> +       gatt_db_attribute_notify(ep->attr, (void *) status, len,
> >> +                                       bt_bap_get_att(stream->bap));
> >> +
> >> +       free(status);
> >> +}
> >> +
> >>   static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
> >>   {
> >>          if (!bap || !bap->ref_count || !queue_find(sessions, NULL, ba=
p))
> >> @@ -1634,7 +1656,7 @@ static bool stream_notify_state(void *data)
> >>          struct bt_bap_stream *stream =3D data;
> >>          struct bt_bap_endpoint *ep =3D stream->ep;
> >>
> >> -       DBG(stream->bap, "stream %p", stream);
> >> +       DBG(stream->bap, "stream %p status %d", stream, ep->state);
> >>
> >>          if (stream->state_id) {
> >>                  timeout_remove(stream->state_id);
> >> @@ -1655,6 +1677,9 @@ static bool stream_notify_state(void *data)
> >>          case BT_ASCS_ASE_STATE_DISABLING:
> >>                  stream_notify_metadata(stream);
> >>                  break;
> >> +       case BT_ASCS_ASE_STATE_RELEASING:
> >> +               stream_notify_release(stream);
> > Ok, I see where this is going, but the spec doesn't actually mandate
> > to send releasing or caching the codec configuration:
> >
> > https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/2=
3166-ASCS-html5/out/en/index-en.html#UUID-c37600a3-4541-1926-2f13-eb29057e4=
1d5_N1661459513418
> >
> > Perhaps you are saying that we need to send Releasing at least? There
> > is also the thing that I don't understand is why would someone send
> > release command and get rid of QoS/CIG while keeping the Codec
> > Configuration?
> I think the client requires the server to notify the current state as
> released.

There is no released state, only idle, that said the spec clearly
state that we need to transition to Releasing (0x06) before moving to
Idle (0x00), which is something we are not currently doing, anyway we
need to properly document this and perhaps we need to add a timer in
case the remote doesn't disconnect the ISO link we should probably
cleanup ourselves other we would be stuck in releasing state forever.

> >
> >> +               break;
> >>          }
> >>
> >>          return false;
> >> @@ -1936,9 +1961,7 @@ static uint8_t stream_disable(struct bt_bap_stre=
am *stream, struct iovec *rsp)
> >>          /* Sink can autonomously transit to QOS while source needs to=
 go to
> >>           * Disabling until BT_ASCS_STOP is received.
> >>           */
> >> -       if (stream->ep->dir =3D=3D BT_BAP_SINK)
> >> -               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> >> -       else
> >> +       if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
> > Don't think this is correct, why are you taking away the setting to
> > QoS like it is documented?
>
> This is also what I am confused about. Why do we need to set state=3DQoS
> in stream_disable()?

Disable is different from the Release command, it is used to 'pause'
the stream but keep the QoS settings, but the server still needs to
transition back to QoS, and no I'm not guessing here the state machine
does really require these state transitions.

>  From the ASE state machine, the ASE state should stay in Codec
> Configured after Released, and switch to QoS state when Client
> configures QoS.
>
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/231=
66-ASCS-html5/out/en/index-en.html#UUID-363eeef6-abc5-6f54-cfa6-09fe4451fd1=
5

Sounds like you are confusing Disable with Release again here, over
each line connecting the states there is the operations, transition
from Releasing to Codec Configuration is clearly _not_ mandatory, in
fact I think for embedded devices they most like want to save memory
when a stream is released, so Id only really recommend caching the
Codec Configuration in case the connection is lost or something like
that, not when the remote peer intentionally release.

>
> >>                  stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLIN=
G);
> >>
> >>          return 0;
> >> @@ -2068,17 +2091,11 @@ static unsigned int bap_ucast_metadata(struct =
bt_bap_stream *stream,
> >>
> >>   static uint8_t stream_release(struct bt_bap_stream *stream, struct i=
ovec *rsp)
> >>   {
> >> -       struct bt_bap_pac *pac;
> >> -
> >>          DBG(stream->bap, "stream %p", stream);
> >>
> >>          ascs_ase_rsp_success(rsp, stream->ep->id);
> >>
> >> -       pac =3D stream->lpac;
> >> -       if (pac->ops && pac->ops->clear)
> >> -               pac->ops->clear(stream, pac->user_data);
> > Hmm, I think we do depend on clear to be called to tell the upper
> > stack the transport is being released, or you did test this with the
> > likes of pipewire and found that is not really required?
> If clear is executed, CIS will be disconnected automatically. I compared
> it with the pixel+Buds5 headphones, and it was the mobile phone that
> disconnected the CIS, so in the cached Codec Configuration operation
> process, there is no need to disconnect the CIS.

Fair enough, that said I don't think this behavior is invalid either,
and like I pointed above we should probably trigger a timer if the
remote doesn't cleanup the CIS on releasing.

> >
> >> -       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> >> +       stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
> >>
> >>          return 0;
> >>   }
> >> @@ -6172,8 +6189,10 @@ static bool stream_io_disconnected(struct io *i=
o, void *user_data)
> >>
> >>          DBG(stream->bap, "stream %p io disconnected", stream);
> >>
> >> -       bt_bap_stream_set_io(stream, -1);
> >> +       if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
> >> +               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> >>
> >> +       bt_bap_stream_set_io(stream, -1);
> >>          return false;
> >>   }
> >>
> >>
> >> ---
> >> base-commit: dfb1ffdc95a00bc06d81a75c11ab5ad2e24d37bf
> >> change-id: 20250106-upstream-1ec9ae96cda4
> >>
> >> Best regards,
> >> --
> >> Yang Li <yang.li@amlogic.com>
> >>
> >>
> >>
> >
> > --
> > Luiz Augusto von Dentz
>
>


--=20
Luiz Augusto von Dentz
