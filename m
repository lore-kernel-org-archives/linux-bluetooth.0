Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22432EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 20:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFUUdV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFUUdU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 16:33:20 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21519A3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 13:33:16 -0700 (PDT)
Received: from [192.168.1.195] (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QmZvS4h8QzyYc;
        Wed, 21 Jun 2023 23:33:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1687379588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXeEVG+xQhvVQ6S2htfYFX/cZ92tXBntMV9plGcFKQw=;
        b=uWuPW+z/SolElG401hO7m1ym81YOEqBWdFKyscBv4gAG8s4AF34FcIqiVlR4IICR2B4/LG
        ckcsfZu9qNSGbBRtNZEqxndP0I/y+IyNSRIRS/PyKo0rtZkmLHem2c4MMc80lFgEJdSRoD
        2prY5DcPzUYOZfb5qid49JOy/WjrZ60=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1687379588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXeEVG+xQhvVQ6S2htfYFX/cZ92tXBntMV9plGcFKQw=;
        b=p4oCbEpqKiV557QKkExgP9JEls7LXHIc1DtVLjiBli4drm+MzydYkIPPaBpRxRCc8Ox60d
        tuweSAwwOk/KJUY/dsRBJ8kr9CJuy26UEUqS3kUvxj2T0rw/rWa835sQue7/607hsE5pR9
        nTiKWEge+7jgECI45ndroWyjdf1Sq1k=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1687379588; a=rsa-sha256; cv=none;
        b=JNIlgVO8K/xZTWLAzMfme5DGJ6z25hm6RVhVURHuJ59Sso39rjYF/tqKjtp/ujXh70Qr4c
        +O++ELPvfu1I0CWZC47cVYN8zS6gv3czwhQqEeJhdRub/p3SJ464u+MN4P9GDZw48dr5Zj
        HBZMgnHUEk+rPj5XDAC/CDXDY3yvcSc=
Message-ID: <66add9bf780aca773d41cce3ea42589388de2543.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Fix parsing of CIS Established
 Event
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Wed, 21 Jun 2023 23:33:08 +0300
In-Reply-To: <20230621195407.977001-1-luiz.dentz@gmail.com>
References: <20230621195407.977001-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ke, 2023-06-21 kello 12:54 -0700, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> The ISO Interval on CIS Established Event uses 1.25 ms slots:
>=20
>     BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>     page 2304:
>=20
>       Time =3D N * 1.25 ms
>=20
> In addition to that this always update the QoS settings based on CIS
> Established Event.
>=20
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_event.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b1aefe4bb751..6fca6d9f1b34 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hci_=
dev *hdev, void *data,
>  {
>  	struct hci_evt_le_cis_established *ev =3D data;
>  	struct hci_conn *conn;
> +	struct bt_iso_qos *qos;
>  	bool pending =3D false;
>  	u16 handle =3D __le16_to_cpu(ev->handle);
> =20
> @@ -6846,21 +6847,30 @@ static void hci_le_cis_estabilished_evt(struct hc=
i_dev *hdev, void *data,
> =20
>  	pending =3D test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
> =20
> -	if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> -		__le32 interval;
> +	qos =3D &conn->iso_qos;
> =20
> -		memset(&interval, 0, sizeof(interval));
> +	/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> +	qos->ucast.in.latency =3D le16_to_cpu(ev->interval) * 125 / 100;
> +	/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> +	qos->ucast.out.latency =3D le16_to_cpu(ev->interval) * 125 / 100;
> =20
> -		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
> -		conn->iso_qos.ucast.in.interval =3D le32_to_cpu(interval);
> -		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
> -		conn->iso_qos.ucast.out.interval =3D le32_to_cpu(interval);
> -		conn->iso_qos.ucast.in.latency =3D le16_to_cpu(ev->interval);
> -		conn->iso_qos.ucast.out.latency =3D le16_to_cpu(ev->interval);
> -		conn->iso_qos.ucast.in.sdu =3D le16_to_cpu(ev->c_mtu);
> -		conn->iso_qos.ucast.out.sdu =3D le16_to_cpu(ev->p_mtu);
> -		conn->iso_qos.ucast.in.phy =3D ev->c_phy;
> -		conn->iso_qos.ucast.out.phy =3D ev->p_phy;
> +	switch (conn->role) {
> +	case HCI_ROLE_SLAVE:
> +		qos->ucast.in.interval =3D get_unaligned_le24(ev->c_latency);
> +		qos->ucast.out.interval =3D get_unaligned_le24(ev->p_latency);
> +		qos->ucast.in.sdu =3D le16_to_cpu(ev->c_mtu);
> +		qos->ucast.out.sdu =3D le16_to_cpu(ev->p_mtu);
> +		qos->ucast.in.phy =3D ev->c_phy;
> +		qos->ucast.out.phy =3D ev->p_phy;
> +		break;

Are the ucast.latency and ucast.interval the right way around here?

When I trying to use this in userspace, I expected ucast.interval
contains the ISO interval, because in Set CIG Parameters we use
ucast.interval to specify the SDU_Interval, and ucast.latency is used
for the Transport_Latency_C_To_P and Transport_Latency_P_To_C.

With real numbers the event (AX210<->AX210) looks like this

> HCI Event: LE Meta Event (0x3e) plen 29               #3493 [hci0] 486.97=
8955
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 2560
        CIG Synchronization Delay: 4020 us (0x000fb4)
        CIS Synchronization Delay: 4020 us (0x000fb4)
        Central to Peripheral Latency: 94020 us (0x016f44)
        Peripheral to Central Latency: 94020 us (0x016f44)
        Central to Peripheral PHY: LE 2M (0x02)
        Peripheral to Central PHY: LE 2M (0x02)
        Number of Subevents: 2
        Central to Peripheral Burst Number: 1
        Peripheral to Central Burst Number: 1
        Central to Peripheral Flush Timeout: 10
        Peripheral to Central Flush Timeout: 10
        Central to Peripheral MTU: 240
        Peripheral to Central MTU: 120
        ISO Interval: 8


> +	case HCI_ROLE_MASTER:
> +		qos->ucast.out.interval =3D get_unaligned_le24(ev->c_latency);
> +		qos->ucast.in.interval =3D get_unaligned_le24(ev->p_latency);
> +		qos->ucast.out.sdu =3D le16_to_cpu(ev->c_mtu);
> +		qos->ucast.in.sdu =3D le16_to_cpu(ev->p_mtu);
> +		qos->ucast.out.phy =3D ev->c_phy;
> +		qos->ucast.in.phy =3D ev->p_phy;
> +		break;
>  	}
> =20
>  	if (!ev->status) {

--=20
Pauli Virtanen
