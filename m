Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD151F099C
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097300; cv=pass; b=h3lxJMw3nnlmoybNplRziD9kESEodmcnEqhSPS8+ISNwns4zyiX5sw3aM8VpH0GCE35WrWDZZ0oi1i14S3DieuSI+NfO7Yd2QJ8CiV7j/aWXgQ08GTl4SbMJjTCRVQ4j29uAZPgOPdWt6rkz1L85yuLkiGUo6QMeCrt373jGqGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097300; c=relaxed/simple;
	bh=1dH9rDMRRqCTSE6NNbw88IMsFCd2NOxBgQilUhHGdD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev66oD3LCJHW9OOnmxojVu5bz0mxFSYZh0L/J7TKqIA97T6xBV+1GKumw5ZBYhAran8QOmSPNBTSzbujZIzb21KBPETjIp7ANq1khF7/IrTS5Lv9Y8xI5fK/Ju+wH4iDJceFRz4XcwDhzNktc/r8Cmml0X+RGvcSXQ9MlyFnz94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgkaFtqJ; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgkaFtqJ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66058b880e9so6793182d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 06:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097298; cv=none;
        d=google.com; s=arc-20240605;
        b=FUUus5oybeKkJtdnC3lf8Om2ftoSsePG+VAKpobon5Z9A7goWVUDF8knnZlbjC41KX
         l30RXkkwpd36wNxZpuvxI8dU71qcjBYR2+jLmCH1GZ6sKm9VMfqeyDISObCp0jflUpHZ
         w8z3qyViCftFgO5uYtT3jEIqWNu5KPhhzjjTPrYeCBXjb3l/AhBwPN/p7vv6GVG+5Uf2
         LbT2ms8UDeRS/thLC1RF0o0kQ3lF8XmaTfExSW5UgtM7K+QuXPRHIa+toX916P42bFGE
         kpwUlNAkCLcFWtYXwyEI/rMxl7+19EXjyDM8zq1kBQ2iVSxyOTAa/jakyxdBPqiDBs2u
         aG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MCGAip3wCyqbLBPVk1VGFkIVqM2lZAg5RbNKURTltM4=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=PEHbMBiYukO9MMqcgw5oqRQ/PGvAnUsMbsSemhexkY2EaBPyolQLa330X06mi4xIih
         VNqxNZ5qygjkW7f4Iwhz5xsQPX00Aut1kchqUDEMbeGsbYE+eEGy427aRxbtI0SNPKob
         ucBrFW/pR4dR9c/Y41Sy0jS8cxUuKNoiLoIIF4rpNIS4HDEs6sNA1XfwCV517AhJwxSo
         WOwkFp24CvqX/5lWPcggQw5CQC8xC9Dd0hqkMZ7nX5fejUnkuVSWdCUzsgJGmglb29M1
         PCYc4nIWjYovNJwwXhS79ZFLGQMjFVbbr6mNIJuuzhGYUpw6iB3s4yEv7SAwPHxeYgeb
         MsUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097298; x=1781702098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCGAip3wCyqbLBPVk1VGFkIVqM2lZAg5RbNKURTltM4=;
        b=LgkaFtqJ3SwBn/ybGADmnhi6b5hxd6R8L1j0iqrTM/2lfx12fDKTkqM/lAcbOL++ih
         tQfYNmUchyZ1JBN46V7LUnXmWYNwBPtcIv82t0GXmz+Bb3tRCy8mNNxaaaA1TQv8d/kO
         QHVbp8bz+H8LjZlY+Je2w0/mA2di6F5+u+uUt3rWR0DGD3fdGadn1rDg8kcADIgXjIjK
         noV0XmljeWxSYHzUS2zEBmYbaiBUoksXmV7Fi/kYjnx1nRIw5gFrIwrp/Rp8+wFj79Kz
         yTTNbVCMBiJLWPsju709XLpWOIp3FNkfXg3aLrlxd1tISwG0TusHHUFtC2fq/OBTMm/h
         gnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097298; x=1781702098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCGAip3wCyqbLBPVk1VGFkIVqM2lZAg5RbNKURTltM4=;
        b=KaPSuvDzSZTn9Vn9fyOApnEzqWrpQxq3Tdtfc+3+FQnKu1ya04b8iYYyH+JLScrFgV
         a5pp6Jx64OH3Mvz8WnvfTh6QJu0CjfVgma4MC4zoc7w+BBQvNBJRwg93zYnR3A+01DVi
         3zI+OqNzyHJhG80Oluwkhdz5ptn3hKlzMadGHF/RjjPKVhMI30PX1ejiECmdHTaVe9Zw
         Lqbq7iPYsaiISBW3kZ6I//8mONg20jhmHTvwGcbowu1yWA0MEN5sCggEIs6HCMIqpjaz
         ySLrnSvx7piVIXxDY3en8l2VPyeV7SSCNZdAiWklzR/jsyW25fCeQRx6xTc1/b5KYWql
         KyFQ==
X-Gm-Message-State: AOJu0YykTfBFi76nq9U05mOQXcr2vwgjkgJG7FIzY3ywlssoywEOsREy
	r5WO9mR6ltWlJIRQXpBY62qVPteL98zy0DiyXQJcybCX3hh+klkxMKA43FnZ59YWs/tQ77bFuiT
	lhMUDPEPtzfiwwuXzVc9y4OpqC3tpoyyJ8IAvNh8=
X-Gm-Gg: Acq92OG4zHw6pBeQxiHG69rJBtY0yXaAm4+uDV0+ZMoOWSJJTsUJ5zn6QLDVFm57MmV
	KkgzBcSEy7HDxkcLIOO+63c1Wtuasfi1JbsdUIRIQRaO+fNhwvNJCIAm+5BQjI55kgRjZtc9upq
	fnKxruqDU1xJE9KnsxvyNLA3wNfNx/B5537AShe2t50GyNwkN2tSZR47lUItE1c7sAJ014QmBE2
	TJ6XD+zh4YBrjqDmLC/tg9F+wz8YZPOI30ggeUdcY0fuSWDc3HYI+CNkEo6rBw0qdJhPQhL3pBi
	epr+cJWhyH1BxOLdIYMgkJGdP7rz9DgtEVJQbTZ0Bfx9Ll9ODYmyyUL4I+xHCKVtGFmo/qTSsI1
	f5Q==
X-Received: by 2002:a05:690e:1c21:b0:660:367d:539c with SMTP id
 956f58d0204a3-661070e74d1mr22813217d50.65.1781097298061; Wed, 10 Jun 2026
 06:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610130648.1091326-1-oss@fourdim.xyz>
In-Reply-To: <20260610130648.1091326-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 09:14:46 -0400
X-Gm-Features: AVVi8CdTCsLN9lDM4XLWKCepx7czCSM4hm4JmObfXTGVNoE-0MxtWiRZQlvpK2M
Message-ID: <CABBYNZKCciLjShDCi0NR53WA9KvQjMo_sMyEwtvWFCsJ0MSZDw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, Jun 10, 2026 at 9:07=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> hci_abort_conn() reads hci_skb_event(hdev->sent_cmd) when a connection
> is pending, but hdev->sent_cmd can be NULL while req_status is still
> HCI_REQ_PEND

Can it really be NULL? If it can then I don't think we are handling
HCI_REQ_PEND well and perhaps should instead just check hdev->sent_cmd
directly instead of bothering with hdev->req_status.

, leading to a NULL pointer dereference and a general
> protection fault from the hci_rx_work() receive path.
>
> Check hdev->sent_cmd before dereferencing it.
>
> Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting =
connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  net/bluetooth/hci_conn.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 54eabaa46960..43fdacb2c9b2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -3188,7 +3188,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason=
)
>          * hci_connect_le serializes the connection attempts so only one
>          * connection can be in BT_CONNECT at time.
>          */
> -       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_status) =
=3D=3D HCI_REQ_PEND) {
> +       if (conn->state =3D=3D BT_CONNECT && READ_ONCE(hdev->req_status) =
=3D=3D HCI_REQ_PEND &&
> +           hdev->sent_cmd) {
>                 switch (hci_skb_event(hdev->sent_cmd)) {
>                 case HCI_EV_CONN_COMPLETE:
>                 case HCI_EV_LE_CONN_COMPLETE:
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
