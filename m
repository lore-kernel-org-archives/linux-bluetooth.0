Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012123CF0B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133340; cv=none; b=RMHauVoUjBSPU2b+NOBie4I0jJGN6Pdo6dU7+9W1weSuNSoYtku3uEwWoys87p4p7H+d0JdRmjr8Qxpj8k/8KTZBUAsIWmRkWnmZcnSRES1ZG566hzWZSE2+RPFUZ6g3hRfeh6hTWs481A9KJenAdLuH6dBbuMrXmh6I0FL2Ax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133340; c=relaxed/simple;
	bh=Av4DUAKPjfkGGOH8EUfuyCGDQQvAUv8e3ML8oi6FQgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om35vPs42RBqlLZfEcKqeuHyV+tCssv3/wejygx/ZkBcEcTQRKH8kC6PdkeL3qn1ttXkO+KXFyCYvEHDLKL329H6+Dw2CZQvxPORPzumVcTJ1I6YjlDYA01ZKLtDv7tSw5elOrn+HPh/orKfnBkP9tBXCY7HpJoBA8bk3W2Gxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4n3sELl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4n3sELl"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30de488cf81so60784721fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744133336; x=1744738136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OhskGFIzh9iMHrP+tOHThsdKCe1y2K36Acb2lEojoE=;
        b=B4n3sELlJWDQfvYS+dwR5Tl0vWm8ZxFyd8GCT7NIAhw+WS8G/uxUHJGgArMtACEHE9
         WE36pS9kCkn8tHkySyVHJ5+ff67MW5+lJFXghRcN6kqRuZ/REYM8TsigWkLSXOmwoz6i
         yD8Ko2h/4r8oLJmeXqAp0+puNWY7IuwMhsh3deV3MYo51Km5Pmwy+UxzCAMvC/yHBBKp
         42bF+vLY0u2wsrO27s2UcSwg680Qo0wS4wzzPGS8J8SgrDxzv2mclafJhYh05YoIIPgl
         bkqsXZc6dH38gaUKSFiQu4QP76Gu0EsiCULi3VEPnu2YT46qQlDsOo6/hK5qeqs7aLEd
         Ghxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744133336; x=1744738136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OhskGFIzh9iMHrP+tOHThsdKCe1y2K36Acb2lEojoE=;
        b=DOaNL4JtftDZAUK/QHcRr82LXV1Dkuph1geTfNrTn0p0/b9jUP6BND7UvufXHxSrc+
         Ec5CKAtYPvzNtDE93wn3qQyCbyfhABE3dC4kHzBGRwsLgtRzOLaZxfdMUdNfirJjrIIu
         7widngdyQ7Bof/2JVWkSZh/IoNbEf07uo6IQ6R4bzENMedN4JfKn4HNzOq+pIeH358BX
         D0AnCjN7hFvWBsxkm40hVFRgb4rrrCG0mwvDZyuld+XggbdmZ9baAppPwAYNW51n/yku
         ANXzaDKeJidhOg8v+04DIJLdVKw4t6QY/ccABTXcl7J4m3bUHH6ipr0/2ThG9Zn0sZzn
         vFCQ==
X-Gm-Message-State: AOJu0YyR6IXwgmPqwTdJQIliNkwbYI0rkC1wcQuyDC89TrO464ZbUK0P
	l8qqoY/LsmEW4fDSYfyBXqr9ZAB3Ugbc0SSSIwQ22Q2e3wW/8DstMTJVy4rqqsRIz014jyU3WuN
	lltjumx1Fpue3haBVblK0QDQf2fE6O9f8H/Y=
X-Gm-Gg: ASbGnctII9OalfFJuPKavw1DFV1ThsgOKc2zb81JNKBuAHtU4bzABgdkkugBlNgkay9
	1Zt16gdG5BdOqo56BCNvOdEtMc2AinvB5FHflIzJc3eRaQ0jIpECYaIGKSYuv407Y4nBT3J4DgY
	gIMSHXB57Zno6CWVxgM984xqMD
X-Google-Smtp-Source: AGHT+IFXeBE1OGrFvuUZeMjzSjBzOLWpo4el0gMsl4Xy1YkgY507dAr9b1IDqCNXD2tIGJ/DIvOkUyVC2bD7U+zRW+8=
X-Received: by 2002:a2e:be9d:0:b0:30d:e104:d64a with SMTP id
 38308e7fff4ca-30f165a424amr32812541fa.38.1744133335787; Tue, 08 Apr 2025
 10:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408170915.623602-1-frederic.danis@collabora.com>
In-Reply-To: <20250408170915.623602-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Apr 2025 13:28:43 -0400
X-Gm-Features: ATxdqUGoENNA8xeoPXgS--XmPJ_Jkjeu-c8qmYdoQWMclwzK3NjJem6rEKFOvS8
Message-ID: <CABBYNZJNTJsn9a+n1V2yyp2kkEVKTvvP_F4S-rnH-Trqm0hKPQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: l2cap: Check encryption key size on incoming connection
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Apr 8, 2025 at 1:09=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This is required for passing GAP/SEC/SEM/BI-04-C PTS test case:
>   Security Mode 4 Level 4, Responder - Invalid Encryption Key Size
>   - 128 bit
>
> This tests the security key with size from 1 to 15 bytes while the
> Security Mode 4 Level 4 requests 16 bytes key size.
>
> Currently PTS fails with the following logs:
> - expected:Connection Response:
>     Code: [3 (0x03)] Code
>     Identifier: (lt)WildCard: Exists(gt)
>     Length: [8 (0x0008)]
>     Destination CID: (lt)WildCard: Exists(gt)
>     Source CID: [64 (0x0040)]
>     Result: [3 (0x0003)] Connection refused - Security block
>     Status: (lt)WildCard: Exists(gt),
> but received:Connection Response:
>     Code: [3 (0x03)] Code
>     Identifier: [1 (0x01)]
>     Length: [8 (0x0008)]
>     Destination CID: [64 (0x0040)]
>     Source CID: [64 (0x0040)]
>     Result: [0 (0x0000)] Connection Successful
>     Status: [0 (0x0000)] No further information available
>
> And HCI logs:
> < HCI Command: Read Encrypti.. (0x05|0x0008) plen 2
>         Handle: 14 Address: 00:1B:DC:F2:24:10 (Vencer Co., Ltd.)
> > HCI Event: Command Complete (0x0e) plen 7
>       Read Encryption Key Size (0x05|0x0008) ncmd 1
>         Status: Success (0x00)
>         Handle: 14 Address: 00:1B:DC:F2:24:10 (Vencer Co., Ltd.)
>         Key size: 7
> > ACL Data RX: Handle 14 flags 0x02 dlen 12
>       L2CAP: Connection Request (0x02) ident 1 len 4
>         PSM: 4097 (0x1001)
>         Source CID: 64
> < ACL Data TX: Handle 14 flags 0x00 dlen 16
>       L2CAP: Connection Response (0x03) ident 1 len 8
>         Destination CID: 64
>         Source CID: 64
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>  net/bluetooth/l2cap_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c7b66b2ea9f2..f2ab09582146 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3997,6 +3997,13 @@ static void l2cap_connect(struct l2cap_conn *conn,=
 struct l2cap_cmd_hdr *cmd,
>                 goto response;
>         }
>
> +       /* Check the encryption key size */
> +       if (!l2cap_check_enc_key_size(conn->hcon)) {
> +               conn->disc_reason =3D HCI_ERROR_AUTH_FAILURE;
> +               result =3D L2CAP_CR_SEC_BLOCK;
> +               goto response;
> +       }
> +

Hmm maybe we should incorporate this is the statement before:

    /* Check if the ACL is secure enough (if not SDP) */
    if (psm !=3D cpu_to_le16(L2CAP_PSM_SDP) &&
        !hci_conn_check_link_mode(conn->hcon)) {
        conn->disc_reason =3D HCI_ERROR_AUTH_FAILURE;
        result =3D L2CAP_CR_SEC_BLOCK;
        goto response;
    }

That said I don't quite understand why the likes of
hci_conn_check_link_mode is not checking the key size since it is
already doing security level checks, either way that indeed seem to be
missing for incoming connection requests.

>         result =3D L2CAP_CR_NO_MEM;
>
>         /* Check for valid dynamic CID range (as per Erratum 3253) */
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
