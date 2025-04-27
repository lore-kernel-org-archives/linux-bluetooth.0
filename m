Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9471D5159
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745776507; cv=none; b=tAsRlsSKPvFzCDBsyFPrbEU3bkhVxtD2AyEFo+iC/ETzA9jtryaUHBx7T3hDIIv+wC+AflWHaRp+2B6jgafTB5QsJilgxyZA8Jnr88wZ/Om5LaZ0fzTQrG7fAM65xkg/Wvd82YmwjP6jmodLjPGk93ZNm8s9+3TDikHpDEUNkc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745776507; c=relaxed/simple;
	bh=NjmEKnsUuPyxd3r2RkiQJ9ICiDMJ1ng5RC5nM9348Xc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XqAqxxvmzcK1KLvu9lOqnK0JHodrHuCdQ5BKxX/sq3HQo6L6TeAbhL54MxaKVFKSvYSsEXPJQAq09miYqS57PpflYsJMqoEexpduw4YooZV3LhQ+8rRQ+XWMfHWGAK06j/cwKA8PC+9lxykDCdAMVOikXMfaCMNM3Ze7l//Y8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfzuKZqx; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfzuKZqx"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso43108466d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745776505; x=1746381305; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kjGeNL7/8MLS6q/Cx36Qw0gpZ31/5/xStKaerkDmwqE=;
        b=IfzuKZqxbM7pnFVLx/k8TlTN46WrS7J8D2AP/Bj0TyI2PXrj6NhYrcxBfholNpyHe8
         Xl9ZjS/4W7+MG0WrqFwkKgeQ65ccQP02L+htlbils9rxRZtPCBS09ObV15SeHJNepUgf
         TlWkcxM85OjrtPtZ/taLrSkF+JTr+HvPh7LIBx+eQbO0K2PvIrzHTd/cqBFbVMwfuA+/
         sD6BM8awozCL6ZPOeqiesevcW1pxDNFlVy9fYwwImDwvU7SiCOOFDP6LK1PV/Q9U1w5R
         ugJ4QpGU8V7hRNKWTbyb55gKd171079F4ruZv0Zi5xeWNqHwAuqZct+AIaCS1x5dMJOp
         OfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745776505; x=1746381305;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjGeNL7/8MLS6q/Cx36Qw0gpZ31/5/xStKaerkDmwqE=;
        b=jfXJh4Y6uwV8OBBecggdPTBUun2ApPRBcWZ0awma64Agi0mapSiJf1+PBTPH4uuNd4
         vMJh7ID+xkhehSUehlaCm7Ls6RN+9ykPkr3YZvN9ohx5H1C1uE8WhX5zc4P5+9dw7wrV
         2fv8/FXF7idRT+M774RA8fNlOeRTk7iCRGVmcc7CTv6L7TFLtC45hRGeOqq9PJbm4qo1
         GTa610hx+oiQLtiIq6QwENH3aFEmq2TFa8fE2fJq9T6Y9DepbYVz8pwYSrK8aXzEZu15
         YPghbqPdLuMqgL73je9K4PhB/qc9CoYbbzzSsSYxLr8wXwZpLpPNZIN7Yj6AHqnL70d0
         JsLg==
X-Gm-Message-State: AOJu0YxCQ6jC0pPHOCO/5HBzDPgLJlWZwKZ4indQsVT1zaYZI2ZPjvJf
	RkqZiiY7CnDOzWIntI4bZXOgOg2VBn+6WiuEBzLCjfLMLln6VZvnfdkssQ==
X-Gm-Gg: ASbGncu0tx4U7BfNxx53MWc+jYcaPTDwiysXAjca7L5sGzSBom/UX4jK5PZz8PKHJRW
	YCYZHhPp9/RdkvCa84MWBZvNj+yEIlezBKg3ov1ZZJ4P8RbxIEu/9ykOZbFRkHJ3GM958xGrrn4
	DiBxm37LruMCYKZmPXzJAwToDLzwLoyFXf7orAV84OP1tWPpREtDoNf/AfdOWzldY6UkAxCQcBm
	J92y8glnBTwgURjY/lpsLRQ+aP5BEqR3gbEfFEObtAxJW/OvJdRGAlP3RL0rYTXwvTkHuPvz3K7
	Nq7C4BQ53g7/EvHYi/4oeK8KUXTdYoU5pN2orDEPYkt+GVw=
X-Google-Smtp-Source: AGHT+IH8lUK9WTMq5i/Lp0/YYNFGc1q9NQQXhh7kPFxOAFLJS+Rh7V+HJP1zjjYS/xB83ER0FNvd6g==
X-Received: by 2002:ad4:5bc8:0:b0:6f4:c602:806e with SMTP id 6a1803df08f44-6f4cb9d29bfmr179607686d6.13.1745776504818;
        Sun, 27 Apr 2025 10:55:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.79.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0a73c83sm46928446d6.92.2025.04.27.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:55:04 -0700 (PDT)
Message-ID: <680e6f78.0c0a0220.305cd.e90d@mx.google.com>
Date: Sun, 27 Apr 2025 10:55:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5159622727016700613=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3,1/2] org.bluez.Media: add SupportedFeatures
In-Reply-To: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745771127.git.pav@iki.fi>
References: <c304d0b98ed0ce4504549e43a99adcfcaca77521.1745771127.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5159622727016700613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957508

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.68 seconds
BluezMake                     PASS      2695.02 seconds
MakeCheck                     PASS      20.48 seconds
MakeDistcheck                 PASS      200.77 seconds
CheckValgrind                 PASS      278.41 seconds
CheckSmatch                   PASS      306.31 seconds
bluezmakeextell               PASS      129.96 seconds
IncrementalBuild              PENDING   0.19 seconds
ScanBuild                     PASS      934.57 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5159622727016700613==--
