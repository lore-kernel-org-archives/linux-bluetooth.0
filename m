Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321F1E1E19
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323157; cv=none; b=YGwtay9RD2bqp2Alw9kCy75UCNe/Agx0/6QLv3G1siirQ+LnWoeThF5qxsWhaFK41QknPYgZ8g7Db3uybKixEV8tEVybcoBZ7S4ZABjQoJl0LyEhb/OIeowEzttP6GUSIaVbbSKowgslZiwfyvo/bp9gAw5I31LTE9PpQdNV7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323157; c=relaxed/simple;
	bh=P3g/MdcpB0heNNCVq3F8cZbANvX9BBNxFXcmFV9IkpU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q+QZSjHMENAHoOJ2UEJIygAtS48ZI87ZgxtaP7mJlBiseWxojBlbSvWdbyF93DxEJNsArfKVeCHL9QiDpMmSyTXbyM9vw/TUo0I3oB6rvu5Ql1u5koZbXYBwdfEP/Eo5iXmb8zZHJGV1Xn/T5+YP//Wvh7LW+rGiFJg4EQkgwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiR8xyps; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiR8xyps"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445805aa2eso40315495ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Sep 2025 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323153; x=1757927953; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P3g/MdcpB0heNNCVq3F8cZbANvX9BBNxFXcmFV9IkpU=;
        b=aiR8xypslJdBMHiR09Elf8zNxcMQvKwgoM9PqFczDNcXmTsEYgyipBNYCIx3aQ7m18
         OYxC5Av8KrHw7zCfluXnox8r+vdXk7Vwnpb5tO93Ushomf9m1svGHbPeuQQWI2rAg/Ac
         Lzh6C0r4O878nZuBoPaxvg1dn2dhFdrURO8TJtJNLGjwb3waqURVwMMbZn/K17twUpvN
         4R8M1gg5zTm7wUHLVlRXkuRajTlTOCtPsz7t95rBUiiUxPGewoX5n35OnbUdIJPp7jwE
         nw9p3Y9wbsEoaZRxSDqAZkPd0/4iSNAE1HCAnzaeI8s3+OZEXGmiuCV29chkSyFuQQpe
         SWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323153; x=1757927953;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3g/MdcpB0heNNCVq3F8cZbANvX9BBNxFXcmFV9IkpU=;
        b=h+ie77VZSadb/4om16caokcK7GSq8YEhuyW88OCfuzNZdD8dlNUftQdTiHeuRnZDZa
         yU4e57GqNY7fawK+MpwwySl3rPHy/bo9yDlFNd115O1spROBIr8Y5UOvUVXzZufQZFhn
         fyWL69LOs6rsr2DrL2vEluwEuJ4NLsfx1EIG53vpl6LflrPxPGjUEkSHdDHyX7Dm+33r
         gNGdBF/BhYffdexPRGp4994DJchx/xLCahprU6n68b/U2wkUapo+P+yQCqLpGIfryBvf
         pjfufSaClLZKllrnkFTHvy2UzfzW5Qfdxjc6eQodkhfRkU43BWEzQw80rPR8CjZCS7jp
         IbBA==
X-Gm-Message-State: AOJu0Yx5Xu8nNicEAgnuSchcmvI64KGcNtCsvAS3/7bXuafZgWmJBXBw
	1jwjLGexOiggHGs0WJe0qy78g3bqSuCiM2xYQu78PjelqLoItmryXSG/gEIJXA==
X-Gm-Gg: ASbGncvEWK4LtzJwW+1WqL/Cpdl2AbW7USXN875q0AyMfLyFO1kMQk+w+rw7Zw9sB0l
	UupOh8wnRHg18ZFsy+OkHFofHkjtcBBC16+PYmN/pVLqoaiPnGUvMdi/KPiY+qr4Llcgg0jFolb
	T4EhHLQp1TyJvR/+TuWv5CAqzZ4IEJoq/1KS/d4GmuGbs1Q4wj5l8S3v+dNl4LzvJrIwOW/V7hl
	aDDhD1tIZAlMIIowjeNfKIxYExNo/t3+s8b48ysb7HY/HrMkulJtqPOPO22Pixd6uOkAf8xVt2R
	GrVxBSKJaxsRiVZc7mc6BlGIUAQmZW/2LVeZ1LnnO2yI+MYlAiIMdZPYyBYezm/tLBFi7NKWkpB
	ZVDvGHeU7Z2jgrNQtlTxXAnFG5Oagdt69ibZEC9yd
X-Google-Smtp-Source: AGHT+IHluWBPWISGSTHWxvnVlAGFaGt4ib8l2Hde6bCS2vCVL0DBLEDibCQMv0FJ/4r6fpGomkSiIg==
X-Received: by 2002:a17:903:1a30:b0:24e:2b3d:bb08 with SMTP id d9443c01a7336-2516fbdd4c2mr89873435ad.20.1757323153019;
        Mon, 08 Sep 2025 02:19:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b13613f5dsm171089365ad.16.2025.09.08.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:19:12 -0700 (PDT)
Message-ID: <68be9f90.170a0220.8bcb2.9023@mx.google.com>
Date: Mon, 08 Sep 2025 02:19:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7439321703158239472=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btusb: Add new VID/PID 13d3/3627 for MT7925
In-Reply-To: <20250908084912.1853827-1-chris.lu@mediatek.com>
References: <20250908084912.1853827-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7439321703158239472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:735
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7439321703158239472==--
