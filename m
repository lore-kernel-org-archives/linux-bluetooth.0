Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822F3D648C
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227755; cv=pass; b=vE9myihkOtN1O0WsVwfxF0dv0E7wDaOlIcLaYfJ3uTq/kx5Zri5pzoyeptiuO2vAo7YfhKh8MQPiUK/mmxzFk6aXuUmPX3GeL9ZHyIVXDAwDTZ9o9Z0G9/ypCwwxRXVLn4WnBWTWlh5KC/7j8oFfbchdFoM2VCzO6yf/LBIoFe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227755; c=relaxed/simple;
	bh=9FHNVmWcJBcG98C8NkFiK/TrxJ6VxfRitXrENJYTlIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO2GwxqXKW6hP1RFZ81N4V0ahL6gbMrX3NKNk8OPyRPTOf9VOjN2tTdupj5Jo/fQn7iLKERUczEgtLaFKhDjD7i9hPaf5zH51PBrt9YGeqGijRIOFTNRr3swpUelDxKxa9t5FWKGWAJ0Ws/Og2u+ZXiQ/mT6lEZNklhBiKWCBQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/o2AN2H; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/o2AN2H"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-662b95934dcso6150255d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 08:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227752; cv=none;
        d=google.com; s=arc-20240605;
        b=agKfYaeiUjSFPoeJRDfD2p5BF7Nav5f+2IGVRiGrQwx5n0tkN4LBM/ZRnqp5lg6jaZ
         7Za2FCg/o4p+GZoSwXVNlZ4qfQ2rTtLoRb2UeyaQdaOf5UZxH2FHa6EKVj14oZaaxZR8
         7DAlX9ruHbZ7symcCSZ8BPsjLppWljQSz95GZ540j1ypryrVc+n3FJzHNIKKenBQ9K7E
         8h6aF2Fq7X9TdXr2hDbK6xg6nuwqQyQRycuZv4BM+I6hu7LVSSDMuQHayqECq6ldosh7
         IqvK68u1w2FaGzRXuhNTMypSV6JL1X9t8BvJP/WBP67/GEM2NjSBXxXqA+1HTL8v1nHC
         cdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CXverWsEjFyfFL+7lJTDmK4Q98NaeiAYyXjXANHv5oI=;
        fh=Wc6KNPNA9TRA5puFYvYtZHOO+aJZk857HwKnQgXw0uo=;
        b=lu6f5CKUC/0mArfIYK6frS4VCSVRbjdcfU6+QRAoK9r7VK7tqxIbGV1yZlxNKrhNYd
         iqywwCgbf+GavyR+X9IhOpA64JRtcbEVCpX5FglmcCblFmnXUWyrhNp0HlsCm9yI7JAy
         UU0Y5jKVCUorFWZWpe8TD5cvbgdXtsqBxl9Q+0GiFg3LrqiZ/GPsWdsUc+F6QLV0Meza
         3kjr0U4FhYWVAgDCZhVrG7leMGrA6jAbq2gBd5aQtXzmWTSyh3wSIyagoJiP2vh2a9vj
         oaSqevoN57aCXabfZN4AOBL+2bwvQQDDZ8SplybfHrjkR3n3BckPc0zP7W72RjaQpIZb
         1s/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227752; x=1782832552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXverWsEjFyfFL+7lJTDmK4Q98NaeiAYyXjXANHv5oI=;
        b=M/o2AN2HGaSflj57EugfluUQ6dnsrt8ZbMkq/JFCBDYw5B57L29isU+LVNBCvJE8zf
         SElTZECdEhPfbxfyjSCvrlIVXtBfk+4uc42JPCDBaR0u7j8diShUFVrugAHcPCwmODKs
         Lfh57IUlG4Nv2OGg22NHJ/WFYrM8/TY5BHiICB3Velu9Fzs5b9+LAZAXuyHZqPP764F6
         eVmN6B06ZjfigevAwNB6IJsb5+l89uRaZbZ/4RbUpJ+yTYdKM4kDi0ESJABz7bntoi44
         R23/2AUHGPp5eQirmSc+S+hSfKzuRIpUcfYoycN0xxCkCFS7p8yRymELxOwf9bRg8LCx
         XmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227752; x=1782832552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CXverWsEjFyfFL+7lJTDmK4Q98NaeiAYyXjXANHv5oI=;
        b=s565QUSI1YxrOineruhwWfqmOIAJlDqtUsCQEyMYT0GqLNcBaXglryAWTrInqexHjO
         PSpOf/Ix22NtN6kxysGDW6dCaI4EIzhQVHWYmavJdy4Ll+hqqL48JXoL2QaxsiOTEmq2
         rdCw3bdP8dKl/cGtbLfMPhq68bXKMZf1ZMa5QDv4oOSE4m2LIyzkSrhhCNOU8dTRTTYK
         lLLnU7eiR+IPTr+iEesj6KVOwRWDyFjhLeE/8/no1UhobU7c+1DiF2vJvCWQz6umn9F9
         2toe0LFD+lXlZ/yHSGKouzlV87PMR6y4uzkXJityKNfq5Xr+8rWpI/8bwMO7WGhCSiW5
         rhPw==
X-Forwarded-Encrypted: i=1; AHgh+RrfLG4ks+gMXiPX93PhlhGAEnmofT2nDFFGv56EuRJ9e8fn4CS57L0/25lE0ALZlN7DYCZhxJB4fErwfPgHuz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjhrs3jYd87ezUdsvoFMil1r1xTkb9qGAPekQueaNHSj1I7iO
	RNjgzBNQSemcHf0hr8zXXw76ymYCkSoQkC7WldBnK2qtssyFG1OwKZsHxZv/5xAP18VUUvU2QkY
	1VqVz+HiE5CSpZEshCB+TTBNoqEqbDng=
X-Gm-Gg: AfdE7ckEv/z6g6+XhjbHj+u59HE5sXWez4KpFiwlGB/RYwpIy0Pvp+kl+VQoVq39lMg
	OkbhPLgUFpIOnYH8UZtGvxwnlM2o6siR+KEJHy11YFIIBDwBO4Jv2NtAa9+zVSpi6egMxSE9mfr
	2+Kxq4KlB2kNXSjHE0vHOCX357+hxK7/mHz3bN4ja+eO6K0lAjHGGP9mG23O4317/t99nP7UCNe
	2fgMi9vDnfRSUaqqdbv0Bh4oSKmlGrJIRE05Nn/HEBR/FCR4qJWpVjFmauQhRi8dlxhlYbpY3p+
	zayMNmTfe1Pwqqv5geXtGOeq6b1YV1wrFwB996cU47C3RFkdUapxokst6g7V1a3F81Vkgw==
X-Received: by 2002:a05:690e:1685:b0:661:1669:b784 with SMTP id
 956f58d0204a3-66359e1b367mr2989515d50.10.1782227752366; Tue, 23 Jun 2026
 08:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com> <20260622-bt_bugfix-v1-12-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-12-11f936d84e72@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jun 2026 11:15:40 -0400
X-Gm-Features: AVVi8CdjPC23MT8XtfsB0gA2x6V-ssAXhEUBUmsu09uEhc_AAYJZ5Stoac-Nuzg
Message-ID: <CABBYNZKx3+08Ajisy7-sHi0TZJNrbgzBzdszcKfiZUiNOdhByA@mail.gmail.com>
Subject: Re: [PATCH 12/13] Bluetooth: btqca: Fix undetected error HCI status
 in qca_send_reset()
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Ben Young Tae Kim <ytkim@qca.qualcomm.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Jun 22, 2026 at 10:52=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.co=
m> wrote:
>
> qca_send_reset() uses __hci_cmd_sync() which returns an skb but never
> reads the HCI status byte from skb->data[0], so a non-zero error status
> returned by the controller is silently ignored.
>
> Fix by replacing qca_send_reset() with __hci_reset_sync() which
> properly extracts and converts the HCI status byte to a negative errno.
>
> Fixes: 83e81961ff7e ("Bluetooth: btqca: Introduce generic QCA ROME suppor=
t")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 04ebe290bc78..875216e15603 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -190,25 +190,6 @@ static int qca_send_patch_config_cmd(struct hci_dev =
*hdev)
>         return err;
>  }
>
> -static int qca_send_reset(struct hci_dev *hdev)
> -{
> -       struct sk_buff *skb;
> -       int err;
> -
> -       bt_dev_dbg(hdev, "QCA HCI_RESET");
> -
> -       skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIME=
OUT);
> -       if (IS_ERR(skb)) {
> -               err =3D PTR_ERR(skb);
> -               bt_dev_err(hdev, "QCA Reset failed (%d)", err);
> -               return err;
> -       }
> -
> -       kfree_skb(skb);
> -
> -       return 0;
> -}
> -
>  static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
>  {
>         u8 cmd;
> @@ -990,7 +971,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baud=
rate,
>         }
>
>         /* Perform HCI reset */
> -       err =3D qca_send_reset(hdev);
> +       bt_dev_dbg(hdev, "QCA HCI_RESET");
> +       err =3D __hci_reset_sync(hdev);

So All the fuss about the reset is just to use it here? Actually the
distinction between -err and status is rather important. The first
means the command didn't run (timeout, cancel, etc), or it did run but
returned a status !=3D 0. If you want to capture both then you must use
if (err). And yes there are parts of the code that test for < 0, but
that is either a bug or they are intentionally ignoring the reset
status as it is probably a non-recoverable error at that point.

>         if (err < 0) {
>                 bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err)=
;
>                 return err;
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
