Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9941DED7
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357005; cv=pass; b=UAeUcTVoy8MgDKuCMyWJo6bI5eBgq+12D+JbmUOyPTnQJO3nvB/E4s2RNkJJWkXWVGxUp4ovC4hBxzqS97S0Jd7xt6DkNAB+U+/uGCUxz07BfxjPwtnF9kG2ck6djGSQhjpLfZRnKCMsIRO2C245ucFIRia6azUTtQSzqIIQN4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357005; c=relaxed/simple;
	bh=RgjAtMc3dHSnlwBUGcad+AsXlhGSJoCOBAboOq2YUkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9JM+9j75PHBcZSG+3iMch1DTZTeykJ13qdy5ot/K5hE0MuNsnaQ+rPE/OgJiyaM3E87Dr0IO2gUFeAgcHvgpY+PBXaZb7BaIpEPcDZu5PT0tNIjhP+Y5b52tu8OAzaoCbGpgZUXsH1kmTxZorGRqnxjIm5xdgLseTGRBKkzboQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH5P54y4; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH5P54y4"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6676fc59e59so1555885d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783357002; cv=none;
        d=google.com; s=arc-20260327;
        b=gA37unqbCLZj9+C8XeKfff5wfnCM0mM35pu2LIOh4RhmNy1/lKpx80223LfOU6WgB2
         T6OqIqRT9DmQInXD8JMZ0s5VoiAFwvzNGmiLUqmmL0/sDCmhK+BTNXo4ppBJQ2Iwe1zp
         ylD97WIZoW2TxbE899p1fyIwW6LHN82Shf6OThAeBmkCjbSnVRkiznqRfo7jwQgyXA5K
         iJtvD9PWS14LxnOr5uxyy9kGQjtlTMmCWebSKx4tmrEy8JTAcuRGfl/H2zLwr0RU/6ZZ
         YX72Nv/cLdO6IHV33zz1GAOYzJZ7V06aNQCZJOfXwgGrEUBQfInZwOPuUC2VQN5RHTCk
         1zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kHWFCZLlUnsx1Rhs1xGVCE3nqb0AdCbJzZDlB02fhHk=;
        fh=1AwUxoBw+I/OhizjQFBo9pHcRDIr5FxK9lvk7ALSzr4=;
        b=PGOcShWTBz6lJVhgAYGt0c1ycwsT+sWY93G9PWnKELgG5kFny6hAXaDpCbUop8FE3p
         c7nBeChBUVCRfPIqTMYfoIH0p55q2g/L4eApV9iy0OFRzYoIDGsKSNiVlOzyMRR+coZ5
         i5KikKiE898ekjCbkUUqVfB/uGgvbIdU+B1QaJg57E7d22q9awyxuGjRWfcAryUcWIt6
         GG8XnFGQDg3jV6U3jfpEchbwCnWh0UuS7CVcQpTwoNWSi8UWNhnMfaX8oHQazfKTBttl
         t5J3U8wstYBviqFdGswHqEbw7if4sGLarkT0Saa1fJbaTUX6DxkYAJlOhO6gRtXmvLcT
         yciA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783357002; x=1783961802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kHWFCZLlUnsx1Rhs1xGVCE3nqb0AdCbJzZDlB02fhHk=;
        b=VH5P54y4xB8SHIccSbR5L1zEkRXWCTENIsAd9e0r93b0k9M4bQudIMrgy7tA5Aowl2
         zJnjvxqypjjixnj8d1iPF2+bh3IsY6i5A+L5TFwr00v67ANBi0lUULEKqoYSK12aDkhe
         X1m9Vvq37qDGuoz7Z2I2/HMODtfEDbTtoXzpRkRbJug4MScwcovtG29cOxZ/aVno7/k8
         btu5mzkmK5sb+Jl9hJHsykLgZDWGkNESi0asd3iZXazXPYVouPZ+L9FJjHmlwdwVmDs1
         /1/7lFIUoFxbKxuAneerkWYW0+iG2ZF9qeNsco2B080hDxZE7e7WcHs52ZzSVvZM339K
         EOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357002; x=1783961802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHWFCZLlUnsx1Rhs1xGVCE3nqb0AdCbJzZDlB02fhHk=;
        b=EHNGOEFlO7pQyRsbert+MVMuz0vdDORg7tNNGGKRmyBSpiLjfZhsDRS7PumQ03c5mm
         T5Lq8wAXeos5PQNa5djDiCObqMKsUgJTFXA6uVSG89VbVx1V3SQ3lZqyfBKquxeCj6wo
         wqtt4Xc+CmB3kAB4lKCU1oGyStYP3QSBH7J9Whi9y2S1h5ebDNXlrSgw81aeEZOK5y5n
         Umdl/i/boj6DEiDAITXs77MAX519pSSxTi7vRuJlOdTnjF++pf1GoqhffYCZI+fzKS4e
         aiQFcQgM1DmPt1QGRlWl/edubyYp71dTK0l3cBLxuwNH7/XqT3lYAVoRy4BfTaVw1x0H
         qluw==
X-Gm-Message-State: AOJu0YxAiL9MCOk4ag+NnLPc/Ebf4Z8uGduRvJIB8EmBz8Cl74NMSGm/
	SFamy0h6tkCf6ffrOkHXInrSLTiJ37oHD0KP7KX/4IYU6EEDZv6bwYcEgIJcZJ2Pu6JtGByTOIW
	TLq1u7ZWNI1JO7f9LpFOezfOovm4adiU=
X-Gm-Gg: AfdE7cmDXaNraRqOzY8QDmBgpVIqG+gyB5iI2de3zB9qaQSmeouiTYhXyka2IPnBC0A
	YcYav8TPyic0czSJfbWIflYZ8mU/AUSY3FlvcR9X/sDivAtOPU1IMZ577KzGQDF1WL8Km8EJ6sf
	F0shexhZ74LE51ANZl71HXLSN7blaeb9VqAg7IuBhUcY/ClSchlh6Mv9m6sV1eH2Y6P+eVQCpuT
	WIh335jorQoKcqy1Cv85QqXtUS+PKjNVeTKssCiBVuzO1GZKy3swAvlXXgSV6/Ui7yTmKwsnHYe
	vTdoAIDwHR42g9mOGl48EX6cYXS4dMUS7Or1Q+QsaPf4uuVLwFdGLtS9
X-Received: by 2002:a53:de45:0:b0:660:877f:a5bb with SMTP id
 956f58d0204a3-6677fc0b1eamr943835d50.51.1783357001949; Mon, 06 Jul 2026
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783275015.git.pav@iki.fi> <23725f0f3ad51aeece0501017e901d673876bc27.1783275015.git.pav@iki.fi>
In-Reply-To: <23725f0f3ad51aeece0501017e901d673876bc27.1783275015.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jul 2026 12:56:29 -0400
X-Gm-Features: AVVi8Cfk1noORp8LUi3-f0IvNiRaAZDp61rCzJ-Nfd0li7QASxhfWy6eWrtOxTs
Message-ID: <CABBYNZ++YgyOGAnvCVry7SgVC42NnsxCXHtT-Xciks4EdL3gPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Bluetooth: hci_sync: hold hdev->lock for
 hci_conn_params lookups
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Jul 5, 2026 at 6:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> hci_conn_params_lookup requires hdev->lock be held, otherwise the list
> iteration or param access is not safe.
>
> Hold hdev->lock for params lookups in hci_sync.
>
> Fixes: c530569adc19 ("Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     v2:
>     - no change
>
>  net/bluetooth/hci_sync.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5dddeed11372..edcaf72baf87 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6677,6 +6677,8 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>         if (!hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
>                 hci_pause_advertising_sync(hdev);
>
> +       hci_dev_lock(hdev);
> +
>         params =3D hci_conn_params_lookup(hdev, &conn->dst, conn->dst_typ=
e);
>         if (params) {
>                 conn->le_conn_min_interval =3D params->conn_min_interval;
> @@ -6690,6 +6692,8 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>                 conn->le_supv_timeout =3D hdev->le_supv_timeout;
>         }
>
> +       hci_dev_unlock(hdev);

Couldn't we make the hci_conn_params_lookup behave like
hci_pend_le_action_lookup and take a RCU read lock and then make
hci_conn_params_del use synchronize_rcu?

>         /* If controller is scanning, we stop it since some controllers a=
re
>          * not able to scan and connect at the same time. Also set the
>          * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
> @@ -7247,13 +7251,13 @@ static void create_pa_complete(struct hci_dev *hd=
ev, void *data, int err)
>  }
>
>  static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn=
 *conn,
> -                                  struct hci_conn *acl, struct bt_iso_qo=
s *qos)
> +                                  u16 acl_handle, struct bt_iso_qos *qos=
)
>  {
>         struct hci_cp_le_past_params cp;
>         int err;
>
>         memset(&cp, 0, sizeof(cp));
> -       cp.handle =3D cpu_to_le16(acl->handle);
> +       cp.handle =3D cpu_to_le16(acl_handle);
>         /* An HCI_LE_Periodic_Advertising_Sync_Transfer_Received event is=
 sent
>          * to the Host. HCI_LE_Periodic_Advertising_Report events will be
>          * enabled with duplicate filtering enabled.
> @@ -7318,16 +7322,26 @@ static int hci_le_pa_create_sync(struct hci_dev *=
hdev, void *data)
>          * 2. Check if that HCI_CONN_FLAG_PAST has been set which indicat=
es that
>          *    user really intended to use PAST.
>          */
> +       hci_dev_lock(hdev);
> +
>         le =3D hci_conn_hash_lookup_le(hdev, &conn->dst, conn->dst_type);
>         if (le) {
>                 struct hci_conn_params *params;
> +               u16 le_handle =3D le->handle;
>
>                 params =3D hci_conn_params_lookup(hdev, &le->dst, le->dst=
_type);

Aside from the RCU, couldn't we just unlock here so we don't have to
do it in every branch below?

>                 if (params && params->flags & HCI_CONN_FLAG_PAST) {
> -                       err =3D hci_le_past_params_sync(hdev, conn, le, q=
os);
> +                       hci_dev_unlock(hdev);
> +
> +                       err =3D hci_le_past_params_sync(hdev, conn, le_ha=
ndle,
> +                                                     qos);
>                         if (!err)
>                                 goto done;
> +               } else {
> +                       hci_dev_unlock(hdev);
>                 }
> +       } else {
> +               hci_dev_unlock(hdev);
>         }
>
>         /* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to up=
date
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
