Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100C21FF58;
	Mon,  4 Aug 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320602; cv=none; b=ZHrIOemmxbynDh1WGmJGRTQw/RJL/IYGI38CxoRPendZKvLjh2CaCXEod99EW4TTmkB573x7VHEWRdZjNuAFMkgoDms+eLuzDPnDgtmOH03qIme8KQ4ddwuxHZ4vEon/AsKOLxDPSbf7ncF6Bx9AkyH0LUH8yuAQcM7obZXWV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320602; c=relaxed/simple;
	bh=2mCHnTS3muxJ/6nIfgxsPv1YtL20SWH3iaFi+VYd2/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsrAfl2OvdkUQY2X7AMQbExJ7ZHWl640mhYlxRR8QWHUjlL1/MUnr1PwgNFo5coBTdWKXZZobxN8fh5ffVh5KarAcga8vy/ULLph3SjGp2xc6NrCYjtNfdmurXBoBnGM3MrOMYiYSAu4P6lOY7tla82XYClowd7j5cmlBG3A0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hibDE1jh; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hibDE1jh"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-332590cc87fso17064601fa.3;
        Mon, 04 Aug 2025 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754320599; x=1754925399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OQYGq9/j7OXWTrynTqo9hEo0qJsn3LcjNGoHQKEdPw=;
        b=hibDE1jhLMJK7ST3rBG+fZ8YSI/rgVPKnBatjsu35YRilH3hF7q+sVD9BMfPNeJY4G
         W/fcOHMrAoOjXezlfbVljfm69d8I80X8HUN2qNkMJqcO6RDALfwIVziHC0xwfkj/t2eN
         bb9I4qBEILSGjqI6gC0e2ZTbZj9cmkkKqMCgwLi0+foU8rUmw2DuafNx/FqYAg81PqzL
         IuFN6GnudK4ke3FH7bQu9aPkHFXuahvTrmggp5RI1NLQwIKCPnzPVwpdaHtnIdHxR6Xn
         4hJ2vZgoIqMU7mwxUh151gItgPrpArYtUng1eRa6BfhJY7Ie8+jPEb3u2nQE/XvEQd6F
         3F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320599; x=1754925399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OQYGq9/j7OXWTrynTqo9hEo0qJsn3LcjNGoHQKEdPw=;
        b=Eq9/EoveValufljH/ggWU6R2U2/gQ4JZtxp1OKf9/kb4aySIsyFp4Muq74qwTnsKWz
         y1JfLkzZT5ncJy6sAwy4k6+h7vr/yJAwU+zEf297hAEiM3jKKLdEXuaONOaSLdb4Wdkl
         N9tQ+I6FG3IPwopKr6jZI6cV6+ZlNeTuU8vYgjfEkEWjlljJd+ecH6S7Y9YaxQ3UunEj
         sVQPqfros2K2Dv+m79U11Wr5Abq/ABdjLR9Dq0LTG9bpSjLFjZt8Nb2IrLPFU5n/8X4r
         0Hb2BhJP4EusEoRPmjx6LuDUyATXkF+wVRsAaZLq3Xy2R2Gl1IpQhuoOyjCfzpE8cn9o
         iH1g==
X-Forwarded-Encrypted: i=1; AJvYcCVC9nFdvxp+fvsDCqhgWYefatP9PGQ6ERU4fG7fMcnj/vOcb/OQ7lwAhs4tQl71P9yFwkg+ZIb70T4ouYifky0=@vger.kernel.org, AJvYcCVn6H+N3fVWj/dP8pDSp0Vgk0awxRm5/lRbSBq2qLMzwUPCZGIf8URdwy5w9oA1deyCyYdx/bHKk8cO4XDz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TgUghldsv+14m7w+5L3jAIe7jp29aeo+nX29U5hJnnaJqLX0
	y6wTN5x7u9b2EA38knra8fJ6w5LHHqcG+I1OvWjtAiSfIZ1sJWx4rSZKdkAzCxl5tKskGUaYhle
	HeO1xXRay7irIb/aY1qz4f53y8LGkHNw=
X-Gm-Gg: ASbGncsJT6PlV2OpaSW1W1OUnTFTqU0AY6QJDk8Actuv3cDA4rybwMXw9IJaQgVWZMN
	gW5M3uwVOcXLsNqbRcNaYi/x3rKTEh6YjZqC7I8lWBnlyOB5qrpj+UWAnJK9dW4F891P4Gv/RSF
	GQdJuJUoIkk8TWEa8uowaK0ShrI9+X/FqbJE7/9KKTD9mNysYqzCsttDHrCLJXeomsnxpdbfDBy
	NvUmQ==
X-Google-Smtp-Source: AGHT+IFXXkhhoaQrFrH6fdu2lxTde+v5WqjnBn4rjrHK9wMMpfqZ3m9VFcAOQa4aPeUGR3WCdCnVdDH7nCSkWCGRjDw=
X-Received: by 2002:a2e:bc1e:0:b0:32a:6aa0:2173 with SMTP id
 38308e7fff4ca-332567dd421mr24852641fa.20.1754320598261; Mon, 04 Aug 2025
 08:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
 <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com> <4e0b2df6-1139-49df-b03b-a2f31925d52f@amlogic.com>
In-Reply-To: <4e0b2df6-1139-49df-b03b-a2f31925d52f@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Aug 2025 11:16:25 -0400
X-Gm-Features: Ac12FXyPKeDnnARROrALtCie8zwh0cGRmR8a0qiQ-cnW-rM_2DEJhPqjxI4cDdk
Message-ID: <CABBYNZ+buYOXaBST-bCyzDWtWihMOoXGaoNzp6+kowKgo+-6=w@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Sun, Aug 3, 2025 at 9:07=E2=80=AFPM Yang Li <yang.li@amlogic.com> wrote:
>
> Hi Luiz,
> > [ EXTERNAL EMAIL ]
> >
> > Hi Yang,
> >
> > On Thu, Jul 31, 2025 at 4:00=E2=80=AFAM Yang Li via B4 Relay
> > <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> When both BIS and CIS links exist, their sockets are in
> >> the BT_LISTEN state.
> > We probably need to introduce tests to iso-test that setup both then
> > to avoid reintroducing the problem.
>
>
> Since the coexistence of BIS sink and CIS sink is determined by
> application-level logic, it may be difficult to reproduce this scenario
> using iso-test.

Looks like you haven't look at what iso-tester tools tests do, that is
not tight to bluetoothd, it directly operates at the socket layer so
we can create any scenario we want.

> Do you have any suggestions on how to simulate or test this case more
> effectively?
>
> >
> >> dump sock:
> >>    sk 000000001977ef51 state 6
> >>    src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
> >>    sk 0000000031d28700 state 7
> >>    src 10:a5:62:31:05:cf dst00:00:00:00:00:00
> >>    sk 00000000613af00e state 4   # listen sock of bis
> >>    src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
> >>    sk 000000001710468c state 9
> >>    src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
> >>    sk 000000005d97dfde state 4   #listen sock of cis
> >>    src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
> >>
> >> To locate the CIS socket correctly, check both the BT_LISTEN
> >> state and whether dst addr is BDADDR_ANY.
> >>
> >> Link: https://github.com/bluez/bluez/issues/1224
> >>
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >>   net/bluetooth/iso.c | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> >> index eaffd25570e3..9a4dea03af8c 100644
> >> --- a/net/bluetooth/iso.c
> >> +++ b/net/bluetooth/iso.c
> >> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct sock =
*sk, void *data)
> >>          return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> >>   }
> >>
> >> +static bool iso_match_dst(struct sock *sk, void *data)
> >> +{
> >> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
> >> +}
> >> +
> >>   static void iso_conn_ready(struct iso_conn *conn)
> >>   {
> >>          struct sock *parent =3D NULL;
> >> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn *conn=
)
> >>
> >>                  if (!parent)
> >>                          parent =3D iso_get_sock(&hcon->src, BDADDR_AN=
Y,
> >> -                                             BT_LISTEN, NULL, NULL);
> >> +                                             BT_LISTEN, iso_match_dst=
, BDADDR_ANY);
> >>
> >>                  if (!parent)
> >>                          return;
> >> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr=
_t *bdaddr, __u8 *flags)
> >>                  }
> >>          } else {
> >>                  sk =3D iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
> >> -                                 BT_LISTEN, NULL, NULL);
> >> +                                 BT_LISTEN, iso_match_dst, BDADDR_ANY=
);
> > Perhaps we should add helper function that wrap the iso_get_sock (e.g.
> > iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is the
> > expected socket type, also if the hcon has been set perhaps that
> > should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
> > introduce a socket type to differentiate since the use of the address
> > can make the logic a little confusing when the socket types are mixed
> > together.
> >
> > Now looking at the source code perhaps we can have a separate list for
> > cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_list
> > and bis_sk_list), that way we don't need a type and there is no risk
> > of confusing the sockets since they would never be in the same list.
>
>
> Alright, I will give it a try.
>
> >
> >>          }
> >>
> >>   done:
> >>
> >> ---
> >> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
> >> change-id: 20250731-bis_cis_coexist-717a442d5c42
> >>
> >> Best regards,
> >> --
> >> Yang Li <yang.li@amlogic.com>
> >>
> >>
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
