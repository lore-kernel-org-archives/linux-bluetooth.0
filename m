Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753A2904
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040944; cv=none; b=YGC+WvFECyhof4+wtAsooCNCFKhoWEPBqqxikFuvIz61yu0k3vOtJ3BDLaJzISKy+89lscLBjXdGpMAZYwircrjGPPz9+t0C5C0GwzyicuquTzwrw7J1xQkem8M6azbjwi+5M63YOHZItXSvpLjCz+2wKYC15P8MXyAeKpxe2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040944; c=relaxed/simple;
	bh=aZpxcSc4wWt1XY/XIDpFIZWC1kqccdbcgbyo0GPFuxU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a+IPxr1fLBvn3vyudOeXBPpozYcohwE8xgNLCB+X3OLWvkfJOUMQ+2/JVN/CXle20wtKCwK2n1528hnv6ipDBob4GhrO0LtCpitU0EMaj3RdddZSqqOwK/UPR/e2OQacHvm6prk5aa4Hz0DPwbtT1VBGgeOUbHug0ZeFKOVwm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY7kBOBk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY7kBOBk"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6facacf521eso22825946d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751040941; x=1751645741; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob8R+YZT/3/bTCDi+tOe3IxNvbLWaIJpa3gSq/RrJzA=;
        b=FY7kBOBkzARltWb0/KxbL9wpsiAmqKkQCmSGSekCap0/0bojIVBoA2ah1xzr4df1hV
         iLUchK7e0uI0tyamYX6wZFiSR5F1riigdxtirQkGVfjBizl5KskZO/fczUa57Gq5kybP
         2BcVdHeeJ3IPBpnnRVeV/UWa13vx7bq9IHwdkVtd4Dp34ek8yv2xpCfr/xPaVfH2t2/Z
         85ns+BcDk1OqyOkd5xzBovUOHQIrMfAvVRoQ0QNtjKnjbtYtg9/hUWc1kqOs+bP0Hv46
         gefhje572VlY+xPGlWdg8wvlDjKMbtd9rCEjI8TUXpoOuKiyp3bH8KhwagvnOTlQsQKF
         lC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040941; x=1751645741;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob8R+YZT/3/bTCDi+tOe3IxNvbLWaIJpa3gSq/RrJzA=;
        b=GfyiAZHSm8NIS/BIMQCAgoKC+bqVQsKdyfbJZQWzGnpjXss2sCmXCVv6YBUshHqyho
         noVhwnd26BmO9MdE4HhCDv3GpjhpMnL6jhXWFkJoCkds87cM7FlF8i/3G3k2mLCxRayr
         BM63sEgWA3cXXhvd2dgdUJOKJtNQlknbtNDVvrLdonRMXJkApKUTx1CYyuferwZKbsHs
         ecl7T60rrBUA925En0fxqIwlke5x0aKwPeuomBNDJ+BFaimh/WhHWgmtH8Pgz9OrNj0/
         OYuzrc+s8yRKn4PrnhlsxcvHnJPkNaxwNy6nplO9I/IFGr1ecvYXKHtopm0F4LlYGlSs
         TdwA==
X-Gm-Message-State: AOJu0YwaKmiX8sgHYkPsqASqaYGaw4Q0orMsZoo0SGybr8Qog66Kva5O
	TlQhGAtrtR2V49Wj0EH9gX+cHD9vzTtIepKro88S4iCi/6YeXtS8mG+BUohynw==
X-Gm-Gg: ASbGnctzl0NyjiPXCizIQxn9Hd8uI+aLd4LKxIRgoCWPNQUrRe1iKVOiUzNpSq0bwfR
	aWWlfRs+JDxQwgdgJsttz0NC9KfOCo7DTjshepA8L1071jyOoG/H3+DURHWx7inK/d1OPYYcu7J
	+I3BT8l4XOVxXHM8/n99yDOt76PLiyfYcshetkLK/R9w0+1AsyXLAtwKmXizNL1lwv9k5EhBgsm
	+1K5dmK2FR2scMHwj4fb7tvZwLkV/FGaYKcLCik4saKp7k6u1vgn+U1NIK6GhBGEXYfF/kJvv+z
	NSURTxqqkGC1nl6Wf+eZ8xy99hC0L+mRnJJgU6qvXy+Dp0VVZerGoS1VnvNVgT5K59w=
X-Google-Smtp-Source: AGHT+IH1gKHzBzzrMG7TjzTVqlbQ5O0n+wfgeX9YySbQncKdYSiaBGBp32hcz5qncBgXF6cobnXkwg==
X-Received: by 2002:a05:6214:5d8e:b0:6fd:75e6:bd33 with SMTP id 6a1803df08f44-6ffe4eafc6bmr61815916d6.0.1751040940507;
        Fri, 27 Jun 2025 09:15:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.5.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718e77bsm22817616d6.10.2025.06.27.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:15:40 -0700 (PDT)
Message-ID: <685ec3ac.d40a0220.2f4111.8336@mx.google.com>
Date: Fri, 27 Jun 2025 09:15:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7262271458058401152=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: New Telephony interface for HSP, HFP and CCP
In-Reply-To: <20250627145136.421853-2-frederic.danis@collabora.com>
References: <20250627145136.421853-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7262271458058401152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976686

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.14 seconds
BluezMake                     PASS      2783.77 seconds
MakeCheck                     PASS      20.18 seconds
MakeDistcheck                 FAIL      51.64 seconds
CheckValgrind                 PASS      278.24 seconds
CheckSmatch                   PASS      310.19 seconds
bluezmakeextell               PASS      129.73 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      924.19 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
../../profiles/audio/telephony.c:45:10: fatal error: telephony.h: No such file or directory
   45 | #include "telephony.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:10827: profiles/audio/bluetoothd-telephony.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4708: all] Error 2
make: *** [Makefile:12323: distcheck] Error 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7262271458058401152==--
