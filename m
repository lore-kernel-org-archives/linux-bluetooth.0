Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4235976
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746828929; cv=none; b=AQyB+6TYMbquN5uZplQmOaJ9EE3oGo+Nrh7Vru35EZ9wERCxaxGCHlQO8a0Wy0g9xJ4lvXnUGWjAySwfe+itq/z2DTEyDqJoJvZZr7OfccNeVQtKCj1bGyekt6E8QdDALggZEUZHHXU6cmvicp1SJu4ocq8JvLX09lEwcPtbIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746828929; c=relaxed/simple;
	bh=r1y59Ll7D3iaLhjX20Rr4PYpXFE5QyLtXYkk+qWti+Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hCzzJx2IqZUBsZaAwmofMwcQiDPPmQq7N+2Gix8X2xpIcLSOlsMfLGDKbSXJ+vwBcaFbaxYDs23/xsS/iWUxpTE/YOSKzYFknkiGJy5IeWR5Bb8CKckOKUL/iplla29LnNg9uvwoWDWLx36V5iAoNfmUsoDkKiooxbH/Kw3gy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCzp5wHR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCzp5wHR"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso3594276b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 May 2025 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746828927; x=1747433727; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e2uqZ+FnHQiqcs2h+LYXR1MoexHtWJfI+YIlBy9Fb40=;
        b=OCzp5wHRPUwVkSRhTR8wfn/6TBYfnCqYTgJ1k1dSvEiH3QNYwhMjXs8OhNvih8a/ER
         AE/vvjYbXp1PF5/tscvaj2XcSiacWskonnYqhJDyegkW86KvNGa2jC9A4aAQBiyWlsiO
         Av9uf3e7B8pLU7SoSMazSbm+FiawZf0E1Os6yUy+j78w+TwThbovD2pxMVRitPt8i2E5
         JN6JnNtbHPArCWq7JfQBF3butU+guxemLmCwGmz3lT+ybWGQVCJoC0lUj4YSdTgDyFiK
         VKa7X6gqwW5nU8XQ0JqIYQYIxL3MYCD2HBsqu03RCJLXVHb2PNlgisZeOEnSZAR6Hco3
         I1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746828927; x=1747433727;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2uqZ+FnHQiqcs2h+LYXR1MoexHtWJfI+YIlBy9Fb40=;
        b=m0GqIvH2Bdy5jNeXnUZEpcGTJxiFwLLoVa6ZqrOW0y3lvncdE2EWZmK+ysuojsGw6s
         h351kI9v+RsicLg5t3JkBFdfnse8rNVjQjBI2vqH8g/3Nqr5+BOYlTQJJqoUx2Du7w4g
         R35tYgbzQwEwHYBJ0eYAZGKw6gmI4YsREsK13KAJFwTlnkkrINYdL9Lr9AGzjuYUqMqJ
         FB5Z+eEzxzh4C9zOVoquhVoAZ+vermlnMKrODRoSdF7Ytvt7W/n0TcqU1Da4TF1SCl39
         JJOjUD3szDSDSJvoNndM5x7UsEwibkMB/YQk4jJyh3T9byMBkZpqGrctMxtsJjkRnu91
         vCCQ==
X-Gm-Message-State: AOJu0Yz+Hoq5X3kuRPr05oYdOBhyORvqTtg+rHQCJ+R7ipOmO6SMc3ud
	hPoNRi5xTYz3GLwU1AbrugzoERnieiSUwd7eIn9ZeA1f/zBOoQ0UowyHGA==
X-Gm-Gg: ASbGncsrNFXbBHiiNoAkt428h4IcOqC0vbmsiFSre2EVzA9E6BmORLNveQ9f73JwLnj
	nlpD/+8E063q57Ib1bLE3SWBgTgV+4SfGQoaBe1tHGSrqcQUZX2AQD8gCoCo1OvbAoLAfkLUNqt
	/ouYy5ceId7U7Kra0WYzzqefUqCzzhhFB06SRUc8t0g5rHdC+xK7rKM5EgiGLGQYHdhfuzFUbPq
	/tEVrpq+OipfVAKGaXWe65RkCWtpJiqBGO3Dz+h3oZOxL+sjX6wTbrnU9m2ef370AF6GgsrMQMs
	R3lifjUnP+deYTEFC5MqFR+AdtJFYVTIUggiUHu0rbOJGS+AqBbtizS9Xe1LhgA9/w==
X-Google-Smtp-Source: AGHT+IG9KpgpZ4wv7CoPF35e3xMntl2vyBMEcu8pQnSB3ikE24d1iDKHpVWc8a2/n36FpTFaR2BxCw==
X-Received: by 2002:a05:6a00:a83:b0:73e:1e21:b653 with SMTP id d2e1a72fcca58-7423ba832c2mr6723272b3a.5.1746828926575;
        Fri, 09 May 2025 15:15:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8f7edsm2187287b3a.167.2025.05.09.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 15:15:25 -0700 (PDT)
Message-ID: <681e7e7d.a70a0220.49f0c.c39f@mx.google.com>
Date: Fri, 09 May 2025 15:15:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7071904404416807672=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Subject: RE: [BlueZ] shared/asha: Fix bad parens in a comparison
In-Reply-To: <20250509205341.557936-1-arun@asymptotic.io>
References: <20250509205341.557936-1-arun@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7071904404416807672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=961533

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      2679.03 seconds
MakeCheck                     PASS      20.83 seconds
MakeDistcheck                 PASS      196.74 seconds
CheckValgrind                 PASS      272.92 seconds
CheckSmatch                   PASS      300.59 seconds
bluezmakeextell               PASS      127.72 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      897.24 seconds

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


--===============7071904404416807672==--
