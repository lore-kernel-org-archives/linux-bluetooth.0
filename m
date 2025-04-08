Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE022DFB0
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133580; cv=none; b=uMJ8kV0GwP2FEb4zPf8cZESyJgdfyswyASzhmW/RkDBvsSDv3Br/XvyLPGkaAD15kksbIeG9s/3Ji9uQeFrOzOdD6Sx4cZc73wW0/f/J8GtE+YSCosWW7oL7gp14zCiuJHLEMgYwS1PKOia623iS15qj/zt0oT457RLlJrHxa0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133580; c=relaxed/simple;
	bh=xR5EEg54XDBTo0qEcFEu7QCS013H/CCV3r1d8nx5ZkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKorzff9Iaq02kIcJKr7/21mdiXl4E4+/S2C+YM4NkNU73CQq5Jl4aLCz3hmIeAoYz7C5+QvLmNXleOs38TRs9avYYQVqSI2pMxP0woD5IFqGTowfc7dbSkLvRtvj2LTTgfJvw93H5VeMXuiQ1Ah5L9H/BqWh6u7+hJo8VFhAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l49DfkQ9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l49DfkQ9"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54acc04516cso6743576e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744133576; x=1744738376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac10o4rGUomrqU2G9Z4ZxoQKUZH3TorDKzb4ytt4HPQ=;
        b=l49DfkQ9YZ3bfg3fq9VAKY8qn4ZiLmZP8BZPqWVzDywmjm+gdvXha/drprCgLjAHgf
         QsYhaFqR8uys0tMc7FgCYT1hadfTqi8Obz4c7L14Br8cyeJmsPIZuV96lkNsMNPcDXlX
         3NlgJENwLhLD+yUaQ/tDpJZnsUECbopf/H9KeIFU9smqTELxlwBaE/fglPLEEkjsBWLT
         iAYN1n2bw3m24dhtI+kJFBnHEQ3G2NaprTo2ujgKgNgdvJPFxbtAUKRzixkOcqgGloEB
         owTd6ST+JOr7WsD7NPkvwh1KVNpSnrm9o5/56/KfGMbfdlsv7sug9qcBDhWITTTJzeQ1
         vcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744133576; x=1744738376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac10o4rGUomrqU2G9Z4ZxoQKUZH3TorDKzb4ytt4HPQ=;
        b=mLfcOzvSOwFEyOvD9IymHCPkJ3YB2zIV8YYvje8BnEIfjxkUs0Xv+Qf+cqaXwfzCYO
         FA5G4n3yKBSA8fhBiRYcx2WONc2kWb4sKf+2z6fkESvSARHX+LdWUdgWnarZjZe4DgdO
         UMVBpep4qu823nBpP8+IzSi7Zq+CTevDlBWBrhVPbNYunNk8EDB37poGnTNNwyDLg+pa
         onj1/5E4SonNJsq2Qgrugyput+3GzidHQp+aLowvFrWZ/Gtg8DsT4/rf/ayH+sdOcsOc
         cQKGfExSwd3cXiTDCsIV29m+1WlNbZjOEZu5jysD01WIxyzEsTFnZwFn5eXnUMRqv1xW
         gssA==
X-Gm-Message-State: AOJu0YzQ6jruJFhcMrziyCJk+JpXtC5OmHQg+GktaEXvQiCEd/F+4O/+
	Noa5gswtscYKfqeyS7R5lBjUSI8q/9IC7NQ0ySwiCsf9Tg2EvXH9ReW9yb2Lsxs5qUUqR3eRSGu
	RD7WcP6Lpqblcjkt70H8aa6kchkkpd8FiLe8=
X-Gm-Gg: ASbGncuveG6+ZGqcGCCExrtB+HfSkdRHaiVvf4u2cD0KjW0EDOWALkI0rcGNXia5cgP
	8bVZQpf2AKrGtk3X5ESJuHgAr8J27H7U9pbpR1XShifVEn2H/HOG4dgV1amrAwUq+wBYdQCK94K
	CMS88xNVyMNabYeuwiCm91I5ec
X-Google-Smtp-Source: AGHT+IHpvtcLuB9dhglS+v9gILDcpQui5YUzl/mMZdLdLg1aftR4tb0OaoWxXOVxQi2sy3eNMsDu78LcjuN9nAxHz2w=
X-Received: by 2002:a05:6512:1255:b0:549:9143:4e8d with SMTP id
 2adb3069b0e04-54c297b7221mr3648224e87.8.1744133576410; Tue, 08 Apr 2025
 10:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408170915.623602-1-frederic.danis@collabora.com> <CABBYNZJNTJsn9a+n1V2yyp2kkEVKTvvP_F4S-rnH-Trqm0hKPQ@mail.gmail.com>
In-Reply-To: <CABBYNZJNTJsn9a+n1V2yyp2kkEVKTvvP_F4S-rnH-Trqm0hKPQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Apr 2025 13:32:44 -0400
X-Gm-Features: ATxdqUFUySIltFHM_5P1liMJUidn9HCWj64bBALCl7iMDodhouImA1LQ9YLGpy4
Message-ID: <CABBYNZJ5L_qvats5dL7PAR==r4VaAfYQLsD372W9FmAfD3R9sw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: l2cap: Check encryption key size on incoming connection
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Apr 8, 2025 at 1:28=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Fr=C3=A9d=C3=A9ric,
>
> On Tue, Apr 8, 2025 at 1:09=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
> <frederic.danis@collabora.com> wrote:
> >
> > This is required for passing GAP/SEC/SEM/BI-04-C PTS test case:
> >   Security Mode 4 Level 4, Responder - Invalid Encryption Key Size
> >   - 128 bit
> >
> > This tests the security key with size from 1 to 15 bytes while the
> > Security Mode 4 Level 4 requests 16 bytes key size.
> >
> > Currently PTS fails with the following logs:
> > - expected:Connection Response:
> >     Code: [3 (0x03)] Code
> >     Identifier: (lt)WildCard: Exists(gt)
> >     Length: [8 (0x0008)]
> >     Destination CID: (lt)WildCard: Exists(gt)
> >     Source CID: [64 (0x0040)]
> >     Result: [3 (0x0003)] Connection refused - Security block
> >     Status: (lt)WildCard: Exists(gt),
> > but received:Connection Response:
> >     Code: [3 (0x03)] Code
> >     Identifier: [1 (0x01)]
> >     Length: [8 (0x0008)]
> >     Destination CID: [64 (0x0040)]
> >     Source CID: [64 (0x0040)]
> >     Result: [0 (0x0000)] Connection Successful
> >     Status: [0 (0x0000)] No further information available
> >
> > And HCI logs:
> > < HCI Command: Read Encrypti.. (0x05|0x0008) plen 2
> >         Handle: 14 Address: 00:1B:DC:F2:24:10 (Vencer Co., Ltd.)
> > > HCI Event: Command Complete (0x0e) plen 7
> >       Read Encryption Key Size (0x05|0x0008) ncmd 1
> >         Status: Success (0x00)
> >         Handle: 14 Address: 00:1B:DC:F2:24:10 (Vencer Co., Ltd.)
> >         Key size: 7
> > > ACL Data RX: Handle 14 flags 0x02 dlen 12
> >       L2CAP: Connection Request (0x02) ident 1 len 4
> >         PSM: 4097 (0x1001)
> >         Source CID: 64
> > < ACL Data TX: Handle 14 flags 0x00 dlen 16
> >       L2CAP: Connection Response (0x03) ident 1 len 8
> >         Destination CID: 64
> >         Source CID: 64
> >         Result: Connection successful (0x0000)
> >         Status: No further information available (0x0000)
> >
> > Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> > ---
> >  net/bluetooth/l2cap_core.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index c7b66b2ea9f2..f2ab09582146 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3997,6 +3997,13 @@ static void l2cap_connect(struct l2cap_conn *con=
n, struct l2cap_cmd_hdr *cmd,
> >                 goto response;
> >         }
> >
> > +       /* Check the encryption key size */
> > +       if (!l2cap_check_enc_key_size(conn->hcon)) {
> > +               conn->disc_reason =3D HCI_ERROR_AUTH_FAILURE;
> > +               result =3D L2CAP_CR_SEC_BLOCK;
> > +               goto response;
> > +       }
> > +
>
> Hmm maybe we should incorporate this is the statement before:
>
>     /* Check if the ACL is secure enough (if not SDP) */
>     if (psm !=3D cpu_to_le16(L2CAP_PSM_SDP) &&
>         !hci_conn_check_link_mode(conn->hcon)) {
>         conn->disc_reason =3D HCI_ERROR_AUTH_FAILURE;
>         result =3D L2CAP_CR_SEC_BLOCK;
>         goto response;
>     }
>
> That said I don't quite understand why the likes of
> hci_conn_check_link_mode is not checking the key size since it is
> already doing security level checks, either way that indeed seem to be
> missing for incoming connection requests.

Also this need to add Fixes: 288c06973daa ("Bluetooth: Enforce key
size of 16 bytes on FIPS level") since apparently tha missed some code
paths.

> >         result =3D L2CAP_CR_NO_MEM;
> >
> >         /* Check for valid dynamic CID range (as per Erratum 3253) */
> > --
> > 2.43.0
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
