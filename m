Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8914A0B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828522; cv=none; b=fA31WEkI7fUsXcdFmoP3WgGJbXElbQ4+232qCAlQmHGPaNgGZoO9RYMwzoWfQeWzSpJRRdkI7T+KSKbtbTj//Dut38hSMBiFXGS5KC6ChvIt7t7vYrjPJaLQVjZIJ66bpU/coWYmrvcz4/6hIOKg0MlVItg/JlF0uCbue7+dE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828522; c=relaxed/simple;
	bh=eqIb7afWL9ijGRR9RLfnzW+nh5iLGypbfN1knWzG3hA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nZYNbymE4k0ncOF/cru+Dr4bnzjOCUweLgq4eeivsTgwF2H1v1GbXm8iiMd7f3z3ei5njC0iCvtU0N4/vBwAVuwre051Y5OTwdk+yK8wqzgdS65PLuhugyt4nUCsQ5MP14becw+6DKVEltMz6p9cVuMA5vAiNUJCNzC7oouxRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DynMD0lY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DynMD0lY"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e026a2238d8so6721139276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724828519; x=1725433319; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u5g8MTX6aIaA5dontol0Yw9TDRLUZrivTxEw93D0V7Y=;
        b=DynMD0lYAuaP/IXw76jXGds5mDMX8AYiAZ35KRdu5+voE/39QowJqP2ODRuvUPQmt3
         vPndJugn/WDExyp8TDkXIDXLczWEVW84krx1N9FZA8zb+UhvE8AtGWllQOIY+K2AuX0O
         CnP4JOHMZ8D+b+QhRvHKGbrf+HMMmOrNG3BL/12uVwFV9f25KO8ootIk2jTt5J6OgVCJ
         ZH/GOWTvqoFhFQNeGxQkDq1V1IzaoV4HpPGt0pmsxXQUrXFkBrbeLnRoWc/VjU3nwtiP
         gLfYltAOAui+uUucH9ktTx4xnkldcUzvMD+Q0jwfNnjfNf9wDSTkfQ17fWur3KDtTFOw
         rfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724828519; x=1725433319;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5g8MTX6aIaA5dontol0Yw9TDRLUZrivTxEw93D0V7Y=;
        b=I+GvZdLwc/8jzlmNH/hNfE88Ll2EKu8Y+23p3+Cp/jyLC7Vtbvz3Lsns13GcW1HUoQ
         GbDtCANs6CfFBM8+OTmxZH9Ik5kiScoKP6SKGeBmZulnvtAakaZRZXlcgvFJi5/CjNcI
         6PU5AJvJo/6ZBciEjIiGsGYDunbRd+1PHf9yJru/3ompGPbBkGD4Sv8RD20YzXOstpYt
         3m5iEI/k5GCZfzSTGqeuYB4b65IyMaQXDf9qOknD9+VVFIm3i1wE3L2mLKTiIirAP/Ey
         P2CTZ7ihHfoo0R/HsEQGaoUQlOehG8lMedm7auSLF9xj2tpNC5HkK0+xTHUcbStmqqBd
         g5tA==
X-Gm-Message-State: AOJu0YzcJsgbyQ8Zmh1B16WVpWHkwW1Hn1aZzY5IJWOEh8FK2MwG9vM8
	U/Pp1StshDmCpHs87SVWi15NMZL09CqufhRZHHDAoSshJPMQ8bGdDAhl0g==
X-Google-Smtp-Source: AGHT+IH5TUQXC7BcVXAgky7EuDbi0oi/tRhdnYsmmmbdmdU5nFjRfCpWnYa89uZktmzExS2hwyj67w==
X-Received: by 2002:a05:690c:2d03:b0:620:2cfb:7a0e with SMTP id 00721157ae682-6c6288ab313mr134022027b3.40.1724828519392;
        Wed, 28 Aug 2024 00:01:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.99])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9e13sm22347617b3.93.2024.08.28.00.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:01:58 -0700 (PDT)
Message-ID: <66cecb66.050a0220.282e10.9f55@mx.google.com>
Date: Wed, 28 Aug 2024 00:01:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0680154333148263218=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tot0roprog@gmail.com
Subject: RE: [BlueZ] mesh: Add provisioning algorithms config
In-Reply-To: <66ceb660.050a0220.214e3f.28fa@mx.google.com>
References: <66ceb660.050a0220.214e3f.28fa@mx.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0680154333148263218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884079

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      27.14 seconds
BluezMake                     PASS      1626.17 seconds
MakeCheck                     PASS      13.70 seconds
MakeDistcheck                 PASS      176.40 seconds
CheckValgrind                 PASS      251.86 seconds
CheckSmatch                   PASS      357.54 seconds
bluezmakeextell               PASS      119.80 seconds
IncrementalBuild              PASS      1399.35 seconds
ScanBuild                     PASS      998.01 seconds



---
Regards,
Linux Bluetooth


--===============0680154333148263218==--
