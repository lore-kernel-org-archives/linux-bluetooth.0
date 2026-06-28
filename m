Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1940D574
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606641; cv=none; b=oDf25PnkmKUR6xZ8+ng1nKZ23Y7Qgrb1603OANaM4dX3M2tSJyemm9JDSx+rMJmW6UmResEK/tXGCvm6Vn3jna2OLN3sHIqXljeS6IL8dg5RZs9uxrW7omFHi7TnJ9DAyVUaDwV+O6ztvZ24DyS8LQrZDfpM+4UqES9GPKKa024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606641; c=relaxed/simple;
	bh=Vr4o9+KQKiJXMFaheJ7h63/70L3yB76IgGxo3gqAT6w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SEllRYBWauAUIvQwlLhDnCeI2PNLyYIlLMzbCjqpeEGZwcPLINT0vT/3k6pcf0K1mIGDtpcq1K/BRl76qx5jfyQBrXpTKUCayqTcOQu34OLNm4stXbWF9KuGvxf7D4IyxVFuso6pQD+o9R/vHJs5H7UITYiSROYrSCkj+O5q4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXEUWrsM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXEUWrsM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bf1376038so1722541cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 17:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782606639; x=1783211439; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq2P7aYxvw/tpXLEeXoRxTImtZFVGQm2uPAlaisr1/k=;
        b=AXEUWrsMJr+DhtS2cYz+jx9fOK9xt2UIPRKNt1o3AX7hk7g/tV+vnyOqLSupF02YO4
         2WNPl4XtErn+J0OnBE/p3/AcfjkMXlm7e31A9H+6/wcHxj7zrrNbhVXLJ8S/h/anES8l
         DodwHdZqI+BvxHPUcvJ4sD8zy6Q3l7GRE3/2HC3x31oZ2dKPbe8XtgoW0kXUV0kFaidS
         R35smu6ikjlYmbaVdQAx9s9l/eDXp4HNxkrJ7bDgxsDWchVh/rji4ZnM7qHWARzIg6kG
         ONd2MIlzLHUZij8Vxmto4LihLKxG9DEVDjS5hHJZEey3ovx6oxpywrunDfK7Fhv91EWu
         HDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606639; x=1783211439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq2P7aYxvw/tpXLEeXoRxTImtZFVGQm2uPAlaisr1/k=;
        b=J5E2ZU3LqACzmLV+ZONhLUZgQMK2laBtITMXIzIQm0I629nrvwvYBL3kLne+6Z/627
         c90KAp9RMXwZag7lWX57ZJPZz/Zx76e4CGbDZWchu020KBZHM9hDxzKOlwlu1SdQUKgZ
         3Kb/OGzAZ3btSBHARhz7TaIQ+HcWK8Y+CjgE8024rQnnkQQUohNf/KJdj/HffhP7Kiwh
         dmmEgftq1XSr37gIU3WDVRLiCxOqamPzzmzn/jLFpYhxrMZCAN5CXE8mWKAFCUds9BJX
         PuCqVkWydXJQNFJM7hg2MA82QxiWC+R9pOXoFbAGAElZkXLWJ4xHJqEN4u35X6AC8WSE
         d26g==
X-Gm-Message-State: AOJu0YwSKqhvTnljsdMZ6vg0H50KoV8V25UYHibiaZPG7gS64FRte09S
	6oQ8Ir5yFCWkQ9hDKy6Hk02ikAQM4UmDFntY26XIKxMP2k5uUtffsKwt/D+E6Nc6
X-Gm-Gg: AfdE7claxySZu9C4LjO+WlroaXcp6BesBY6PYJBFTqlMFFxeMGuRYm4XRXe45rzX6IM
	Vv4QhaRCbeIoxBM/EtqpYSbyNyVu3QD5w7Julv8fXCKT2KOyDIR2a8bglqxXws/y2t8ypuQNHBo
	w8G1BhtFHW7dpVBYmiteGQ7D00F+6CaHvFQPIv4xEXelwZhKC6IizsvCsOiOVzCU+Pcgmw4a+Bx
	99ffzHndVZSt/FgcS9yE4yLj9nOLisqUPhFJOUwBnVbI6urMhHu1yeLwlXMlIk9euNLNnm6GwjN
	bFtZYbtUMzJ71YSDySWI0QaYHcYuN55HK8RM4s0NLikildzuiTQe8DN6+Q2kxA5bolAq76IIcVT
	I8g6y6wP2WMVfGo3EJPhcy6C18kQh7ATPapMvST9MWHguT9R02CNP7J6xLIrldmEZMwy+xd1O7M
	ZCDMAGkUqw/M7k5TKg
X-Received: by 2002:a05:622a:6181:b0:517:79f0:ae3d with SMTP id d75a77b69052e-51a726fd836mr182514111cf.21.1782606638909;
        Sat, 27 Jun 2026 17:30:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.47.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a514b5128sm128755771cf.6.2026.06.27.17.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:30:38 -0700 (PDT)
Message-ID: <6a406b2e.8d510ab8.177b16.5e60@mx.google.com>
Date: Sat, 27 Jun 2026 17:30:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3246277624075153223=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, matthew@matthew-cash.com
Subject: RE: [BlueZ,v2] profiles/midi: Fix zero timestampHigh
In-Reply-To: <20260627224444.531788-1-matthew@matthew-cash.com>
References: <20260627224444.531788-1-matthew@matthew-cash.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3246277624075153223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117539

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.59 seconds
BuildEll                      PASS      21.11 seconds
BluezMake                     PASS      552.10 seconds
MakeCheck                     PASS      1.26 seconds
MakeDistcheck                 PASS      160.30 seconds
CheckValgrind                 PASS      155.74 seconds
CheckSmatch                   PASS      310.72 seconds
bluezmakeextell               PASS      102.50 seconds
IncrementalBuild              PASS      548.81 seconds
ScanBuild                     PASS      975.14 seconds



https://github.com/bluez/bluez/pull/2256

---
Regards,
Linux Bluetooth


--===============3246277624075153223==--
