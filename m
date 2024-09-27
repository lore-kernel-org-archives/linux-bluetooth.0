Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09866EEAA
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727412141; cv=none; b=j9wll8gu1wGfiNV74XUm10SbF+S07QmoVFypOlX66oqJvsRnhqBNY6J8O8azuQXo9PQuaS9rpK1l6nB7JXiqY9rjuiOWlisIF5EWpBIS8R5lTFTDRTaE7BDbLdoCH/1Uejs9vv9E7GMcNQ8VlqsWOmJFhZIo/SgXS8Hl0g1Y5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727412141; c=relaxed/simple;
	bh=XMukbI+nuAa0VjrvoIvJ3kzO8LgJE5Yw/OKgZOoQkZY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FqRIz+Y0FO30W/JTdJvRmyCnfJvOBqYCkBzbebl+d9KrbxPVHlkZGye12jve3UwpDzjr748Ij+lO8iG1Qjqegf6EhODabxoTt6IlPaebxS3fb3RaK1Hn+ghpi4fTgt5MINjYJKuzI/qh0naGYuJY5g83IoW/Wpovd6opbMQpAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YosdY8i8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YosdY8i8"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb3cbc28deso5012476d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 21:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727412139; x=1728016939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A2Q9xhKtYplWbn0F56wjl0zTmre0uATKb86p9vbU638=;
        b=YosdY8i8iA/m03uQSG1u+3NZC+c2ytmdscGAdI2VnxyiMhXmSTX89psIL8BN4wbBue
         Ox/NzNEEn7ghoZlAI5v8NPP+V8Cjr1R4Xzt3YLHzW86RKMatyLsEKZXJHM0G9EvEYYM/
         5BFQLhK1NryrvvhrSE8PD2TIXHmd3gj8gUEkeb6JuJNU5Sx6BB9e8q2YvYMWP/aCFz+i
         0/Ca6VNMW3sUz20ubPvFMjw+LZAn/FaFBIWepHq5R3WbX+xydik/FbRYzCjT6gdXRj7e
         JCCgSpIxO0HQVWabuvZBKzKDGuL3iORpGesP0PyOgkJsMF55Y3FbmXwX1naIpLQhpNsU
         BDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727412139; x=1728016939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2Q9xhKtYplWbn0F56wjl0zTmre0uATKb86p9vbU638=;
        b=QmVU6tAtHtGJWDnnLK/xORBzVZ/bju7HoBQc6/bOtVSYrQB71Qg1JLaV7XdV1+bJ5R
         ouGZqrL198tZIyc+8b1ZW9FK8mWF9dGR9JSJDDqeGmO2bqAiH24BqvhKqlzNirss2fZJ
         idRKlqso+jwz2iQTHie8ex0c8DPbI7oQb2FlUVWCUsSBS/XB4qFvB7cRxG6V+pzl4dUd
         esJwWoEfbS+mTUOgZZNEZCO+sPHGI7NCdxZiYzcbz3zqKPJNEje/2z9jNPiQiXXHrhUs
         i09NwSdF3oU5dw3M180cEM4UuGYEPwac7zYbZfzFMbL4LpUPARUH8Fc1q5Wk3qxLOQvM
         RD7w==
X-Gm-Message-State: AOJu0Yze1VU/6wTbTomYgl6781QW0fgqIn/rhavbcvJPKyhLnLebqhcZ
	ULeQJsruNFb3clsxzJB0W3+Zz1Oi6Q60omz3K7LzvGyPznrMoUhA3PEhdQ==
X-Google-Smtp-Source: AGHT+IHIN9OBziG8LMV57SvD1AjQ67XoYXKhPy7gkXbQ+uLrq5BCtfzXuK/Uk72big5pcrbfV8wnfQ==
X-Received: by 2002:a05:6214:4a8e:b0:6cb:2cfa:3b9e with SMTP id 6a1803df08f44-6cb3b5e5023mr38143996d6.11.1727412138745;
        Thu, 26 Sep 2024 21:42:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.206.110.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68e7fesm5459376d6.132.2024.09.26.21.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 21:42:18 -0700 (PDT)
Message-ID: <66f637aa.d40a0220.2bba37.2b57@mx.google.com>
Date: Thu, 26 Sep 2024 21:42:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8209658422332830532=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v4] device: Remove device after all bearers are disconnected
In-Reply-To: <20240927023854.2447283-1-quic_chejiang@quicinc.com>
References: <20240927023854.2447283-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8209658422332830532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=893302

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.46 seconds
BuildEll                      PASS      24.05 seconds
BluezMake                     PASS      1507.72 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      174.81 seconds
CheckValgrind                 PASS      246.55 seconds
CheckSmatch                   PASS      347.47 seconds
bluezmakeextell               PASS      117.03 seconds
IncrementalBuild              PASS      1357.42 seconds
ScanBuild                     PASS      992.35 seconds



---
Regards,
Linux Bluetooth


--===============8209658422332830532==--
