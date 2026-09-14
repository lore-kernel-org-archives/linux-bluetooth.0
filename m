Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990447ECC8
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395210; cv=pass; b=WcBWXX4Rw94O4LIFKYBBM4bpApaPkJn7/h9wMnRff2BqaH6fRUkzUTFFDDrc4f2u3K1/sPCAsSSEN/E15EYXPHHJ7y1pEn+2g1f1YFblTeaJpvHwaYsGgKjJx9/UPtVdOHiYnhN7qgD5Ze4a7si6HG8KAMhJdBaA2yNxxYo7/s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395210; c=relaxed/simple;
	bh=HcrVb13U8U1dp118Fj0sRZh6DKiZuFwN4zfw0H9EUfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hf2gORsnyuPy6gZsR5aeTUyFSYYAup8q1Swo/dN0F+FLkMZVTaykMAISxxFZkqktyJkJTgLSkfo43POp7v4vyQw1Q3f1XJFIeSS+xKMqNXo2uWKhyKgPIVabitY+Z264IQp+tQ+p95/EKVXHZBVONdITKkb3r5+kpwKRjUj41sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UztkEWeD; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UztkEWeD"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67124ad72e4so3194385d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 07:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395208; cv=none;
        d=google.com; s=arc-20260327;
        b=OmTWvXeAy5N/Bj0jLpeOzJYxtykFX9I0IMaloIbE43E1sYZtUTv7+Z3vAkQJJ4yXXd
         g2+Jgs4ipTGyn7GWM6GCiOzvhe9piFfgQq/LZBxWbDrww20DRaXF/N80Vr8H/0aDyhhH
         xZzx3yiNikc7S3ylMu8mmGRc9FIKYjFUSPB8ZcGS7LulvQH2FLIXU0zybmozK72apIV/
         UvsWfqriXI/RfBBPYBmLxtl36fxV05kjmsCJFi+phO+xkmX29aYRbU3k6x8t0wTw75Lf
         Egd/dlAclC1JGLydrb8M6jUBB3Kb7BhPDSASXY0csWKK3+aDfP6h3rT6k35HVtPZXAh3
         mwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p0YA9Y7XdajM96S/hal4rI1ACWMLOOoO4cBFd0Cz7Dg=;
        fh=PiUTBW7BrOIS4fJir+sCnQVg6vPfxk/Xt/omyugxTqQ=;
        b=GkjW3L0CDzydR58AXjNp4Fflr9tOnJH8m0m9jzS2AvsHmUyJeQY7zRHCTDIBdfoe3w
         g4C9FQKavJXASL9jA0CRorwMBKZQi48tpOJtTZkqalUv0l4Fb8hjov/L7uWIxm1Sp55R
         1QkCr0anV5caOy353ujyzLS7NLZdQU/nc9VfFlBdDjqlQ/eljQUBX4xeihtu2HC1iTVv
         cmIVnKBu9k2GKMwpog6Z3z/8aMhyrX5trcSbCKGFYOm703/pltEgs57MWqDhdJMNRGy3
         OALHR0qmX+GHnxs30FATpWoDnj3B9w19q2hYljzUgpa7z7gi3dv0SNL+tLTDj62uhCEZ
         AWqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395208; x=1790000008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0YA9Y7XdajM96S/hal4rI1ACWMLOOoO4cBFd0Cz7Dg=;
        b=UztkEWeDVPGK35cr4zBccCBvvE8fFRAWQDzn2JvsG13AV6MCHdu/le0q4V/R1mJtRx
         JwPCgxTo/1xu0fqKEEIuHg8DfMs6OBVQk5TLUPoA8vE8Db2xQFhXYrNn9tE3+ro+efRw
         4taJotbFC+sk+Eui53STknbX+kdwZzK0Vw/AjhoUgorfzcQi8wnk0Wjmwdvflq2F3qFf
         jupMXpIhCtziPm5ofxTmM1LleYgotf3kh28gp5/ALNgRBVXw32eWURADELYFmta2tq6M
         oJdrYayuGBR36WOPqrDsRfvxAidUp5h/pPDmavS94WfnHXoCBdTVqfcdvYiiuiStrXji
         ybkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395208; x=1790000008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0YA9Y7XdajM96S/hal4rI1ACWMLOOoO4cBFd0Cz7Dg=;
        b=rcs0p0Bx3GBkNu5HRpN96cn06boMXrlP3FDQnmpCN22p19ExKVVNoQP5u071CjG46r
         qj13NYD3SxU7Da4FVfKXO7nXyad+8bOoQ3WM0pjHbQwdrD+mTXLaxIoHf68sSgLc14sL
         ZSdlYkAtH3PMcKF9LpN4RUcSbQqZK88Br8de4gP84YDWBqDjxAw8lw+WO2Af8dCkDxDz
         NuO2Pq6Xpte1mQw6fCspO41G/ie8qR8Kq1SdMkya7kZ6H4nho9caeF5aQkxtvbmJL4Kv
         +/R2sYptHdaBZWj+hDla2a1XgB3cX67982i8i0ILCOXzGi3ebJGzyAbuIZMPWQOufb87
         hKaA==
X-Forwarded-Encrypted: i=1; AKwUvBzGtaP9HGxeaVD92yA3WGohV3D0Y7GMcUatzZsHUnH/wBpLs3WOid2v6eO/2FMDcM4nxlKEwYBU26k2Wl7uKK8=@vger.kernel.org
X-Gm-Message-State: AFuF++nWNHs9cANPRLNTl0jp41QCIbI8WYAYoMrFBPTIhHauyQi6g8Bf
	XrlkK7dUnFy61ujTN4dcOPb82aHmeMSnfk6hivE/OabLOs+6r5c+CNLDrqjmzIwPgv2ecmtfSYw
	Dzh+lFUkMTOL53OqgbTDPbd4UN/Gbmne64Rg9nt4=
X-Gm-Gg: AYBFou01Zx8PwBgZKB7LZdYvWVB2k+C4wGqfAhJ3axiSknLx4orPUcCV6FfmdRC+4cv
	nOYo2/rdEFP3+yCIxysqpYh7117YbicJsRwfI1h46o+G3xHxpmhv2OeouUZd1UHPe1srFJMtUgj
	CgZgOdah1eoTI1/rPkolqEH6gW8kCwiti4gSe/VyD2xleCsoU0vbAAE+LktqYdNvD8I/q/DqZgT
	b0DmAKTkMfRFxdj1+eSTZoCitNQJIgI9pSsCayTn0zA/Sadli2gf0iD8XC32dITkSy/iE3Lv9ir
	Hgt7/xSfsS9xIyDdKXgC0m1Czo9zoE0wIT6gDLInqnDEglu7vW1gs2vEXySoiR3i9LjExdrm882
	/UgDW7i6Ypt2ZuwzCJhGo1NzwHR7dlskOA9TpUMY67IE=
X-Received: by 2002:a05:690e:4390:b0:668:8e5c:ff98 with SMTP id
 956f58d0204a3-6714dfe05bdmr386913d50.23.1789395207755; Mon, 14 Sep 2026
 07:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-bcm4356a3-bt-v1-1-ce44d0abb5db@gmail.com>
In-Reply-To: <20260914-bcm4356a3-bt-v1-1-ce44d0abb5db@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Sep 2026 10:13:16 -0400
X-Gm-Features: AcwNN1WrwmpS_SIKuwSZN8pnxrVfPeJjc4lrLwC0U9902tk4YSJcvvLjDIoMLvA
Message-ID: <CABBYNZ+553teDOW-43qkf_TCyNr31LP8gS1vQ7YfKvAZ9UnzLw@mail.gmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
To: webgeek1234@gmail.com
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 14, 2026 at 5:38=E2=80=AFAM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> This patch adds the device ID for the bluetooth chip used in the
> Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/bluetooth/btbcm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 463d59890befe..14acea7325478 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_subver_=
table[] =3D {
>         { 0x6606, "BCM4345C5"   },      /* 003.006.006 */
>         { 0x230f, "BCM4356A2"   },      /* 001.003.015 */
>         { 0x2310, "BCM4343A2"   },      /* 001.003.016 */
> +       { 0x2409, "BCM4356A3"   },      /* 001.004.009 */
>         { 0x220e, "BCM20702A1"  },      /* 001.002.014 */
>         { 0x420d, "BCM4349B1"   },      /* 002.002.013 */
>         { 0x420e, "BCM4349B1"   },      /* 002.002.014 */
>
> ---
> base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8

We need some more information, such as:

    Test log:

      Bluetooth: hci0: BCM: chip id 206
      Bluetooth: hci0: BCM: features 0x0f
      Bluetooth: hci0: BCM4384B0
      Bluetooth: hci0: BCM4384B0 (002.001.025) build 0000
      Bluetooth: hci0: BCM4384B0 'brcm/BCM4384B0.hcd' Patch
      Bluetooth: hci0: BCM: features 0x0f
      Bluetooth: hci0: BCM4384B0 AP6684P CN iPA [Version: 1030.1021]
      Bluetooth: hci0: BCM4384B0 (002.001.025) build 1021
      Bluetooth: hci0: BCM: Using default device address (43:84:b0:00:76:93=
)


> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>


--=20
Luiz Augusto von Dentz
