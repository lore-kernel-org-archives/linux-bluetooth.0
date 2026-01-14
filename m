Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF8280331
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400676; cv=none; b=hRCRXFyJyfdJzyB9eIeEt4vtoQIG6drK6f8gIdBXj0EARvP+ifWxdUlyRhKNPn7Zm/uuXD2fs8Me65Ju7MeTsmLbC5G2+lBpGOLS/SRwbzNSLRBrUufIz/1o3IKsfe15WZWNzmqn97PDBNt01EC6y6ECOG/I9N4cknB1PjLbdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400676; c=relaxed/simple;
	bh=va0XmQImQD5JRc9CtXk3gcTToUJxruEUH8jhfHJFxBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9jmkFM+S6gE0Ls77CvindXgysHxJUeJ8siodwE0PmJ2ExMLTRIjAXTfcSCQIYxviAmmMXtRGLAuVM9qRbPl3TPu8eMDs9ZgC1o996IpJWt8l7oBKrCF1e9hVyhGAxL7htsECbrc1zrytJ5mc7rRq68CfOZzQOw9xdxZK0UkwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z06FQr2I; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z06FQr2I"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fc174ada4so81176177b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400672; x=1769005472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYNwB4R+v+F0+MWgInWWK39pHalCMZRumjXQxmXGNRs=;
        b=Z06FQr2I2UkK6966ISFL18BGFi94vlMsP6Q8SyMd2CFs9QngAYd0KwNVE0SM8PbDgE
         8R/cS2jzF0WLp2jARf/Vx74nglCdzE7FT/Jpd/oTLxSUM31hYNp+SWULlRzeRtqnzLOk
         e8slVlSivNBFmPoJ96sZciF6PnpuJmIvgfwXgpsY2g3BZ51neUYCfIGqZJlPwRRNHUOE
         cWQ01nkOMJrcHWzSh5D3Xw7wn+fxkr5Vn421B1OWsyfQTpDx7DdihNKBvNg7mD8+tdwf
         MThWS4fTKICDHPcxV49geMGapQQz2j8n27IoL/AfFhyX7/9OpfXqwLLg3ZzI2zRhodnK
         Rj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400672; x=1769005472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYNwB4R+v+F0+MWgInWWK39pHalCMZRumjXQxmXGNRs=;
        b=INE/QKLvnL/3RjrlV/vgQhzOE+/RC3l8QO2lVGmfzx3JyEni+kEPQjdR4Rwri5/njz
         IDA02lcAzjr+ahDCFUx/Ley+52tKm4J3ojGguOafsECP+u8BHePxC5FO67S89I0MU6JQ
         n9ma3XkZyZ5kTqrvRzYOfMMtnTYcF+1iXUkbRqh2b6i+EBH+aXALPqdC7suzqYyQKADG
         LCPeU/jZYYn2jO99mxp4IngH3Rgy79phMqnV9WKYlTz20/ugr2VwDR/fbLQQ57CDXgKe
         9kdR0FF5GxpvQo0dB6TfgiW8pjZsxGh8ukdema8JlpelBojUQVsd5ip58U4QlKp5BHsv
         nx0g==
X-Gm-Message-State: AOJu0YxoC205l47qWrURa28lezTSjzFZNMEF3Gk33hcBhweDmx6dLcjw
	2eLO7r3lEDXCRjwUwiA5DhNpWmfoFolpjiBqSeiZEjFt5DmxezVAwQWoFncVoEe5+sI6pCrumSV
	meQmNeVWRoUdFOMXioac/4Zczml5nIqs=
X-Gm-Gg: AY/fxX6Bkre7iL4iR7ujd4l7st5q3FWJ9F8X5LFDguxMgTnbnhkM9iq8rU7rgYltrua
	9CHn8sXUk6gUAVmfGpEGj+DLW/9n4Q1zWdtWlCG+Ri7pplzgG5IISycen+6c7/Xzt1LycSgqXWm
	e9BIKQHn8JnpvQ06x+/flAovt25nYxHrU6Pts6JkhDA7ZyjDnf3WAEbbL8t614wsETqMIqW4NjF
	/k8z62E4QoJiA7UYlioWEjWppbig/FPymT90pYtSx8KWYUICSEqLE/qq63EhqVf4RNtrKfVjfsR
	w5/ookOuhHlhFPtz3ZZzPmuc6RCDrqf51Ke0Xa5Y43sxDT+1BsDqcl198Q==
X-Received: by 2002:a05:690e:d4a:b0:644:60d9:8650 with SMTP id
 956f58d0204a3-64901b364dbmr1872104d50.95.1768400671545; Wed, 14 Jan 2026
 06:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224063439.2477969-1-mahesh.talewad@nxp.com> <20251224063439.2477969-2-mahesh.talewad@nxp.com>
In-Reply-To: <20251224063439.2477969-2-mahesh.talewad@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Jan 2026 09:24:20 -0500
X-Gm-Features: AZwV_QinJ-8uCG2WjA-KJni2MU3dWDuDeZWKkVjIHyIBwdUX5S4dk5XZi8DEX5o
Message-ID: <CABBYNZ+zsqdf4rmO8e+rb1ZNxJRxC31K_aa8kCaOHp53BqGUKA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous Connection
 Request command is handled in emulator.
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com, 
	sarveshwar.bajaj@nxp.com, vinit.mehta@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Wed, Dec 24, 2025 at 1:30=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> Implemented the command - Enhanced Accept Synchronous Connection Request
> command in emulator[emulator/btdev.c].
>
> Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> ---
>  emulator/btdev.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index be43623e8..55367cc7d 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -3434,6 +3434,64 @@ static int cmd_get_mws_transport_config(struct btd=
ev *dev, const void *data,
>         return 0;
>  }
>
> +static int cmd_enhanced_accept_sync_conn_req(struct btdev *dev,
> +                               const void *data, uint8_t len)
> +{
> +       const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cmd =
=3D data;
> +       uint8_t status =3D BT_HCI_ERR_SUCCESS;
> +
> +       if (cmd->tx_coding_format[0] > 5)
> +               status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +
> +       cmd_status(dev, status, BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQU=
EST);
> +
> +       return 0;
> +}
> +
> +static int cmd_enhanced_accept_sync_conn_req_complete(struct btdev *dev,
> +                                       const void *data, uint8_t len)
> +{
> +       const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cmd =
=3D data;
> +       struct bt_hci_evt_sync_conn_complete cc;
> +       struct btdev_conn *conn;
> +
> +       memset(&cc, 0, sizeof(cc));
> +
> +       conn =3D queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
> +       if (!conn) {
> +               cc.status =3D BT_HCI_ERR_INVALID_PARAMETERS;
> +               goto done;
> +       }
> +
> +       conn =3D conn_add_sco(conn);
> +       if (!conn) {
> +               cc.status =3D BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
> +               goto done;
> +       }
> +
> +
> +       cc.status =3D BT_HCI_ERR_SUCCESS;
> +       memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
> +
> +       cc.handle =3D cpu_to_le16(conn->handle);
> +       cc.link_type =3D 0x02;
> +       cc.tx_interval =3D 0x000c;
> +       cc.retrans_window =3D 0x06;
> +       cc.rx_pkt_len =3D 60;
> +       cc.tx_pkt_len =3D 60;
> +       cc.air_mode =3D cmd->tx_coding_format[0];

Why are you harding most of the field above, aren't they available from the=
 cmd?

> +
> +done:
> +       send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
> +
> +       if (conn)
> +               send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE=
,
> +                                                       &cc, sizeof(cc));
> +
> +       return 0;
> +
> +}
> +
>  #define CMD_BREDR \
>         CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, \
>                                         cmd_setup_sync_conn_complete), \
> @@ -3471,7 +3529,10 @@ static int cmd_get_mws_transport_config(struct btd=
ev *dev, const void *data,
>         CMD(BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG, cmd_get_mws_transport_co=
nfig, \
>                                         NULL), \
>         CMD(BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN, cmd_enhanced_setup_sync_=
conn, \
> -                                       cmd_enhanced_setup_sync_conn_comp=
lete)
> +                       cmd_enhanced_setup_sync_conn_complete), \
> +       CMD(BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST, \
> +                       cmd_enhanced_accept_sync_conn_req, \
> +                       cmd_enhanced_accept_sync_conn_req_complete)
>
>  static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
>                                                         uint8_t len)
> @@ -3604,6 +3665,7 @@ static void set_bredr_commands(struct btdev *btdev)
>         btdev->commands[23] |=3D 0x04;    /* Read Data Block Size */
>         btdev->commands[29] |=3D 0x20;    /* Read Local Supported Codecs =
*/
>         btdev->commands[29] |=3D 0x08;    /* Enhanced Setup Synchronous C=
onn */
> +       btdev->commands[29] |=3D 0x10;    /* Enhanced Accept Sync Connect=
ion */
>         btdev->commands[30] |=3D 0x08;    /* Get MWS Transport Layer Conf=
ig */
>         btdev->cmds =3D cmd_bredr;
>  }
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
