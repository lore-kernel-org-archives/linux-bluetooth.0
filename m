Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152751119C
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901854; cv=pass; b=ZKDKI/HdR092d0AhK0TIDUr/fhTr33R9vRVxo7O2wcCZPiOri3vpVXLjmjspoZ/YpnXMNlplGXwIWv47xkMjIgepBZOXBh2uwdZ977dNMxX+hfNMbYFzwXClZbTO2JN/BfzytlcIBJ14ru/oVCdy+9y5DjEEkHjOi54a8JOA5uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901854; c=relaxed/simple;
	bh=73gs90JNiq1dAIXiQ1ybKsUuegiCY1xQr4TK975IBsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNvz3ADpbbBNn95rVWLQyIIWU5UaWYImDByGJE0pntcimdVJnbJiGoBzTa3AeyprXc0qgzcF260gzRbd54YL+/V/9ZQvUH3QU6cQjTZjKSwGTbaXn0WZqopeSkVY75E2yoDneElgx3wcorivs1bupYV3CbQf/1QtOlwuSNL9M5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxSNiLtc; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxSNiLtc"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ace0741488so23791177b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791901851; cv=none;
        d=google.com; s=arc-20260327;
        b=DimzjbQqX6FPlBkHZ5NVei9GNYv75EfoWBr70Xp2/AE5RxzqFOiO9QbsGMeYdlw1W1
         SnDoUD2sBC/+LHeaHw/KGeoVLhEVjmBaPr9a8DdUah5vfVZqvAvmpCv4Z2JlivhVHfRd
         id7a6PWanLk6lI4y0huwdfDDuAdpyWAOJbAvm61Wzd4yMxxQHvkL2U8U0Z7281psvhnq
         VFJAQc4ONBBk6Tgz2m01xKCgTo+oLE62HgfU6GpFWmOodW3CzFTcNcOOUcAE8oi0D5Ja
         wJE8uA6rh85H4l0oYZjvQt2TNeb+kaTRgJSEbjCWLjq5a/qA6fl80xR5JcQXdVCb7wLd
         6a+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXsX6fDx0CyqTaqEZmI6agrsGcVKR9akpmws85ltFP4=;
        fh=bAf3uaujpCfZ+gfuJE9eD1gL5QYFdHZrAlQVfG7eWXo=;
        b=MgCWsHf8CiiKsayYPUD8C09sJY5UI2gBV96qVnJuLNAh9x3h55hhAfm4f277/KPsrD
         uwtmVRckW4cTeUxTVbSk+KAaaDbhWDZ+szYA+C7WYzL9Oe02EQz9gevrVTmw1N9Dc4UK
         BpDiFJDmZlEQv1/a6Djm4ZSV8g07X5897mDuSQxFMiuXvFGnWJFU2HRLr+0g68nktHNg
         NNt+Ym6y6ffb8AK30UQizt2HBIh0ckqZPZz8HxD70ShCw3MduAAFJ8sSAzem7C+kEyX8
         lpDA4MqExI2I3Ml1YG1Bt4FtXiShcqg++5vtiFwtv5vzGp27Fs4CJ1WZthHDBJPQe2/Z
         JBFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791901851; x=1792506651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IXsX6fDx0CyqTaqEZmI6agrsGcVKR9akpmws85ltFP4=;
        b=qxSNiLtcF0L7PUHJqG+I3pwrfrfW+35mf5F4Di+jGx4f/uT7A5tn0iUMKHo+ANtGA4
         kioRN4hNdFSyQRPeVdeDPFyffx/irkwy7Z6lKt2BYityrIXY9dRJETUDtDRaNOR4+M78
         0dta3EoerOP4di9wq0Tg6wsmfS4MvDeefiGpw85eC/VmKUDTaWwH54TEFNhFJMhZkOl/
         NyQKYT2OeJfu9rlBxvnBI6gnnLJcq/cgnQy5fR6sCOfHp1X4DzNpe0zdLHAIeoVBAWnS
         JMARYbhev5Uo7XGqBRXBmSM8cjgwwXk7lDe7ioJoxdif0bgrE1DAYU1YpXND8UQaQXj3
         GJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901851; x=1792506651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXsX6fDx0CyqTaqEZmI6agrsGcVKR9akpmws85ltFP4=;
        b=EunhyEkGIMAYfueKPu8kAeB7tYTZ1ahYsgIOsm4CeR3iuvBjy7ObRq40QM+IwMSx2Y
         rmsFCzf7dP9wB+Nr6x5kPsX0oVIZaV+sqNwCk8pyW0QQuxsEZSm/7H0bwQ9DvFUWc5GC
         ZTCzvCTcabuR41k4k6U3u49XUmskbpO9V/LC6B60gTJb8USzLVI6//hnExc33bzsSErg
         T5OwcoHMBY7cNzVmmyl4qBN+m53t7g6qYS/Rk+Q6Q9edH4ubee7Zwfp+FjU1GWkaYkE9
         4pTrIMPpYw0OvUJ/14x+SBolYOL6HNe6UYvfOGJfg3uH8S9flA533ze+XdKxnXQkqqRo
         7Cxw==
X-Gm-Message-State: AFq9FYI6/WMXPhini7x/UtTU6ZglfrxmZ1S0n5mQADSyImuVR3jimGwL
	K7jF39Uxs0APH/j6pKTEgZ0bLqCwE0DQo4rAbbz1JRAjiiKfUM1e/1oE+HOCSudBEK1nyCcsC3x
	hX5+JcE52NBOxHPk/Mf5cYqLcPkhbRLGb+QzU
X-Gm-Gg: AYBFou3wQgIn33ULvwHdTrcGMaXaD1Awxs7nDsyyqT+seutySkUBFpo1iDFcABa9qNL
	PqpWhPtEthnvSRtKeYmNgz5iMCVy6XK98rzCP9gj83z3P/Bi2g2QIUf9Oh4ppqeUt338iHl4sIN
	ulKEEJvrCjZhaqd1lbqi/PiQTzj9hSXV7JDE4x/TgpxhzcUow2hh2F8aB+0+PKGYwYnXJEZezjl
	Xncxk6vNwZon4w91t8hu7Y8qWjdF9mLWd/4v8bLZvyaz5QAAVtR/t6ntjvcu84lyCTHAwhPby9r
	K9+/JX2iZwvLIl1WTRBFrdjRq/nMxSvVFyCm+0b2oKdbplfxBz/gLEYR4tL0K8VdmBTdLm68J3i
	OUIlIuRQYE9T8a/dwU9UIhdAmT+oQ+iL+TaFQIIMLJQ==
X-Received: by 2002:a05:690c:289:b0:8b0:9eab:b77c with SMTP id
 00721157ae682-8b09eabc030mr20486377b3.55.1791901851244; Tue, 13 Oct 2026
 07:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013033452.505349-1-cochcoder@proton.me>
In-Reply-To: <20261013033452.505349-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Oct 2026 10:30:37 -0400
X-Gm-Features: AclHuK_oMNSxRAnbOM48dql5bbmgmTm3MXvHx8gS6jxubWXrUwvF8r5TZzMKgP8
Message-ID: <CABBYNZJ=cg5vK=_bmLd9XemzLrS7NtaUgMFj_-4afP1RnSY7Sg@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: hci_event: negotiate LE Data Length after features
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Mon, Oct 12, 2026 at 11:35=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> =
wrote:
>
> Request the controller transmit limits once both peers support DLE.
> Queue the connection with a reference so pending requests coalesce and
> connection deletion cancels them. Check the connection under the device
> lock before constructing the command.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Submission review notes (not part of the commit message):
> The user reports that retaining the explicit DLE request enables the N8
> to disconnect automatically after audio stops, whereas removing it
> leaves the device connected. This idle-transition behavior is the
> reported reason for retaining the topic, not an in-stream timeout.
> October 9 no-DLE trials already negotiate TX 251 octets / 2120 us and
> stream successfully; startup throughput alone does not test idle behavior=
.
> The supplied captures do not establish a controlled post-STOP comparison
> or the causal mechanism. This patch requests data length during setup;
> it does not itself implement STOP or issue a disconnect command.
> The claimed ASHA idle-disconnect requirement needs a protocol citation.
> The corrected ownership implementation is included in the working kernel.
> Native disconnect/handle reuse, LL ordering and post-snapshot races remai=
n
> unproved. Submit as an independent RFC with these limitations disclosed.
>
>  include/net/bluetooth/hci_sync.h |  1 +
>  net/bluetooth/hci_event.c        | 10 +++++++
>  net/bluetooth/hci_sync.c         | 47 ++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci=
_sync.h
> index 59cb918d1..5a37d3e50 100644
> --- a/include/net/bluetooth/hci_sync.h
> +++ b/include/net/bluetooth/hci_sync.h
> @@ -194,3 +194,4 @@ int hci_le_read_remote_features(struct hci_conn *conn=
);
>
>  int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
>  int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys);
> +int hci_le_set_data_len(struct hci_conn *conn);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c055d16cf..4035f2659 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6846,6 +6846,16 @@ static void hci_le_remote_feat_complete_evt(struct=
 hci_dev *hdev, void *data,
>                                 conn->le_tx_def_phys &=3D ~HCI_LE_SET_PHY=
_CODED;
>                                 conn->le_rx_def_phys &=3D ~HCI_LE_SET_PHY=
_CODED;
>                         }
> +
> +                       /* Request the controller maximum when both sides=
 support
> +                        * LL Data Length Extension. The Link Layer negot=
iates
> +                        * the remote limits (Core v5.4, Vol 6, Part B,
> +                        * Sec. 4.5.10).
> +                        */
> +                       if ((hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) =
&&
> +                           (conn->le_features[0] & HCI_LE_DATA_LEN_EXT) =
&&
> +                           hdev->le_max_tx_len > 0x001b)
> +                               hci_le_set_data_len(conn);

We use HCI_OP_LE_WRITE_DEF_DATA_LEN to setup this for every
connection, so either the controller has a bug and doesn't trigger
trigger DLE or something else is off here. In case it is really a
specific controller then we might need a quirk which once set by the
driver indicates the host has to perform the DLE procedure manually
like above.

>                 }
>
>                 if (conn->state =3D=3D BT_CONFIG) {
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index efbd2e538..20c690007 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -8123,3 +8123,50 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_ph=
ys, u8 rx_phys)
>
>         return (err =3D=3D -EEXIST) ? 0 : err;
>  }
> +
> +static void le_set_data_len_complete(struct hci_dev *hdev, void *data,
> +                                    int err)
> +{
> +       struct hci_conn *conn =3D data;
> +
> +       bt_dev_dbg(hdev, "err %d", err);
> +
> +       hci_conn_put(conn);
> +}
> +
> +static int hci_le_set_data_len_sync(struct hci_dev *hdev, void *data)
> +{
> +       struct hci_conn *conn =3D data;
> +       struct hci_cp_le_set_data_len cp;
> +
> +       hci_dev_lock(hdev);
> +
> +       if (!hci_conn_valid(hdev, conn) || conn->type !=3D LE_LINK ||
> +           (conn->state !=3D BT_CONNECTED && conn->state !=3D BT_CONFIG)=
) {
> +               hci_dev_unlock(hdev);
> +               return -ECANCELED;
> +       }
> +
> +       cp.handle =3D cpu_to_le16(conn->handle);
> +       cp.tx_len =3D cpu_to_le16(hdev->le_max_tx_len);
> +       cp.tx_time =3D cpu_to_le16(hdev->le_max_tx_time);
> +
> +       hci_dev_unlock(hdev);
> +
> +       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DATA_LEN,
> +                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +int hci_le_set_data_len(struct hci_conn *conn)
> +{
> +       struct hci_dev *hdev =3D conn->hdev;
> +       int err;
> +
> +       err =3D hci_cmd_sync_queue_once(hdev, hci_le_set_data_len_sync,
> +                                     hci_conn_get(conn),
> +                                     le_set_data_len_complete);
> +       if (err)
> +               hci_conn_put(conn);
> +
> +       return (err =3D=3D -EEXIST) ? 0 : err;
> +}
>
> base-commit: 964430c038967fd06643e866f68115664e1a1bd1
>


--=20
Luiz Augusto von Dentz
