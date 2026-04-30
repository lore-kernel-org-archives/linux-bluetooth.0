Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77D2DA768
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582485; cv=none; b=g9BqolDyWoENIQPmc+kMm78owrgpWvG40uucQQSTWcyYaafMDsazxM5QldnzifX65GmrmfSxYYn1MSJzNU8mgN35d/nVoI/S1m5nVc4TZSIEMDxiiYZRLzwBJM65O+kI+lCzvdm/jYGvZnOcWbeyGmkqNXrvaezZ6T9/ACI1Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582485; c=relaxed/simple;
	bh=YDYZDrtrFtHRfrZai0LzZIjSYbTqPH6fBYntOezJHa8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=htDMACOGdqJ+RBMJ7Gx3gb3g6EKlmBaYS5AK3XkwZypZ/B31h051DmXWcwK43EPK9iNCWxO7FZsKArSpEKJgkCC7N87WQ43gTdmORSNoufqnkiXqEM4haqNAM+KE8x6CkG0uGXpZRPd35yQFa3ykDGEX23cT3XZc5pxVipMdCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYlShDWt; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYlShDWt"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b4000e51fdso11004676d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777582481; x=1778187281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ma3YuSzXQphLYH5esHMWdR5HQTqRc1MCz4G15UHU1VU=;
        b=LYlShDWtmYSG9YS2L6wJtsctLl5rWw10ObpaEMAba049Nw6fQw9XppAVwUviz/WcJo
         w4IK+NK35joKbPD7+Y1uQisogSNj81yckcW5c4n6FJcUxt8Y+GhX9KeDTvmypfwjvXwu
         nBM9gounZ4RseCcSOS/3oeRjRkQuvzsmGuemTcg+QInLt42LzxM9Lo4mAVIyneOUzKaT
         zmaHMnPASqslP2lP70K+MH/6/6sKVNe8TT/7h+IzCGe25Yy2xSCPNvpLtHjmxm6jkKw6
         NCRS8U+ALk3K98RgYVyN+Z9exVYduKqcSMNkajg0cTTjFuDnzti7xzqlcia5RZEW4jSi
         7tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777582481; x=1778187281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma3YuSzXQphLYH5esHMWdR5HQTqRc1MCz4G15UHU1VU=;
        b=DIQKfAXa0tD0VaUhOlhvHCPJpYIz/C5L/JS86sWJKY1LI3lXNwT2f2XGsrFTWumBnq
         QEW2ubHr8O5RXnzr3DefsYUymsv8oq/pIMvnWbQny+5TgrGyIrCs5wnSekSji+prxBv3
         InXP25sM5y2L0FDqFDhPhqSSivXysTTQ6L+XIIU/czx+SkaGo/ablu9cADoHJwDB9FWo
         nECydw4OFAOI9aWFohPMtdVrGv33kYS0Cxd7sNUCajqax3pH6CJwkv9rHgBuKQR15uDb
         5fIFBWucWwSW+pw4W8D4cdJ9zpKU3R1Ro5MEadeaLtyqhZDq+iO/BlEplFU/q20G++S/
         BxrA==
X-Gm-Message-State: AOJu0YwC5Zgj05Nxz4HrSzJYr6JiThf2ZPaHTEdx1HDhbUWZxKtLwH0s
	7wJhB6UQIj4kbcDNlKlp1h0V8QNBLSZSbWY4kISKO//W18pfL101KOsVim36Uw==
X-Gm-Gg: AeBDietfkRaavEi61lhmYuWxvRZxckbSXarWfOpVmOmdcSvNlW2WLn6ql8yvVCDMlYP
	OXCPTbkoVVZ6uYdEEISldbgVZOf4k/ymcIFkSktmQqd1t6kxD3Zk1cQjpB+z4KAGKFpO+RreshL
	5fR3DzzX8lbyyRxGAbw4Quln6NNTln2fMT/nWh52nEvXXpvHc0Cr9swte5aBakR1AzHt7yVZmZv
	iKyCGP0LVcBavijDBClR+67yRcZkafdGaFcWenli5XHZkGeyZF9uBTpHRt2KF/CxS9vGY1ony0u
	vEGI6UUaDJjs7HNxgqSHfpnJcLI75hJqGvns/NYiIUxx/6oBzUSUiya+hqTocLIR0q0f67mWrPN
	2mJ2H/esMQKQ7R/RIXIGO9NGLivRKsvUNrqkZGbVO5Cc4vSBaA1+Oe6WTetnqdMFld6Hv1Tla/I
	pLeqESIlENnqxjP48GBmk4kZJKIHMrRBiWmEZuc+Y=
X-Received: by 2002:a05:6214:5c82:b0:8b1:f069:3fc6 with SMTP id 6a1803df08f44-8b5478e5145mr1382346d6.40.1777582480873;
        Thu, 30 Apr 2026 13:54:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.47.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c1dceddsm1603886d6.30.2026.04.30.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:54:40 -0700 (PDT)
Message-ID: <69f3c190.050a0220.2f225c.46a0@mx.google.com>
Date: Thu, 30 Apr 2026 13:54:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9033078364399904032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/util: Add decoding support for HIDS 1.1 UUIDs
In-Reply-To: <20260430195114.608794-1-luiz.dentz@gmail.com>
References: <20260430195114.608794-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9033078364399904032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1088308

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      607.90 seconds
MakeCheck                     PASS      0.97 seconds
MakeDistcheck                 PASS      235.19 seconds
CheckValgrind                 PASS      202.81 seconds
CheckSmatch                   PASS      324.87 seconds
bluezmakeextell               PASS      165.53 seconds
IncrementalBuild              PASS      615.26 seconds
ScanBuild                     PASS      926.13 seconds



https://github.com/bluez/bluez/pull/2089

---
Regards,
Linux Bluetooth


--===============9033078364399904032==--
