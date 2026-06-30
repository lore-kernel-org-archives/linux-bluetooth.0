Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6C271A71
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843873; cv=pass; b=WTHXKdJJdSWsFolzCQH7uj+NEsn/fvQx5QK54Zs9tal9Uc5pYvWmHSwAzGvMLiONf8+Jk4AyCb0ctCAnbZSzWO7oRzz2JRxyYqRIZyDQPBa+RUntKbwx61/tXNhup+uV/tdqWI3EwgRoJQIz8R3zOLt45qnMcf1TjWdwaAeeXjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843873; c=relaxed/simple;
	bh=Qlizf8QT2P8sarx1qI+SkXOiK9iQHHZu1PUwDPHPPo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0yqPpphp/54pIV/i2ceY2V379jXB4XOE3n0qcCvRQtlnu0VUj4iu61zuoUpv/4zYvOBBdYbHu5nL0HLvrLBcZaEKDYRV0YON8BdRLqLIVAbKy4AnE17HTgU3Y6Ng4p4vitIYaW1gW0L6tcOjsNyfUufMtMGzzcHtjD2uBFdRc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU6kx+/C; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU6kx+/C"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664cb440f9eso2633880d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 11:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782843871; cv=none;
        d=google.com; s=arc-20260327;
        b=SkR2MFIhJVTUJyYaFo5HOXV/ApmErd+UPC445KkBh/tmVZQkRYmJazSc5TDWde7+Eu
         Pa6wv+JexLbArTn38L+Xlsn8a+72jVgTmLlDJDpe4NE30c6n3ocCZ5m/KJSxILngvjMA
         CUh9jrESXWIHVOZq7byN56pS+36Yi6xau5enpDPIkvhkRAQLYR4EoX1MUZqTyNpLxjp4
         gnjfvb/cAr1zXBx3KmiAMybkhOa4r7SKFQ9+0YRqynxXzwvdxP9oVAD7JMKi+lwe2t0j
         jz/pO9sie8R3vps+I3gBsrRUcjzccQ2XOQ1XeUEIOYSZZSvhjcXtwmsPq1fYqeDItQOI
         +kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ErOGvjjWMQAvbs1shGbKaRhux2HncpmCjaCOTBWmg6Q=;
        fh=Bk8ZqMnnMDjoWsMPWgc0VqjXPxfEcb4DGCSBOtMJ1vs=;
        b=g1GKArHqvOrnnUyhWVL53XExyJk57D/c7Xjj9tKV5AilgqQMugx+FASrRsZYGmhw5Q
         V2y+A/H61/EFvQHD4wcPIW2PaC8b+xWJghB4IFyRvZvmKN1yem5V41UBScSK/EeZ1Y27
         G4XskAviWPrZEdnTBoXR4P5haiuEZlWIEb/vOZWyYgKhlkMlz/A6kWlQPtbae0+lHwBR
         rbfy7cJQqm2awtixL7urvEGs3KdRBeUQQd0xb9xrLmj0dk9+zpX+vBymlQnCy3LNXP9L
         4TAc8mU6WL1mp1Ui5+UoYiX5yU8iEDp8AUlEtg19HUgtw025Qz9iNPGGD3x9OhnPerhP
         qTbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843871; x=1783448671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErOGvjjWMQAvbs1shGbKaRhux2HncpmCjaCOTBWmg6Q=;
        b=LU6kx+/Cu8BJN83QC2k4vwrAtqNR4mcuTpJv5j5LRxaBT/ZPRJOH4+36IPzOC0kj0S
         y/sZxOmNT1F61jm81kFkzOb1rhOStoaI/5HGRsJgriq0qkQgURUzjX4jcSBssheJHk5B
         uwAwUg8HaFXpfwW4duN6adBRGjOPyimrV/8X+iKEujEOx2P/qLhXTyfIslCVPWuPe3ml
         fQWKWWCcKv+t3Ri4BqupHZLwOcwyn9cdIeUwSCgHzO55SjBbGjHz/UeQjutEvCsWWegd
         5RoDh1z0i2w1vv9I2d15H9h3CUN/1UmPrXQFKUEIMahyI0mMSUfUWkprs4lu3DPgJXyv
         ypzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843871; x=1783448671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ErOGvjjWMQAvbs1shGbKaRhux2HncpmCjaCOTBWmg6Q=;
        b=Yx7GfDVhtCfBJdLSeEL17FMiNcELBAs8mjZcjyq69ivR511f6O9j2De1iM8/PUhRWj
         tnZ9ya+TtBE6LS42g0N2ia1w89gMCkqccHY9n7K2LZ4KR4MIL5l5Nnit7VEoGZ1/m6JC
         lRyFNDnPrwOF7UDZmThKKFngtFGz4Oad8RfKzYelsOj1N8pgKc0VFl+HkwBQ+zpkrded
         O7w3oSiNAo9tzRJ+ZsysyRuiU6NYdCNvTAqS6xxCXGyONugfbRa+HtEGEVT/NOEt94sC
         skzy2/85iP2LjL0CpmLlnoAvjgNRGaQFi0a0hEcSMYssXySdJgE95KsPAiYKMgay5zNa
         rPAg==
X-Forwarded-Encrypted: i=1; AHgh+RonzVKvhMoplMrD2+92cxQSv+VMxSq/Sxz5pkRFjLSj9Kq9mm07pbXPpUuI/MSupknsNFmyK+P1vd9+6NGYsmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXMSXYmG9iLwW66Go6P+5s1LsDalEMyrbCTdbFRxlIG11bTta
	6OAGxPo2DUCDCZajKsrOgN2Sj50SzXCPTbAaOd2nfZBXzr0EVbhE35ztaW+gGPR7w4+FZgz9aE9
	0o/OB5okIbVq1er90qn0Ir7fgvzTLqRo=
X-Gm-Gg: AfdE7cnKZUWaAC81n02kNyvezIulx89qnoYzBeUTwLf11HqlTbjy6Q7sDOPiBcrpghv
	QK0R3sCwgAx+0daT4iTgW7lcgzG1NNTjnqeScAaveVyjrLTi3ZodQ+dOEwYdePQARVdFlkOwHG1
	yR67kofsLCHFpjFF33wYOy+w0MZ5iaj4To6vvqLLd/OCHN9uSFfuPJTRGFNlckzoiyyTVe515gb
	IouEXunqov8/Tp+WhYWLs8JaRDwHb/xTAr4Two1vbvbPxwIyvRHK8bvfVvbHJTzUpSxIZkQPtyb
	sRqhX0nCXmeSnvJLjyhRdBCOJ4YHZfUGzIsSiMR0LNxWeAE/ygnU+nJb
X-Received: by 2002:a05:690e:150f:b0:662:e0b5:33c with SMTP id
 956f58d0204a3-664f96c0ebamr4752644d50.8.1782843871439; Tue, 30 Jun 2026
 11:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630062759.2769059-3-bestswngs@gmail.com>
In-Reply-To: <20260630062759.2769059-3-bestswngs@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Jun 2026 14:24:20 -0400
X-Gm-Features: AVVi8CdDy6FB7gU6WjuSRsXQM44Yd3QxF3S9svRNpMuzw96FLCGnkQXLnMtyC3c
Message-ID: <CABBYNZ+iGcx+t5XTVfeb5Q1xKYwtZBn2vuYEMNUMedu7hgHi3Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bpa10x: check response length in bpa10x_setup()
To: Weiming Shi <bestswngs@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Weiming,

On Tue, Jun 30, 2026 at 2:28=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> bpa10x_setup() sends the vendor command 0xfc0e and passes the response
> to bt_dev_info() and hci_set_fw_info() as a "%s" string starting at
> skb->data + 1, without checking the length:
>
>         bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
>         hci_set_fw_info(hdev, "%s", skb->data + 1);
>
> A device that returns a one-byte response (status only) leaves
> skb->data + 1 past the end of the data, and the %s walk reads adjacent
> slab memory until it meets a NUL. The same happens when the payload is
> not NUL-terminated within skb->len. The out-of-bounds bytes end up in
> the kernel log and the firmware-info debugfs file.
>
> Bail out if the response is too short or not NUL-terminated.
>
> Fixes: ddd68ec8f484 ("Bluetooth: bpa10x: Read revision information in set=
up stage")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/bluetooth/bpa10x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
> index 2ae38a321c4b..07c6ed6f18ac 100644
> --- a/drivers/bluetooth/bpa10x.c
> +++ b/drivers/bluetooth/bpa10x.c
> @@ -255,6 +255,12 @@ static int bpa10x_setup(struct hci_dev *hdev)
>         if (IS_ERR(skb))
>                 return PTR_ERR(skb);
>
> +       /* Reject a short or non-terminated response before the %s reads.=
 */
> +       if (skb->len < 2 || skb->data[skb->len - 1] !=3D '\0') {
> +               kfree_skb(skb);
> +               return -EILSEQ;
> +       }
> +

Looks valid to me. We shouldn't really depend on the string being
NULL-terminated, as it could be truncated for some reason. Need to
check if %.*s is safe though and if that would work with the likes of
hci_set_fw_info:

https://sashiko.dev/#/patchset/20260630062759.2769059-3-bestswngs%40gmail.c=
om

>         bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
>
>         hci_set_fw_info(hdev, "%s", skb->data + 1);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
