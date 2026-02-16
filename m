Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CA4502A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257779; cv=none; b=VXMfMsEHk/CafgdRfv6bvgeXMMIZZ02UmKnfaFOA1zskMEiOSLOaZPux4attb082/Wetbt9alidRLd/39BLkmwcJls9Q0XZ9eEKgYVX6/BS9qmyck4rKsli9yOEyoteaZGptPpc9nT3FuqYjIDbGhOs+JEjJ9Bg+gdQKaaKmVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257779; c=relaxed/simple;
	bh=v+Xm4hz8UQFQCCoWjiJZ1qnBQX/DEMOj+dum6T/tWPI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdI3MksbRWTmGUgPt59VhPT8zeS5Fsj3YOC+zlJts855McZNsapos04tQSIXch8vk5HIKPcGsOgw55KJ18W5I3IN3sGZodkh/AkmiWkK698e8C4NSeI7qKkbn3scr12IX8Htt006JnS8F1popKhEPIQfNIA2pqRvUnVX97NiTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxsSqt8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxsSqt8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC28FC2BC87
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771257779;
	bh=v+Xm4hz8UQFQCCoWjiJZ1qnBQX/DEMOj+dum6T/tWPI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=lxsSqt8HD+6BIpA75Bxc5QgEhPajmuxAol7Tkr6yYSsOdGVSRYK+eTGilcZniK+8x
	 k5L/ebksjt0M/KBoJbNJ5kzZyDVejYv+1rrNuZNLdw73NxajPH7cNdmo70fQGKrOoo
	 BtVrLxfBlyNGrb6AFX29TOrGtkmP7Vt7gveUwno9aqaeDzSYuW1FsGohgXyrUAkqcq
	 9+Ylermj4N66gru34xoIIxLhvkuQLTOYDhbZZEoUcAl6zKRfJICbPt0/mD+JlU2Pck
	 oIQ7f7TKPWNUHm0kUxX7wpibmxMnOnA6+ufq39gbfBUOPz/z1dCaCD+htO2cLGwUS4
	 66CiByvoAmHcg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38709888abeso25610931fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 08:02:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ92Lfpo5pLAeeM4RuafGmWUBuLu/uzcZfEwzSaEK5A0VnLiTA6rx4IfTs+gezGIN2JSGdnJxs+fLIjHB+RGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbQ6pv1M7oz6AJu0ERrAQg1ZLspEOpuLKqoaK0+IpAse/82g5
	q2lbCEDepyL4oA36fkSWrhkM6QEpyg9IhqTUJDjAjgNTe4FpI11zOhy/4VarGuOlNqZ5P6BFlpA
	ciZEB1hASWVF+J/AkdTKOpfrNmjXZgGBeWUry1D1fRw==
X-Received: by 2002:a2e:a913:0:b0:387:c42:f6c2 with SMTP id
 38308e7fff4ca-3881052574fmr34595291fa.16.1771257777426; Mon, 16 Feb 2026
 08:02:57 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Feb 2026 08:02:56 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Feb 2026 08:02:56 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260212141721.69961-2-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com> <20260212141721.69961-2-johannes.goede@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 08:02:56 -0800
X-Gmail-Original-Message-ID: <CAMRc=Md0gdOVOzwaVZNf52ZgQ9uw1Vn+e05Fvc44ZdLtrKezLg@mail.gmail.com>
X-Gm-Features: AaiRm52OOfO2fZk9Ikgj3W8D7regZzNn9lCNsLVvm_J-4u9S2Ct1iCvGIHfI_mo
Message-ID: <CAMRc=Md0gdOVOzwaVZNf52ZgQ9uw1Vn+e05Fvc44ZdLtrKezLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: Fix BT not getting powered-off on rmmod
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Feb 2026 15:17:21 +0100, Hans de Goede
<johannes.goede@oss.qualcomm.com> said:
> The BT core skips calling the hci_dev's shutdown method when the HCI
> is unregistered. This means that qca_power_off() was not getting called
> leaving BT powered on.
>
> This causes regulators / pwrseq providers to not get disabled which also
> causes problem when re-loading the module because regulators and pwrseq
> providers have an enablecount which now has never dropped to 0, causing
> the BT to not get properly reset between rmmod and re-load which causes
> initialization failure on the re-load.
>
> Fix this by calling qca_power_off() from qca_close() when BT has not
> already been powered off through a qca_hci_shutdown() call.
>
> hci_ldisc.c will call qca_close() after freeing the hdev, so this
> means that qca_power_off() can now no longer deref hu->hdev, change
> the logging in qca_power_off() to no longer use hu->hdev.
>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index fa7ab4272771..9993e748b56c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -721,6 +721,10 @@ static int qca_close(struct hci_uart *hu)
>
>  	BT_DBG("hu %p qca close", hu);
>
> +	/* BT core skips qca_hci_shutdown() which calls qca_power_off() on rmmod */
> +	if (!test_bit(QCA_BT_OFF, &qca->flags))
> +		qca_power_off(hu);
> +
>  	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
>
>  	skb_queue_purge(&qca->tx_wait_q);
> @@ -2220,7 +2224,7 @@ static void qca_power_off(struct hci_uart *hu)
>  		qca_regulator_disable(qcadev);
>  		if (qcadev->sw_ctrl) {
>  			sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
> -			bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
> +			BT_DBG("SW_CTRL is %d", sw_ctrl_state);
>  		}
>  		break;
>
> --
> 2.52.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
