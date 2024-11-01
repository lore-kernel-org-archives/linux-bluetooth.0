Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76415F330
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459427; cv=none; b=Cgf9v6LTj4yA95NZJdcmizsU2AYYH/LFMNMa/nE6sqks5Nl14uSkyQuR1KSm7i4UCIhBjsDZDlqxUnCP1s4poh2659xtFKZCpoerc8c9xy+9pziBMvaDlc1VHosNI0R6TORmpBlbgY6snaPfgESHxtpf7fQiaRNmDR+ZlOT1H08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459427; c=relaxed/simple;
	bh=Il1K/7QcRy2QnL3hxB9qwZPPrIuhASInd0mth0rFrSg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lAhGaaVT3iKSynOYldpJfhAWQ6KeFa3TFIQaZzlY0trrpi/ECImn+Wc1Vps8M0+hdylcs5NkiHwSwoDtVwjaqvRZFxw36QE0Ur5XT89hgONFDkFb2+0iT0V52Zwl+TKM5fmjiew8fccG+AA8zK73V991CjnQOYg4aj5ZkGnkh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c34BFqRp; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c34BFqRp"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460b04e4b1cso11814781cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730459424; x=1731064224; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ra8AICIfH9qjZlA/UlSqEKykehGM6scQwdXsDKERE=;
        b=c34BFqRph61V+pL/s7kLh1px9XESFeyVlqtBGbGI0QK4T98mlN7oZF29ajNt+43QT7
         RNP5JO3Em/aZU1zrX/r2DJy/28grCBIySnDsX8EVAB6ED5llQW0gTOdS7x+JchAyuQh0
         uL2VhsRICkeYjO7xn7R2p71LP8rrIhAtoHXrQgXKCGNXH3Bo9YH5ZpxOmUCFgsK4lnOE
         i1BI+ENcF05F5HmFNVm7T8BJ0NxpeVHNdqpd168n+aj6kJtcs+RlRGBHV7X4uCArIk4f
         K0SA1cEcSzWK3WrzVvu2H68lz11ZStzNs2/lVaDV2DoTSKm97LOq5l5haN4LVLzJLEm6
         D+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730459424; x=1731064224;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0ra8AICIfH9qjZlA/UlSqEKykehGM6scQwdXsDKERE=;
        b=ZZIKN81RrFV2y3hGJvIOV94Rf8itrW3G3HHS36HtGPsMzyYn36N7VtrQ0p+b77GvCZ
         aXS4GxVJuPu9K17QDI8u5ho14iA/QYRdN8jr6AlZwMTyJHucUKCHL1JDM/FnxLdY2h+u
         sdTn15IdEJ5SxQEdbSwD3YSWbj0KH7m5CSp61SyymAiQZkvxFwtwqeQxMhBUHFcQGbTz
         C8/JGLtlM5vLSr9h7qpgkJJEguRKPvpmia8FnJM2fCHTwIRj5v+Wr4R5L8kYU/n0M828
         IqMmBxMIbI0X0uxuF2e1QgHm82Ir5zZWQ9nOojS98aJ3E4oego/9SLu2Aa/6qen/Rtjb
         ceSw==
X-Gm-Message-State: AOJu0YxueX4p14f0j6bF+nw31k91w5CbaVNbcPAH2Us7lffOh8DQUVEM
	jlunSThK0ncqQZ32ntSigLNwN3oMTxj41QZkvQjeOb1P6wIhHNTOLzbHsQ==
X-Google-Smtp-Source: AGHT+IGb2vR65mSmEKmaAiOQl3txFh1Ta6oOC94ig6j2OOTS1Vyo3wL5jUfJCiuG7WMLpsuwaqhwwg==
X-Received: by 2002:ac8:5e4c:0:b0:458:294c:39e7 with SMTP id d75a77b69052e-4613c1a7512mr357009061cf.38.1730459424157;
        Fri, 01 Nov 2024 04:10:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462b0d8faf1sm14790661cf.76.2024.11.01.04.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:10:23 -0700 (PDT)
Message-ID: <6724b71f.050a0220.145873.4759@mx.google.com>
Date: Fri, 01 Nov 2024 04:10:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1762912851899501798=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v4] obex : Fix for PBAP GET request in PTS testing
In-Reply-To: <20241101093304.1631217-1-quic_amisjain@quicinc.com>
References: <20241101093304.1631217-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1762912851899501798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=905326

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.99 seconds
BluezMake                     PASS      1803.79 seconds
MakeCheck                     PASS      13.67 seconds
MakeDistcheck                 PASS      181.99 seconds
CheckValgrind                 PASS      262.50 seconds
CheckSmatch                   PASS      361.29 seconds
bluezmakeextell               PASS      121.75 seconds
IncrementalBuild              PASS      1686.67 seconds
ScanBuild                     PASS      1033.02 seconds



---
Regards,
Linux Bluetooth


--===============1762912851899501798==--
