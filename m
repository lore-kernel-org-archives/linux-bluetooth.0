Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461628E34
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313370; cv=none; b=im6K052U5+bdET09zIUzEJsf5ftpd2/hP/IqYppvehxztZdfqX7bJc4ab4A9wfykSjJOQOCCk0CWbHiSrwpVR64yIyPQvrxKBRdOLH1r4F6AN3yLvbtWhCioIOCx4ptuMNVgr2e/fV9WR1wJkvjldf4d7jN1eCVnfsgxhObmuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313370; c=relaxed/simple;
	bh=5HnEQKztV3FI9rgFVS6PytXD+r3Y5ifznT6M9EcGymE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ui0+vd94kQ/H2h7/1sYHT8E9le48FR7DishsXHG5Hs0P3+3bNRvAT+Q2EvkkZDuqdEqSRrdoQ0VGe2Z6IdnaxH4Q4gvSFh+pRL2huXiI8fpSFTjLC2ATltfd59qtIplo8oFWg7cot6J0YftWppzDg0bUoReEw/R0hZ7b5RCk1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0qWhTBx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0qWhTBx"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d43f8451aso119860285a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712313367; x=1712918167; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+WrqGPvXbosKAxV5aq+83D7UwuEMn737QEBce8clJxY=;
        b=O0qWhTBxjcdKUyhhxF5EkmLXXARsXdAbeOy5FPG/gFc7+/zLImnWrE84O7jfvzEe89
         i4i3TBEgmljjExoP5hfihQZ2iGzP6g/g4J4MNXvp+Mqcm4mi3/PB0CxtB5+LLqu/5rHm
         /mEH/lRsrIUrqn1WsQUDXeip5CCuzOarv//ROuRi5bb8CCuZwwedFT5dsg/vckPnlEMt
         WcWaUy+h6/n395rw8m8GXTyCWtdiNBynR6JbfP3CbtdFwkjS4dUj/op+0WE4mkbHBWOg
         ycjtcWuSoA46sToXxVVSTJfUUoXYMSh1rB4WQO1HBAls3ozYOMIIqE/5ozn9OZQYqoXn
         h7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313367; x=1712918167;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WrqGPvXbosKAxV5aq+83D7UwuEMn737QEBce8clJxY=;
        b=i6qTS3Uin+Nx/gEernZGQcxN+EUK/dp3sJGeioRMFHlWjYVotSCO3P90BqiPII/GyG
         zxPAL2JEFmtXf+8F4OZMj4b0lwz6A3FRGC/GqlqnjQyZYMVQo9DIzxibDtFGRFHdaTpz
         l3IoyIIH7UrVaebnUBUQG0ySdaqY3U3GRTsZ75R/H/tDkuWPFtWhiu2jz4j75W9RqepH
         P4cptIKR5RH1vTGOxonGV8rJT1ps+1GgsCUCN02sPIs3NZuMlNQ2ZAYzIWf6HxkGxUEe
         86DDoaRq8lqHawmVFshfvXkgTg7HYu8yWWv42PdvETe0LKkHWtBNUrROTHFZon/fhNAO
         yQJA==
X-Gm-Message-State: AOJu0YxVf0jgy/ijBOpnJ5ewhSK/pfn94E9+9xPXQ30y94wJfmkRUl8E
	JZUSjt4eOiol6GECg6sGAHDLdIzk6LodiIriG/ro2gKJfgVUphwWt+P0S6rF
X-Google-Smtp-Source: AGHT+IE+pPoK2Pqxh3CUpz5tAbDhQFuWamyGHuGrvCXD9br1hso3PK9Lga7tsCiouyjFok1e0HbVLQ==
X-Received: by 2002:ad4:5188:0:b0:691:abc:ade5 with SMTP id b8-20020ad45188000000b006910abcade5mr3812267qvp.27.1712313367515;
        Fri, 05 Apr 2024 03:36:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.37])
        by smtp.gmail.com with ESMTPSA id mm19-20020a0562145e9300b0069945b5d4b1sm43439qvb.16.2024.04.05.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:36:07 -0700 (PDT)
Message-ID: <660fd417.050a0220.43bfd.019c@mx.google.com>
Date: Fri, 05 Apr 2024 03:36:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1136654905874984731=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] device: Fix airpods pairing
In-Reply-To: <20240405090050.1477187-1-frederic.danis@collabora.com>
References: <20240405090050.1477187-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1136654905874984731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841718

---Test result---

Test Summary:
CheckPatch                    PASS      1.48 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.53 seconds
BluezMake                     PASS      1617.20 seconds
MakeCheck                     PASS      12.91 seconds
MakeDistcheck                 PASS      176.72 seconds
CheckValgrind                 PASS      245.82 seconds
CheckSmatch                   PASS      349.97 seconds
bluezmakeextell               PASS      119.24 seconds
IncrementalBuild              PASS      1390.81 seconds
ScanBuild                     PASS      990.97 seconds



---
Regards,
Linux Bluetooth


--===============1136654905874984731==--
