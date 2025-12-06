Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981326FDAC
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765034331; cv=none; b=eUAX8WsNduC7gVEO6J3x3XRGViFHA7K6JN7IUOyZhWHs/ofV9k4O/Ho6OhHvmpTABIenT8m0wK8gBLDrhH/WFUOBHltVtd0ElHtnEYvyjzhboxf2WLUdNeTKznXLAMAMpFBJ4wLsJpkQoQGI8JG0vAmqxncmtzrSl/RpZDe5958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765034331; c=relaxed/simple;
	bh=HBTttfyzmS3ZPjebMU7cWOC4ssiv0uCTTfqLcVR8CU0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WYyUk/UCH30oRgoe8lA2kUXefgbNGnafzv7lTRV2r8onTVC0lEVyzPGgFXTr3UXz2LwtVg5mpOmkTgZwktE6/JEeLevzEdub2/Q7FTRfEMDQnVAsbjehnb2Uz+5s6HVhGlUbO7F7D0rXvTUWascw68fLJspMYKIw7iwiVs1DsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAKVcS1t; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAKVcS1t"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b220ddc189so355441185a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Dec 2025 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765034328; x=1765639128; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tsXFOk6Q10PRZp8Z3L36Z2RipfHJ4wAcXtMSX6bFt9M=;
        b=LAKVcS1t7AI2bqpkIrMxa+tHesG1OSxNylfOcIkpbnqtEQvhMXbGe79bw04LC63uqe
         hRArH0rPlh391GyZ+UvCyJqa4zlI/2ccSUocrDZZMND93ckP5MDxnYLDdm1+Ph4wvP1e
         Iz7DO2x/awSjEdAyETtIfCDUsixyTXLPP6PNPRYd+QAeQOOyzs4iip2fXfUVysnq3GvM
         gTu54lMqt/shEEKFYsGBaI++Wo5C49ykN2v+kSnDhPKJqPS5DV28Q3tTKKangc+25d8X
         rRvICQyEip6kTTxISQbw/Z2g2zleJGTycuvkHUhSwEKGQo7ByYur3lsX5XY+uLOMooJI
         yGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765034328; x=1765639128;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsXFOk6Q10PRZp8Z3L36Z2RipfHJ4wAcXtMSX6bFt9M=;
        b=Xi4mGRyFUDjMBHO9UwVIwXGrIhgfRaNHnrKl4zJAazjfN70DiWHokAaCH5ZGlXudOs
         vI4fnLtx6lpN/kFVWL9KBNs25iqpKctNNQHtfaz3NlV9Q7cJ/rAXR8N+wXZ3vgBfkaZD
         WiYBS5MhoXtqlT4+90meRNX5rHIhQ3M/1AbhJIe9KywNGSf+ubICrnJhxS7BWoXZn8s9
         lZD3r2QuXBgSIOlMVaLqFjuZUiX7hL9+AtXA//qQj5Zl/nPaTRRwgF2G1i7tt43y0pBX
         M7BBBtvF2eKy8O69QsNFC7IHQCpMpWC2YxG7l1R7FWVy3c7d9j3+Q2IgY5Wh71wVV0m+
         2nng==
X-Gm-Message-State: AOJu0YzGQMecjk8tnS+fkVpbYPY6LQeUay2yrDQwWXzF7AZjnXExlGWc
	HhSqYkiUenbQ6uAwhgTpKHfnn7FU+5Hu+SCfHQcAsCZCM+d1al2chj+QewBeDg==
X-Gm-Gg: ASbGncszrHdS2oICq63BMf32Y4B+huYbzMZNydYrI7SJZS9thWcH++C9239yBj99I+H
	16yzLQYivnte2ADPhqZlJNtcCTSUwULMSn2meim9F19hrpWU54FwYid7HfSPSk9QoWNebM8InTv
	iqniDLM4YkgDx4sFGk+3u21bbZs3Ve7t/nICGC1yvrzY6WCIMCHtMLiDdyN092C5hzn1az8BI/Q
	DCa5GQn88hgwM8zjWnIPiHqVWZtDzR+SEfJE84+ATqqX5BtYW3hv1MPdwTtvkhSaVeEXgwweUeJ
	sQp4KYVK7lVRx3KPvylHcIxSahLNgX6WT4nJIjPNtB2Q7EU6er6NRs7azvGr8/hLPaZc7Nvhr32
	o3/OjeAbTahhqjCEkUPhQZQF41/IOf+0h99fl4s7stdB7O0FGp5eC/CBV+nlxNVSjbsTxRr5knc
	6Cs+5SABtt3OFI2T6l
X-Google-Smtp-Source: AGHT+IEgTNbWgczgO85RT2yxAv17lEW3+pJVfV1SYULrj0k8kXyxum+Cs1GxARLU9X7wKNaNzkIBRQ==
X-Received: by 2002:a05:620a:1995:b0:854:b9a1:b478 with SMTP id af79cd13be357-8b6a2332b6emr355670185a.18.1765034328371;
        Sat, 06 Dec 2025 07:18:48 -0800 (PST)
Received: from [172.17.0.2] ([172.174.165.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b6252a01f0sm621772985a.4.2025.12.06.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 07:18:47 -0800 (PST)
Message-ID: <69344957.050a0220.3737e.313e@mx.google.com>
Date: Sat, 06 Dec 2025 07:18:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1464474978344329684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] monitor: show ISO timestamps and fix their handling
In-Reply-To: <d86bbd8809c75dea5107ddd0f63f300d3e9c6423.1765030276.git.pav@iki.fi>
References: <d86bbd8809c75dea5107ddd0f63f300d3e9c6423.1765030276.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1464474978344329684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031084

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      19.95 seconds
BluezMake                     PASS      630.17 seconds
MakeCheck                     PASS      22.33 seconds
MakeDistcheck                 PASS      242.10 seconds
CheckValgrind                 PASS      300.44 seconds
CheckSmatch                   WARNING   350.13 seconds
bluezmakeextell               PASS      183.23 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      1019.59 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3866:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1464474978344329684==--
