Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207B27FB15
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009702; cv=none; b=lXTX3+NgRcHCrDAsiKdwR4B5Vje3cZBiZ1hQBw0n8NSRAZyIsuQNHgFsA4F5SYODoelhqhipnueunSdNILAA2HxvG42Fo6j93T5COjyYVKGXXkqbyNRFwjAqpAFK+gdqyVBuMiBztzANQInH5UclOpwwdmdfS9UdTar1yHkm0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009702; c=relaxed/simple;
	bh=A88R8dZpusPdY8H7Op28A+rvP4xWmYZFe9QLFxMnkwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2scZo+xvMAhU+RFWQD8ldzuJbHtc+F6NbjN4qmWKRotsYq6mQnN/MWuPOoRI/Haqzg5MVcHQWGru5s9YVV6DY26P69MWPeQDPG6hgAUO3YdigaOSqz8WHh3MNlWs4c0Hebezzq3W/cGxoQQtTf34xvpatkFsoeYv4xU2WLPFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDrJ711x; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDrJ711x"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3326163941dso48498101fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755009699; x=1755614499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAnaXSScHIWY60iFOHjqh/jo7VyupBVZWKopV/irj78=;
        b=QDrJ711xD/0syS5hjukqj9Gv1gXF4ze0UoObEP0ZXO3niI7Nm/zcYQRcd4jPAHCvft
         qjM0AkkcjEV7KLlSvh1bfTLkJFSuEzBh+hVvv7ctB3N2jlAxx3tMlhc2dToRl9qrdst3
         kg6/wNAF0beazs9s6XEqTaEmSRDQz5lfA8LHJWir0668NHT6Id6h8BG+T7ubDVBdwQz2
         /8UQ5NzqFEs1kiVv9kxRmk4GpzEr2gswmf5e5jidwJ2TRL3PqOkQWrcW+NPvdzXYMIIC
         iNeJZKGFt1rcHtnM2sMQiZTWj1DhpUHuJTu4wb4+Bk3Awu2UDEQv/+Z+st3md/LxaZ7g
         Z4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009699; x=1755614499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAnaXSScHIWY60iFOHjqh/jo7VyupBVZWKopV/irj78=;
        b=aQ9qTKzjmNreyvEIBaDgIxHYaUSNK+Ynoy1GpZ7JFMgbQZtBWk0OdBob6YaWDOYZhc
         3l6RyNYdzJMqW33WT/Xn+OoMi/Z0/2lnfg+RURYmOfSABIOuyYxmW/c4ojfZP2Id0RHY
         aqAR1cAoUvCAKCuBCjSsdVN6GKWbKp84qMzj4Pt3Fvd6pYw/Z7HAQ9QPC/MX9zffuC4t
         pHRoY20VLWk1eCJnnzCgv6BRFb019XP5vMPMx85rdQeZ7ppAYDnYP0z51OegydZACUd6
         ilmqlGkT03nAh+So6OcsI5NplxL0SEBUQcGTB7D1ilkfNoQnnE1iSus8B0DDBmd3BTTm
         nWAg==
X-Gm-Message-State: AOJu0Yy/o31WW3aBJNg+Jyx+NVt/Jt95GCvm9NGGHprNtrEYU6Em9TMt
	XdOYA5cMEas6/TWKC8PWGJ7E9ui0fhjWXdYWq0h2BIKPdivow7sXaPkowTf8fuFLGoViTutdLeL
	KdxxMIfNMt1YQFWBHIU5wtfDGm6T1LLd1WTJV
X-Gm-Gg: ASbGnct0R/v1tE7qJCqigyrVQJ0CFD0OIZrqXuaWmekQRrl7maxFEg+Ril1EOPQrl5F
	pVdzndc+H8J/ZgQEKOvR8o3P7o0yzUVR6PM+melvxGZdR/ND6AcXXFUXGBfqQ8E+K2CkGoofE/t
	ZjyukujTn76N0VvqWK35wDT2od4J8hS7ARnsn4EOv7JlRnWXkGhl95q1Ci2Gb7IWU4pts+A3ij6
	K5jG+0jXm+xF9l/
X-Google-Smtp-Source: AGHT+IGoAHJdKmme84YTfuJePfdrZapJwH8OSDfPdIuTBhruHOl5/hkf07YPjsC86xHHS0w6dyk0cUf3uTA/eVNaxHE=
X-Received: by 2002:a05:651c:304b:b0:32b:968d:1fe4 with SMTP id
 38308e7fff4ca-333d7c00d06mr8423111fa.14.1755009698296; Tue, 12 Aug 2025
 07:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812141028.509783-1-ludovico.denittis@collabora.com> <20250812141028.509783-3-ludovico.denittis@collabora.com>
In-Reply-To: <20250812141028.509783-3-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 Aug 2025 10:41:24 -0400
X-Gm-Features: Ac12FXxCyMixkCw-xUdG0H5uX04p7sSNM7QueGLJeSLbSd3txGMsCXCyK0nlZY0
Message-ID: <CABBYNZKTYrYmd_C36GU2xZ6YEr1cQGsrpke1mYuz3K3QDhzw6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_event: Mark connection as closed
 during suspend disconnect
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Tue, Aug 12, 2025 at 10:26=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> When suspending, the disconnect command for an active Bluetooth
> connection could be issued, but the corresponding
> `HCI_EV_DISCONN_COMPLETE` event might not be received before the system
> completes the suspend process. This can lead to an inconsistent state.
>
> On resume, the controller may auto-accept reconnections from the same
> device (due to suspend event filters), but these new connections are
> rejected by the kernel which still has connection objects from before
> suspend. Resulting in errors like:
> ```
> kernel: Bluetooth: hci0: ACL packet for unknown connection handle 1
> kernel: Bluetooth: hci0: Ignoring HCI_Connection_Complete for existing
> connection
> ```
>
> This is a btmon snippet that shows the issue:
> ```
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>         Handle: 1 Address: 78:20:A5:4A:DF:28 (Nintendo Co.,Ltd)
>         Reason: Remote User Terminated Connection (0x13)
> > HCI Event: Command Status (0x0f) plen 4
>       Disconnect (0x01|0x0006) ncmd 2
>         Status: Success (0x00)
> [...]
> // Host suspends with the event filter set for the device
> // On resume, the device tries to reconnect with a new handle
>
> > HCI Event: Connect Complete (0x03) plen 11
>         Status: Success (0x00)
>         Handle: 2
>         Address: 78:20:A5:4A:DF:28 (Nintendo Co.,Ltd)
>
> // Kernel ignores this event because there is an existing connection with
> // handle 1
> ```
>
> By explicitly setting the connection state to BT_CLOSED we can ensure a
> consistent state, even if we don't receive the disconnect complete event
> in time.
>
> Link: https://github.com/bluez/bluez/issues/1226
> Signed-off-by: Ludovico de Nittis <ludovico.denittis@collabora.com>
> ---
>  net/bluetooth/hci_event.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6c67dfa13..81c9fc774 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2718,6 +2718,11 @@ static void hci_cs_disconnect(struct hci_dev *hdev=
, u8 status)
>                 goto done;
>         }
>
> +       /* During suspend, mark connection as closed immediately
> +        * since we might not receive HCI_EV_DISCONN_COMPLETE
> +        */

Hmm, the comments suggests that this shall be done only for suspend
case though, should we be checking for hdev->suspended?

> +       conn->state =3D BT_CLOSED;
> +
>         mgmt_conn =3D test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->=
flags);
>
>         if (conn->type =3D=3D ACL_LINK) {
> --
> 2.50.1
>
>


--=20
Luiz Augusto von Dentz
