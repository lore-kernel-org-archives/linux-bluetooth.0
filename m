Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75EDDC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763620267; cv=none; b=VtE+Jd5TROSUhv2B7CsOWkUR9HGF6KUqUPYVdFV4ZV1UAv5SdkHIWyjP1o2qmgJNT+5T9J37ZOGZEAwO9uB87+Conamkr1a9rzcF+ML9QmenIV+fosA6PeLFNmnIlSA3eDYKhIvmRFxBmSgFeQo3tI3D9XcW3iO0/uX/mLsf5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763620267; c=relaxed/simple;
	bh=Vj0oUqgdjXtka8x1D1nuQmVneuMX5ah24CpqJzt6DJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTTT/n5T6Q7k/CJhslEY/L0AqvDnX0B/F1NvwNNeud3Rp7bUfi5pR4jLkB1lkq+/OAwXjWSPNxD0Yk/Wz2hyuS2Btj5QDMGEZs5ZlcfW6VlkGufZFPRQPEDv/qCl3IPX8S2p25BZudNImp2iIiNA5TzO24UQo+mJ5hStkom2Jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=go/bLhSR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="go/bLhSR"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso789128a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 22:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763620261; x=1764225061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UZzBLoi3OOPNC2jFhtLWiTjN8vln3eiSs4jfqveXB8=;
        b=go/bLhSRiwwM+YoJ4RCkW+HsscDgF2Q6n+zDihVUN8KBAQOSktyzlEivydukL9ca8Q
         hVKMSTodNSvlx7tICSpZGJio3caJC2zoGTfg6746n9NQ+bIeKYTMidGqJNRPIzX2VMyw
         P4Sxr+7rKV6N4A3igKyZ6nIDEg+PwyMbcMVQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763620261; x=1764225061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3UZzBLoi3OOPNC2jFhtLWiTjN8vln3eiSs4jfqveXB8=;
        b=lZx6zbOTtukkyq/fevxOvn/BrOfV3hNDxjyPPGj5rkpQtTntWZdSLjCSyKjPPtdIfV
         8JwhtQumUS01720oHYtnnNEEzEwZ5Bx0a8lwC9RivUYHgE9l2qUG3YOLZSkoN1knyqSb
         8tDS2QaD1v5lhc0Osg+e9Gt3xFiZqxvbNqLXS1lc6zF+HnlgXwdHPO9wKAwWzQFn2R17
         XxPFuvshfcg8VYwacbHOXoc/rA+W4dv6P5K8Qvk/hxquSRWGdlmiNxhsjTrUzaHem7tR
         PO9kBH/3vCzyvGMEqbTDfRGzwiVqTAt0hy5bRT/yFCLdypyiiYsluU0xFtcj/M02CVjc
         3ijA==
X-Forwarded-Encrypted: i=1; AJvYcCUm8cRqDIaQd+jaS33JRC1ZNiDj//LVdSOPbIHWk5gD9F79ZzFqM7bP595v54H8TXsfdDJB9CeVnwzTtsagFak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+G8o/MHuM98DeJW45Dc32DYhrdrFmWkRQnwqNNDIjTIncekA
	KWj9Q3ZqDAusrNNmHMRvbd4QMH4Tpvfz2/gvFWaj2H/nP/E1MMdGNQDG5C89ceDN4SYBjOC0Vr7
	5xXrf+nJv
X-Gm-Gg: ASbGncvVHX3OJZZ3RML/uLhYmHkWBCX5DFBMqcx0gPIfWQtWFZHQwiQ5i+RnGmuU6dG
	9qxSF3xitak2P8/igK+rA63X+m3MhGjE0e7/R8JJQ5kZhn0vHNBVt/t/MRM69D6FjGiK5yCk3Uj
	KAMCvjLVF1epmafdZ5sdrazMgclmOOsaXncFzNzMUqeZtn8htJQRVEDRndLlmefI97PqbaSI0RD
	zLRmfcHGu8IxKuW99KgOaqHmsdEXelb1XUfw0MOIkf9GGlo0KJBr3sQPicnsMk8k+g+cUnRLE1Y
	vL5dWJWRkIpnRfGDKhOLk7Uksx7iQ78PRWhJb2TviOd7UEUoSjhLa0R+jCaBqwrkiuOgu4VFslg
	muD29FAiDY+84bAnQCVPbEmiqw9LpUVg/0LxgWGCik0witeQt/dpjr4ZOz7y2ix7UpdG9hwgrd4
	T/3njndl010g55MkOHy5YpVOcAQBqnnyzfH1ZAtnziu/FH+EIa1w==
X-Google-Smtp-Source: AGHT+IGAAlYKYFlLiaA6AiTW/NOkln+tRfateA2DO4OaYYBJpmtFFs/D9W7HdI3JmcBummIMCYhTLQ==
X-Received: by 2002:a05:6402:35cc:b0:640:b8a0:1aad with SMTP id 4fb4d7f45d1cf-6453d08470fmr626426a12.6.1763620261413;
        Wed, 19 Nov 2025 22:31:01 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363ac9a2sm1331338a12.6.2025.11.19.22.31.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 22:31:00 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so2756305e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 22:31:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWh5ky64UpJxARLWy+5ULE3sW7+HvtAXU2LhyA+H5LjZET3R6XzxcsP+nd1gpjGhTgk6Yj9O3PYC5Qlvj9WCjE=@vger.kernel.org
X-Received: by 2002:a05:6000:2f86:b0:429:bc68:6c95 with SMTP id
 ffacd0b85a97d-42cbb2aa2b8mr781529f8f.47.1763620259551; Wed, 19 Nov 2025
 22:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
 <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info> <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info>
 <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com>
 <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me>
 <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com>
 <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me>
 <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com> <5vLxmZlxKXfznaWPi2ndxyj90dJN1FML_fINz027uaJP2rZK_nQu_41m7WA7Gnc1yy_XLw8KMWF18Y_keW-qKjHy0BBOQl0A92QiY7Kg004=@proton.me>
In-Reply-To: <5vLxmZlxKXfznaWPi2ndxyj90dJN1FML_fINz027uaJP2rZK_nQu_41m7WA7Gnc1yy_XLw8KMWF18Y_keW-qKjHy0BBOQl0A92QiY7Kg004=@proton.me>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Nov 2025 22:30:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WRYYYB+G4-7y7uVR8QCEEMp2iRfmtsAa29UfyNCVD=4Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnTsU355qMVV2Ab2pAuyymcavgyaDDrdQfCxFRSS9uXEOwFEsBZmxvs2zM
Message-ID: <CAD=FV=WRYYYB+G4-7y7uVR8QCEEMp2iRfmtsAa29UfyNCVD=4Q@mail.gmail.com>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized
 since v6.13.2
To: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, 
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Wed, Nov 19, 2025 at 5:04=E2=80=AFPM <incogcyberpunk@proton.me> wrote:
>
> Excellant , i will reply to the lore so that further progress from the Bl=
uetooth maintainers can take place.
>
> Also ,
>  Yes .Simply because this is an unknown territory for me, i had a hard ti=
me understanding the problems just from the commit patch message.
>
> I would be grateful if I could understand how the `btmtk_data->isopkt_int=
f` being NULL caused a crash due to the commit in 6.13.2 and what it means =
to say `Prior to that
> commit we'd pass the NULL pointer directly to
> usb_driver_claim_interface() which would detect it and return an
> error, which was handled.`.
> How was the pointer passed directly such that the device_lock mutex , wor=
ked in an undesired manner to lock the adapter and turn it on.

In 6.13.1, the following could happen:

1. We'd be running btusb_mtk_setup()

2. In btusb_mtk_setup(), we'd run:
  btmtk_data->isopkt_intf =3D usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)

3. If usb_ifnum_to_if() returned NULL, "btmtk_data->isopkt_intf" would be N=
ULL.

4. Next, btusb_mtk_setup() would call btusb_mtk_claim_iso_intf().

5. btusb_mtk_claim_iso_intf() would pass "btmtk_data->isopkt_intf"
(NULL) to usb_driver_claim_interface() as "iface".

6. usb_driver_claim_interface() would see that its parameter "iface"
is NULL and would return an error.

7. btusb_mtk_claim_iso_intf() would notice the error, print "Failed to
claim iso interface: %d", and return.


In 6.13.2 after commit e9087e828827 ("Bluetooth: btusb: mediatek: Add
locks for usb_driver_claim_interface()"), we'd add in this step after
step 4:

4.5 btusb_mtk_claim_iso_intf() would call:
  device_lock(&btmtk_data->isopkt_intf->dev);

If "btmtk_data->isopkt_intf" is NULL, this is the same as
"&(NULL->dev)", so we'd pass a number that's very close to NULL in as
the dev pointer. Then device_lock() would try to dereference that and
crash.
