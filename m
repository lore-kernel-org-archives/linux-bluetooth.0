Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D717D6
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069851; cv=none; b=ErsfOo9rD+ochyt0lhnq4/lSRfzkCn5cmplLh4/edPCxM4Db7VbEC50GrWgjdrIZOpWH4ESg//PG6BY4ppxPPS1rxQey4ktGHajPKwpDNjxvaxmbqJPxwh4mFDrbsELQid5G/mcsmNSF+h5s3AsF0jqy4H3mUZ2qv9jTTqYm2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069851; c=relaxed/simple;
	bh=AP1uiYaH2aHdejRPSbkumNp5h4kb0qA4pQvpM+v6wSo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PPdWoHmT4yMyuj6k/zxFG1xlS5nzX63N9a7QNGbLdndesQSajuWjSxSVnKCEeW2N1ipjLm8zVQ6o/SV+a9ccr5K4YyOCa+n49HKHI+8eszMH9HmJTA2mzJzrrL9pyqIUAOP8r8Vfh+EkM08mj3doqynHw3v3h9Kwk8gpJD4E52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzU4CQK6; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzU4CQK6"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b821f39a12so22094466d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 19:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779069849; x=1779674649; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H+eM+1v4JujqhTVgANhgOyGcGWl3C6vo5a1hT5FVRQA=;
        b=BzU4CQK6+KuuQZh2eV3lzRNpATj2p2At8OWD59FJQVprUlI1ugBqVLm38YQHr1//dD
         wR6x83A8QPTxDOUJpK/r0xuFrJc4/P+j6jiLKeFzVbSXmCO9iC9QNmMgt7raFCcBu4a5
         ZZTRxwfpOmQ68hNWej7V6P7Yt23sPw6gx2heQVxPmmStiwyBCHNO77/7Thc1SQxIVIfp
         5ALF6vU6rAYD/bB4fEu92UzPbTXugtiH7YXzrw8kzm/9ZATupZeBmWBWzudOtso7dzYr
         UR+lDOBtQCMBPt4MHIEl+vZejA6+PYfWOAgbx+xJSqN2XOS+jkYylTViT6HvdHEbC122
         aOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779069849; x=1779674649;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+eM+1v4JujqhTVgANhgOyGcGWl3C6vo5a1hT5FVRQA=;
        b=MG7t+Ze3UP/p37aiH7DtUgrxZ/x4miw2EoMW0gcvEmyd8Que4oJbinjPafiIr2QlNT
         XxbdFohM8fm1lpH9GxxyJBKIvGrfjaZ+NjdU7rHoD+3bdA/mxfh9Z34lHvUQwNRyZ8bE
         jLzuzMlmpYXeL00NvPDSuuHJKh0sGdXPQ1qt+bfq2RfHzvtu5NgEZoG5voXO+w+FHFuy
         3K9l+4mVZ8f+T0iNo3siDmicEu9aU+AWhIbFm/BVikfc/YFeAQHACK5A6VI6u7HcayU4
         usQekmiOQcSE4CapYdrpX57Sc9xtRbNgGFiJWZJkSlGYZeweQpzvLmhVYKEka2HMm7Ux
         9srg==
X-Gm-Message-State: AOJu0YyYEVDB9rnRMUTAhwQlDgh51gauMYW3kbLILITvU7HiCRl7hXhm
	z5DQ2RyImG2V1ez0c4ZIODsFIsjWJ35hQ4uzCO9R3JvpGfIMuDR+Kz1/16p8pbve
X-Gm-Gg: Acq92OEq4V483GekT06+LXFD7CjoderHkHVrqNplsrAGzg5/SxlZSX2wQj/MF9Bdm6c
	GfWX4sZL2dMssCDfgA0EX9LzRzFNHDU6xyAet3krKExril069l1oHgzMnZWYorKshh2EBfeuqq1
	2Bc4tzyRJKHg65fR+30VTbO7SaVee3AUjc1PrqtT7vEW992MNjHiOddy9HWUnxla4KiCpuqOFO+
	hdWbH1lHP80dWXA889lB/n0YbMUiU7/b9bgBsN9IuQpc+iMYDMMQA0qbWSO7SQZ01y9lWaPenRU
	NRMh2mNkCT4e+bc4sS6C/flHwbHPkbCGMMBDFOOQf2ZH95YRCv5hvk4Amk4jQAAP1uqAdpc7vO2
	KQONRZSlD9NGre+KzCePYPpf36H5wcWuoTWqebpdJAqgCrRKvBtpnBucdSujNfaAhF1rE4YXuHT
	i7w5wLtWkljeztAdRsVWKyJHWCI8On8yI=
X-Received: by 2002:a05:6214:5403:b0:8ca:165b:c77 with SMTP id 6a1803df08f44-8ca165b0d36mr210448626d6.19.1779069848961;
        Sun, 17 May 2026 19:04:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.104.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360979c2sm40052086d6.18.2026.05.17.19.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 19:04:08 -0700 (PDT)
Message-ID: <6a0a7398.e571d274.158326.9fa9@mx.google.com>
Date: Sun, 17 May 2026 19:04:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1790161405129992764=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
In-Reply-To: <20260518002800.1361430-1-michael.bommarito@gmail.com>
References: <20260518002800.1361430-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1790161405129992764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096214

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.56 seconds
CheckAllWarning               PASS      27.84 seconds
CheckSparse                   PASS      26.36 seconds
BuildKernel32                 PASS      24.38 seconds
TestRunnerSetup               PASS      533.67 seconds
TestRunner_l2cap-tester       PASS      378.52 seconds
IncrementalBuild              PASS      25.29 seconds



https://github.com/bluez/bluetooth-next/pull/207

---
Regards,
Linux Bluetooth


--===============1790161405129992764==--
