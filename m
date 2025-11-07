Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B22F83A5
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541582; cv=none; b=oerRQblbt2Yj3JRuyeD2zASZhW3J17aL8F5z6IurNXIiJRVy8AIjAeBczCzQJAkl0ODTvsmFd8HgceLiafV5lWeUiughjKlA4mGtbFdCNiaYZ4UdohZ6uUXFCkuHg7stihu5sObWWWl7lm9j2KEnxQXpMn1116lN+2Lt1LALvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541582; c=relaxed/simple;
	bh=vxXA3LK9/AfbF+SDVghSO7WvhVaphHP2+bqSpYUMEVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrzxjT1H032mcfyH8QBfOdYMpBExpi+FxuxYQkEmM9JwULMTuCrHeyF9txYYAQQdcyQjnKN5lE6ZZLM+sB/yrFjly/g0oegZ0u4FJ9TBuyNaQ8KGqHdBQoWZ+QJfboxdmdEIpiTLVl78ixvLdKUG+0S/XKl4aESay1Zn6iv/kHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZHCfa2k; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZHCfa2k"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5943d1d6442so1118668e87.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541578; x=1763146378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hon46fvN5MaciwaNZYrtLZsDUBr0nJ8uArIkh0dKSPk=;
        b=fZHCfa2kYM+CIih2gJ8RUZOCneO42yDIB+w7AtVHVDohgWFVtCM6R7Q4SGlf9tzaWY
         cC4BBekNUuJvqwnsfYSG269RTdu1LH8apynh5lhrroM2Rd5yBUl+ntwNp0M92U0FVMVw
         SmstcivpJRyb5UNAPGp8tCRhiA7HvIYY3y++G1tA8Ys0M088TtO7xpwOTAQ7hBqP85gi
         /UiIOZrMsT7KGzzt763fSsYCQCz6Nd3KBVfnZ45jNPH1/9JIA3Nravh9TKEenf6SQb0h
         7iGHUOFq5zoPpY0r0v5T2ojOmEgKTjBJxDj9uYHEDgsolGQepdtJdc5X36+N1qIpK1Gc
         Idyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541578; x=1763146378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hon46fvN5MaciwaNZYrtLZsDUBr0nJ8uArIkh0dKSPk=;
        b=plXGuWTub5QfXmHfc3SOWh+tLn/Q71ZejWpTKudf0eWCSbk/2YMeAyHaD5WhHxD3xU
         KrhIOpopsrgcTjoCvPex3wzNTs99KV/KLqNLUDSfh6ZCxbGqMrJ5oZNNmQP1NvG/Nd1P
         ds2ynsv7aXJGp/x9Dye56OV4VHOQ8FhOimu0kLfP6rFMh0T54VUNXNGfcV5e1eNvEa3t
         H/0oYEjfrziRmuwY25g558RbuqXs+6h22vCOwa5rtUC7Xs7uFgmd63gsLZzPwNynDvEy
         TsZV2bClicZkQchMhE8UK5/ND+2EPF9mmEXUvl8Ud2uvfYsSenPBKFES3TS6f7AQjbMP
         +pUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEjCg8A1+wVCaLMIYiNqDPWUFxTzd77v1aUXE8wo6HtRMIANcQB54wXIxgQDMfpBCY2bzfLt/v9a5w8zpfxB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KcXCFA2A/nP5iSGd+JqXskW+OYOwO5VOKL2H7UI7mVSI/EL1
	8w3X1FBWTEpVmT1cdhDW9BNT5NpAIYNw6ExEizOQF3uaPLQ7Uvbu2jdymwf0VP5D8PMc40TYPrt
	81cdvvriYVv0ugqPa+O1OOR1lY0vZOoA=
X-Gm-Gg: ASbGncuhVhQKGHNYJ6+EK9n3bFcES67AuX0Nr6qvzrvJ/J360xKr8r/jjqm7MLx7xzg
	k0VJbIU2yQk1i4AkNRC0k/sHAIm+M7evh0bBJjDFk8W+yjQxivHJo+N0Wvd36Z0i1vQsltxbnCt
	XUBGdXFnP8wyZ54LERb68AST7Dmwd03qVrC0CPdD9YTzCjRGw1SDVKyi8kuzZVhhYviayzd0bne
	5Vh9KyXBI0YjT1MrIILeCaNW6OSTdHw2s7izAM25GVDpYdQv57zPS6clj4=
X-Google-Smtp-Source: AGHT+IFA6zfGpW3e2YRQJkcD06Bw5q7iH/apEoGfim8pJL2ZY94sZ4nvjnUySTqDFSdWvXYxiMu04t/6b8hxtsXSTnE=
X-Received: by 2002:a05:6512:1149:b0:57b:7c83:d33b with SMTP id
 2adb3069b0e04-5945f1e568bmr53063e87.47.1762541578130; Fri, 07 Nov 2025
 10:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-kernel_panic-v1-1-88637054c6b9@amlogic.com>
 <c6f8f015-267f-49e8-b427-b4524c134bfb@molgen.mpg.de> <0aa28372-feea-4252-a498-b3b8be7617f4@amlogic.com>
In-Reply-To: <0aa28372-feea-4252-a498-b3b8be7617f4@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Nov 2025 13:52:45 -0500
X-Gm-Features: AWmQ_bmVM3rzEtih8fwMPwUDpjsoajbHrK5YOwQNdL46Zr1W4bSBB3i_tzQOiGo
Message-ID: <CABBYNZKQPBaxmxzDttOKumMaReycbSAbc-JM2P0mwzy=d-kbkw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: iso: Fix UAF on iso_sock_disconn
To: Yang Li <yang.li@amlogic.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Nov 5, 2025 at 9:21=E2=80=AFPM Yang Li <yang.li@amlogic.com> wrote:
>
> Hi Paul,
>
>
> > [ EXTERNAL EMAIL ]
> >
> > Dear Yang,
> >
> >
> > Thank you for your patch.
> >
> > Am 05.11.25 um 10:02 schrieb Yang Li via B4 Relay:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> kernel panic: Unable to handle kernel read from unreadable
> >> memory at virtual address 00000000000003d8
> >
> > No line break needed in pasted logs.
> >
> >>
> >> Call trace:
> >>   iso_sock_disconn+0x110/0x1c8
> >>   __iso_sock_close+0x50/0x164
> >>   iso_sock_release+0x48/0xf0
> >>   __sock_release+0x40/0xb4
> >>   sock_close+0x18/0x28
> >>   __fput+0xd8/0x28c
> >>   __fput_sync+0x50/0x5c
> >>   __arm64_sys_close+0x38/0x7c
> >>   invoke_syscall+0x48/0x118
> >>   el0_svc_common.constprop.0+0x40/0xe0
> >>   do_el0_svc_compat+0x1c/0x34
> >>   el0_svc_compat+0x30/0x88
> >>   el0t_32_sync_handler+0x90/0x140
> >>   el0t_32_sync+0x198/0x19c
> >
> > Please add a paragraph about this problem, and how `iso_pi(sk)->conn`
> > can be NULL.
>
>
> I will update it.
>
> Thanks!
>
> >
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >>   net/bluetooth/iso.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> >> index 74ec7d125c88..89c7700ceb81 100644
> >> --- a/net/bluetooth/iso.c
> >> +++ b/net/bluetooth/iso.c
> >> @@ -838,14 +838,14 @@ static void __iso_sock_close(struct sock *sk)
> >>       case BT_CONNECT:
> >>       case BT_CONNECTED:
> >>       case BT_CONFIG:
> >> -             if (iso_pi(sk)->conn->hcon)
> >> +             if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon)
> >>                       iso_sock_disconn(sk);
> >>               else
> >>                       iso_chan_del(sk, ECONNRESET);
> >>               break;
> >>
> >>       case BT_CONNECT2:
> >> -             if (iso_pi(sk)->conn->hcon &&
> >> +             if (iso_pi(sk)->conn && iso_pi(sk)->conn->hcon &&
> >>                   (test_bit(HCI_CONN_PA_SYNC,
> >> &iso_pi(sk)->conn->hcon->flags) ||
> >>                   test_bit(HCI_CONN_PA_SYNC_FAILED,
> >> &iso_pi(sk)->conn->hcon->flags)))
> >>                       iso_sock_disconn(sk);

Hold on since the bug is actually in the handling of BIG Sync Lost, it
has been assuming that it also means PA Sync is lost as well when that
is inform byt its own event PA Sync Lost:

https://patchwork.kernel.org/project/bluetooth/patch/20251106230943.877242-=
2-luiz.dentz@gmail.com/

Also note that Ive changed the handling so it no longer calls
hci_conn_del without first calling hci_disconn_cfm, since the latter
actually informs the socket layers about the imminent deletion so the
socket can go ahead and clean up properly.

> > This diff looks fine.
> >
> >
> > Kind regards,
> >
> > Paul



--=20
Luiz Augusto von Dentz
