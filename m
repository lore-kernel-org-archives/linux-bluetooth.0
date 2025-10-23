Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1127781E
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253526; cv=none; b=vGnYEspa22RqxlSX1iNRLtkiz0eAI8L8nkc02idHhrtapIWbNpvN7xAc9w3Bye+wbysfJN2XRh2GL9V/tJZXKjZjzMTTCcdTPgiB8QJU+b1/onENgjJiElH2aXP+JCvXHCKBTkf2YiOqRusFFQijYE5UUmKCk7Hg0r2sFh+qfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253526; c=relaxed/simple;
	bh=uNN9PPr/yTFHzxK8MQ3XHv/YvwCSmF0U+8ouACnxjAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WV4HnkhcjnCQncDxm48bWzbCbLol+cDL5RB35G2ir1PyQz3ya0cQ+CCEuF7tpqkQxYCDLNGHNOh3eptQ1p/JwvgtEWzn7ocihi580bqdaDN/vGyIjf88X+HWf6nyfXIVzL0P5OCjSnbNujEQTPklNDnbP2RpvlzhJZ6xMkyZgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbQ9+78i; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbQ9+78i"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378d50e1cccso15468801fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253520; x=1761858320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=862okFpfVZvhmXzSNmyjfrfI1Xm8aQ7K46jS7eTHfAM=;
        b=MbQ9+78ijwayERorwWr8N805GGfvAwCcoWQxfghPCkoFwEg9j0sZ9CyzaYoj6N3kFs
         Zzr3KsuZXg5GRzn7S8gjvH+fQ+9UTworBMwnQ6AGjUnBr15OcDtaLRsYKwI69IFBgZS/
         Pr8GYeLApEmyJcAPwEWGOiI2opqoN6FPMAO22l9pThwbzfJ6PWSFprQS70DbiOd0VZ4n
         5NBj4ERfKkMCur3qRriANvVbSMLYjSKlWGND6WswtBADsLeAq8FpD703RktdgbiOqjqu
         RwJrhUvDpRtGPrh1LMcuEYqiw38OoqW7tfC9v6SUC8SJZN+MpVdmQBn02epKnRezWbI9
         I8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253520; x=1761858320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=862okFpfVZvhmXzSNmyjfrfI1Xm8aQ7K46jS7eTHfAM=;
        b=SoexXHIw/rLsHeXMuZvuB6r54rkbmtVoq0HEKWUPC3rG0Qm51lw9nSoqmSX0OfH8GU
         A32DNUZf8X37k89mIFf9e4arT2VCiiytKAv633nGFF63awtSN7zgAmtpgGlcwrvJGqus
         vCSLFaO9xgx3T5p6V8vlfVWtjXVI0tmsGWmFcxx8CSnl0ByQlMIbI4bUT6/KZs6+DU1l
         zrXUSFLS5NLy1QJmq10UJKRREPsBLlc1oehOWeEN5qnj2FiSexS2tUQpFhB1J/XmlToj
         egOX15/14v1WgNrn8m5IifEbxv6uPsxLcqzEaeFR/qtEZiZTQ+imr6rSwDe9sdgrKqI+
         97AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzMxNyX/ROpyQ09/2mxO+HXEZRRW3j6EGVPzCvUtS+Uget4uk1JB71HD9E+S4qIsGulKNAutjYM1UxG5ZshaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaozeRg9WVuKNbOFQEIGoOFjW3h1UT1gbFNs5EpBJEln3/zdG
	6EgQ+UIFvjzTUDa+R68EYpxZXZkyMhvTkpkFSrqq0Yte4eml92XvsbHOpIzYhEWP7qsIsNDk8nE
	Xa/iNE6n/QG+nnfJCU31J3B4P2z4V65GO/OInuvw=
X-Gm-Gg: ASbGncvIGOENbxXi+/WwXnHDcrR62ZbyaLDEssBkMEPmuXBdv0aWv4nnZUisJxlonB8
	DxTbtatxjyVK16JCwIbtd1zUbJZK5qFqZWwzl2T9ppoaDYg9uhWmYtpSt7rfGGgbn9MgTuDtojr
	9Xm5s5RYL2/IYlgKvNFwgteufeRhI939HV6y25HJEK613WC/PavtJgGASOwJtb2ma2N59E7+aEE
	eRHurz87PhaKIyTB7grXgR+3bnEu5U5vddKVxtulPd2jrVaDYg5x6/G4R8mw6As3ieU/w==
X-Google-Smtp-Source: AGHT+IG9hVStadcHgcH9pwqipVZ8q236Yr5ZSYyiWguCrs1hAdh+Ks2DDRtnidEtfFSfFhuAguYEPWv9H0ksKC0iQco=
X-Received: by 2002:a05:651c:908:b0:376:2802:84b0 with SMTP id
 38308e7fff4ca-37797a8ed3fmr71073181fa.46.1761253519780; Thu, 23 Oct 2025
 14:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022223417.139332-2-rpthibeault@gmail.com>
In-Reply-To: <20251022223417.139332-2-rpthibeault@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Oct 2025 17:05:06 -0400
X-Gm-Features: AWmQ_blXZO5mFjarWLO1_mPPNpv69dkFfEOsfq92hPD4abmuqgith-oR4ByY-LI
Message-ID: <CABBYNZJtp0wqL_SJEk0wVo4DuadrBirmJ5VOe_TyE_RN8jOJNA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: validate HCI event packet Parameter
 Total Length
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raphael,

On Wed, Oct 22, 2025 at 6:38=E2=80=AFPM Raphael Pinsonneault-Thibeault
<rpthibeault@gmail.com> wrote:
>
> There is a BUG: KMSAN: uninit-value in hci_cmd_complete_evt() due to a
> malformed HCI event packet received from userspace.
>
> The existing code in hci_event_packet() checks that the buffer is large
> enough to contain the event header, and checks that the hdr's Event Code
> is valid, but does not check the hdr's Parameter Total Length. So,
> syzbot=E2=80=99s event packet passes through and uses the un-init values =
in
> hci_event_func() =3D> hci_cmd_complete_evt().

It does checks the length:

    if (skb->len < ev->min_len) {
        bt_dev_err(hdev, "unexpected event 0x%2.2x length: %u < %u",
               event, skb->len, ev->min_len);
        return;
    }

> Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da9a4bedfca6aa9d7fa24
> Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
> Fixes: a9de9248064bf ("[Bluetooth] Switch from OGF+OCF to using only opco=
des")
> Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
> ---
>  net/bluetooth/hci_event.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d790b0d4eb9a..5e1498cc04cd 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7565,7 +7565,7 @@ void hci_event_packet(struct hci_dev *hdev, struct =
sk_buff *skb)
>         hci_req_complete_t req_complete =3D NULL;
>         hci_req_complete_skb_t req_complete_skb =3D NULL;
>         struct sk_buff *orig_skb =3D NULL;
> -       u8 status =3D 0, event, req_evt =3D 0;
> +       u8 status =3D 0, event, req_evt =3D 0, len;
>         u16 opcode =3D HCI_OP_NOP;
>
>         if (skb->len < sizeof(*hdr)) {
> @@ -7585,6 +7585,13 @@ void hci_event_packet(struct hci_dev *hdev, struct=
 sk_buff *skb)
>                 goto done;
>         }
>
> +       len =3D hdr->plen;
> +       if (len !=3D skb->len - HCI_EVENT_HDR_SIZE) {
> +               bt_dev_warn(hdev, "Unexpected HCI Parameter Length 0x%2.2=
x",
> +                           len);
> +               goto done;
> +       }

Looks like a big hammer for a uninitialized value, which I assume is
from the following code:

    if (i =3D=3D ARRAY_SIZE(hci_cc_table)) {
        /* Unknown opcode, assume byte 0 contains the status, so
         * that e.g. __hci_cmd_sync() properly returns errors
         * for vendor specific commands send by HCI drivers.
         * If a vendor doesn't actually follow this convention we may
         * need to introduce a vendor CC table in order to properly set
         * the status.
         */
        *status =3D skb->data[0];
    }

That one is accessing skb->data without first checking it like
hci_cc_skb_pull like all other event handlers are doing, if that is
really the case then something like the following should make it go
away:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bae8c219341a..e71fbdebffae 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4219,6 +4219,13 @@ static void hci_cmd_complete_evt(struct hci_dev
*hdev, void *data,
        }

        if (i =3D=3D ARRAY_SIZE(hci_cc_table)) {
+               if (!skb->len) {
+                       bt_dev_err(hdev, "unexpected cc 0x%4.4x with no sta=
tus",
+                                  *opcode);
+                       *status =3D HCI_ERROR_UNSPECIFIED;
+                       return;
+               }
+
                /* Unknown opcode, assume byte 0 contains the status, so
                 * that e.g. __hci_cmd_sync() properly returns errors
                 * for vendor specific commands send by HCI drivers.

> +
>         /* Only match event if command OGF is not for LE */
>         if (hdev->req_skb &&
>             hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) !=3D 0x08 &&
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
