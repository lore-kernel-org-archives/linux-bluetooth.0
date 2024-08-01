Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA8189B95
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512644; cv=none; b=LLJO2H0o+Ct4trLbnfg7Xq+8NB50p05zL/VQ3bpdtvad7IGdh9GQaBC/nEu8gIMLGgszTenR5fKhMwKtWCdqyED91NeHvlHAy/i2Xg5ByoUHvWlrF3xWdYPacwKnhVGjBT65XqzDLt6YRmhsQadS5YmnD1tpI5fHzXLdsEfb3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512644; c=relaxed/simple;
	bh=5F8UXIxNvkurUl+/91J2hNZ4jrTCRW8lNPcfyzUvl44=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RhYA/fHgiEt22LxN9IhF5oCT9pueKemwOpb9zyCRH+i+XAgJuu4BU4i/WfjHHcfdOHpaVRpwtgizhCtaUeKJz/0WfJYWwUmdVHyOnImBRJKCTYQq3/xB9qiwR+mB8ffCHcZewpYAb50wzMXklg8B3fPuDptNySE5/xv25VGLcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma5KPms6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma5KPms6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1e2ac1ee5so440021785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 04:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722512641; x=1723117441; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=34HHSzuU0jBlWDWLhZIy4SkgweHI8erye7R0LR80YiM=;
        b=Ma5KPms6vegU6PzwHMXm7jA9xF800rX7orDrVYZxwp/g7aCCWNyIg39Drk9FCku9r+
         8t1+N6+mQLiz0SoraZPuG0dGNVNmguWw/8mW9k5kd/85PmLxBi3IFUCfAF5vfLlTnLGz
         Gjszdr64GDFQrfJSh3En9LT7s7si/GkzRne2Pa+TnfXeARw5mwKkMVmCDLUodGdg2U+y
         ud0Yl6tpNKeM5neN62hOE62it7HAbPZn6QM0/giVSWWIi7qa86xVIfv3n2d+EK8Kyh4y
         VIvZeNUVShC/1pyoPPIglk/H4WZxDKquXKyoU+NVIzPLzbTdlPE3yb2j9Mur7UWnnJQ7
         Ke9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722512641; x=1723117441;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34HHSzuU0jBlWDWLhZIy4SkgweHI8erye7R0LR80YiM=;
        b=Zr4QHUPwQ+AdesiA4ITBPq4JUu+e8r3JITLVd3RQJ516BnZs7eT/VtCQZCl1KIabe3
         /2oVYIsGx8Qlp+CZ7/FE7Xsht6AH5mpGvTnHeU5sub2rjoQ3CDcuWMEE1MfUtoAE92cR
         7Pa7H164/nY5pVZ7gaIR2kn0w4+cFFgHMKATPELSLUiIcuULa4vhWhLF/dtIIDqQY75h
         U55n9CZbC4J8WVh1JNevaxUN2N2HUFAaQwJ7t61bcSjf8YST/xCkeBS7tRAssCt2l0Hy
         vglEqEBt1lrKUf33ASo/U23yYMPXe8kJN39JEJtwTyVUTjjdS0SpuFKeh4Ru/YSh2/Ko
         DV/Q==
X-Gm-Message-State: AOJu0YzNQNh4jhqpvKimFeLHnbErH1hfVhJ09x3Ns9lO4mU2Bu620lnM
	pyTVObO0ARy6M6hJgTqYZCsd/HCFa3mZZznDrfOM8kVZ3epegC5LuxxIyg==
X-Google-Smtp-Source: AGHT+IH2E097UodkgzcZJ/rfyahgRauywC9Pb6lvSY6xg1NZoC4iUMdV6G+Bok2hfoya87sAwyE4ig==
X-Received: by 2002:a05:620a:1988:b0:79f:18e5:f730 with SMTP id af79cd13be357-7a30c67a108mr254810485a.28.1722512641374;
        Thu, 01 Aug 2024 04:44:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d74342b8sm845120485a.73.2024.08.01.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:44:01 -0700 (PDT)
Message-ID: <66ab7501.050a0220.38d9a.be9b@mx.google.com>
Date: Thu, 01 Aug 2024 04:44:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0515704753912842699=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v7] obex: Move size emit signal to plugins instead of obex.c
In-Reply-To: <20240801093119.25832-1-quic_amisjain@quicinc.com>
References: <20240801093119.25832-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0515704753912842699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875837

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.52 seconds
BluezMake                     PASS      1680.84 seconds
MakeCheck                     PASS      12.93 seconds
MakeDistcheck                 PASS      175.97 seconds
CheckValgrind                 PASS      251.35 seconds
CheckSmatch                   PASS      354.25 seconds
bluezmakeextell               PASS      120.62 seconds
IncrementalBuild              PASS      1572.33 seconds
ScanBuild                     PASS      991.46 seconds



---
Regards,
Linux Bluetooth


--===============0515704753912842699==--
