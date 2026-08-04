Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602933D9558
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864299; cv=pass; b=owmmqN09TrALqCEWqghFUHIVBFTPdjiRdsfrBh4fFbHngL4HuwHAFExBAb6QoIk1uO5adk/JvxuAU8xHkGAQVJD19p17uQVDozSntsRvCy/TaGtSieaXyfuaxEcy5IBF3EViUjxtf4K1d4eenKHkubcwaEIDr3ThcyzovQafELs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864299; c=relaxed/simple;
	bh=8oq58Kw3e1RY5V+nPTqZEO2efIz4sFxYjBLsUf8jM28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRxmuw3xnmq9Xb1NfpABiW17cbtn+isJKMqWkkLpzSSn/LMhHabwU/4k6pgWz5R8S/G6LQwUMQ1xh+6zJUzmzAIaK07nB2tj6M3tQRg2xk35GxZ83bVpFxm1iWW0rHWViTChRLbCLu+6sRmjuuq3mw7JkET3z+1q/FE5PAZ45Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctNgKf42; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctNgKf42"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6680ae2031fso8227d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 10:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785864295; cv=none;
        d=google.com; s=arc-20260327;
        b=SrhAGI4Nrp6upSVLMjfQnMqMaVHp8ZhbwBZDqiKSRsFeyGM4+WHPyaKIrhy7b9S4/c
         sMtiJ1YLIUt/NVye9kOZujZo9CHOmRHlwr+BvXTZ+nla1807Mev9UR95twu+S5dtoIYD
         BoBVfaHjsI78Eqdi9Qc4jtIQq97/aZ74GRZ3fAzU2RljFKakj+G7P8vA3Hoy+OqzcV9m
         QY2D1CUrAKrHLQtmO0W9HqSSccP/pIzf++fMNIsf9Q5xh3x7F/H7Mim6AQxTh0zNoIWz
         g+QUgt4j7WHCkE2tk4ovZrYD5V/1l97Zf54lh5Xm8A/RcUcbcTSo4slFuZHjI7EONXNA
         dpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YCJrQoTfml5uDAW7GHqOcLpcahzFZHSJyluVSUxfSYM=;
        fh=fHcfxdJCBGnevrig1mfvrgHnJ0EwkobW6eG71zTUs9k=;
        b=E0UgmkenoRhdQmkf3GCcVcjpzIMewegD3AhTgZJ7mdedAJm5kDDZ2Y9E727Dg4A3Kg
         Db8cIhua2Lm54BU1orY5jF40OVdUKGqq6Up3b3OU8p/Ty+m/DPr15JQx7gh2ZnNDUF0a
         7uFzeAWhLFQMZMtyJV7FnA6CxomY7UP+sxAAbHtOI+sPXaFYSwcnGnte8oqP8aTyzw5y
         gAun6z71jVuGy3W8AvLT6f6uHYWlYyWzzJtzjwGqgKs9o19gRCEaJsRxujwvQl3EYN3q
         JKGb6bNiROeZ2OfVwKu7Aqw75IrvdMo69Qe/u57f3jlxqWAPgewugXdIeVTyde6Ii6Q5
         rMyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785864295; x=1786469095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YCJrQoTfml5uDAW7GHqOcLpcahzFZHSJyluVSUxfSYM=;
        b=ctNgKf4209RDSHk/UydzBmiasH0cWOIG1oI+AbgEB2ojKBh68rsm8ZeYWfvvFnFhkq
         Ti+nkg2gw4X+L9rG5jdNJy8MdMwAHKi+p0gxBNkmKLuqPMfaYV9LU9/+ozXej3X42e2z
         1VNx2iHmQxXbZWKIcT45etZa9Q+I+Mm2BPHV73U6Yr7fUFIA7+MbvorkYoeHkgZ7ahEn
         n1SCSBGV2kf5zB7wR7fqmFDZtAf24e5oNWv3o2M2F/FLwv2UC41g817zONaY/xAwX/lh
         5Ta3gZVXJ5nr7M6xdZYDgOwdu1GGYXvSAloXV4cBIpIpM/dLoKHJmj14gER8B8mQMLY9
         bBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864295; x=1786469095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCJrQoTfml5uDAW7GHqOcLpcahzFZHSJyluVSUxfSYM=;
        b=kXYcAmYWxdYialIfs2CErbWxqVUMxfkYKLdHAS+JVoVnDOy5AUFUhZxyGH5iczxYLD
         72wALBpLJf/c87l5imSM3zs5VFxB/1gDKgv9FmsHSdPk2+JRUAscoR3VavoYP33b48B6
         Ko47+WGtbAnx6+2etXtr1UGEGJFmvqbjCVTBLMK1TTEBTGSBGBKvmfkClNuTt+5alnt6
         T0AG7N+DiBfoBBw11TnLEX2NF7Ck9nAFwSt+TYeHUvi5fl38AQ7DddFVlZ7eC3JgzDOm
         9zSjjla+e8DCcjNdQPP9piXjQsW/tx6/2tGzV/XhZkfnr3Z2LaenZwpQh+520wYTHg+G
         4slQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCNqOfnppz/KQ/4gc3bzYzuW7n9Hw6RpOj5JpqTxuP3eeuZ0Hnvw6GBZZ2PWKp8+Wk96f3kTkTTiy9OlpWQjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFIVZvcrG67/I9KuTEZmiwzR+t170bbkUMNDsIhFgJQhgHqM1W
	etS60yfdFq8O+T6wTCiZBqvVCcfAUxAcjFhy+Qj7sjOi9IT6ol/Nkf+VYk14WttdCOwzr0Q99k6
	V8i56tq+wx2LlDbyMJSsI9dYvlULqkls=
X-Gm-Gg: AR+sD12Cadl6SnBaU6csOntM2Xt+jUxTkfSfmg/84NGMnavkzdCjNJOhVYqqxv7hXvk
	q2OlKxWkjG4zKeUFRpgL169hAuKpJ1LzZ0mpi1A3PF3HhzvACwwFymFy59Q/R9Og7/n0oFEjxas
	vPRNsqmVtZ/cPvR11ZVyJ6JbzYgpS/lrheZiNR3abA1RNisnShcgcka6AyctMQSB7GpPDLTi6X/
	D+Y8CDUVSckh56qX8WMjS3DZX/zXzbjdAbFBqiR7/VPSGQ9YRqdavvn43WGXwtpUdt6GtGthYHx
	QyRYotMJsmsF7EvLLTd/G2uIFL45S9ZlxadXVlT6yXOrBzWJH/wHMoPXckumqmH3Y97x5tZGXaT
	BdZbF6IBsO8Cg4oQderIFrCeutglbwn8mhdU=
X-Received: by 2002:a05:690e:4410:b0:664:ddca:8183 with SMTP id
 956f58d0204a3-6699abb1fe5mr202165d50.52.1785864295244; Tue, 04 Aug 2026
 10:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-qca_logs_enable-v2-1-587d584ef4c2@oss.qualcomm.com>
In-Reply-To: <20260804-qca_logs_enable-v2-1-587d584ef4c2@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Aug 2026 13:24:44 -0400
X-Gm-Features: AUfX_mxFhsqcpcjDD-uOrczblhUYQso4LgYYmrMNRKyCjeNfybAAYqJkcTz8CTo
Message-ID: <CABBYNZJjM6P_+-mGL3SewuHRdeKBU8_RHomZNy-8L6JtOaXfbA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Allow capturing QCA debug logs in
 snoop logs
To: Dishank Garg <dishank.garg@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	rahul.samana@oss.qualcomm.com, harshitha.reddy@oss.qualcomm.com, 
	yepuri.siddu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dishank,

On Tue, Aug 4, 2026 at 1:20=E2=80=AFAM Dishank Garg
<dishank.garg@oss.qualcomm.com> wrote:
>
> Add a debugfs flag to forward QCA diagnostic ACL packets as regular
> ACL data, enabling their capture in Bluetooth snoop logs.
>
> Signed-off-by: Dishank Garg <dishank.garg@oss.qualcomm.com>
> ---
> This series adds support for capturing QCA controller debug/diagnostic
> logs in Bluetooth snoop logs. Currently, ACL packets carrying QCA
> diagnostic data are intercepted and routed to the diagnostic layer via
> hci_recv_diag(), which means they never show up in snoop captures.
> This makes it hard to correlate QCA debug logs with the surrounding
> HCI/ACL traffic when debugging issues, since the two have to be
> captured and aligned separately.
>
> The series adds a new debugfs knob, diag_as_acl, under the hci_qca
> debugfs directory. When enabled, diagnostic ACL packets are forwarded
> through the normal ACL receive path instead of being diverted to the
> diagnostic layer, so they get captured in the standard Bluetooth snoop
> log alongside all other traffic.
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://patch.msgid.link/20260804-qca_logs_enable-v1-1-4e20=
9447da0e@oss.qualcomm.com
> ---
>  drivers/bluetooth/hci_qca.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 1222f97800f4..6996966319e8 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -182,6 +182,7 @@ struct qca_data {
>         u64 rx_votes_on;
>         u64 tx_votes_off;
>         u64 rx_votes_off;
> +       bool diag_as_acl;
>         u64 votes_on;
>         u64 votes_off;
>  };
> @@ -698,6 +699,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
>         debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retr=
ans);
>         debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
>                            &qca->tx_idle_delay);
> +       debugfs_create_bool("diag_as_acl", 0644, hdev->debugfs, &qca->dia=
g_as_acl);
>  }
>
>  /* Flush protocol data */
> @@ -998,12 +1000,14 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, =
struct sk_buff *skb)
>
>  static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> +       struct hci_uart *hu =3D hci_get_drvdata(hdev);
> +       struct qca_data *qca =3D hu->priv;
>         /* We receive debug logs from chip as an ACL packets.
>          * Instead of sending the data to ACL to decode the
>          * received data, we are pushing them to the above layers
>          * as a diagnostic packet.
>          */
> -       if (get_unaligned_le16(skb->data) =3D=3D QCA_DEBUG_HANDLE)
> +       if (!READ_ONCE(qca->diag_as_acl) && get_unaligned_le16(skb->data)=
 =3D=3D QCA_DEBUG_HANDLE)
>                 return hci_recv_diag(hdev, skb);

This is going backwards, we don't want to process the debug handles,
that is probably not using L2CAP, etc, so falling back to
hci_recv_frame is a bad idea like captured by sashiko:

https://sashiko.dev/#/patchset/20260804-qca_logs_enable-v2-1-587d584ef4c2%4=
0oss.qualcomm.com

Btw, the likes of hci_send_to_monitor do have support for
HCI_DIAG_PKT, so btmon don't have any problem decoding it, so either
you don't know what you are talking about or you are using a tool that
don't undertand vendor diagnostic monitor events (HCI_MON_VENDOR_DIAG)
see https://github.com/bluez/bluez/blob/master/doc/btsnoop-protocol.rst.

>
>         return hci_recv_frame(hdev, skb);
>
> ---
> base-commit: f5a7e2ae5f0a9a5caf59501457938eeb249a7dc8
> change-id: 20260803-qca_logs_enable-9b8197aaac09
>
> Best regards,
> --
> Dishank Garg <dishank.garg@oss.qualcomm.com>
>


--=20
Luiz Augusto von Dentz
