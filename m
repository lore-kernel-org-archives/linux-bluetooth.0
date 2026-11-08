Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127649;
	b=2ErOZmgION+KNH+nH3flRtg/8d08zTo1f5UHEqyTMkLpYpggnD0oXvpouoi0JwksWu9G
	 q1OmPZ3fXKrD/MBBj6NRtQ4DBy9Ub36ReU6SbLiiexS3ljUjvu0FIiD3nkf84JRvOxmhH
	 fq8v5NfhogfsxpTSUH4sv5KnRznBMpbJuzomBWE1FR5cF5Aea9KXGq2ihf+k7IxFOo3uw
	 V/rsM0mI5Ytv1TBRfiown3/HSL+fFVMOQUWfHTvJxlVUWoJKw2r5zPTkBYzYWXLklRJRf
	 1gOBa+JrLphFqIk82GRLz/TbVy9IBDXdOjW0CQ/B8GySM/kNoE1Ea26REThp6JcWr5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=0URcebOB0wJinttrLP/SVi7Sh8Jf8lYQlOaLvAuZJ8U=;
	b=eJw9yF1bmG0MQNwQMOqaZgxVeAY71vVwuFTOq46EPDW5zygtnRzhdHac/FBMaogiY6KW
	 UXiGVWP0snUtQXxS3P60meBHwdSIYg2cKotcBmh6DhVOhFrcKg0lWW5fEtRfn0S+alU9G
	 2Dptk3TLBwFq030uyGlg6DeTKbdvODXJsRHs+FYjPQbaozVwIivhrF3FvGOAV6QiSI6FE
	 ueQLUHvumDtu5dfRQJTRI/pfrZS7fkOCtyAs/AfRfFS+QizRiaRR5um/1oX2Zqxk81nRH
	 0dhwTZjDEaEqryHDLMxNW+MAg+9fXtRXXlah+qjaKnSrtuLNM2kJjyjHEkHYkTDKQ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfQJJ0fy;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90A606A321
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 08:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B90A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfQJJ0fy
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f20b304c0so28940685a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 00:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794127647; x=1794732447; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0URcebOB0wJinttrLP/SVi7Sh8Jf8lYQlOaLvAuZJ8U=;
        b=qfQJJ0fyf3HbqRt9CTBN6fnoCFyayJ4O+z1xFPJ/kJT8MUy9XGzaTsl4KLyoGZfYQu
         g8QonEeH7f6qEWPvBrnGxyZ66u7JvmXYSNFCrpCE/qyZX701ORK49f5sLBISK0igPSXg
         Vhfd/tUZ2+qns+cd43Rql5Ug1ixT3nymtGgtPRu3Uo6QZeDh7XfXZaqXJJhGaCbP9OzO
         C7/m/3NI/KJM25VCjH3TG0mYCCiuFaNpdHMO5YXew3b5ZHtQTroJOdmX3l51l/P8bzD6
         MYEoP1t37yLJkb124R8O7PVWeyU47DB2lrCne5+4/vk/ln7xWzztmjqgZtvUjzwf/pOB
         FNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794127647; x=1794732447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0URcebOB0wJinttrLP/SVi7Sh8Jf8lYQlOaLvAuZJ8U=;
        b=zgJ47iZDSwcJpeTAFEnU6GgDZepLm8myrfgXNRoD9w1CE0ghdTWtrsgkWn+hkmmIPI
         QoSrMUsWSseNr8u+RIrhKVpcUEPyYbSQNSCgkBi3oQjcj+gm9pMYyBM7qNKHAa034BLm
         7+ue5YrRa4CXENibU74pYUcgFc5DBWsqUHBBIEF+x3eslQA0YxZ3rjcwrb14XAAzBClS
         JQ1v3N5cK0/RrKUVHZkvzLRDHwR/3KbaoYlpfbgPuBHt7bm5qRezbuR8hDu1cKL61Kl2
         iEJPuUOgWAV1Nw0TcdTAnpSUibwDgUVHqUaLKrIv/doqJ1NmuCrzaSTZPS/oBrrYpKt8
         Ygjw==
X-Gm-Message-State: APuU4Z8ibKA/+buKH77VgDB/Qx4c00WVabMO9TuHFwtNOIsctmagYCSi
	Z9dTlKe9AB3aA114c5meSgtKOjOcJTTln6qlg3F610RhQ5YiL3oj73NV7tI+EQ==
X-Gm-Gg: AYBFou2O04tM/eKW8DBtPSsp0UtXz563s1TVHOJUVooOIAue8qQQbDODEzAbBWR9BAV
	qW1TJapzsVSY1vNfCIPVDhHmYrC8kb/Wky7QVHuoixR1quIRD7UxNAq/M9XmAuYDlA/h+aEtrT8
	sXvJLcqaJB4ltYq8djvHK8JcE1dN7EkBFqKu3gBUGvydv7831qVoYr0EufvMHFMmXxh6SXWDTDS
	ZSbFKVHKg301iQWm54IRSFxUcailolDUMFAjApx9i1gmratA+XnbG5Ig199/L8GWtz7bHTE6bHv
	FEPZtN5udprZlqUUtYQGBX0vKzc+szvsX0DgRYRHNeyRYTTLD0oJImO2SlDmp92opUwWEwqnExP
	aR0pCS/oVF9N95L5XsxfiJIEfDkIh45EVWjTeL5rWpth0gG6yPl4wbn6RNd08tjDJzfC10U+tN/
	HpaXlk+20D1CYE6TG9t4Pc2vPdS6ffiV2IRVZE6wRhtiNlWF7t8gcpiI27tgD+Wb4g9EgnqFVEz
	NxwJvmvuaOKoG1oRvMdnfBCtXO/WmRBHxHJ8wr8gqE1uybfi8rSG3NpZFRbito=
X-Received: by 2002:a05:620a:2725:b0:943:f2ea:5ee7 with SMTP id af79cd13be357-94784201bffmr123642285a.23.1794127647150;
        Sun, 08 Nov 2026 00:47:27 -0800 (PST)
Received: from [172.17.0.2] ([20.161.44.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782d61911sm155210085a.8.2026.11.08.00.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:47:26 -0800 (PST)
Message-ID: <6af0371e.ba263b4e.34721.0191@mx.google.com>
Date: Sun, 08 Nov 2026 00:47:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0190828682894744746=="
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
To: linux-bluetooth@vger.kernel.org, hex@freenixos.com
Subject: RE: Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for memdump segment data
In-Reply-To: <20261108042008.226295-1-hex@freenixos.com>
References: <20261108042008.226295-1-hex@freenixos.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0190828682894744746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1205193/

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.33 seconds
CheckAllWarning               PASS      35.05 seconds
CheckSparse                   PASS      37.98 seconds
BuildKernel32                 PASS      31.13 seconds
CheckKernelLLVM               PASS      32.59 seconds
TestRunnerSetup               PASS      741.78 seconds
IncrementalBuild              PASS      29.21 seconds



https://github.com/bluez/bluetooth-next/pull/1088

---
Regards,
Linux Bluetooth


--===============0190828682894744746==--
