Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08720C8F0
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770671253; cv=pass; b=lhu1SFMhW++iaCR6CFhS7gM5c4qAGetra/UpNlfjYKoeuDRk8UWJadJ4OzLdlyJo2ABIJql15BIPoeWfGF0bQCxwgZbzu8Ia0iIyq1b9kLs36/L8S7snwcODFhOrdXPmapK7T8mXaEt2KUCFoFv0ZpfL3ArXSarP9vdNGkaOauI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770671253; c=relaxed/simple;
	bh=6lX6KfSLSlnGcw9LkhNC1YCYF5t9IC37P/s8cuQtlrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKAKSSpFKEQlUQ7z0WZqJqRbCclbV2pLE5tkWaNgEFLImuewPZvaLqznUNDjPH8M0u/jRnZAV4bea05YjCe3LFEiwLVkkjuWSrcIWqQ2ne/vhy5jaRyy/apqSjpfacD0u7tnpoJUYkNylBLtTQknKrlVRGNdTsHSwcFsqvRlziU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6n6U0K4; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6n6U0K4"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ae5f0777dso194072d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 13:07:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770671251; cv=none;
        d=google.com; s=arc-20240605;
        b=BvqdNjYr0cCNwVjx2TUneqAIjxTtZFNBneVImsgehMXMQxIYYKWKxOb1XqLWA25W+O
         9nMKwVrIPpHYDTZdIsnQJCqXeBFpg5jEW2XyGlRSCALaRz3D7VAxfmTmIa8/6QMPMqON
         1fvv7TIlfzaY/5fyZ573wq5spt1j377V5+Gg2G23fElayEeh+NNIZ1NKvessf95+S0Cf
         hFo1hZfMRyPo9+/Xv2uEEww1au/e/l89p+gHqtsQCscd2Z6HyWZ8L7E1VeZtfXi9Lmp9
         +5E6ljHNFpaMDByRPNiDqR3ai229wSCUBWfK7/9bdHrtlsW82mgHaxXrGnygMCFGIO+K
         6W+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=42WLa4n5qh0yIZ8zs8eeEqfQPaFzELfuoqMN1DcSWvA=;
        fh=jf0k0Oqa9xX8Ck2l94lUTtxB+ja/Kv+RIEGNjuW+Kcg=;
        b=F1xK6jhzpQHA4F/QiD7xRQ/NZhZlrL9MEOebbKf+zhP1/ck4NG61AOJZWL18NeIAqB
         9L2EUCjWmyq7+7LHSZQyRuAPX2SIUTpjoK1UxUnIK9xZ5bMwzy4O9MZYjV6uAUB27djR
         1GPurTgsLQynI2InEqUThNMmJSGd8jeCG23Jjkz4ennmFHylpeJ2bkvYGNZLqz/6AcQ3
         bYXLE6MEMKv51Ffm1W8LeImG717c0jCR/KHJdS7xhTcUp8A4DSCQfhwYiJCWJku1DFFt
         qraMsfTIyIbFNHQ13Kq4OWeS+HNWYeTByyGkNv1PcpX+cfYWQrde9wwoAdjnwBWp1BOR
         rbfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770671251; x=1771276051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42WLa4n5qh0yIZ8zs8eeEqfQPaFzELfuoqMN1DcSWvA=;
        b=m6n6U0K4SMRQvmPNyzx9tPS4oQJToHohT1gk79KxMLg3BpPiq/DJAqmv7ZfxuXSjrB
         d5ZLdxv1OV1+5pUkF//3NNGwICvFtn9n3jBVtDzCWOz7eTF/MIH4YGukwlkdnKe/pxnb
         r3g0k+oUSjEXFKTwttPnxNax8h0t3O96ElbbZ9zYGOQkfiPZMbZtnUlbRw7LrKq36mlW
         aKVkbZamT6CEUIowAgiNV2E8jZtbz/q/bwnWhnuJpnkGr0GU7aCfPQXZ1V0oCStw8IvD
         /tAskbwconbEux6PCdXwP72MEO5p1P9RBMb+840vvf5YDs2FSSTX+rx2lAs+mSrl+fC6
         wA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770671251; x=1771276051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=42WLa4n5qh0yIZ8zs8eeEqfQPaFzELfuoqMN1DcSWvA=;
        b=Yz9nPKw9eqU2kd0eHKW2Ic1+y6MRo19m/0j0t+TmPZkR6tBwDyg84ATFbQo+DMqLqH
         FztcLz3P1lRbkhKzaZuYY695u/P4RkYJaeMKfH0EKodleo99wlmjzc12/YtczHawkUDX
         ghSoWCNfZFHmVo6gvWiRaeXTPTQ9CS1i3bafNPhGJ3QOs660rUkHjZKbXhRXC82+HbbM
         lAyV/iVxa3FWeoNpktSxnCWOSyzgRgNjejbTHKkOFMS4cgi7Mt461qQR9P1gctZi3qCr
         4teh8QSpinwZ/QW0rpxjWF7yeekfnb56MDfxkQK2mVGINgSjF40k1CBUEnPYHXiVJtoP
         1woQ==
X-Gm-Message-State: AOJu0Yxy+0X0sfPwWRq9JV3lIaTOF6wv/mNB49E/LB9kqpZvWmO95f8D
	012033qeEsa6bFz1nbxeENBjkrkfv0KpqClrzKdyQw0VGHFwRzQ+4UraZs8mmSadCMo6/IygfH3
	ZlqSU7SOziSmq081y4y4Qce+V6fIG2Vs=
X-Gm-Gg: AZuq6aLZdLxgTEvGHtxaUFIVO+su7AVR2ke9OsUMYjCbahrXpxF6ZxwhDeY4a/hlyCH
	/RaPye/aqjA8lDH+4qBpn1i212BZjfwn4R8wO+3cZykW0SWQzy36W4CcBNznvR/t4CiNAyRmE92
	MVjxFBQotl7qRqNQPLEC11qEaqQvTSWZ4QYKoeAEgmincphBvd6oaVHvIsLRaopUQU+2Bal33Uw
	PYV75w+4iIfh7uFHUXXvRlQZyH6kfNJKe7v2DHMONpbdgrgfwp3kK0EknIp6x3K+ExLffxrZBuF
	TdUXf5BzVWi9Ee0LCRY28QCVEtUC3dY43wJqDD4pagdPV94NnQKa9tP+Jg==
X-Received: by 2002:a05:690c:b9c:b0:794:73f7:ff81 with SMTP id
 00721157ae682-7952aa64975mr251854947b3.14.1770671250823; Mon, 09 Feb 2026
 13:07:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224063439.2477969-1-mahesh.talewad@nxp.com>
 <20251224063439.2477969-2-mahesh.talewad@nxp.com> <CABBYNZ+zsqdf4rmO8e+rb1ZNxJRxC31K_aa8kCaOHp53BqGUKA@mail.gmail.com>
 <DB9PR04MB94526C8409BC4F75CCA79CBE898CA@DB9PR04MB9452.eurprd04.prod.outlook.com>
 <CABBYNZ+MN=f3chmT1zJnBTjmLLyz_tR36ivgaQXOWoVFYTAkgw@mail.gmail.com> <DB9PR04MB94527DD42500C2D579120B30898DA@DB9PR04MB9452.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB94527DD42500C2D579120B30898DA@DB9PR04MB9452.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Feb 2026 16:07:17 -0500
X-Gm-Features: AZwV_QiM3y0jWzb5hu7-slKFNSQMah5QJXBe0stA3_dxaqypO2IDWKXYAj-6dZs
Message-ID: <CABBYNZLAeXDfUX3p4zDJ+kZ7rDs0L2u-78sZ1mUO6zK9zrJx3A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous
 Connection Request command is handled in emulator.
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, 
	Vinit Mehta <vinit.mehta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Fri, Jan 16, 2026 at 10:15=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp=
.com> wrote:
>
> Hi Luiz,
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, January 15, 2026 8:30 PM
> To: Mahesh Talewad <mahesh.talewad@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole <devyani.godbole@nxp=
.com>; Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>; Vinit Mehta <vinit.meht=
a@nxp.com>
> Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous C=
onnection Request command is handled in emulator.
>
> Caution: This is an external email. Please take care when clicking links =
or opening attachments. When in doubt, report the message using the 'Report=
 this email' button
>
>
> Hi Mahesh,
>
> On Thu, Jan 15, 2026 at 7:47=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nx=
p.com> wrote:
> >
> > Hi Luiz,
> >
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Wednesday, January 14, 2026 7:54 PM
> > To: Mahesh Talewad <mahesh.talewad@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole
> > <devyani.godbole@nxp.com>; Sarveshwar Bajaj
> > <sarveshwar.bajaj@nxp.com>; Vinit Mehta <vinit.mehta@nxp.com>
> > Subject: [EXT] Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous Con=
nection Request command is handled in emulator.
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > Hi Mahesh,
> >
> > On Wed, Dec 24, 2025 at 1:30=E2=80=AFAM Mahesh Talewad <mahesh.talewad@=
nxp.com> wrote:
> > >
> > > Implemented the command - Enhanced Accept Synchronous Connection
> > > Request command in emulator[emulator/btdev.c].
> > >
> > > Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> > > ---
> > >  emulator/btdev.c | 64
> > > +++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 63 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/emulator/btdev.c b/emulator/btdev.c index
> > > be43623e8..55367cc7d 100644
> > > --- a/emulator/btdev.c
> > > +++ b/emulator/btdev.c
> > > @@ -3434,6 +3434,64 @@ static int cmd_get_mws_transport_config(struct=
 btdev *dev, const void *data,
> > >         return 0;
> > >  }
> > >
> > > +static int cmd_enhanced_accept_sync_conn_req(struct btdev *dev,
> > > +                               const void *data, uint8_t len) {
> > > +       const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cm=
d =3D data;
> > > +       uint8_t status =3D BT_HCI_ERR_SUCCESS;
> > > +
> > > +       if (cmd->tx_coding_format[0] > 5)
> > > +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> > > +
> > > +       cmd_status(dev, status,
> > > + BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int cmd_enhanced_accept_sync_conn_req_complete(struct btdev *=
dev,
> > > +                                       const void *data, uint8_t
> > > +len) {
> > > +       const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cm=
d =3D data;
> > > +       struct bt_hci_evt_sync_conn_complete cc;
> > > +       struct btdev_conn *conn;
> > > +
> > > +       memset(&cc, 0, sizeof(cc));
> > > +
> > > +       conn =3D queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
> > > +       if (!conn) {
> > > +               cc.status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> > > +               goto done;
> > > +       }
> > > +
> > > +       conn =3D conn_add_sco(conn);
> > > +       if (!conn) {
> > > +               cc.status =3D BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
> > > +               goto done;
> > > +       }
> > > +
> > > +
> > > +       cc.status =3D BT_HCI_ERR_SUCCESS;
> > > +       memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
> > > +
> > > +       cc.handle =3D cpu_to_le16(conn->handle);
> > > +       cc.link_type =3D 0x02;
> > > +       cc.tx_interval =3D 0x000c;
> > > +       cc.retrans_window =3D 0x06;
> > > +       cc.rx_pkt_len =3D 60;
> > > +       cc.tx_pkt_len =3D 60;
> > > +       cc.air_mode =3D cmd->tx_coding_format[0];
> >
> > Why are you harding most of the field above, aren't they available from=
 the cmd?
> > [Mahesh]: They aren't available from the cmd. Hence hardcoded.
>
> Well not the BT_HCI_EVT_CONN_REQUEST itself but the code that originate i=
t, which I believe to be cmd_enhanced_setup_sync_conn_complete, it does sto=
res bt_hci_cmd_enhanced_setup_sync_conn fields into conn->data which you sh=
ould probably use that. Btw, make use you run sco-tester with these changes=
 and the kernel changes to confirm it really works, you might want to run u=
sing test-runner:
>
> https://github.com/bluez/bluez/blob/master/doc/test-runner.rst
>
> [Mahesh] : bt_hci_cmd_enhanced_setup_sync_conn fields do not have tx_inte=
rval, retrans_window, rx_pkt_len, tx_pkt_len fields.
> Hence we can not use conn->data (which contains bt_hci_cmd_enhanced_setup=
_sync_conn fields), in cmd_enhanced_accept_sync_conn_req_complete().
> Same fields are hardcoded in func - sync_conn_init_complete(), also.

Looks like I never replied here. Yes, now I see why you need to
initialize it here. That said, we should probably use
sync_conn_init_complete then or maybe just call sync_conn_complete
since the function you are introducing appears to be a duplicate of
that.

> we are running sco-tester using test-runner using blow command
> sudo tools/test-runner -m -k /home/Documents/Kernel_Image/bzImage -- tool=
s/sco-tester
>
> With and without 'Enhanced Accept Synchronous Connection Request command'=
 code (both in emulator and kernel), below testcases(4) are failing:
> SCO CVSD Send - TX Timestamping                                        Fa=
iled
> SCO CVSD Send No Flowctl - TX Timestamping               Timed out
> SCO Ethtool Get Ts Info - Success                                        =
   Failed
> SCO Ethtool Get Ts Info No Flowctl - Success                       Failed
>
>
> > > +
> > > +done:
> > > +       send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc,
> > > +sizeof(cc));
> > > +
> > > +       if (conn)
> > > +               send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMP=
LETE,
> > > +                                                       &cc,
> > > + sizeof(cc));
> > > +
> > > +       return 0;
> > > +
> > > +}
> > > +
> > >  #define CMD_BREDR \
> > >         CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, \
> > >
> > > cmd_setup_sync_conn_complete), \ @@ -3471,7 +3529,10 @@ static int cm=
d_get_mws_transport_config(struct btdev *dev, const void *data,
> > >         CMD(BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG, cmd_get_mws_transpor=
t_config, \
> > >                                         NULL), \
> > >         CMD(BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN, cmd_enhanced_setup_s=
ync_conn, \
> > > -                                       cmd_enhanced_setup_sync_conn_=
complete)
> > > +                       cmd_enhanced_setup_sync_conn_complete), \
> > > +       CMD(BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST, \
> > > +                       cmd_enhanced_accept_sync_conn_req, \
> > > +                       cmd_enhanced_accept_sync_conn_req_complete)
> > >
> > >  static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
> > >                                                         uint8_t len)
> > > @@ -3604,6 +3665,7 @@ static void set_bredr_commands(struct btdev *bt=
dev)
> > >         btdev->commands[23] |=3D 0x04;    /* Read Data Block Size */
> > >         btdev->commands[29] |=3D 0x20;    /* Read Local Supported Cod=
ecs */
> > >         btdev->commands[29] |=3D 0x08;    /* Enhanced Setup Synchrono=
us Conn */
> > > +       btdev->commands[29] |=3D 0x10;    /* Enhanced Accept Sync Con=
nection */
> > >         btdev->commands[30] |=3D 0x08;    /* Get MWS Transport Layer =
Config */
> > >         btdev->cmds =3D cmd_bredr;
> > >  }
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
> >
> > Thanks and regards,
> > Mahesh Vithal Talewad
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
