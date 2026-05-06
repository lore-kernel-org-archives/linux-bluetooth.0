Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F5345CAA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069124; cv=pass; b=occDI6CVE2LFEDWqH0cEvkatXUDnWMHKZKC1YaRlwOwx0Q/qH64745yiW/9vjGmw+LtvpeJ5hFjwNvlFUFpUXnKq8egyB+ozp9YH9OBHxj+ct/az+Hn/7dfdlxg2yf7ivSiJy2RBbPfIRLd0eFUa2cf+ILiuChDlFhBtMTxnzw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069124; c=relaxed/simple;
	bh=2zMx+FaWfwnhe6lXrswOUXzCVpQRjKQ7ump7lWG1tV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIBMKnDMqP6f1Ajy5bljeiJHiMDEpV2qIb++swLzJTMaBNQulHcoOHBDm3gJvh2jGMqk4wo/D6qg1AgdRX2iXOysQ77mPWCOUH+p+UMlyBTTmRmVr5H17mqbNV5nuCWW5szzL6Wckkyt5rqjLwNankuJmb58UFxuNPtTliwD0zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJoy8kS6; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJoy8kS6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so10255a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 05:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778069121; cv=none;
        d=google.com; s=arc-20240605;
        b=grOASwt20pYUhFclLmoYZKd3TDln6gp4zbXY+QaFMuJUHkPP8nc8raD+xdGBT9invN
         o3OB/A9F/JT8UwAFrPmw7AkOe4f9LBqLYmYNyuzNIPyfxgTIVQwayd+k4qXtZpNOShAQ
         G8rOKRurE79oEoeO5MhxsKDsttf8A/U6fFhess5Xc6Dx48o0INM95dJ1pBYSxio+iUsB
         obO0RCLruII8cRe/kO3NTqbQ+A0+li7a48yH0mJI3P11ugBbkSts3kFxQIDNEY15LEVZ
         IwtsGZyvYBYlS4Z13vDrK12raHD1cTJJoNDG/G4Ml3UKuYtwyMfd70GzNh57+vw4TbCe
         Qq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7SkiCwpoGGSR+VOguP46PNj7/26BOC/RtwhpETWAfik=;
        fh=3i0kjVV2ZqxYc4Xfxtx7CCdtQ56Av1YXevgDRi7bqdQ=;
        b=SN/nG/EtpSMmMfrmgYgm+RtbG8LoTGT8X09uPsHCAVS+v5E8b5cD8Snn5q5XmVYs77
         g7qtdOiLmhpouikWNhHkHp4ss4lob9hA8E0UQnlw3fppMdb5eQNzHHEp5hFq2hmkdNW6
         aOqsKCG0IcA3i42EYJxTnN2gnPqTQaPbKgV5tWO+3eeAlJl7b/kS814kvjQ/8INzy3aR
         yvqipK80/fsv+86BrabLfbZYw5w059tvOlgC1d5gHtSgSz9YweJCjCW1tnorHt3xqpHw
         fzKW4lVkzLvQloA29/dwGcRLBD17PWH4dFj6agc9CBhxbFGY/EGNd/I4zMwfwns0rIdq
         ymsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778069121; x=1778673921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SkiCwpoGGSR+VOguP46PNj7/26BOC/RtwhpETWAfik=;
        b=SJoy8kS6T6BdmZLP8VhA9T5JeIwqr+R/w1dpbCKU9jv9p39bY0IWC1ex4Secnng9hI
         38RqbpwDr87OdQjcRw+le4i4lfAv+z6oOSCy26qOL+IGHTvv8oPASD4k5+8svd/iXIxc
         j9YuBreomd9hxDMhGY2BrEzjsI9HhAAsruj5FVHn+u3UlteL2xGgBpeMmLW5bnX9LQ/x
         wk0rsSxfOcy+7Ng71iMVsHz+XjnZn8Io26Z/KPLwoZbEv6s3rzmbZ+Vbm+2s4al8y0DU
         qpqlQ4n0VumMedLWTnC9NisjqOby5ECqlQM+RajnkU2mNmdwczAeIxvlg6TxfEdAg25x
         oAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778069121; x=1778673921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SkiCwpoGGSR+VOguP46PNj7/26BOC/RtwhpETWAfik=;
        b=azqHDmmcbCBDHW4SXv9avMo1aAlXENq+sfr5bPv9yIdKflytqYWPIwdb26G9AI8t8R
         U1LnMLdpcOt8QBDd0b3rc54dZF5gF/aGMCMG83Lc+hv5q0OYdYclFsIN54dY6PsQQLgR
         47lRe33jMcObhuAvJbjkDzKeLPMQmemoDsNcfoZBU0d+UJ3Ny9v/BNxnpX7cSoCWg7ip
         imCwxFDaGatwUIyGQoFQuMu+cVPOawP/tbRfrz5LNjTFrw5CHri4qIhmfYDeMEb2gl/b
         MYSIPBaYwNYFG5eaS0Vksw5CvmypcE6YrmzNFhOeepMxWzbj9oMUSaCfQxt58Q1Bgh9q
         +cEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4v0swMyJgmHrE5SGCH26T1M+Zob1ohUokhbFb5etgo9BRHijDD0N8iXJ8JFaTj4hW0dyP9d5Ok4b44U9CY9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3iiEj2x8iL3UgS74w5CioS/jCx4/zL6+5wJ8oZCvagJGF9lN
	K92bJjoyhS6Xc8ShowGodJTf2N89lq3OKK3b6f8yJwGN1wWVCA/q9VHZ/8Yv/JsANxSTzlTkuLY
	k0PhhoTbmErAUKZlN3kYOOfZpGZEnYjBUKtvR1QjsBhXNbRtR3eNHip+/83o=
X-Gm-Gg: AeBDietn2F/XE/sI0vIV2mFDQS/zS7FcYCrZ9jReMCNIrWPtV/b2hyfhVQv1Sj/ES+I
	yy0hccN0wnfWPQbugKDs6tmIaV+lMU56diw8+VAB2ZMwNpR2zIZ7IECu7PaoScwUqhDvG6V4QIm
	s8uKc4xu0i/bBVRRUk88/7PFG++MEsUvjAiPxddPi0AFMI2hx8U82XeWDprZss+rpCoeJMlVbON
	j4G/Hlxn1F+cs0RhbOpDcl9VtgAVr1vf6mAgCdxq47CpfcV/LrlySxbIPKzTeyTsOQchU3ZQchy
	O/krCXSCbQCP+e6dj7+mRJNlYYscwJMVLIrZVgzWlexdW6kdp9HOiKNLAf8=
X-Received: by 2002:aa7:c903:0:b0:670:d5f0:2595 with SMTP id
 4fb4d7f45d1cf-67d63d9276amr44273a12.11.1778069120699; Wed, 06 May 2026
 05:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com> <CABBYNZLzyh7a7sZ+0U4DAq8TB6e6=WdNrfKrxGXMqnYAMT0KnA@mail.gmail.com>
In-Reply-To: <CABBYNZLzyh7a7sZ+0U4DAq8TB6e6=WdNrfKrxGXMqnYAMT0KnA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 6 May 2026 14:04:43 +0200
X-Gm-Features: AVHnY4K5YkADVGWfu3nzBfhgYwm-1qpAh1RKBgX_mKXaVR2EX0ROB4TwY8iXUu4
Message-ID: <CAG48ez3HWBb0X1q-owvK40OC5ecx=A7CWTAGBoWSppJYSKYLRQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:06=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> On Mon, May 4, 2026 at 11:11=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Use lock_sock() to guard against bt_accept_poll() racing with concurren=
t
> > close(accept()), which can lead to UAF:
> >
> > task 1           task 2
> > =3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D=3D
> >                  __x64_sys_poll
> >                    __se_sys_poll
> >                      __do_sys_poll
> >                        do_sys_poll
> >                          do_poll
> >                            do_pollfd
> >                              vfs_poll
> >                                sock_poll
> >                                  bt_sock_poll
> >                                    bt_accept_poll
> >                                      [read ->accept_q next pointer]
> > __x64_sys_accept
> >   __se_sys_accept
> >     __do_sys_accept
> >       __sys_accept4
> >         __sys_accept4_file
> >           do_accept
> >             l2cap_sock_accept
> >               bt_accept_dequeue
> >                 bt_accept_unlink
> >                   [removes new socket from ->accept_q]
> > __x64_sys_close
> >   __se_sys_close
> >     __do_sys_close
> >       fput_close_sync
> >         __fput
> >           sock_close
> >             __sock_release
> >               l2cap_sock_release
> >                 l2cap_sock_kill
> >                   sock_put
> >                     sk_free
> >                       __sk_free
> >                         sk_destruct
> >                           __sk_destruct
> >                             [frees new socket]
> >                                      [UAF read of ->sk_state]
> >
> > This UAF only leads to incorrect reads, it does not corrupt memory; it =
is a
> > fairly tight race window; I believe every race attempt requires an
> > incoming bluetooth connection; and the leaked data is limited.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  net/bluetooth/af_bluetooth.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 33d053d63407..d24897167838 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -521,13 +521,17 @@ static inline __poll_t bt_accept_poll(struct sock=
 *parent)
> >         struct bt_sock *s, *n;
> >         struct sock *sk;
> >
> > +       lock_sock(parent);
> >         list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept=
_q) {
> >                 sk =3D (struct sock *)s;
> >                 if (sk->sk_state =3D=3D BT_CONNECTED ||
> >                     (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)=
 &&
> > -                    sk->sk_state =3D=3D BT_CONNECT2))
> > +                    sk->sk_state =3D=3D BT_CONNECT2)) {
> > +                       release_sock(parent);
> >                         return EPOLLIN | EPOLLRDNORM;
> > +               }
> >         }
> > +       release_sock(parent);
>
> There is the following comments though:
>
> https://sashiko.dev/#/patchset/20260504-bluetooth-accept-uaf-fix-v1-1-1ca=
63c0efadd%40google.com

Regarding the LLM output on whether lock_sock(parent) is enough: The
locking I'm adding here is the same as what bt_accept_dequeue() uses
for protection; if event handling can also remove accept_q elements
without holding appropriate locks, I think that is a separate (and
bigger) bug.

I see I've just been CC'ed on
<https://lore.kernel.org/all/20260506114338.2873496-1-n05ec@lzu.edu.cn/>,
which seems to be a broader fix; if you want to go with that patch,
this one is superfluous.

> I'm not really sure if likes for the poll are supposed to be done
> lockless, if they are, we cannot use lock_sock here and will likely
> need to rework accept_q so it doesn't contain deferred sks, as those
> shouldn't be considered ready for acceptance.

I don't see why that would be a problem;
Documentation/filesystems/vfs.rst says nothing about wanting lockless
operation, and if you look around at other poll handlers, you'll see
several ->poll() handlers that take sleeping locks:

 - dma_buf_poll() calls dma_resv_lock(), which locks a W/W mutex
 - vb2_fop_poll() sometimes calls mutex_lock_interruptible()
 - virtio_rpmsg_poll() calls mutex_lock()

My understanding is that is is preferable, but not required, for
->poll() handlers to be fast if they're used by high-performance
userspace code, since event loops might hit ->poll() handlers fairly
often (especially if userspace uses an API like poll() or select(); I
think with epoll you only get one or two ->poll() callbacks once the
file descriptor actually becomes ready); I think this probably isn't
really an issue for bluetooth listening sockets.
