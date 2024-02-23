Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAC12C523
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708896; cv=none; b=BKCb4iURr0TgxZHTrLEBGz2GIKoGTcsQUlLLpMcsUiLBvW2WLkNgHHgj6BPBaMPFF38Q4iDocjEdI1fVipV15yQvdQcPWdcZiv1XwY3HjJ5il782LJGB2U53qdKP0cDO4KzI6A8MkHNfgqag9Y9oIBtIal0x5lL8y7X6Fysn1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708896; c=relaxed/simple;
	bh=eA3mpcQgt8oob7Woga4czx0TXMHp8ebrBtOWU0tv1y0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=grQoURMIeRN3DLR3otTssEIsPztgiPIu6Alwls/gRu19CC/SGVqkF0VaoWrrI7QOS5OGXADnsyWD5ELPIs6T5t4gaFL2HBEMLzjW4wBtsIoJLQTuhMYB56UUg6wus1hIc5fPdqYnsPhd9nJ4jGcAe9WNWWmM/JXK2nkf9jkbgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgaieymB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgaieymB"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68fe2588ed2so2556676d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708708894; x=1709313694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6INFWYiu53jzhv4R2NpsOTGW+OirXxHxfy8yV+30Y00=;
        b=JgaieymBRCYnVkeg7e9Nnre4S29LXYKabuBjgE9BvXrjWah/DUMqiIPAavZn8O0WjM
         GXdM60SEZVBJjC5j47MeSD8hFLw2jkutWJcaerdUTmc8bFgc/T3NY3eBgShgVZ8zooEL
         SQjcnibBociqRjjAcmchmzTL19lS3rk/c/+lhsWeWh54qDYIlwBxXZF1f8u4QvV8oiSl
         7fcsR31bXV+bTzX5cs+I0qthxGmCN9AzPd/fwan6rEW2wIUm0N5qOrp4Grv8n6jobNND
         WL0r/jvvg81RhM5qGvlM2xB0brYRtgRHenoyALf5jBcYtOEgWvWxJDMLS0bhe+Sugdjc
         hBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708894; x=1709313694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6INFWYiu53jzhv4R2NpsOTGW+OirXxHxfy8yV+30Y00=;
        b=S2jXFLlRtJC11GSrAwgDaBuJ5H3v+AhbH1mMQwPDHRfVXCL9+evQyQs7OmsDmI6KXJ
         Teeb6i6vVqSnAVc6hGJfJNBYtoHSWAqOIKDTg0J/hIP7GCkgSGc55DCARhN/KhDTor+L
         dv7ViM2Rh4Khx99mybO5Ee7n2VOf4tuKZSjKVNFvDS62HdqB8qrafwHJh2CwDok02V+u
         YBJx+3U/3LZ3q+Dt0QKiLkMmFRwf8QgSxEWtj/hwKW0JjvJ66fXg0zHQBiOmdqSqzUVS
         bTuBGLWngk+Q91l+g6oDEt/JACG5fRCoH60PCkW9w9VMgArj5ddGOiQxcEpuEdvjQv2m
         tREw==
X-Gm-Message-State: AOJu0YyDYCNuLTY3tp5umgwQ7PrEpj0f5eAsHzLGuFog/irBYAe/s4Y3
	onpANH38hCLSt0BNyoQTGtZsFyXO0tiFt65S1B9tkLpCos3Ngh56T1lFEsA7
X-Google-Smtp-Source: AGHT+IG7DVreZtMFU7YSFJYDZRsz1ilyhuLiERt3gFgDmIHUsqNLAexQSovMYoEzupmY0CQ6keMnMQ==
X-Received: by 2002:a0c:e210:0:b0:68f:301b:5481 with SMTP id q16-20020a0ce210000000b0068f301b5481mr488698qvl.13.1708708894098;
        Fri, 23 Feb 2024 09:21:34 -0800 (PST)
Received: from [172.17.0.2] ([20.84.127.101])
        by smtp.gmail.com with ESMTPSA id j6-20020a0cf306000000b0068f9f26ea47sm3967245qvl.72.2024.02.23.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:21:33 -0800 (PST)
Message-ID: <65d8d41d.0c0a0220.bf5f3.6954@mx.google.com>
Date: Fri, 23 Feb 2024 09:21:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5973408184143687022=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Update Sink BASE management
In-Reply-To: <20240223153450.86694-2-andrei.istodorescu@nxp.com>
References: <20240223153450.86694-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5973408184143687022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=829146

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      24.47 seconds
BluezMake                     PASS      715.60 seconds
MakeCheck                     PASS      11.57 seconds
MakeDistcheck                 PASS      165.54 seconds
CheckValgrind                 PASS      229.04 seconds
CheckSmatch                   PASS      333.01 seconds
bluezmakeextell               PASS      108.83 seconds
IncrementalBuild              PASS      1352.76 seconds
ScanBuild                     WARNING   968.20 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1154:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5973408184143687022==--
