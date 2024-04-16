Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC61CAA6
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277933; cv=none; b=qss1CFVFh//slNGCdcslKKPXiY4vfwpLD5lvr6ABgdX0uUdwgDwtwR+crVs+BQzyFe8z9J0E0Jgzm0eAPMQiH8bs2hycC/nyOHW5+sFlTS1XpYqMOZmeEyfET0vnSxjJid9sIE5PVyLgpXoEvc00xRFhtUuL2s91sWrbbIlyvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277933; c=relaxed/simple;
	bh=5fqxAsj7q+hgP0UJnNcquPnE9yZAB6GLv01RlUHziG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/ugaibOSk8cqdrIZqIRH/09GCXRyK0FbTOLOPGsQ6YjLXXHqcQSRsarlJ3/tx9XE7UzREGdeQbuIIPq3VhArqMWFhDOV0A+GIrnxJ8gP24ncAsWQqEMrOmi3Wjcgu4HTWf6ceMfPW4doI8sq+qWKIFqttG27fuvN76OQdUltWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SePwANvn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SePwANvn"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2da0f8f7b24so34661341fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277926; x=1713882726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6+bQWOPS8ReOYqU2kI7X0CZRsFWEYkg0DaAMT2DOYA=;
        b=SePwANvnA64jVCotK1K8DZbmHcuh7/m7l50ys3JYQh8rLhqzpp7Ke6YyLXFawA7Lje
         joDQrWt5W2CAHPxIJuRuOqZXq43BXVMhyERLpG+HHXv91NfcWuGEQRKcpdXppch0zhIZ
         L4YCKt6J0GjDiUK5kU1SG9qjaYcoBEYDG5UbO0xPPoYn1L8vbvmPBAL2G+ILumUkCY5D
         G/mTO0lB3NoymY+FuguRzyMJ8n6YuccBe7S2CNLsEuLwFYlM83NIUC8QAnQD9eu0kZpE
         TE6ImxEroLCiCNnPYaQ3p8+A6/785dWobSZqmB+F2QJpkQYPy9WapnrbA9vQtwxL3DRc
         u1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277926; x=1713882726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6+bQWOPS8ReOYqU2kI7X0CZRsFWEYkg0DaAMT2DOYA=;
        b=X2ajYiFD0RrnFaItk/JaPRZkbLI4t4g4KWCuRIW/8wsdh53mabG0JXufvKRoxII6h0
         bzIdyuub2jNB8wxsMLZKv2QlN7FT573DygQkiiwAJ/4SIGZTmBQvmzd4A65W4+HNJW65
         Do2D7W7eM0NupFVNob5xlGqeeOAUkWy3l6vY9MDAt3QpZwej/RGGzc55W71uTqgSzGyd
         lMC9GCLJpFjDW6910cKN5mb9Z2mWsA5J9qjXrK7UmVgjJs8e0lzh17bAYPYKJk6gUJfP
         2mMpOEYpvKBirnnn1o8QCNrpllHvulbg8hAy7CD/fuYSY/5TiyRs2Hpzwhh733pueFMS
         ILCA==
X-Gm-Message-State: AOJu0YwtfnxeR+2W/rT+qgw2nZAUabhQHJQz3FWhGoMQc0FPREQi9BXF
	ZF8O6mF5YqMAXkcWAva1R4PNTqTn8DJv2/4W/eUXtrdwermxwS1f7ZCJsa9HNGU5LxotXoTrJ/C
	8uIR9u/JLCUy9RE2PDuK83RERysCtlQ==
X-Google-Smtp-Source: AGHT+IEk9IZwUzXgM5W0lIuMjbcD3vtCO54UbQTYbJU9goHpsCWW8R9Ib8I8r3a2u9u4lSUR1LJhH2I75BeQN8zXkGg=
X-Received: by 2002:a2e:9c46:0:b0:2d8:bf1e:154f with SMTP id
 t6-20020a2e9c46000000b002d8bf1e154fmr715178ljj.8.1713277926132; Tue, 16 Apr
 2024 07:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416102501.42996-1-vlad.pruteanu@nxp.com> <20240416102501.42996-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240416102501.42996-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Apr 2024 10:31:53 -0400
Message-ID: <CABBYNZJ_4ekgf03fUDTKyQzz1Ucg=7JJbh=PtaGSJjqsrtz0NA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: hci_event: Fix setting of broadcast qos
 interval and latency
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Tue, Apr 16, 2024 at 6:25=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.co=
m> wrote:
>
> The latency parameter of the broadcast qos is calculated wrongly.
>
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
>
> For framed PDUs:
> Transport_Latency_BIG =3D BIG_Sync_Delay + PTO x (NSE / BN -
> IRC) * ISO_Interval + ISO_Interval + SDU_Interval
>
> For unframed PDUs:
> Transport_Latency =3D BIG_Sync_Delay + (PTO x (NSE / BN - IRC) +
> 1) x ISO_Interval - SDU_Interval
>
> For broadcast sink the latency should be taken directly from the
> BIG Sync Established event and for the source it should be taken
> from the Create BIG Complete event.
>
> The interval parameter of the broadcast qos reffers to the SDU
> Interval and shouldn't be set based on the latency. The Host will
> read this value from the BASE.
>
> Signed-off-by: Vlad Pruteanu <vlad.pruteanu@nxp.com>
> ---
>  net/bluetooth/hci_event.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 868ffccff773..dff4bedc3e9b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6983,6 +6983,8 @@ static void hci_le_create_big_complete_evt(struct h=
ci_dev *hdev, void *data,
>
>                 if (!ev->status) {
>                         conn->state =3D BT_CONNECTED;
> +                       conn->iso_qos.bcast.out.latency =3D
> +                               DIV_ROUND_CLOSEST(get_unaligned_le24(ev->=
transport_delay), 1000);

You should probably add comments quoting the spec, also you quoted in
the description that framed vs unframed but then the code does not
attempt to differentiate, so perhaps that is not really important and
then we can remove it, the important part is what shall be used as
transport latency.

>                         set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
>                         rcu_read_unlock();
>                         hci_debugfs_create_conn(conn);
> @@ -7029,7 +7031,6 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>
>         for (i =3D 0; i < ev->num_bis; i++) {
>                 u16 handle =3D le16_to_cpu(ev->bis[i]);
> -               __le32 interval;
>
>                 bis =3D hci_conn_hash_lookup_handle(hdev, handle);
>                 if (!bis) {
> @@ -7044,11 +7045,10 @@ static void hci_le_big_sync_established_evt(struc=
t hci_dev *hdev, void *data,
>                         set_bit(HCI_CONN_PA_SYNC, &bis->flags);
>
>                 bis->iso_qos.bcast.big =3D ev->handle;
> -               memset(&interval, 0, sizeof(interval));
> -               memcpy(&interval, ev->latency, sizeof(ev->latency));
> -               bis->iso_qos.bcast.in.interval =3D le32_to_cpu(interval);
> -               /* Convert ISO Interval (1.25 ms slots) to latency (ms) *=
/
> -               bis->iso_qos.bcast.in.latency =3D le16_to_cpu(ev->interva=
l) * 125 / 100;
> +               /* Convert Transport Latency (us) to Latency (msec) */
> +               bis->iso_qos.bcast.in.latency =3D
> +                       DIV_ROUND_CLOSEST(get_unaligned_le24(ev->latency)=
,
> +                                         1000);

Ditto as above.

>                 bis->iso_qos.bcast.in.sdu =3D le16_to_cpu(ev->max_pdu);
>
>                 if (!ev->status) {
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
