Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519477;
	b=q0chPyc3u6KVx/m6cDjX4eDGKnqQ1Zr+dFYJtqx6V8Wl8mcTg5yaW+lKLJmddQ+9zoy1
	 AunqJ5tuD8F0xSMAUVnZCC6POyikiw8ilLHv6vCD+kXnTm+Ufo1DjGO+q9H/3k7IMzPhE
	 A478VKo9ULD8xIYTMNdCyxWibKsL4jY1Y5r0Yq4fcL4309hRhLV4oRQU7i/uwKpjupGjA
	 nvjgx6v7SJ4SurlleY1Q6nUNaCGJZFkM1koal4K3fc3B6kB91XbivlbjopB/n6lzoHpDY
	 8RGG06qhWvRECUd64wJv9ixp4wAOQuJ5f77Hp+TY/0nFymIRYdwW0NGCkJsrzIOjY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=L9hzWahxL9ED7EMWn67CKhZFBlAaaJgdBqSN1Fs19rY=;
	b=HogIbJbLVdr7Q0vYyKCrQXeNX/294H8zT3I4KRlJqgk/pDF39TduxhCD7rn+6oWqxckH
	 kJuy4EVPz/c04Kjkz3NO85gBeM32/wvVhAvQ5XHONGF350KJ7hCSwLauBbdhJRVoI0aVG
	 QZ8n7yMaT0XVtv9pr7qE9p4yFqc8a30Nf3bScc5zvE+kqGemXAIJcDf2L4ZGQHa8yfEQ5
	 YQN++5eeTktK0VjfZWpMsjmxLp67SycgUU2Sw4TvF4vKc96tI9Lc748R6RFAS5RCbgLVx
	 BjIQwhrLR7V7YG/VGiJYQX+xdjHx8zGSRhIri3QvxVXCRlx84d8Q38C9jsYyNMiqvYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EMzzaDW;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB38606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAB38606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EMzzaDW
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53634b8328eso42595101cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519475; x=1796124275; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L9hzWahxL9ED7EMWn67CKhZFBlAaaJgdBqSN1Fs19rY=;
        b=0EMzzaDWSArgUzuOmtldHTFng5GZjr60Fet7w6nPjBYV3ODQR3Bt5ttBtllFZaLCeM
         S86KMvSFb9tKdGUVdv8i3KOCtFYIBT/RU/0sofg7xiCaWBz1Lqm6/+R/Z+DcDj011raD
         nFztIZwrZ+6MYOXUMX7ctfto/O6b3Dw6pVBJpnbkMap1Isg3dHTeFhuyea4m2EMm7TKA
         l2rySrytC34l0yGG7tLNURTqJguEuFSNattI8hqYM1NZUQfgefZxeTffQu5kpcwNjoHY
         jiAQ3jGWLsjrTVV7/QfxRJ/RJBnMH1X0g9DOK4AdLaS9S/Er3pYfqkwLGTZK37GdIckw
         0HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519475; x=1796124275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L9hzWahxL9ED7EMWn67CKhZFBlAaaJgdBqSN1Fs19rY=;
        b=YV6ogP17dTgFIIN2mxKOK3XXsLxSlGJoPVd/s0tn/rjgV9Qs2jXe0J2uPt18cH5aDA
         vyMaqffBz9Igd+B+o20s5el3q4WH1wwe30kqQGTMWQw7FnC12H0AHeCqWvBu2B0K6F4Z
         oX7NkAgWPCz7XsSy4eP/r4e7r8Zhj7JFxteIrioNvSZ7pitu0E+huMo9fer7pxoDn837
         XCDLLs57YZiU7EU/iUQkdmtKwagwjoLirnyhagI5Qx5TRfQPBSy5G0rKf0fACYnKR3my
         jqIgXjtk2VHkozS6fsd8JzlituTw+0lCp5gItlKtHNltXcJubu2+qADjhH3IxcJUDouV
         LXzw==
X-Gm-Message-State: APuU4Z+REecNOcf3k72ubDoqsMJ/JYLrqMdkYZsh8ATDNf/jieua6QA7
	SkPx5Rid2xD4fIYB1JrCvphDZdpGXHFLTVFhv9hS19NqGA/WTsOszX9i3ZduXQ==
X-Gm-Gg: AZFdTZdeSghg8N8tdKR0G9r+75oK8ELOXzQsyexBfj7s71ktWtkPC4nCKoUpkoD4utB
	1kBBeNu7p2cwnwIt9AVcU9eu1c2cb2ZrUaj9pJiv5I+Y3NiOZXnN34TDhvQAv0+EIOulu2WQlyt
	RW2euiSPDn1TPhjyga9OC9Dcvw5V5sSfviVFAi5ab4Z9F47yZFb4PtasQ6CBRuzQSbvZP3wFfzZ
	nzCgFY78Dc+4W/Tgw5onAXxPP9yjeDx8Mf8mlLhDwmmGbLxD1TAXCCuI2B8QkD1bjtT0g01BcNh
	xB88SAu6/PsXVkYY+w4jwrPeEkBsXQgYJ2cINsL7bq6rUTwqQqfOV+ragjSF6WPkOWet+s5e701
	Q0ikNRwUPmrzJvexoKPz4OOpgE/hvFwpNcnUXwu6LmrIWPqwWymgco1mWiUkh/y06sumiZiYd59
	aQGjjdns0bqVYG2Uqh0/Kgt0LPYp+GhXnYuH6Db0xROrCpk3ZxgapUv04033LvxLlsk+WXiEHEw
	4duXEM5RyuYeWG57YGjQmRUUc7K6hG7fEcPC5gAPqfWYcyI6RxERq3JIGRRk5O+yqvDAGa9kTtb
	IZS673rRWZQ0gS8Eqs0OM98VRpR8fKrz
X-Received: by 2002:a05:622a:1e18:b0:533:8c7e:c6ec with SMTP id d75a77b69052e-55d76a5e19amr270479711cf.36.1795519475542;
        Tue, 24 Nov 2026 03:24:35 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-137.compute-1.amazonaws.com. [3.41.210.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347966desm130008996d6.3.2026.11.24.03.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:24:34 -0800 (PST)
Message-ID: <6b0573f2.82740cff.98eaa.e42b@mx.google.com>
Date: Tue, 24 Nov 2026 03:24:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2973974315094466905=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v3,01/10] avrcp: Fix not checking browsing PDU parameter length
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2973974315094466905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220593/

---Test result---

Test Summary:
CheckPatch                    PASS      3.85 seconds
GitLint                       FAIL      2.60 seconds
BuildEll                      PASS      13.60 seconds
BluezMake                     PASS      205.44 seconds
MakeCheck                     PASS      12.51 seconds
MakeDistcheck                 PASS      103.36 seconds
CheckValgrind                 PASS      247.09 seconds
CheckSmatch                   PASS      183.05 seconds
bluezmakeextell               PASS      65.95 seconds
TestFunctional                FAIL      952.54 seconds
IncrementalBuild              PASS      228.86 seconds
ScanBuild                     PASS      696.53 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,01/10] avrcp: Fix not checking browsing PDU parameter length

30: B2 Line has trailing whitespace: "- New patch 9: a unit test for a stale NumberOfItems reply. "
[BlueZ,v3,06/10] player: Fix crash on Search in a folder with a space in its name

1: T1 Title exceeds max length (81>80): "[BlueZ,v3,06/10] player: Fix crash on Search in a folder with a space in its name"
[BlueZ,v3,09/10] unit/test-media-player: Add test for a stale NumberOfItems reply

1: T1 Title exceeds max length (81>80): "[BlueZ,v3,09/10] unit/test-media-player: Add test for a stale NumberOfItems reply"
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2895

---
Regards,
Linux Bluetooth


--===============2973974315094466905==--
