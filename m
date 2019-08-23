Return-Path: <SRS0=uRBT=WT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C81C3A5A2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Aug 2019 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A879622CE3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Aug 2019 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DQm5dXvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405740AbfHWNqF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:46:05 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:47268 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405715AbfHWNqD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Aug 2019 09:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HPIzUD59/XZrVzmZOsT4wg/CjbkQ6dTDP4VDgkOL5j0=; b=DQm5dXvtl9kX3mWWmltvM7iMmf
        T1e1eG+LOUGUMAXCqgUI7VI3aO4m5P+SIMvqMU0elGkkvceKZ3PsmuxneUSH0ZkC8xcXVVxUyNJVz
        zep2t0wkt8rXPqGXgWqbxyQ9dsl5iiVwJFaJKafgt9hg12JOZxZREXbAB2SMMBZQS1AM=;
Received: from p200300ccff081c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:1c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1i19tA-0005c0-M1; Fri, 23 Aug 2019 15:46:00 +0200
Date:   Fri, 23 Aug 2019 15:45:59 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Carey Sonsino <csonsino@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] bluetooth: update default BLE connection interval
 bounds
Message-ID: <20190823154559.1f203fac@aktux>
In-Reply-To: <1c707bb9-999b-7ca3-3c91-7b183dacfdd5@gmail.com>
References: <1c707bb9-999b-7ca3-3c91-7b183dacfdd5@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, 20 Aug 2019 11:01:41 -0600
Carey Sonsino <csonsino@gmail.com> wrote:

> Update the default BLE connection interval min/max bounds to the full=20
> range of permitted values (6-3200, corresponding to 7.25-4000ms).
>=20
> Commit c49a8682fc5d298d44e8d911f4fa14690ea9485e introduced a bounds=20
> check on connection interval update requests, but the default min/max=20
> values were left at 24-40 (30-50ms) which caused problems for devices=20
> that want to negotiate connection intervals outside of those bounds.
>=20
> Setting the default min/max connection interval to the full allowable=20
> range in the bluetooth specification restores the default Linux behavior=
=20
> of allowing remote devices to negotiate their desired connection=20
> interval, while still permitting the system administrator to later=20
> narrow the range.
>=20
> Fixes c49a8682fc5d: (validate BLE connection interval updates)
>=20
Trying pair XX:XX:XX:XX:XX:XX in bluetoothctl=20
leads to create connection commands containing
le_conn_max_interval > le_supv_timeout (4000ms > 420ms) which the
controller does not like and is imho not allowed.

< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr XX:XX:XX:XX:XX:XX type 0
    interval 96 window 96 initiator_filter 0
    own_bdaddr_type 0 min_interval 6 max_interval 3200
    latency 0 supervision_to 42 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x12 ncmd 1
    Error: Invalid HCI Command Parameters


> Signed-off-by: Carey Sonsino <csonsino@gmail.com>
>=20
> ---
>=20
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 04bc79359a17..f4f2f712c527 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3181,8 +3181,8 @@ struct hci_dev *hci_alloc_dev(void)
>  =C2=A0=C2=A0=C2=A0=C2=A0 hdev->le_adv_max_interval =3D 0x0800;
>  =C2=A0=C2=A0=C2=A0=C2=A0 hdev->le_scan_interval =3D 0x0060;
>  =C2=A0=C2=A0=C2=A0=C2=A0 hdev->le_scan_window =3D 0x0030;
> -=C2=A0=C2=A0=C2=A0 hdev->le_conn_min_interval =3D 0x0018;
> -=C2=A0=C2=A0=C2=A0 hdev->le_conn_max_interval =3D 0x0028;
> +=C2=A0=C2=A0=C2=A0 hdev->le_conn_min_interval =3D 0x0006;
> +=C2=A0=C2=A0=C2=A0 hdev->le_conn_max_interval =3D 0x0c80;
>  =C2=A0=C2=A0=C2=A0=C2=A0 hdev->le_conn_latency =3D 0x0000;
>  =C2=A0=C2=A0=C2=A0=C2=A0 hdev->le_supv_timeout =3D 0x002a;
>  =C2=A0=C2=A0=C2=A0=C2=A0 hdev->le_def_tx_len =3D 0x001b;

hmm, what happened with the tabs here? I needed to manually apply it.

Regards,
Andreas
