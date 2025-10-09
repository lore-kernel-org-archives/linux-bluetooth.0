Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B96635
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030144; cv=none; b=J+E9WzeauPgDsK3gDCnjAIUjxfteVcNHgnxHD06Ia003Db3RiA4EguSOecJgmr11Qoaw9ClgZkyx3q1Zyj1DYqxjipQoXFUwZkhmksqfo4MaTZ2KoMdX0fxwXj2F4o2C4JR9lRSSftVlAX5RplUBcz3gV8jr1lJAReCN2LhKpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030144; c=relaxed/simple;
	bh=j09wdoMIS18gvx/+rsuPIqBvgFgCYx4FXCbiSAa/BtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMLATVJUN5njncgxL2s0bcTShtOuGLDd2gTGOiF95xOVt+74xvIc+lWnUYKMyoTDPn87pZhgZhC4Mj2TRLkKgrhhKfg4Llweh9lBPRkNRATfw1fMM66Vh9jPPSBhX7lkNQMWlSDgKKkzlg3rVuaPwn8JBOszlvMyvEL6HECwBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYC7LDpx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYC7LDpx"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57a604fecb4so1503949e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760030137; x=1760634937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elbeML06AHUvNr9LWqjkzs3Ca71mVa2DMgAnKuBZXMg=;
        b=SYC7LDpxlASlAQ8ftIx8di6XX0gC3IFotm/DDAVV3Tyg/xlazdAi0D9cUnS/SZfFjC
         XpB1qB7bqGTJxau4oKezqw7THM9l+oiXhfTPJotI9+WkW5g6kAmfOxu69TVOT4TkBdAE
         vhz+CNIb/L8oAUiNIQWS5NgtH0NfXH2QnZXihW+ZwaCb3yDDaE/Pb5tf+pNWadjjXPLt
         dzZweG9kqwqVta/9WIw0UVFGaZg2fIb4Va+Uv8k2NPVUAt+s5KaWkW0w4071G9bADCY0
         ExLjZ076awFIkCsw/9zW25w4BPKGGEaeRaf/uxfIlboxoLyo1TMdEGiHsFWU1DyAdd5o
         bVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030137; x=1760634937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elbeML06AHUvNr9LWqjkzs3Ca71mVa2DMgAnKuBZXMg=;
        b=mv/HHo5PJnDgW4o2XUztjpMNPE2cx8t/92tt1GIrjoob1q0EhQwC9ZVOWKPXDHDZSn
         HRvK9PVrA1eXr46rWafSM6OgjOuz2mYONyxCYRT97RMOjp3wZ9Y1MfnRu9dAXyRi5B+2
         ulBRmZtJ8yMPQVmQXEqk/9CDLXkBxz0aFnVyi2y1HofgLzGTohFUR7XBA28yh4QYg0Lz
         7GJ2qCtiCVcGaskKQ8Bo8RFJ+peOluWPFj74VQOGLB6YP5VFF7BR8GcJFvtIxuTZFF94
         aglrW/OBBlRL4shfh9B9u05YlstNMTa/dVbR4HOd6N3xfyLGaGxuC/7uxQoMYddFhwsf
         94/g==
X-Gm-Message-State: AOJu0YwgdQ/jynFl8kq+aEg6SHapjtLEhg8SPN134jgc+jkj9IMSp52C
	fLra8/5raARHij/3jJFNvvJEYUKUv0T+FHe+Y48HHppgu0Z33P3i6O2EAm66rBUfW4lhsIGH622
	k4TEUkvaPlK2AFx9W4hEURUGzM8q2xOk=
X-Gm-Gg: ASbGncsSoVVNBZtpmqUz4VQtAM9ELcR+HzNVKc2BMnOS0V70Ldp4LTEP45UaZy6L0+d
	7NT9/IRZe+j1Qwad5kz3wrI5x64fP376YEUb+M67a/F7zYxle3jh9p7ulWFaK1Uy2cX8Tk+RtSh
	CjXloySK9f+UjwOzvmCh6DJBtkdcRUIUpGouplnMCCCFeuxwGp5skarprguuF3NwA/NUHuFGfbe
	VjbtdosW8PUzx4NwoCsiDQfdatUhY4PCGJbo1e1
X-Google-Smtp-Source: AGHT+IEwJSMwNcQeBIRVFTHaq5NpdweXaIDXUeQwakcc16c6rEOnoBk+i+5SBK64FmQ8c290Ny5Af6E16wZuvlvF1Q0=
X-Received: by 2002:a05:651c:b27:b0:372:921b:4b8a with SMTP id
 38308e7fff4ca-37609cea71emr24415191fa.4.1760030137364; Thu, 09 Oct 2025
 10:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009071159.359476-1-frederic.danis@collabora.com>
 <CABBYNZJo4z67N4RbNAgfdMpJ1swQt3360ytCTddkzBhHrMzxrA@mail.gmail.com> <7c9a5707-af06-4540-8add-fc2901fac610@collabora.com>
In-Reply-To: <7c9a5707-af06-4540-8add-fc2901fac610@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Oct 2025 13:15:25 -0400
X-Gm-Features: AS18NWDcMO_5bAJxO9xNOCL_3t9A81u9XHOy1QEHZeCyCdDAjPIY_Fw4RiOMkGo
Message-ID: <CABBYNZKe8LLk7XJ86qX2gK+S-aHS99DDVX7HnSteiv71ARWrSg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gobex: Fix abort for SRM operation
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Thu, Oct 9, 2025 at 11:58=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Hi Luiz,
>
> On 09/10/2025 17:53, Luiz Augusto von Dentz wrote:
> > Hi Frederic,
> >
> > On Thu, Oct 9, 2025 at 3:13=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
> > <frederic.danis@collabora.com> wrote:
> >> The OBEX Abort operation currently triggers an OBEX session
> >> which prevents further OBEX operations:
> >>
> >> obexd[327475]: obexd/client/transfer.c:obc_transfer_register()
> >>                 0x50e000001380 registered
> >>                 /org/bluez/obex/client/session0/transfer0
> >> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0=
:
> >>                 ref=3D3
> >> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0=
:
> >>                 ref=3D4
> >> obexd[327475]: obexd/client/session.c:session_process_transfer()
> >>                 Transfer(0x50e000001380) started
> >> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010=
c0:
> >>                 ref=3D3
> >> obexd[327475]: Transfer(0x50e000001380) Error: Transfer cancelled by u=
ser
> >> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0=
:
> >>                 ref=3D4
> >> obexd[327475]: obexd/client/transfer.c:obc_transfer_unregister()
> >>                 0x50e000001380 unregistered
> >>                 /org/bluez/obex/client/session0/transfer0
> >> obexd[327475]: obexd/client/transfer.c:obc_transfer_free() 0x50e000001=
380
> >> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010=
c0:
> >>                 ref=3D3
> >> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010=
c0:
> >>                 ref=3D2
> >> obexd[327475]: Unknown header offset for opcode 0x10
> >> obexd[327475]: obexd/client/session.c:obc_session_shutdown()
> >>                 0x50c0000010c0
> >> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0=
:
> >>                 ref=3D3
> >> obexd[327475]: obexd/client/pbap.c:pbap_remove()
> >>                 /org/bluez/obex/client/session0
> >> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010=
c0:
> >>                 ref=3D2
> >> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010=
c0:
> >>                 ref=3D1
> >> obexd[327475]: obexd/client/session.c:session_unregistered()
> >>                 Session(0x50c0000010c0) unregistered
> >>                 /org/bluez/obex/client/session0
> >> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010=
c0:
> >>                 ref=3D0
> >>
> >> As its highest bit is always set to 1, and so its value located after
> >> G_OBEX_RSP_CONTINUE, the G_OBEX_OP_ABORT is part of the operations
> >> constants.
> >>
> >> This has been tested for PBAP and BIP-AVRCP with Android 15 and 16.
> >> ---
> >>   gobex/gobex.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/gobex/gobex.c b/gobex/gobex.c
> >> index 0e33ececf..df80d79f3 100644
> >> --- a/gobex/gobex.c
> >> +++ b/gobex/gobex.c
> >> @@ -382,7 +382,7 @@ static void check_srm_final(GObex *obex, guint8 op=
)
> >>          case G_OBEX_OP_CONNECT:
> >>                  return;
> >>          default:
> >> -               if (op <=3D G_OBEX_RSP_CONTINUE)
> >> +               if (op <=3D G_OBEX_RSP_CONTINUE || op =3D=3D G_OBEX_OP=
_ABORT)
> > Let's move it to a case statement as it was done with G_OBEX_OP_CONNECT=
.
> The case for G_OBEX_OP_CONNECT is switched from obex->srm->op, while the
> test for G_OBEX_OP_ABORT is done on the op function parameter.
> I don't think it's useful to create a switch here.

My bad, I didn't pay attention to what opcode it was tested in the
switch statement.

> >
> >>                          return;
> >>          }
> >>
> >> --
> >> 2.43.0
> >>
> >>
> >
>
> --
> Fr=C3=A9d=C3=A9ric Danis
> Senior Software Engineer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United K=
ingdom
> Registered in England & Wales, no. 5513718
>


--=20
Luiz Augusto von Dentz
