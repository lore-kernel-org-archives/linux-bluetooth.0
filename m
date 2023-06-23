Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744ABEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 17:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjFWRh0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjFWRhZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 13:37:25 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D09411C
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 10:37:24 -0700 (PDT)
Received: from [192.168.1.195] (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Qnkvk5G2lz49Q1Q;
        Fri, 23 Jun 2023 20:37:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687541842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QS2dN9uF+/0eLOk7wH6uMxWHuATfpYau3T9s4H+0GNU=;
        b=dminLCjplfoE4Dqp0owpMPRfTNVouhLxlwT5LB62LlNSu/674OTZM1+1ZH0HhtPWnHROrD
        gvvujWT627uM4MuYR7Db1Q5Ko4/isxh++j+3TwisfIqZhmniPQI3vvg78Yc4zDjdIILpjn
        XZW1C/ywLUwFCnDoe/FzZhDqxAc3gixgzqIu2XFaEtx9DcqGNWGAHsSUbDni3pZ5ps79i2
        ZT0IQVcY52SdXcVdzi/k8XSwhBiAr7a3i/tHfnDFccGKHKkmsqx4cRGny5C7LFHPek2jbd
        F2+wOrrwpjX9UHpODo/G/C/dae9t9BzRADbvR7zuiQAwscTk7Qa2SFLCFCiMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687541842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QS2dN9uF+/0eLOk7wH6uMxWHuATfpYau3T9s4H+0GNU=;
        b=VrprvWvmdbu462JzpuBQa5hiF+gDNcIB5rF4Y5N7BOfQz13+OfNyo5NpRMkKyHhU/KUpLJ
        nnL2kb/kMA1bZRiSUTv9Ckomf40Wp1rCdcFfc/NVePF755SCN8aocNMWcF7WNJUnFZAcwo
        bYl1pB0ztcxBrN8Mtt6A0DdE8XFBfXXrrsnAt9TxsbCpIIO1YvG150YGDDHzwLQvQ8PjeI
        j4kZDV7rceVC1e1b5MrbrpIGaz7D6FYqOOJN4+TcDBrsTIrh7NQjir90lBhhf2ZdX9lrSY
        hitVRo7iFD2xYzIAQs90BjkOac7prj1yn0hwnGrxu+d2GIfRPQVbtkKuF1QRDw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687541842; a=rsa-sha256;
        cv=none;
        b=R/bj3LK4LVSzDk/QbONZD7r8jOWrosdBM6e/0DvX+T3c1a205xHT/6voCZyepwVqenUHuA
        YYJSM0FGMYXvu5h6hdeq7yjyw8pwUlpVFW5LhowE5K0uo5a5Swru2NBQ/y0nhuJrYLWgPs
        DFZLlCXK5lMQ3Zpd2XSoHI6dsQ2InC/51/fjO1OPVFmuZIHeGMcpaXvhvFBF7fSA/zLF3d
        Y+a1vx1CunDbdEI8pXplg6OBK5NfSgkanYDlSTuOF2osd0hjfbS/NutUH1AOWrcdGMv5DO
        ui9FZ7r8UFRzZAS7NQMN0Uth/fNEjHJgsIu+9Sd8ysJIZYcY8BIl8QLl0E8BnA==
Message-ID: <512cf6a2dd110bf634e391f92aa613ca44a7a756.camel@iki.fi>
Subject: Re: [PATCH v4] Bluetooth: hci_event: Fix parsing of CIS Established
 Event
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Fri, 23 Jun 2023 20:37:22 +0300
In-Reply-To: <20230622192722.1248374-1-luiz.dentz@gmail.com>
References: <20230622192722.1248374-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

to, 2023-06-22 kello 12:27 -0700, Luiz Augusto von Dentz kirjoitti:
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
> index b1aefe4bb751..049aa7f6a7c5 100644
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
> +	qos->ucast.in.latency =3D DIV_ROUND_CLOSEST(le16_to_cpu(ev->interval) *
> +						  125, 100);
> +	qos->ucast.out.latency =3D qos->ucast.in.latency;

In Set CIG Parameters:
u16 ucast.latency =3D Max_Transport_Latency (ms)
u32 ucast.interval =3D SDU_Interval (us)

Here:
u16 ucast.latency =3D ISO_Interval (ms)
u32 ucast.interval =3D Transport_Latency (us)

Currently BlueZ seems to not account for this swapping of the meanings
of the QoS fields, eg. in client/player.c it has

    num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
    ...
    ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000

and writes num packets in each interval.=C2=A0In the AX210 example it seems
this would give num =3D=3D 0. I guess this and other places that use these
need to be updated.

Since field meanings anyway change, would 1.25ms unit for the
ISO_Interval be better than 1ms so user side doesn't need to know how
kernel rounds the number and undo that to get the actual value?
=20
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

