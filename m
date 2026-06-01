Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB7376481
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316570; cv=none; b=IFw6iBm9Oue8/O3EucX8If3GzCIJNd2643Zii865MKU99Ri9+sugOPChA+owIxIjoxe8GYCEw0ceDgg/i+EpIwn067a3Ex2/DyhYQjc+60cW9JkNd4oXZsv8uVeuZVsNGUwNy2DinIVXOTN3c5f4NRKSRaaHyXLHQvXu3C6saSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316570; c=relaxed/simple;
	bh=g6VXqzYNe0Hyd74Jyv9lpJxPUpWVjdyoz+WcwvPE9Yo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T5QwpwWDzkguldOkXkXFIG1/RE5x3w8Fr/16ersn2IrHGPKzqb42o5olRvT18lmN9GzBYPAo9iKFOrRnQR7M/+Afi2/0b2O3zIyHQ4+XvH2ZJjd66XD6Xl/7Zz0+nFVRSfw7yZe/qpreHoH0INrfGzlWmgjfifEkEWsCwcHqipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zkh04+ci; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zkh04+ci"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8cce8873b56so28587416d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780316568; x=1780921368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g6VXqzYNe0Hyd74Jyv9lpJxPUpWVjdyoz+WcwvPE9Yo=;
        b=Zkh04+ciGfudX+6hEe4Q0WrSgexFxlFTTPTY2VFQGW/loKQRpuYxZLnGeV1FgWLV4g
         oZvLnDABqzHk8egKPoRuTlrcnNRpRol3zZYtWfZkykXZ4UZa4uvGKzRV/BffCZRmF27m
         c5BpWZYh8qq8SGkYAB/l3fsOhtYwm0LVij5uFkUkfm3AJ66+hWcobCrqQ5JfiqnN4qhd
         xUV2gqXhBBD/QnxT7FD/4jJGnFDhJSkDHc54nxP6M1MpMw1s10tUR5UUGUxRby6y3BD1
         MJv01O0sQgyH2k/Fu7D8J1p7iIWutezvELOBv5ANtxmN/1+pRMqJIwKgCBkGaCfueEgI
         O3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316568; x=1780921368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6VXqzYNe0Hyd74Jyv9lpJxPUpWVjdyoz+WcwvPE9Yo=;
        b=DScaxhjfLBWALA35n+2kbX9qiNPFI8lzE7WB7nJeeRvJY5YYjAQg0ptjJyHheyux1J
         BmYPRQ27Pa1rg/TvLXk6aTafiFCA4B+GENQOYUqux48R9u8WX3eUSx9kBIzIjTFnYW++
         9KmfuB00rwl+INMeohJjSIMQGXdMIYc95W847Co1PUfzIzmV8hgKC85sgKD0DsCpKea4
         W8yhrS/4xe4hfIFNbN+UumM57Qkd787AKdeP8oj2MBmW1yq8uiBJnfAhwBEM7yJ8HVje
         3D0gF78GU1Ph6Bg4NW8bW0RAxEx9cgr+dbszVjtB2GIcxBvQZ7wDKd/qogIjsTiUuICc
         gzAQ==
X-Gm-Message-State: AOJu0YzdGjZfgwv5+0OrBPGj0U2HP+5mBRJhvm4HYvFfWR3uNY9b7TQw
	656/lY3k+ia17OuT/1ZQP4rrVgmwyRMrnLlubBgrWXJJOI6HH43Vq78SGxs5JA==
X-Gm-Gg: Acq92OHhuELu9qBGfvbdYmlGHerm0uqTBdv/rWVBNx0wECXwi8OFKHPe7HRqlRvOd+U
	RR1DrrysiMHa9YLlZX0QYVAimOCVxwkYaLokerESgbzciN6cFMTcznPMeE8YQpGxTJH1Euq4jYD
	Sw2gH7s22LSplBr4EFSFmIOYLIoJuRUCM5Ox2fwuSBEs+ix5FhL36SWf61CIw25RU9iRwIoH7Gu
	MaKdtFOBL5a6hGEGNA9O/SZbIxoTmEhq/Jwy4LG02tQi7AoivhfxOv1VgCXGSYD3yDMK5nWmPDS
	K4WaZaeJY7bBwYDb/vyrvpaK9oyB9Yp7QS6HD4islXVhsZ1vnJABSeBsLgPVdsuvR9EsIj2bqoZ
	Q6+BP3OqBUJKbm2GKpclZKI+hF2aBtEsD+zsPxXzDSAcFA+gcnc5oKjxs1NY1ZNjSgEf6Fe7OYk
	56YpqR5Ofe5pa8sIE0oI/f2CY0VTYxfCK3uE2hBd8=
X-Received: by 2002:a05:6214:d64:b0:8cc:e13:ba02 with SMTP id 6a1803df08f44-8ccf0392eb2mr132624846d6.21.1780316568400;
        Mon, 01 Jun 2026 05:22:48 -0700 (PDT)
Received: from [172.17.0.2] ([51.8.152.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2164cfsm91152266d6.37.2026.06.01.05.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:22:47 -0700 (PDT)
Message-ID: <6a1d7997.bdb7e8c4.39dde3.56ff@mx.google.com>
Date: Mon, 01 Jun 2026 05:22:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5868638659929434713=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
In-Reply-To: <20260601-sm8350-wifi-v1-1-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-1-242917d88031@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5868638659929434713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/pci/controller/dwc/pcie-qcom.c:1907
error: drivers/pci/controller/dwc/pcie-qcom.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5868638659929434713==--
