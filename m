Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DC269CE1
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978684; cv=none; b=d+D9bR/KnmRTnizFJGkhgHdLEtsJ934ZUZoVnoGexbOlnwVeUKb4Umhas3NhBLN4Zj/ipnTogkHKlr1EB9aKMm78hB4EVzjsfGiKqUIyYZVSR4kHyhuTqNsKaN8kVj/uAOEJ2+vFiV+jWqSvcuyeL6KiAhRPIzGi2mxS0+0TPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978684; c=relaxed/simple;
	bh=l5otYkXX07R0nycv8iDKcmYX441Nlwa+BRUpJ4K9csI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X6nOBgJTC1Yr29zTA90c7mF1s2TKSs6bk8OYCx3j83vw41PaWHhi8bHjuGa/WpbOD35wwPiPhbYwhuxedBVGgJ04c+VwyE8q6+J6bKTIdtQ1cdCQiJSsqNR1hHe5kLwkGNP7cJA+mZh4OF6CLSCi3m5l7CLPos1Y5guvBJYKEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgttpZKK; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgttpZKK"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d5e18860aeso174410685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751978681; x=1752583481; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4aKGdp4UFEQLNGOs8obYcHLFimh5Gbh8Zpm9+7GDIhw=;
        b=ZgttpZKKQ2kFjwCYSI4KFangqVnoqPB6t1Vqesb/fP8ecRyQTP0vKK0ri6ekvNQeVL
         XBL3DHC6vaoRq6dXZY3WzxpLTsPw0OKu0RbXlrfQnLZpq7IpK1IhwRjDwf1US1vtEKQY
         2V2xKsLFGCy8RWc3248s2jCVw7yRSb27CFREI6D9+a4NRjWwidj+upgtoztMc/Igga64
         FcEpGHh3Pp1f7t0wY+vGTSxKQqc4dQ9gOTX7Sam8j9kFZPxBFxx5b9Ryume94JaszqhZ
         XhxpED97E9i1fQT+OVeE46/ZcXzuzQT2njAjCVvEphPsY0ukTEPUgNHAv65s1/3CuhKu
         z0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751978681; x=1752583481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aKGdp4UFEQLNGOs8obYcHLFimh5Gbh8Zpm9+7GDIhw=;
        b=ao+UGuP6WVbPBLQ7WbkF2ESJWJgJ9p1G/ybcdR73YuTKL4Hcnen7Ud4J7flS1acdCE
         POrrXf/C1aJrMcy5FBYJ3WsiYoPtIBD2RhPBcOnkI6fYrnIOKxIwRATc8GJDC7KSiXrH
         5ehdowbQi6Gwxhfnu65yko5O4rqn/0SrAc7zvTEKlcAAin85zi9Ez+0RtEn539h7/ITl
         cW6AA7YLgW6iucSrumg8d0wBNUjXZ1pecsqG8MTWkRredMImVk2+DWYJOCqMBuOv+ii3
         05XIJptUDUlSR7YxxAs99Rh0kyO8gqJqmpM89xDNyIBsKUE9C/mPzDyA212S1QY6bxD+
         n+Tw==
X-Gm-Message-State: AOJu0Yz/x7+/Wbhh45ha8QWby13asaM0Kbw+15xvvMlT6vBsQh8LFFxI
	9ek8qdv8qQzlP2vCQcad1KGr9T97U34qmYl9OIpq3wli+UHfrSuSVOpiYxfsJw==
X-Gm-Gg: ASbGncvxHOfKSjhF0IX+X/77PWb/zj1gsBZuIsu3KRQSNQ/YPmFqaJMzumMnDO/7oEI
	/rE/bEueUdOiQ9foefn3hFhJ2qd9J+WCfq0HRoP4wZ+Cd0uBihFVU/i9Vem6ctI1i9WKcB+M1zE
	v+SatNvxPx+yrdcnq5Aoc3ZMdcwQ+KMICkLyfPqeIi8f39iTQwAoRrt+LuiVidfFAs31NchYTL+
	hknmKSqFQncjWOSPek2eih5Zpdu8b/oZSxXu/zyFVu8nQ0zdh+6lW86licdepc+RB+KniufHEEw
	5Tl7M6aeXHdVyY622qIEblDy3B/uJJSLGsS3mc5jlSetZXW4UqfIYdY6c3y8KXTsbxY=
X-Google-Smtp-Source: AGHT+IGf5L7PJ4KfHq5TWZjHtzHPryoiKngJ3mxSPjIheGPAzJJwztzW9qzkxSPAYcX0zklCVRNmOA==
X-Received: by 2002:a05:6214:4ec6:b0:702:ce4a:849b with SMTP id 6a1803df08f44-702ce4a84acmr119872816d6.43.1751978681248;
        Tue, 08 Jul 2025 05:44:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.241.39.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5109asm75106676d6.80.2025.07.08.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:44:40 -0700 (PDT)
Message-ID: <686d12b8.050a0220.f064f.960e@mx.google.com>
Date: Tue, 08 Jul 2025 05:44:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6811351065793080136=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i.iskakov@omp.ru
Subject: RE: Fix bugs found by static analysis
In-Reply-To: <20250708110909.2626286-2-i.iskakov@omp.ru>
References: <20250708110909.2626286-2-i.iskakov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6811351065793080136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980014

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2677.72 seconds
MakeCheck                     PASS      20.01 seconds
MakeDistcheck                 PASS      184.57 seconds
CheckValgrind                 PASS      233.46 seconds
CheckSmatch                   WARNING   303.91 seconds
bluezmakeextell               PASS      128.51 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      935.76 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6811351065793080136==--
