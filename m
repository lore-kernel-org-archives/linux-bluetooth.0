Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071185;
	b=GBnooCaGcWn8oi2Rj1mFYMRNOL18wCrUJTg3viIBfgOCaKle+UVmmFVw1Zj9rcWw/Yge
	 XdvdYKWwM043tjhBC4HmG3mwNRIS2LjkAwmOCjJwQ8prK97goq7oRDm1yBy6ZYyThw8bn
	 JcOUu0FECahDYus0rDDwO3k5Sd/vyYqTuL4E1dhzOnQgmvy+UYB5N8BYrdmsJwBnjd8mQ
	 D+rCW2ndeskiJ5R3eUuFWlVovGwnODd8iZfsiV7G7bQ3cjsazDmkdQivGDkPFGrzydTdQ
	 fJs6hqN++Y6QAv9f/HTHaQJ7scgqd1o3BMb2luG/sdrpE4UMvKZPzG+NFfYvpImPNzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=88eAufjTu6E74xVzBr05xvvO1csOjXxgW9za8CZUGMM=;
	b=lFL711uqY1p0addGgtogdf7fqCQ15+d72AdLTBXTb5yHNQsk83RDp/bn/ZOjiB9Qi5CS
	 CD3MN9Ya22LwCt46sT8RXwo7esFsZvejyliZmH6uf7A2M1psHBFYyVx2wFbCo3m2WLVCj
	 BU1AFkZxpvF0UgQVW1YVTGAOjDkoQ4ZoeUuuB07wI2zGyrGdaEdcFTVn0nv0pgqg2LDL3
	 7pn8Kzsc7juLPkv23jrblqO//deUGtttjoLtt/XCDBWVYKbe691qHTF0dPYL40Kbaw8b3
	 VFyWY4MSH5QBEwob6mBXbvgabEP9+BhqhK+YGkjr/VoEWP0K0rrIbJ5I4g6n92NiXVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WPjPe6BS;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF6606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 03:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WPjPe6BS
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6d290b10a35so1647292eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071184; x=1793675984; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=88eAufjTu6E74xVzBr05xvvO1csOjXxgW9za8CZUGMM=;
        b=WPjPe6BSaMmrTPUGaKBpTSK1/aLyLI8k0Sa67aufAefOWuUeSpMrNng2Qh+B87wT5v
         VkZv5e3SIJ7FXzTCOxnPGQxMdVhtBAMieTgXKcr6HyoXbt6Rb9uzKBASa33BtecwyVPz
         JjEXCcrG1BoqoHEukh2IO7YrIElgAI9fWPmQ5BSGSP+iBdBlD3dMncg7obWM9JQpExOq
         rD/6CJK4AgWlokX+ZaE2ncYoRSGgw2ePduKz0a3ZZsmOaRTitDU8mMDXTCe/6vW/TcjH
         KJSFBCox82o4eDadAcmN2mgmnJy/8WCfOozVMeLe+cFL1T8as7EC7oL9Sk8F+bmpMFvn
         dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071184; x=1793675984;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=88eAufjTu6E74xVzBr05xvvO1csOjXxgW9za8CZUGMM=;
        b=uWJZ4GDw1LZpTOQncAIuo5kFjCxhTK5PPu7Tq9APNsU6xz6kOjAd7z5TnZIZHFrTAK
         Jag4F7yASsbos+1SjlSgTO+hDXWCOlv42bJLa6+Yt62IvjlX2gICofxVbKLlrrEJ6H1S
         QOpqOdjQQ73X8k3Ta0ijbX+ShJEOuXMyFIpL2liCUBtCWHktzG+59ZwcJyl/5BN960mr
         95aNvhvhRY7uYyqQNeTIAMg0xFSGT2QmGSpULL7K6ZRUhGqvL1jsyRlxxYaPzIJRFGz8
         1neHgrj1LBviDzi8IgO7tiGLErm4bf+60a5SLQC/DaflPxV48hhPlM6upJCYhQpgoN82
         p80A==
X-Gm-Message-State: AFq9FYJDZmKnBOeLLa4SHV0V5xGLuMoba8L2iczrv+WoQKvtWJSuvqGX
	170xna4D6XNPyz8JXh4rK3/3sGJ4yz1M8iiBebfbq6HLJCxG01oaXvksGqCExA==
X-Gm-Gg: AYBFou0MkqgExl3RQ8iC/Tq7zeQTMSTJNiwvY11y/wEXuE+iefJpPKl2kFtepT/0Rcx
	/ETk8/8aMmEpuTdQd9PFz8Q89szLYvUUBuPWy0OspjwQ7QB2KDJ/+xEBKvTsroNFcE8gLgt+V+J
	9odW31cVNoYr6IWCyH2l16vwKY2Wxkhox42w0w0dB7KG9CydrEdSEczfnCqruk6AD7MEJ/RkI6O
	qDHWJjFnXRyBklQ4CdkNSCxILdOhenQ2RxN5lbNBeIxtyTXLrzaqpkhVaUWp0gmYtVTagP5vkH2
	B7Qv+wfSwAkjzbxMYdX3MloGs4xTPsDlo3nKAvQuDrHBuUo+DUodw/ckspBHD6kiBiGH06L41XK
	GHR+URhLUEeOvUfr4oHgDHMjtk0JqMZQPtWa8ng4ScL6oIKXyAgZ1zIC2vCutAQxXsQ/zLbEIHa
	Axeu4RluK591S7FE4aP/8rzYMohC/V/yU/FLS/7hpJVDmJFfoR3Kds+yTnq0tPrnUJ+MfMnnk8l
	dG885gvN3k8MesizZ7+A+mcuhtw8XSd/rhlNIgXODqlLTQ5/5QF+3jLOgZJR3zLMeTi7FNcnM8Z
	ksi81hXrIf0=
X-Received: by 2002:a05:6820:61d:b0:6c7:7668:a28a with SMTP id 006d021491bc7-70c17ed26dfmr3815072eaf.61.1793071183825;
        Mon, 26 Oct 2026 20:19:43 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0763easm9685439a34.13.2026.10.26.20.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:19:43 -0700 (PDT)
Message-ID: <6ae0184f.bc6be18c.340b7f.01fa@mx.google.com>
Date: Mon, 26 Oct 2026 20:19:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3979832892599386599=="
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
To: linux-bluetooth@vger.kernel.org, contact@capsize.online
Subject: RE: [1/1] monitor: validate Return Link Keys length before parsing
In-Reply-To: <20261027013113.555921-2-contact@capsize.online>
References: <20261027013113.555921-2-contact@capsize.online>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3979832892599386599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194173/

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      1.60 seconds
BuildEll                      PASS      19.09 seconds
BluezMake                     PASS      276.95 seconds
MakeCheck                     PASS      0.87 seconds
MakeDistcheck                 PASS      137.12 seconds
CheckValgrind                 PASS      138.78 seconds
CheckSmatch                   WARNING   274.51 seconds
bluezmakeextell               PASS      89.40 seconds
TestFunctional                PASS      1055.53 seconds
IncrementalBuild              PASS      278.11 seconds
ScanBuild                     PASS      1006.35 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3925:52: warning: array of flexible structuresmonitor/bt.h:3913:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2716

---
Regards,
Linux Bluetooth


--===============3979832892599386599==--
