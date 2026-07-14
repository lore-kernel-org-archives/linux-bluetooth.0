Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3937F8A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998592; cv=none; b=jkL9aICqguLFVxo+Hbnk4YxvCmwrcQoa89CEcvhHHrNs4G69K3Wj/S3/DegoJcVPJHob4Bp72CiiJ/JAbVY/GI4Mz2sodCIlejLLxajapPuZP6WH/HS45yvd/f94jbb3epViqNASUj2IiD0KCiXzWeBjmMDVxa/6nUpAjhENygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998592; c=relaxed/simple;
	bh=wK4iFhU9kA2rZiahVSoJjq8DU1ohH9A1CB0QHz2alp8=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zge3IHK74ZiQACKJSPgZzu+lZdOBl5YIolMaz2QIjXnVrQLn1Y6aLQhnS5xRBHhUch96pFEUKXHSyPHx5+F4f7TqL1E0F7zuvT5+9VvCnToBk15t922/X61NErYCtDFjZAkjowlQbQpq0/NzA6tn9XOFKR0mBWezdyS4Blm/P2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG/+dGgM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG/+dGgM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c167c58f2so25335681cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783998590; x=1784603390; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wK4iFhU9kA2rZiahVSoJjq8DU1ohH9A1CB0QHz2alp8=;
        b=DG/+dGgMdGL5IPWIF1iXofKUJBoxaR1eZNyKeA9xPqnTAHQsMCp7XYacNmfwxQgHoq
         Jl+UkK7kP/0+jAySivTopKQYeWhMDoJECB0ixm3ik8LMUlJxY7VhfCAyMOEOulx4i+Fs
         iBhAJx37flnW0j8VE3F2cdZw8E2Ni++OnyUZ1ttc62V11AidF2hLMEe5r+yN2RgO0G0/
         vchhAwzDESJwynwXhi8pG/svc39kTPzbiJt7WNNiRrsx9kVAvaIiYznYCvpYR02Q0Se7
         gV0Ge2rkaTH3+XiVhbB9xO84kz3EoDKuJ8lBpffxqis5IYqlbR0p/L7mejGiNtBLkMu1
         g8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783998590; x=1784603390;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wK4iFhU9kA2rZiahVSoJjq8DU1ohH9A1CB0QHz2alp8=;
        b=lhEwDHLHWJnCjw3nEgpn+Z42lH+urJSxcSXH7MiwzgWfOSGX3f4YHnLw80ROZyl5SU
         x+IKF3L/lVmIUu48exANMIdljmBdqamFTZrS5Jj3pdPz3053opOklACNts8R6mdAYQYx
         EF2D8blYMNDGMEaQ0YB3fJi3Mc8J/oC6+O9z3dRRJSDXFq5ukLkPrut2H/IUqBFTlOfK
         Urw872G7R2VA2xRNGyzO506SOZAt2mlPiVGCu4ZQuPcmPn/n3HSWaIYyThmUYEj/YMH5
         zf+XtJEGSBPdPbxUuwkVkaF2/MU0RUQwTGyKrQUSTQvDgTeK60f6Wtpst85cLZSa6u42
         /Zrg==
X-Gm-Message-State: AOJu0YzgwAHTK5MCV3CXcBhtEn6CtTjypfwsLDFwvwPAp/qC0zBBwmhl
	7ECCT/bNN7TaWENNYLgVkjstxrHRqQNRt/HeZLi2Woq0S13h2oSjLadN
X-Gm-Gg: AfdE7cmFamANh+wQTqZSMub9KB1NTAx4vgkVJ/+KJw+KOudpVehSCHocibt4s9AJQ/R
	GX6OR1gdb+4Ipx6/lYPGu10fiMPtVpiYtTZ7LHmSaojUPsSiB987oCWeBru0EzYFhgaSYrxHpzZ
	NPmCJkggRPyTeLAAqtLZN8PM5t57Ixf//kmrhhURbHQDob3+OaocSbHgdDMYA/6cO/smjMQLvZC
	9PKgAPMrSYdP2qByEhrKEyCOMcz0I2DOMEyxtFvSZjBJeNfkTBE4ePE9qOQ/ISWZwPbCQM3hF4/
	85gApNOziWSsE8C85ivXSq2f4AVWfOIIWIWwMbXy1Bn4zCuXKk8DVfVfd4qQCVZQmCpr5epYhAF
	xQdySEWqpMoITKL6CHHPME8EDk3ZAE4qy7KES0xFpg/ceC6Sjv12YC6UPI7nFETk5z9A9945Aje
	CWM3Vt9LAOgfo7ODSNr9pNzQoRwwker0Phe3WKY3oGr/YFSBrU2CJ6q/5BOCs=
X-Received: by 2002:a05:622a:1b8b:b0:517:8e65:68ea with SMTP id d75a77b69052e-51e424540a8mr3623901cf.54.1783998590132;
        Mon, 13 Jul 2026 20:09:50 -0700 (PDT)
Received: from [127.0.1.1] ([209.202.207.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae206b6sm101289021cf.14.2026.07.13.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:09:49 -0700 (PDT)
Message-ID: <6a55a87d.c6960a0e.13e016.2f67@mx.google.com>
Date: Mon, 13 Jul 2026 20:09:49 -0700 (PDT)
From: Ameen Al-Asady <ameenaladdin@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: btintel: Fix spurious error on FW download
 error recovery
In-Reply-To: <0f0d783d-8b03-4048-bd7f-b97dc2bce92f@molgen.mpg.de>
References: <20260713215537.81222-1-ameenaladdin@gmail.com>
 <0f0d783d-8b03-4048-bd7f-b97dc2bce92f@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Paul,

Thanks for the review.

> "fail" is ambiguous to me. Maybe "errors out".

Reworded in v2.

> Any hint how to match the firmware versions, or add a sentence what
> firmware is on the controller and which one is downloaded?

Added the firmware build lines to the log excerpt in v2. The
controller was running build 81755 (2024.33) and the file on disk
contained build 82122 (2026.5).

> Please mention the system you tested this on.

Done. Tested on an Intel AX210 (USB 8087:0032) on a 7.1.3 kernel by
rebinding btusb with a non-matching firmware file on disk, in both
the downgrade and upgrade direction. Both runs took the -ENODEV path,
logged the info message instead of the error and completed the
download after re-enumeration.

> Excuse my ignorance, but moving kfree_skb to a new else branch is
> not totally clear to me.

When __hci_cmd_sync() fails it returns an error pointer instead of a
real skb, so there is nothing to free. kfree_skb() must only run in
the success case, which is now the else branch. The old code had the
same behavior through the early return.

v2 sent.

Regards,
Ameen
