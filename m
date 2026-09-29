Received: from mail-ej2-f28.google.com (mail-ej2-f28.google.com [74.125.228.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A751990B
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693735; cv=none; b=Igjye5/lSAJpN2zVT0IRG/hfoM0E2esyZmCNWfLvaHznIgr+0Kaf8y3pMnJyiWSuW7RdKKiPBIyacXWgoTmLnd5jb69elEBHJn36MXAcA/YBkeV4ig3X52TjigDOGMGdLMwFL5fX0msNDnNE8+4RW3TBjO5h/pqxeVMc1uk6bxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693735; c=relaxed/simple;
	bh=WOmeg9AIoU4j5OcR/k4W+ugr9HMm/C6ihi667z6xmdg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DuMFiSmBBq2rIvNpYpYxqHIe3g4oXpgtvGii0fYNYpzz/ydqHtv0eZba6zxOb86340Qh5CYbpjvsjrGQqhy7WpHNkErd5P88l8U0NAFqiQcMB0KTMqp3MZvZQCkR9INlWNdzhLi/lBOVJTwFUoYaSbyA14/dX1UEwN/AHLHEaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeAxQkL6; arc=none smtp.client-ip=74.125.228.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeAxQkL6"
Received: by mail-ej2-f28.google.com with SMTP id a640c23a62f3a-c2af3701927so646277666b.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790693732; x=1791298532; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=knzR/LBO25Fuhit5V5SzzT6/6oY/idwCEc2ULB/lPAQ=;
        b=UeAxQkL6XGvtZs9bOXlFSre5VYrMIvtb2PGPRRUCkUDY4WsE7RPH9VhTaZZiRDCprm
         vLo6IdJvBzL4b3hQaJnNAIgbnAkB7+f0N5QqwX4LotriAI3wDmG5iv0ChAh2hnpqAtn+
         zDJgurPNdbvnRuGi6QZihekxZPWcnpUn2eg7Iy/zOzqnle8E2SNginQgwtCFSyUsc2Qd
         WDLoANbQxzK/+EHzJRNxyRftRg9yeF5XZwiAUj9gnDpj5BH0tEzDP++cZEkBunElJQmg
         wTeFJBwRamKdte+7cFn7Pql4rCNazSPvY5caUsGGg+LgPQV7NVr2jqwLlTP7f7CcyB7N
         rYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693732; x=1791298532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=knzR/LBO25Fuhit5V5SzzT6/6oY/idwCEc2ULB/lPAQ=;
        b=HP8FKTjlsf+pai7njw7EGO936CVRbDldNSI5I33M0NM9B+pl5J/yHU5ukwAA0ypETa
         puxsPpBC0Wew7uA0rEBO3M7khJEN2wdEfU0wQO5QXWIBN2TuPazVQvIvy3SnpGbxSqrt
         C3ZJkUsKxvWFN3Cu3Woi8IXWWFjMtpV/QVp/ZPQb33PR5XgVZ4QTLRSku5G8oVdEmh1B
         pKZSi8++vmQLowbO4JgFkp4EsAFzTAVViRtJvQa7kIaPn93zWiCz47Tatz5BqTkjHTAq
         +7rf48tNiNf3a+jTO+om1nM6JlweqK/8+3L9y+v7qnnsTQ197QVEiQs8l2+nH00Pwtr6
         4wVA==
X-Gm-Message-State: AFuF++niRZJL1hDJ94teYQ2NPcRvADkgjpKHawkY6BeR+szU3cTrgKYQ
	/4V111N0DiHvXU97pumJDYpEnh1inII8ScFsa70B/5gWIR8Qjhxl0in9570B3w==
X-Gm-Gg: AYBFou0QPPgN5RN/DLMUtxmKBWiiHgCgyYlOFjGVN8oNWjIQuuCr7Rw4OM6hkBkj6nf
	rD8FyQSoGVjSLeDDpDesDowAoEASUva1LN///fQJLUh3WVEpNIAiH3+0t2scUZCFz1mAky4mxXM
	+29az9WFkxVfLheVbNQ9jTWrO0Lm7QzW++LnGxqegVMseYTf1NHS3qXNp09UHCnJjUjSw3YacYz
	k4htgfin/EAo2G7YBVE60MwXVK3UBWZnu9N1miMQXAqjK3jLwXQd4c+SeqcOCodB3okQPYiEXL7
	mhE8qF2bsW3P19UGLzq4z/YfdNLSDVQk9Dj14OyHyP4qSHEmz6GKQCzzr88fSQ+QHRC6xNtSw5h
	HLeaZmxO2Hw+tGHJeayo8HIvz3I1Em8C7ANqmBygXYwe6WclpclOGR7Fi8Vj5lKNyRsLTczaM+/
	cUALxIlTKncMLeTeYFGlYPM2l7RRRRkU0LbM8ciA9sTpCa3QgGr+qdgRSBQzY2Uj33jyZp6Zf0M
	TLtcolm
X-Received: by 2002:a17:907:6d21:b0:c2d:cdc6:827e with SMTP id a640c23a62f3a-c2dcdc68af0mr630308566b.41.1790693731511;
        Tue, 29 Sep 2026 07:55:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbc6b3599sm473759666b.59.2026.09.29.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:55:30 -0700 (PDT)
Message-ID: <6abbd162.092a6bbc.2b47b.5c95@mx.google.com>
Date: Tue, 29 Sep 2026 07:55:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2492977952771150603=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3] avrcp: Poll GetPlayStatus when position changed event unsupported
In-Reply-To: <20260929121749.282866-1-frederic.danis@collabora.com>
References: <20260929121749.282866-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2492977952771150603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176102/

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      392.09 seconds
MakeCheck                     PASS      2.79 seconds
MakeDistcheck                 PASS      143.68 seconds
CheckValgrind                 PASS      152.72 seconds
CheckSmatch                   PASS      293.02 seconds
bluezmakeextell               PASS      95.07 seconds
TestFunctional                PASS      1124.82 seconds
IncrementalBuild              PASS      385.02 seconds
ScanBuild                     PASS      1133.71 seconds



https://github.com/bluez/bluez/pull/2607

---
Regards,
Linux Bluetooth


--===============2492977952771150603==--
