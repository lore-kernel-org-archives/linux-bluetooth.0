Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273F1CBEB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043703; cv=pass; b=kJyske6tOxa2Xpx6mzGFjxLLXAUVOAwjqOmzwD/6vnotMopZZnnEQuMP/EZH/3zA5DYMZLgaNgvWRZgAn6Bp/lXSz4Wz8uX6vViBqgEJ25QxGvV1L1ROryw6fk/trchitB08XCRrA4YOKamZnOJiojGbpTC9ZxhBJoaGBrKw2tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043703; c=relaxed/simple;
	bh=6nnAEQqCetLfypBZGb2kHScazi/bBUBAZakfEpxnsMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCCae2P/h9Fm1wNQkcN0XhFZLDc34V2f7+V3pPVhMlae2vkuar7s9uxjdnsBdQj1Af8DblK3nwgg72YHHQZ5SnPxaTyxy8AkPMGUnA7QrNg+dBB9Hks9p0qWGnYCvrnBqNsUxY7FqSVpPVoA7+LjZ5/3TqzDlghShf9HoTaMGB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+Pns1h7; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+Pns1h7"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad46a44easo6814698d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 10:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772043701; cv=none;
        d=google.com; s=arc-20240605;
        b=TEGINJsFphQVJEZzkCvawwVHZM7sIqhf/BD5VOp0lwfj6KUEdXXg2VwXxVK4K/6S6B
         1zOLHRKPDn+Q7hH2r9SlMQYkUCOZKJqNQyRCqUxId49HCw7FyQ8u+vsw2m9nOE4z/aZy
         QfO03w7A0x6amGG62BNQGPONGV9V8sjuj62Vm+3Vi6uEdxPLBsfZSRM+VwzGLme4mOye
         wChYv2nXnBL+uv+lvwvSR/ORc8ipHSIkCA/6tQZVOpAQgKSrHcuEioGLX8G9O3d4brnH
         ld02aed+/8f6mkzJ53ZkpMzyHa07rotQxHR5acsd8X8TCBMg3Kyy8Mzqp73+c6wjdrqs
         V/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eA6lqsokdPVenf+hGF5HxWrUPj81pjqWcbF9WN+X4Eo=;
        fh=RWBVPlIyNTUzfMyP4bUC/PZbm0yvAvwEsBrINF3jbGE=;
        b=e0xVr6Jyb2YxgqLr+/VZXEcjibCEEZqnccv0Zv4jXBF8yoZgwekyTs0Lu1wXxtZLex
         G6Ar3ZKwBDQuhjL+tEnH4RHjTDo+Zj6Any49esMkPEjuump8C1p+jzurjP/gnusycwg9
         AEGi8IvDzbWy3r/q2nvgacdK8hZI0LjLRVMPIfIRMyNrMXYoO4PoQLMhkM0RAc92hYtZ
         aoLwYS2KalF4gQDZ/cxDCUTFB+3iAROA3cyqp0tu5PEWJ1LCkCxFN3iKs2EQJDmX8J/q
         47Ln7qCUhhuQ9PuxeuuQefgL1Ew2kV37xj78mxiD3K9kmBfvS/IhIheZTNipA2mnGxCL
         JCqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772043701; x=1772648501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA6lqsokdPVenf+hGF5HxWrUPj81pjqWcbF9WN+X4Eo=;
        b=g+Pns1h7/Jbp+mnqR2DgROKBvzwk1/5vaKxaN81IAQX3akuo6on4m2huDE5Qpk95mU
         7svEA2kyGea5GlkEZm97uWtcf8H0r+XZXo+KXMP+ZopCbc4tRJ1iEmww/Hh/HPSgq/IG
         cP+/fvt/VVdGk+04CdI6Woo2xfLMKrfhpewdT1GSicndHYt8WR35LTmzsbb/W8mZmdJh
         e1sceqCdjpypy/C4ZoNzjdj1S+a8PGp6rJZODaLX/0iSens1u1Lgvy3BI3RRnlddb4z8
         K0snk5C8jjBVG7uiRv58XZIkTU8vqZUvNPmwts6+XF6aH6XgZMljvEUqWwAy7JSiLN2f
         t1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043701; x=1772648501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eA6lqsokdPVenf+hGF5HxWrUPj81pjqWcbF9WN+X4Eo=;
        b=obj5TM813Lcy8DB7JLzBI+xKwoeli/dOfBWT4riHVDtJ5j8fHTS6wR7nfzXRpB9aH3
         7PNQUoLtKn6Bcw0JA9CHvPPEVIuGX/y2cLxLwqbn11ExB17RgnYg7ntiIa/IRg+sysY5
         vpi+umeL9020jTidkL7ntoJcc8BKIxTooaDJEF+m566aQZGbdThdNaiFSYDJ7FP2pVTi
         08Xnoic3PJkDTZJE3hLpYyPWs7/sEoUML2mNitDF4XsVjA93Mz9yAVOpN7vMo5y6lfni
         57nfEMWLp2gYObefye9YYiNuLz058beS1CU7RNllVAQuksEGCijjwCixOu0FKFbaXEaF
         Slpw==
X-Gm-Message-State: AOJu0YyMDJ5I2HLwZY+UA3zehg2qHBkS4xF6hs3KPBDJDuUtePeGmauz
	fxhv/QTfOHDJZhmFI9No8ayq6SJSj6FNOvCfzdesjROi7Bmb+vhrGARxPc0X7sIhlhNlSQFmNXz
	TY4f+nDg3jXIPq57b3iaE/R622ssp5ZM=
X-Gm-Gg: ATEYQzzTdcig5IDHCGHsnrNS3SDi9+8rsfGr74GFdZYAiMSzmhnXNgkU/VVLBztMBfq
	IPt15snajuXJEsdc1Adq3iV40OmEPkQ0l4g8l+oFI2/GxH1ji7/rCit7rJtY8K+OrJOzXt2G9hG
	eU7n33q1ccjCaOE8IbtCFLosFjP3lIFoJRwvuC5ZQiRHvrFSc+SZxGN7Ub3yBEmTQYesRW0848p
	cWV9IYCBRl6Z5uqSVB+0idwiCifz7HY7piqrgT270WxY2udAtG79e6Dd4RJDc3oVm94jyo1xFE3
	+sLKj+7A2hKvfz2dvuuIZR6oCGIsQJKKbsPQyFr2N6DEMFW4EA/FTEdAQWNWoqnQ13UHkg==
X-Received: by 2002:a53:ac8f:0:b0:649:c6d4:898a with SMTP id
 956f58d0204a3-64c789d169emr14842619d50.28.1772043700749; Wed, 25 Feb 2026
 10:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM7PR05MB6790817B215F2B9B88B8C4EBEC75A@AM7PR05MB6790.eurprd05.prod.outlook.com>
In-Reply-To: <AM7PR05MB6790817B215F2B9B88B8C4EBEC75A@AM7PR05MB6790.eurprd05.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 13:21:29 -0500
X-Gm-Features: AaiRm504OPPNxMyvppyCluYZh_RZCrctiLd5l74sotoPJjhD8ZB-QdpYNESOUTo
Message-ID: <CABBYNZLZVNf2i6UeAMwYr+X1Xfi8uXGtObnoBgQPzp8mPEEH-Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajid.morel@volvo.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Wed, Feb 25, 2026 at 12:49=E2=80=AFPM Dajid Morel <dajid.morel@volvo.com=
> wrote:
>
> From f3b8a3b01db23e9adc59ba5dbf99b1a83741e32b Mon Sep 17 00:00:00 2001
>
> From: Dajid Morel <dajid.morel@volvo.com>
>
> Date: Tue, 24 Feb 2026 22:10:35 +0100
>
> Subject: [PATCH v2] Bluetooth: Increase LE connection timeout for industr=
ial
>
>  sensors
>
>
>
> Signed-off-by: Dajid Morel <dajid.morel@volvo.com>
>
>
>
> Bluetooth: Increase LE connection timeout for industrial sensors
>
>
>
> The hardcoded 2-second timeout in hci_conn.c is insufficient for certain
>
> industrial BLE sensors, specifically all the TE Connectivity sensors.
>
>
>
> These devices often exhibit high latency during the initial connection
>
> handshake in electrically noisy industrial environments. Testing showed
>
> that a 2-second window leads to a 100% failure rate, whereas increasing
>
> this to 20 seconds ensures reliable connectivity without negatively
>
> impacting the rest of the Bluetooth stack for these specific use cases.
>
>
>
> This value was chosen to provide a comfortable margin for handshake
>
> retries in degraded RF environments typical of manufacturing plants.
>
>
> A more scalable solution might be to introduce a variable whose value can=
 be defined by the user ?

It is already user defined by setting setsockopt(SO_SNDTIMEO).

>
>
> Signed-off-by: Dajid Morel <dajid.morel@volvo.com>
>
> ---
>
>  net/bluetooth/hci_conn.c | 4 ++--
>
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>
> index d177b7f49..8aeed0962 100644
>
> --- a/net/bluetooth/hci_conn.c
>
> +++ b/net/bluetooth/hci_conn.c
>
> @@ -1131,7 +1131,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hde=
v, bdaddr_t *dst,
>
>
>
>   conn->dst_type =3D dst_type;
>
>   conn->sec_level =3D BT_SECURITY_LOW;
>
> - conn->conn_timeout =3D conn_timeout;
>
> + conn->conn_timeout =3D msecs_to_jiffies(20000);

You are the one hardcoding here. The code actually uses the
sk_sndtimeo to determine how long it should wait for connect to
complete which is set by default with sk->sk_sndtimeo =3D
L2CAP_CONN_TIMEOUT, L2CAP_CONN_TIMEOUT is msecs_to_jiffies(40000) so
it actually higher than what you are setting, so I suspect it is the
userspace socket that is setting it to 2 seconds not the kernel.

>
>
>
>   hci_req_init(&req, hdev);
>
>
>
> @@ -1301,7 +1301,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev=
 *hdev, bdaddr_t *dst,
>
>   conn->dst_type =3D dst_type;
>
>   conn->sec_level =3D BT_SECURITY_LOW;
>
>   conn->pending_sec_level =3D sec_level;
>
> - conn->conn_timeout =3D conn_timeout;
>
> + conn->conn_timeout =3D msecs_to_jiffies(20000);
>
>   conn->conn_reason =3D conn_reason;
>
>
>
>   hci_update_background_scan(hdev);
>
> --
>
> 2.34.1
>
> This email message (including its attachments) is confidential and may co=
ntain privileged information and is intended solely for the use of the indi=
vidual and/or entity to whom it is addressed. If you are not the intended r=
ecipient of this e-mail you may not disseminate, distribute or copy this e-=
mail (including its attachments), or any part thereof. If this e-mail is re=
ceived in error, please notify the sender immediately by return e-mail and =
make sure that this e-mail (including its attachments), and all copies ther=
eof, are immediately deleted from your system. Please further note that whe=
n you communicate with us via email or visit our website we process your pe=
rsonal data. See our privacy policy for more information about how we proce=
ss it: https://www.volvogroup.com/en-en/privacy.html

Looks like your corporate email server is mangling the patch, use git
send-email with gmail (or any other email server that don't mangle the
patches), git am will preserve the email you configured in git config.

--=20
Luiz Augusto von Dentz
