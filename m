Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239413C661
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994083; cv=none; b=ldk4RbO6CVj0pFUDztSF2UVgNpL4Z30h18UzbpHXgkrabRwrViW2mPiA4tzOXCGeBX6Aun5dJF6L0+RGMwpNp3mzn5SH0HzWRkzA7geud2Rhtf4mxlK1IMgiEI7RuVhrEGTmP/y4wU4qj+isuRQ3lraIghYNAmWBIq49GQmU/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994083; c=relaxed/simple;
	bh=luVXb4lSpHlFFlUv3tKpdIz47wLTq8yx49IaYvT9E7E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C1en0JzkE7JH0wshIZ+68DT7xi69W9MhYQRlPFPOtwcE1Z1fL8Nho1w+89y3aMVqKayBf0wOauKM924qyhZluAXIiZMtwkuNQ5WYXAMt7sVPt6PTvxbP9+0G4IuAml1sy5LLb97fWEQd9bm8lBGssQ1I2cNFJiI5JlNKHzHAays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdBOOJGx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdBOOJGx"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b798e07246so3997986d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721994081; x=1722598881; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi6RZZV5HLNfQOP6sphtqsZ9YpZIWdmT+a/pe58JBMo=;
        b=UdBOOJGxYMUzhoN4gw4nAjF7lzlIP/UTdAAMYPbkLXtb3rqr+UFmF+u7HxA7840S4F
         nak8jtGEWWulLhYWtOr/Zhw7cZzrp2rPiwuK9s+Vy7ouWM3LgCQG/hGQg85Z3T9O7WY9
         sTk2cVBSQQV5N58hrHXjkNlvbYusL554CTIjke8CKW9M5WT68mv5tIkFI091DbJraFrN
         DyUEVaSjiwupLnrE8lVMUL7MDqnoELuFc4RhrDs1rJRIXm4pV2/vba3OMalbjKxiifnK
         BkNVhzvaEB9WaixmLE000esQdxEVd7p3y3JEtAfE/wDkS887SUljYabwSYpveB/DtZFY
         C70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721994081; x=1722598881;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mi6RZZV5HLNfQOP6sphtqsZ9YpZIWdmT+a/pe58JBMo=;
        b=eOSAghOJlr5CYCYwUjxFiWWC2ej/yvaAnCAz6X2sir00blEyHsKoOUS6LWDvtRaEPN
         eMoi08Tz8qJn4j9wZeiplKGar0jNrO/BGdCzIEUSvdyVj8r4V4BoYN5gbbXJsTP4U1r/
         KxDtyZCODSqSenvkp45OtqjVx48A7gwCU5OCxIp9uBaPG7/ZMqVNbZJJcVi9I2/RTxVz
         EazGshbt5kHgAPGeR9BcMFHBN2bNPni0lG0Mz7fFXkAn+T0yUwM8NxLbSGXSmgytxt+K
         9i+xxL26PO/K1Td5SIwfj2uWjQNSogRgTiTDp1vDwdb5jRiS5nBFJyn5QnJBxUXLRtB8
         I7fA==
X-Gm-Message-State: AOJu0YzA1V+0UWvtorkgJz3XUm0l50WKc7UTJw0YeFK7SETgc/7mex3p
	kg+xIyhzvwBGhc3RnSR3DcdW41bJ7BRJdFkr8tkVUSNCrFrAJHh475Vp7A==
X-Google-Smtp-Source: AGHT+IHIJHkXvK+7L8JnAv+clev6pqG5+XA1GiFSqSa3PKBXf6iWOYC3bYkETV8WqQVTDRYWCkjPdQ==
X-Received: by 2002:a05:6214:2584:b0:6b5:4e07:2a55 with SMTP id 6a1803df08f44-6bb407147admr56777686d6.29.1721994080592;
        Fri, 26 Jul 2024 04:41:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb0bf4asm15796506d6.139.2024.07.26.04.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:41:20 -0700 (PDT)
Message-ID: <66a38b60.050a0220.df98f.5e7b@mx.google.com>
Date: Fri, 26 Jul 2024 04:41:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4646317042316306268=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Update default sync_factor
In-Reply-To: <20240726101015.263668-2-vlad.pruteanu@nxp.com>
References: <20240726101015.263668-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4646317042316306268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874045

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.45 seconds
BuildEll                      PASS      24.64 seconds
BluezMake                     PASS      1684.44 seconds
MakeCheck                     PASS      13.09 seconds
MakeDistcheck                 PASS      179.75 seconds
CheckValgrind                 PASS      253.39 seconds
CheckSmatch                   PASS      356.90 seconds
bluezmakeextell               PASS      120.30 seconds
IncrementalBuild              PASS      1451.44 seconds
ScanBuild                     PASS      1014.48 seconds



---
Regards,
Linux Bluetooth


--===============4646317042316306268==--
