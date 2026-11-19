Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098229;
	b=zu5vAt9KqKLKX2aDQ6uYUGQ2nM55v1TZxSnVP0re2UKZV3xnSAUS/RfK3KF5l+H+PUYb
	 jKMxURiCpOR01IF4MZhV5sdcJDVInnPWsFjHO8VULStFwC0mQwdjfi62jZKUlyar+g62A
	 ETiIOCcBZuu5lcfPrkrQK1IP+YkBk8YreegP5bysqDD81P2OXQ7XkrCTzjvSqKNBDWBbR
	 +nJDacmkAQ8JBURVCr+yTuWwGsdRUApyklPf3xp84NYYiBS4aCaegEkpvnjkfgNGt5gf8
	 gzPeEJ0f0CA/oC5Vn+iaIrm3UVr62WXN39Zl/6Ms20Vrg19NIRG+Vmpi6q9cu6/VOQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t9bWB+Ike65eic+Yy4cT8z9+HxhXkL0til5+GubOeaM=;
	b=QSvhvyEpnBk93eGP4XZt2hfmlkZA6Hkj9fxcGI5mGk4t9CM6wQH2jKfPqc2mx8WIvKvn
	 bvFeAxd21VEb7jHg0yNzKonbg4jOoqzm120QH07gRvDC0eWblNEkV3GBIJe/EOIXyFvi2
	 n8IdoJ6VdWhjPbdxcCgPLkF71GwpzeLPh8ViHUgC6MU8Q1xYzOEDZizF2UYkKMQCHSyb6
	 5tv8tfsyh+ygVvD0fQnkAEQ/Mh82fwa/rkoW7+05twdsa8C55i609iDaLWyAlwzh7ORmo
	 z6BYKh2P9bMf573nUBlPt7Lif58SCslr0JCJKXbxqMLPG6trB7zOg1yS66cukI0eccw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RakDrLwK;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B1606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 14:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C2B1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RakDrLwK
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2efd7259872so13749745ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795098228; x=1795703028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t9bWB+Ike65eic+Yy4cT8z9+HxhXkL0til5+GubOeaM=;
        b=RakDrLwKnpFkXQ5x53xU+/JtMeb5PKs/XkG/jGg4XUbPrV73tNZs5tZHokm+sjHSaD
         R53c42cI3ZAqLjcvQeKkxZnMlquo2wkjbjqxPk/+SGxCsClwm9WbYqtlckHmdAMLAW/W
         sCiIayoTguztq+/dzFAq47t/Wgeni9PqjkfBR/GKPGF1vnphVLQ9OSbymwte1rXoSaNM
         SoSH6cEG/+tzOQwWZDOZVZXJKYCAEGrndvMQdcryCRTXj0asVWvOO0gIYKrjdEZhARPY
         FJ5yFBp4vC7QWuTfm2RHldZSJvR1Eo78YqbRmFO191CVsS3RVXrql2nTN/cbG/6WKic9
         Sx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098228; x=1795703028;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9bWB+Ike65eic+Yy4cT8z9+HxhXkL0til5+GubOeaM=;
        b=yNityBrzSKMF4RMSjw2afv0dNw5JS1EenNK9KEwlN7VDTGwuvc3frfmS4yiZWaZG5u
         tksokKHFUmOOgikRdlc6VFDwPTE125hR+u5CHs0XywL4gMPZR0wVyh7jCoSrFYLlkQaS
         factgvSs2UMhnH9hXxvzNH3Yn+7ruUBnFlIvWl7nu6lqxMF324aWCeVFEymSdjAAzkG7
         p/N9Zx5Qwd40SzHMJUzjBnYEYCBe/Euj6+Vgi6TRgzsoOL7v+i0sPY4eMIPQxCmOL5x/
         y55KH9SrGArIes3lUo/dRLG30LdkrsIlUsmXeiOqc922w7Mzw5dCWrKbEWqrRE67iNBO
         yUhg==
X-Forwarded-Encrypted: i=1; AL+hErERCZpahBgvjZL8VHIbga2rjoKK1MJRTTt/AchnfQtmuQEf6Yy4emXpJF1bZEge3xh+QYLze8211WO6WIkWPYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kHElBzOsOcrrize1HWGCfre6Gd1iKoReRIUO29QYjAGnHMvBX
	+SCOzR4KXljI1kTPuslHxx9EXugMTgdgT+WiXvEq5l8uiVEOZpYb77ql
X-Gm-Gg: AZFdTZdauA7CG/hoZnucCZmZ1sqFVgT8epNbZMxYz0Tp+aB60TGDQ8LC0sSr54zoGA0
	56+2aW5E1sw+lPMYobpKaguk6YTY4mhNP/iJfomNBp/P3+sAIzehxPY9b2bSGTcsuFH+gmvXhfd
	zRlHkhHB2ej32jDY42MNZ01ELCVDhkaRzgxNDMW313m/vX40ajIe+kHBoCxZmZW6O98yie9C6Om
	j5M/TAySqYvMlR7YoJupXf1+5qwKUDZcUcYeOS293/A9pDbB+I3r0NPSEjA2uTPZfsP9ntP0r6P
	/27lV/P+lTKOMS2ZhpWbodM041L0vaQEh9/1SG8rBJgs00M6B5uVWu/dBYZcIELTqCPek1EanEr
	zv+ebiWhCGRC6avosI7r/DXQL/+mGOmX3/47q/o0aCDoTy5XSbLmiGaQfiRye3Y8hOHFhWF85su
	+VEFi2f5uG2V7o2itIrAhrr2eiptP+3w9kEEa9xoceYtr87WCo+WUSnRsB1UNU4Fjs5oGL1vD8D
	Olnhk7h5mPnu5skixDfgWiCAUzFPq9Eb2hteMF0iYwANHMX2qKoUNXoWZ7XaBkwpmKgMPYWwgdh
	cuOCOghnWk/A6jNIuzjOrWopROyxfRK7Sts=
X-Received: by 2002:a17:903:244f:b0:2ef:ee39:5dbb with SMTP id d9443c01a7336-2eff754e579mr60705635ad.61.1795098228295;
        Thu, 19 Nov 2026 06:23:48 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([2001:e60:8509:ba6c:11e:f696:8454:757])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f10e67csm164415ad.53.2026.11.19.06.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:23:47 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: Re: [PATCH RFC 4/5] wifi: ath12k: Support MAC address from the firmware node
Date: Thu, 19 Nov 2026 23:23:41 +0900
Message-ID: <20261119142342.2063-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261014-b4-nvmem-efivar-v1-4-187c85f65018@oss.qualcomm.com>
References: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com> <20261014-b4-nvmem-efivar-v1-4-187c85f65018@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026, Abel Vesa wrote:
> Read a MAC address from the device's firmware node (a DT "mac-address"/
> "local-mac-address" property, or an nvmem cell named "mac-address" via
> device_get_mac_address()), and use it in preference to the address from
> the firmware board data.

Another user for this: the Lenovo Y700 Gen 5 tablet (TB323FU,
Kaanapali) has a WCN7860 on PCIe, and its firmware reports a new
00:03:7f:xx:xx:xx address in the WMI ready event on every boot. Network
profiles bound to the permanent address stop matching after a restart.
The factory address is only in a file on the Android persist partition,
which the vendor stack passes to the firmware over QMI, and the
bootloader puts no address in the device tree. So on this board a fixed
local-mac-address is only good for testing; a per-device source would
still be needed.

I tested this patch on v7.3 with three changes for Sashiko's review [1]:
the return value of device_get_mac_address() decides whether the
address is used, the buffer is __aligned(2), and with more than one
radio SET_IEEE80211_PERM_ADDR() also takes the firmware node address
instead of ab->mac_addr. With local-mac-address in the wifi@0 node, the
permanent address came from it and Wi-Fi connected as before.

The cover letter says this patch is only an illustration. Do you plan
to send it on its own? If so, with those changes (and the comments
dropped as Paul asked), feel free to add:

Tested-by: Joonhoe Kim <26rote@gmail.com> # Lenovo Y700 Gen 5 (WCN7860)

qcom,ath12k.yaml has additionalProperties: false, so it would need to
allow nvmem-cells/nvmem-cell-names (as used in 5/5) and
local-mac-address/mac-address as well.

[1] https://lore.kernel.org/all/sashiko-outbox-171329@kernel.org/

Thanks,
Joonhoe Kim
