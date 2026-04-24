Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9979DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011756; cv=none; b=GyH7i2JYpNqdNnGIE/mX1pZfw8DBDNOrKu/zSc3MEuHGs03YBEZGMbH/1hfapm+qTFWaksdZVTksQsFsoOEZS5dM4RsY0A5wA8x2a8+ANIkyck0SswVEZlYoWhKsROrp32r4dta8Ed06TUox0AcWIXUJ+prh7o+sfVmIbi02fyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011756; c=relaxed/simple;
	bh=WR+x46J5/cJUpZEAHzCB6osaW1yPsLFxQUF6WY6fyvU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GwCaX7XMTszlDOseI6RBuUT4xHl5+7fA4M22amg9pqW+BfKXiHOmqlQHIL/I0Z8K5i4CuTjhZFryZc+7PgI4J0M5AAvV7jGL9yMBECywTS9wPwGuLv64wslAoWQ8Rgb2bk4TpbYzMaXeEpX+Ch0/HiVZ7k9HRlr5AwSQwLxXWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdmLi5bp; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdmLi5bp"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso1502841a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 23:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777011754; x=1777616554; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lWKb7hcFuMRg3IEg2bQgNLYeUGHrGhIMTx+hUsQaygU=;
        b=sdmLi5bpXZ0Xcxfcrmj8k4alXFQY/tn7y02oo5k/wEtAgJ/vl+isKvXt6tWQyIphUf
         jYrS8OV5DwiO18EiQC2/5/7TbU0sdwpDqAPktjll2MiWiS0PPUYaa1YDDy+FNECPLX2Y
         ZsP7dPLYGhj9tW2ArAUAioZWV24kL3gtU/eBXQt6fW9OKq36PkYsd5vRPEggX9UUWqAN
         mGPILxlmeisNGkrEDQlRjhvfouDPWp1O361TxpJAugaMM2XDuIgAZNZ+ENlV3XKxDZ95
         0rWq7bhSgoLSDCu2/+z08QuiAQmL32ezkFILFYirNE5qyDuakkjX0t87XS0O2PNjGhwW
         8yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777011754; x=1777616554;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWKb7hcFuMRg3IEg2bQgNLYeUGHrGhIMTx+hUsQaygU=;
        b=c4UcZbqyydhArCX78QBhTYK0dW+3+Pa8K7NyWsSl/o5wepNI/it4eDTEeS7+aUE9pc
         Cqrh3nEBCyk+0Pe2GcX0y64oqlg+8BAT6u0rNJRpgjadT5Agrw0zcDsD43Lgc/H3ZdiT
         irrXXiddg5ivb3Q4TwdwyL6wplJfFjlo/LXw/AuAW90Jxw+VfvAWw3wej563khyK96T5
         YuwygKlX+bUj6LpPMIY0m4NOIrziXyyCgtc86i0oO+/x6kqTNsGq0Pq3UlBPqmMF/yfz
         YLtCyW1o6Bn1kKa88EyHv6mUGpAabi6IphiD1POqgF4dVMidPeuhN69nQhGHggpOGr8j
         A4Sg==
X-Gm-Message-State: AOJu0YwQuZzw4rZ9Go2C26Z4/SdoRWCKq+qJ610FnmwW95XcbU/q15VP
	wRyO7lUAHSnBtt9Ueji7l8r+VDIjwZx5dYBRQURslo5t6DLfdVMk/m/UI3b/nQ==
X-Gm-Gg: AeBDieuCW5JjQgb8InOrr+ZLRORJJS4fk+2zDNnKmZ83rdea3m7QVEBkoMzb0yGUaYo
	oE5ruDkCFfOQZvt880ikIFA09SncGvIiVe9pahSDvXGA+wRB67CkquC0nk5ZuGpIpK8AsycLtYk
	bxOXMBnWtIqODBBBkyJO/t6YQ+v9Tc3WYoV/0WtkZ5mxkgq1zOCgzahStXCgvnEr6BWhFvETq87
	YpHmK9CfLV+JGCXL93DI4FAYEMHEhGCl/jUYwReqBiPMlGLz1q/TVZsQ5hTqvqDE3aWvFftAqbm
	y5YreC+8DzmV4SyZL0U9RzGVrjYw1Y7XpvzJ0NMW8lBHHjm8/j+Oc7Qq1tcvCjnTOQERkhg9n3L
	d63yLug60NyF4Gee0dnY2aXuVy4uSNW4QdCgetS9rMSPFncGioLNqlwZfgWdX4w6i7b23dmEDh7
	GbzcsxdyWkZf/JUsQAhafrx4Wd10NqSsNOCpJyiqE=
X-Received: by 2002:a05:6830:82ae:b0:7dc:cbaa:d730 with SMTP id 46e09a7af769-7dccbaaf733mr12303196a34.8.1777011753779;
        Thu, 23 Apr 2026 23:22:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.58.39])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975033acsm18113736a34.1.2026.04.23.23.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 23:22:33 -0700 (PDT)
Message-ID: <69eb0c29.9d0a0220.3a68b0.ed31@mx.google.com>
Date: Thu, 23 Apr 2026 23:22:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3954739432279879747=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v2] src/shared: add custom CCC callbacks
In-Reply-To: <20260424042830.2374708-1-prathm@qti.qualcomm.com>
References: <20260424042830.2374708-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3954739432279879747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085008

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      648.34 seconds
MakeCheck                     PASS      1.02 seconds
MakeDistcheck                 PASS      249.68 seconds
CheckValgrind                 PASS      225.71 seconds
CheckSmatch                   PASS      352.21 seconds
bluezmakeextell               PASS      183.36 seconds
IncrementalBuild              PASS      640.32 seconds
ScanBuild                     PASS      1032.72 seconds



https://github.com/bluez/bluez/pull/2068

---
Regards,
Linux Bluetooth


--===============3954739432279879747==--
