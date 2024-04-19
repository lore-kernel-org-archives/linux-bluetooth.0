Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B54107B2
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561370; cv=none; b=N/THjtA83zzaWk9TDvO6jidenzkycpfEnxF4lulTTUdYwvrp1mvFFKuYnQE6x5CsMxf8MZXDgk3qrfMougP3hFsjacyqRBsttZVZ/PTCC1DVXyfQJHR7aVvUR96Ge35PI8Ki1qrjcC+wIUZ7e2AZu5Ql7eowVUZu6djymfqxEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561370; c=relaxed/simple;
	bh=IVtt/T9N5mzS1JEZv9F5rVU7XH1nEKzBPnLQqez+Qoo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PKDJsEgRtrputAHBtcgOxtDjfwOKXREQ8STW7pnZegkOUZ+KURrt3vJUggwHPL8uSh4KL2saIJ1MFFA7YBlQcwT6gNiOpksow5uWw21wclBIi9fGyMgLkPl4gLu7INy+UQItIA/d60AvHaXVxmwGW4hfchyX5iXjKSgtgrfdylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG5smkZb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG5smkZb"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-696315c9da5so20198666d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713561368; x=1714166168; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Pg+4Fgp0CvUAYvKr7cYgMzZoe2JmKqSfkh5GCJMVBI=;
        b=VG5smkZb+Ae9uftE9oV5O5G5XRg/HO8MoAmYsKTTSRWzAg7PM+T8y9iovnYBROCoN2
         rndxgU/u97wCdFI247mH3R3lJAoKGRYpVNWK/lSsA4GtBea1CgaK+0Z+z64UbXs5XNFH
         Zsu2HXH6HmftX+8x6f3QLeXOfLMnwP/GldbKtZ7bIkj9rbGChN8mUUegKjxVG5UZ8ofa
         JLOvd5JWXUngh8g1fc0ofPkfPP0f3JVeknUZMJeYsPlX64ZU4imx8s1IThDaTBiG0AJw
         BCAJZylTtbgs9D3ySH9hk8VTP4EctkVz/yZEh5B6M3/Q7O7NaLoiOCrYxOCxxgj+1PQ8
         Pw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561368; x=1714166168;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Pg+4Fgp0CvUAYvKr7cYgMzZoe2JmKqSfkh5GCJMVBI=;
        b=O9ykVpUXU39DjQ/p/PKHi8HqlAR6tZzsG57eSSJQb1VQyDG611qAOSSs54gx4DLZmX
         ypvVQb2LQbtDSKpJlvUTWjY0qykrVMW5BSS8MTVtlNcjf9JgvCwdGV11zFhUu/vS+Gco
         S7OgmlaavvYxk48Vh4brAIOC59q7K4ZlEMlrcmI7u5+3I3LS0ga6HLgnu23mlIr/Cptp
         fhJJRX/eJZrihjIvdep/j99lKTNg8GdpuhBuX2gz5w6PFp9S/P+y6eWdgFG8nW7F+TDV
         dTcmHbaDLZpaHmcs28bC3tAua4vJWVcKlVO88ae2oNjDbEeu83noEEGehtXYgpjZC61w
         nMsQ==
X-Gm-Message-State: AOJu0YwLLIvdq0QguSw/+okPqcD5FzgUYsxOAvIue9W8tat0dTsnMyhE
	sRkyuc3OgH0eZLSodOOQyL4XrCPEdb12N7nqbgRUA15SjbKhirrJ3avQ+A==
X-Google-Smtp-Source: AGHT+IH63Mr4OrQeEo2X0jcYJVKtrNP+tJi5QPwLx2OucvjfmNj4I2Xuw2ZS+P/NoBfMlqaB7rAGHQ==
X-Received: by 2002:ad4:5981:0:b0:699:29e5:18e0 with SMTP id ek1-20020ad45981000000b0069929e518e0mr3551530qvb.13.1713561367692;
        Fri, 19 Apr 2024 14:16:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.199])
        by smtp.gmail.com with ESMTPSA id k10-20020a0c970a000000b006a044503615sm1910188qvd.72.2024.04.19.14.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 14:16:07 -0700 (PDT)
Message-ID: <6622df17.0c0a0220.a79df.a30a@mx.google.com>
Date: Fri, 19 Apr 2024 14:16:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3119501364261556374=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Create transports for matching BISes
In-Reply-To: <20240419180752.96699-2-andrei.istodorescu@nxp.com>
References: <20240419180752.96699-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3119501364261556374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846208

---Test result---

Test Summary:
CheckPatch                    PASS      2.49 seconds
GitLint                       PASS      1.56 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1572.58 seconds
MakeCheck                     PASS      12.93 seconds
MakeDistcheck                 PASS      175.06 seconds
CheckValgrind                 PASS      245.01 seconds
CheckSmatch                   WARNING   348.03 seconds
bluezmakeextell               PASS      121.49 seconds
IncrementalBuild              PASS      7288.83 seconds
ScanBuild                     WARNING   973.23 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:285:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:6512:22: warning: Value stored to 'match_data' during its initialization is never read
        struct bt_ltv_match match_data = {0};
                            ^~~~~~~~~~   ~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3119501364261556374==--
