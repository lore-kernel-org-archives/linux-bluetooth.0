Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378538;
	b=ScCJBjbO9OOyHryY5WF1ECjYco2TRC0m2q08ekDhsCIc6WLGU9Ejq1G+WcnHEcbLeFg6
	 QhO9bPEc1gvnLMTLBq8pgAxcOJeGMk/7C7vsidx1QCzYc0F/jmDaRULKDT9+4o09Eo7d+
	 mbDvzawsNOlvVj65bONPA0zVkkjSVIF2uumgWoMrND/aMxZRKAkeKaoQrGTALrJGxdacy
	 YdHO32eF3riCF+/Lves8jD39TOPmD5yXjGr5gJzwvwLpyxA5uFmcHvDYb4pQZXjv42ppD
	 Ey0CKKr5jIpvgzbrSHBYKWHqezChT5AlusfBy1U20vsDdf/4a0n/30OGHY2IxYEW6PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=4wyUn/pgO0fzWDFi0EHki1GaXMBo/cPpBL3C9zZUuG0=;
	b=fj+INs5EE74c+x49IdvegsXRmu0z+W5eg3l0J8CbciGhPLiQdYPC/WmpkSSJtpXxjNdb
	 F01Rq2JUlCtQ//Ow/aA14ampT+p/TrVTNm7Ej5pDZnk27tkaJK/WBSp/0xuTpVEwgYty2
	 MSPHR2+VpHiwWGzIePHeVYLPncBx7k+XFaXk75abRjGA3h923Pf8366t9++drskxjcXPu
	 xmWcieRnyj7QJkV0fhQJ1u4xAGw6iIgQSEmi3e5fCcGDYvrsFw4zQ/WpzsiY+pahMd+jQ
	 wJtvPgFOe36kBKAk4k7BATbOYeqq7lxWdMt721ogF5okxn+qQw7g4I0OqM731eWyEXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLmHhlax;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7BB606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 16:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7BB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLmHhlax
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365b48238dso8252951cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378537; x=1793983337; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4wyUn/pgO0fzWDFi0EHki1GaXMBo/cPpBL3C9zZUuG0=;
        b=JLmHhlaxj2PGC00/9ggossIfsmwgZjOnDaVoSEWOcGHO9aCgV8i2gR1STi2bSigSGb
         MswN0uP3Wp07IHO9DMoIrr0jqnOr+1hRsQj2s1lcduGbzT2V8m9FP5X3IGy1EVONxzRA
         LPI4Bma1FElCLJvehdnZ+lB0yvnBSMtvVreyUechJx/P4vBXtoj9FPB16tQItwLSAJZE
         jgB/o2fsiIaJOMmxcXCpIeVfCRrHkLPlQ10eVUM9mRAmM2iiyPIa8OyyYrXSKLEkuOJL
         whDHyBx0Gm+F0VGaOrp2kO/W7YRrElKB7/aCUDxzs2YuEzE0HZRryUMW0MVNPwhyhZ2+
         mgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378537; x=1793983337;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4wyUn/pgO0fzWDFi0EHki1GaXMBo/cPpBL3C9zZUuG0=;
        b=rjWQqiBcSqSHZKhqJkvUU7uoSZBEWiAZPVNXwbFcxpVADU/TMKVhkAz1tCtPxplwwS
         Kk43wITWCcc/st1kK18M32yosMfjC/FQIpR2YVkGFCy4hRzTUN0Q6RL/JvMoypZ6BeO3
         PiMAgCgfxxDNZzeldz5RJYZHsOdHOcxvb9vKHKp4sM1BBoht8vYIA6ZfbIP4Ul/02Fdi
         TSSnCCbOIeEtzK+GmgRAGGKXuDgBRJADhZzy3c8JuXxu6NXqtbnh05id3Tb5FdOev+v/
         E7++mABD5uJRBtC/NeCTlQ92FWovUup9EQfkD+jMke2f2XN5CdZmxjh8OqFgsyirQlei
         93zA==
X-Gm-Message-State: AFq9FYJ6tj/NwuzFSQiXN8tzk8qwEnO37rZ42rYbkqFcv+PsWzfdKr4f
	pZUFEWaRnPVQlJYJHjUYUXAiMXlpKew5qnNXcUU4W0MEhiDo9rMyQBB2SmKuOw==
X-Gm-Gg: AYBFou2q4ZBT2D0/rNuIERNbTEsBXRO2PSAwgUnX4WNvGG0cFNyfpN/YFF7BvFL00cA
	tPG3OdDw7x93WGSTe/cwdQjo35iUPi/TSFziL3fxf3wIpZTqo5swl+Ofs/4C6HvdWZ5lsZML6zC
	cxceT5Ts52o6IdWNhxgRNw4XHs/SDcM5Rndb8XtPDVbyKx4YKEQNi10QLfuBNKFnDn36tuebAJ+
	9S2BHH/P74L+c0T0/3CjeITg46Vzi+SPyFLGZaTtXnIbgT5QffprBjAuG5+CEIQ/xf77uxeUD4u
	CdxgRipiRaX7T/K3eI5mpwnNWRct28QkZLSxlQlCMekM93qePPT5rr9LA0uk/O+ba+PYW1M+9KW
	y96x30hxw13r4ooRTNjkBcxk18DWokbiDDTFsa1Fk3TCAOF0X7CGxGVUaCVm0pRu6GMw9bJ/Suo
	7NRIDI3qH0CkipYfsA2293yTfoxef2aa4EDIAtXpOLAxjrgVR/WrrZgjD4crTbQHpek9ujYCOId
	2vvVpNIhGc91bVI6NDK+FuRv1mZKk87IUXTQX2yi34x0naFqxZX+KNSacRB2I3R
X-Received: by 2002:a05:622a:412:b0:535:7b01:1ac7 with SMTP id d75a77b69052e-542b3979c2dmr45647001cf.6.1793378537325;
        Fri, 30 Oct 2026 09:42:17 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.236.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54312a5e7besm17252021cf.27.2026.10.30.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:42:17 -0700 (PDT)
Message-ID: <6ae4c8e9.ca480166.1a2ef5.d883@mx.google.com>
Date: Fri, 30 Oct 2026 09:42:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1179484056785348282=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Set MAC_INIT in get_mac_access()
In-Reply-To: <20261030142907.139369-1-kiran.k@intel.com>
References: <20261030142907.139369-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1179484056785348282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197196/

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
VerifyFixes                   PASS      0.93 seconds
VerifySignedoff               PASS      14.61 seconds
GitLint                       PASS      2.08 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.97 seconds
CheckAllWarning               PASS      36.57 seconds
CheckSparse                   PASS      39.58 seconds
BuildKernel32                 PASS      32.23 seconds
CheckKernelLLVM               PASS      36.08 seconds
TestRunnerSetup               PASS      765.49 seconds
IncrementalBuild              PASS      30.37 seconds



https://github.com/bluez/bluetooth-next/pull/1030

---
Regards,
Linux Bluetooth


--===============1179484056785348282==--
