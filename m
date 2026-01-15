Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7353A783F
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489203; cv=none; b=HRnSSZLZNgRCHc1v6ZTUWOjYoI/q32/NvY0VjpqgOZAm5aRB51gG0bMGJM7RV7Dn/Q7XJpIytb72+jfUe9I0U5Sv+g1dLdaxiOy9IjcJvPAsLNS8svyLlpU8g5cyLMQSucua8RFz58sMEWfjN41WgyJuUX8o4x69t91WjMWvAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489203; c=relaxed/simple;
	bh=boOgKQtZFN6YSMkX+Y9tgZmPc9nFSgOFfjlcDlATSFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDY0l4Ec9ZbYxXufMAY7frfrQT5Il/M9TppPfN4xByyF3h4NqIjioth1MsodY+TxVvFnOVwY6NOjERN1X/vJJhnrOq8FTlbZl5MTG3ts7ou8vcba3Ca5y1ug6qbRJJrq6tlx5/wYP6XvgaZVsQLC11VG/UnvZRQrhmrgKh0D/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3a0kwhM; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3a0kwhM"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64471fcdef0so835668d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 07:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489199; x=1769093999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Da9o36po6DpJXa7tRUSiIR6OEN+tECYyvAnyGHKxEM=;
        b=P3a0kwhMmmwYyx032LHYSE0g9QYneQdxHxFbf/gZJPPgH3sXA5dWyJV4DO1ao492iN
         Sjh3ZOKcGknRpk/T+DffXZsuJ/Y49OcLBLR+1gURY+rbuNABvoplRvhl6vvvs9Xg/Ft+
         auq1DH7OVcqqrfDnNn4QVvKwiV967nvQI6d7aaOpPb/Mt637Uf91mUFopdjNlFz6RTQC
         ev9LEf3alRKRleMCtx4useTzD6hzbkPq1k41u/43wg50+00GKPKzKQ75wgGH/PLKWRld
         twmQKPuSRdQj/qw2j2JJa1i/litW+ub9bW9iSxA56/9VfQl8LRxdL/IhEUdFCuFlryLe
         1/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489199; x=1769093999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Da9o36po6DpJXa7tRUSiIR6OEN+tECYyvAnyGHKxEM=;
        b=f/Ye17BfMMqkg66WZpq9BNoTdZyoD+fTOHeJDVirvxhcrKyb6TftTq7qllPn7tfhHy
         EeYQQ73M8fwDf8VC6WM/VJQ1rhQ7dQc8pAHxOSrx836vjT2I82M5VR6/ePSvObKw99aQ
         /D81Qv9/jLYjBsGOLe7qt2rhUhSK+i6SwkeK5+k1e4iY6c3mGIr56osX2iL3h2IqIylG
         8V8cW7bsVFFKr1uUoDE5Ues8Rbyme0dabigoGkUL/1t+gPz3aUOZCS/c4+SOelf0F0v/
         bcVr/zeT0fWjxoq3u1pTHbX7ZFfhgvNygIuKj9rnpLKuvZIYAkk1hj4GFmn2QF3dQI1C
         0L8Q==
X-Gm-Message-State: AOJu0Yzv2G8+X9Pe22VUkmaSAYCdH0DBNWDLbORsiU3gMe0bjrYYQc4S
	cc47qSy7xnto9FzEHh32vnRGJE0U8gPJJcbRR042Ca9VltPCxURLA0pWdYrv2h8L+cRGk31vAnK
	XbP9JEUo/aItzQgWUJEjsOmWBnWTvo5s=
X-Gm-Gg: AY/fxX4tgppJLh1a3+ayVXnWL28aj/0bFB6wythYCOC14jYgOM5J1Sc+dRYk5Pq1nIF
	5hpryFmQaHJ9FJIseXZVTwWRNkOkyBXLLpUptfft7N9z/j5BeWCR9P6Me2QwUi8i9cw5W+CKoii
	d7rId9z1NYMP08prJeeVrbPhWw7OcrRMRGw7f0B48y8BFvYJnxKYreAGp6Id+33iOIBzLyrTWWM
	EjaAu6u2k7lSTlqSIxROkyK3LC1bjlEhiEjJd10zE1fHfMKjHY4m/IaeKIB0R2sK5q6Mn6H0bz2
	Cj2JD/q6p2AnlP6Exba9UvxkAankpHsDvzXnXT2r9aZ1tvCO1b50ZldTVQ==
X-Received: by 2002:a05:690c:6a06:b0:789:3f0f:ac6a with SMTP id
 00721157ae682-793a19ba6e5mr121425417b3.16.1768489198800; Thu, 15 Jan 2026
 06:59:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224063439.2477969-1-mahesh.talewad@nxp.com>
 <20251224063439.2477969-2-mahesh.talewad@nxp.com> <CABBYNZ+zsqdf4rmO8e+rb1ZNxJRxC31K_aa8kCaOHp53BqGUKA@mail.gmail.com>
 <DB9PR04MB94526C8409BC4F75CCA79CBE898CA@DB9PR04MB9452.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB94526C8409BC4F75CCA79CBE898CA@DB9PR04MB9452.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Jan 2026 09:59:47 -0500
X-Gm-Features: AZwV_Qjsbq2WgScIde7Fmxsm56LRh-WQIvmVjhesEbPypbIW066yHHm0bLBvppY
Message-ID: <CABBYNZ+MN=f3chmT1zJnBTjmLLyz_tR36ivgaQXOWoVFYTAkgw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous
 Connection Request command is handled in emulator.
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, 
	Vinit Mehta <vinit.mehta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Thu, Jan 15, 2026 at 7:47=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> Hi Luiz,
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, January 14, 2026 7:54 PM
> To: Mahesh Talewad <mahesh.talewad@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole <devyani.godbole@nxp=
.com>; Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>; Vinit Mehta <vinit.meht=
a@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous Conne=
ction Request command is handled in emulator.
>
> Caution: This is an external email. Please take care when clicking links =
or opening attachments. When in doubt, report the message using the 'Report=
 this email' button
>
>
> Hi Mahesh,
>
> On Wed, Dec 24, 2025 at 1:30=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nx=
p.com> wrote:
> >
> > Implemented the command - Enhanced Accept Synchronous Connection
> > Request command in emulator[emulator/btdev.c].
> >
> > Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> > ---
> >  emulator/btdev.c | 64
> > +++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/emulator/btdev.c b/emulator/btdev.c index
> > be43623e8..55367cc7d 100644
> > --- a/emulator/btdev.c
> > +++ b/emulator/btdev.c
> > @@ -3434,6 +3434,64 @@ static int cmd_get_mws_transport_config(struct b=
tdev *dev, const void *data,
> >         return 0;
> >  }
> >
> > +static int cmd_enhanced_accept_sync_conn_req(struct btdev *dev,
> > +                               const void *data, uint8_t len) {
> > +       const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cmd =
=3D data;
> > +       uint8_t status =3D BT_HCI_ERR_SUCCESS;
> > +
> > +       if (cmd->tx_coding_format[0] > 5)
> > +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> > +
> > +       cmd_status(dev, status,
> > + BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cmd_enhanced_accept_sync_conn_req_complete(struct btdev *de=
v,
> > +                                       const void *data, uint8_t len)
> > +{
> > +       const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cmd =
=3D data;
> > +       struct bt_hci_evt_sync_conn_complete cc;
> > +       struct btdev_conn *conn;
> > +
> > +       memset(&cc, 0, sizeof(cc));
> > +
> > +       conn =3D queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
> > +       if (!conn) {
> > +               cc.status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> > +               goto done;
> > +       }
> > +
> > +       conn =3D conn_add_sco(conn);
> > +       if (!conn) {
> > +               cc.status =3D BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
> > +               goto done;
> > +       }
> > +
> > +
> > +       cc.status =3D BT_HCI_ERR_SUCCESS;
> > +       memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
> > +
> > +       cc.handle =3D cpu_to_le16(conn->handle);
> > +       cc.link_type =3D 0x02;
> > +       cc.tx_interval =3D 0x000c;
> > +       cc.retrans_window =3D 0x06;
> > +       cc.rx_pkt_len =3D 60;
> > +       cc.tx_pkt_len =3D 60;
> > +       cc.air_mode =3D cmd->tx_coding_format[0];
>
> Why are you harding most of the field above, aren't they available from t=
he cmd?
> [Mahesh]: They aren't available from the cmd. Hence hardcoded.

Well not the BT_HCI_EVT_CONN_REQUEST itself but the code that
originate it, which I believe to be
cmd_enhanced_setup_sync_conn_complete, it does stores
bt_hci_cmd_enhanced_setup_sync_conn fields into conn->data which you
should probably use that. Btw, make use you run sco-tester with these
changes and the kernel changes to confirm it really works, you might
want to run using test-runner:

https://github.com/bluez/bluez/blob/master/doc/test-runner.rst

> > +
> > +done:
> > +       send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc,
> > +sizeof(cc));
> > +
> > +       if (conn)
> > +               send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLE=
TE,
> > +                                                       &cc,
> > + sizeof(cc));
> > +
> > +       return 0;
> > +
> > +}
> > +
> >  #define CMD_BREDR \
> >         CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, \
> >                                         cmd_setup_sync_conn_complete),
> > \ @@ -3471,7 +3529,10 @@ static int cmd_get_mws_transport_config(struct=
 btdev *dev, const void *data,
> >         CMD(BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG, cmd_get_mws_transport_=
config, \
> >                                         NULL), \
> >         CMD(BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN, cmd_enhanced_setup_syn=
c_conn, \
> > -                                       cmd_enhanced_setup_sync_conn_co=
mplete)
> > +                       cmd_enhanced_setup_sync_conn_complete), \
> > +       CMD(BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST, \
> > +                       cmd_enhanced_accept_sync_conn_req, \
> > +                       cmd_enhanced_accept_sync_conn_req_complete)
> >
> >  static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
> >                                                         uint8_t len)
> > @@ -3604,6 +3665,7 @@ static void set_bredr_commands(struct btdev *btde=
v)
> >         btdev->commands[23] |=3D 0x04;    /* Read Data Block Size */
> >         btdev->commands[29] |=3D 0x20;    /* Read Local Supported Codec=
s */
> >         btdev->commands[29] |=3D 0x08;    /* Enhanced Setup Synchronous=
 Conn */
> > +       btdev->commands[29] |=3D 0x10;    /* Enhanced Accept Sync Conne=
ction */
> >         btdev->commands[30] |=3D 0x08;    /* Get MWS Transport Layer Co=
nfig */
> >         btdev->cmds =3D cmd_bredr;
> >  }
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz
>
> Thanks and regards,
> Mahesh Vithal Talewad



--=20
Luiz Augusto von Dentz
