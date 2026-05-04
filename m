Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410C3E4C79
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916625; cv=none; b=ks8sdqOfHU/uQQDDJJfEhnBjKFLmhZaWqSgG4hvrGycRKGHtjZOEf9yDeiH0WMeIK0p7aPf1Vr3RB8jevPtRP78u6COm4HKGTeTzNnKrMnijDrnfC+0bfPFal676YgLsb9u1Not1555dD8CEK50j6NDdRBgMH98ulghJ/lluBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916625; c=relaxed/simple;
	bh=e1NbAuoyHdirlNLYqikbOQUfIcds1UhtM1T9VNQKyyQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tOnfYKZxa/RWGH63ohNZsaNNrHdnfDlRRxy33Qxj6/MSI6MBRuqCZY931YfFAX7bdGWIvXysLQbaeoSEFzxuoOlNrP1eq7Fxpv0bZZZQulU7FaVVUqlzbwDuEDLAVr4k4olaPB8fOXk7oCmB+C98sWRs1HckCZhstxP26jJajdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arzDAFeD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arzDAFeD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b8e98fd885so11361846d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916623; x=1778521423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c9mLNFecM8jBquisIOmtIDMy+YMU9hgdsTRwjMHm2pE=;
        b=arzDAFeDT1CqZYM174H1LYK49Opw5kf7ZI9EXxVniJWSZfYOpx6kccHxTebEMudevv
         uYlU9/F4FZjvujilriMxj0FeHCJGRewLKv5L+slByxSSFjimFFL6cyx9W1XPVYgf4reH
         0L6Y07iBuA+gGki+LcKKNbnREFHPqRMPnMwZcXU7cT+k6HrjK+ShHRAU2enaFhfx7jqY
         LSxxthvWILN9B6A1lsl18lUuvAIT+tNnttq0RvfDOg9E9A4GuAZH2mNUHTaaWAbo8x0a
         isPZD9PFRQmr9lyciLjsDxf2kI4mriIkauqS2uFDrxFvShDgH/jRZY4FMemnrQxG6/7W
         FrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916623; x=1778521423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9mLNFecM8jBquisIOmtIDMy+YMU9hgdsTRwjMHm2pE=;
        b=j8rg5tpmjphGmXjH5BL7sQqRzXEA1bOj8crtNyXWKbjsnMODlpDE1rckMXq3r96hyL
         TanQh++f0/OF1acf1qD0WCY9NTpKn7VRFVbRherat0OUERo2KgAzsUO4wWtdFmqxBvYg
         4J+C6bOtv3csQTX8SzGRpUuW/ugspogK1RfMZjeQypeeARG7vyRv3qMhPME6scUM+IQy
         AHmyup4SgjsR2XBOQNsUNhy8PeNtPY9D1k52hmr8KXm5v2MpuUVjV55bDsgR5kHXJBgj
         Jkyn72E9LlcQgjaMfBkcSGMDwqrH5u3DWe/K14zRhd9RljuO7lhSKiW7+u449L94IY9k
         P1QQ==
X-Gm-Message-State: AOJu0YyKC0EkLbPjbk9bFkfeIM51WIPHT7trMcq7Hup5HRrfc7NmW9Jb
	z0PHGXpZkgFnv/kIEOSTPDQDeHqsyEmwpedepmAjw7b1D/SopCYFqXpwlT3vVg==
X-Gm-Gg: AeBDietMYXmYWVeL+nQQoKfAjjJRbndAcV0BLDXPhedevcc9MysNCRtJvvq4giYNzu1
	htytK8URl+6LnpyCk0HKeXRwPgdmzAgv3Wb+JUNU0kYsA8Mpt5y5OcaOtEudvMQBfIvDPDMVGRj
	HXlvo0v9FVJsI/fQv6tvwMiaO9L99K7robN6Ll1i7MDKyIqrSeHOvWH8hTbqTvMhrsueLoJmsbD
	dUZ4lAvsjTnfIATRsnVo+L/S38ErEfvDPnEo6Jazebb26NWeeZ8Qpd4j1gTV0f2EcKMwnpBWEd7
	cN0D42bjwZwmwNrKExx7Op3urT1KuDE8sSE/AbC+oyXYwzHFP2e4de0bmj+eBxMHpvCPkU6KUj7
	qyF3cOackFds4Y1+8QMmm8IDog/CTemZp3mcvlnyQx8tDzVTQAXrrImKUQp4JQBsc60qboDg/sQ
	HfWTR6lyJ/iJtha2cmT2A/hAqMZTD3lib02tUEjwrgsg==
X-Received: by 2002:ad4:5f4d:0:b0:89c:a2ad:33a0 with SMTP id 6a1803df08f44-8b6699c9253mr189299916d6.45.1777916622899;
        Mon, 04 May 2026 10:43:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53ce7e73dsm124521576d6.42.2026.05.04.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:43:42 -0700 (PDT)
Message-ID: <69f8dace.0c0a0220.264aed.0e6d@mx.google.com>
Date: Mon, 04 May 2026 10:43:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8539246879249225676=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: RE: Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
In-Reply-To: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
References: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8539246879249225676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089397

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.13 seconds
CheckAllWarning               PASS      26.35 seconds
CheckSparse                   PASS      25.25 seconds
BuildKernel32                 PASS      25.90 seconds
TestRunnerSetup               PASS      514.33 seconds
IncrementalBuild              PASS      22.82 seconds



https://github.com/bluez/bluetooth-next/pull/144

---
Regards,
Linux Bluetooth


--===============8539246879249225676==--
