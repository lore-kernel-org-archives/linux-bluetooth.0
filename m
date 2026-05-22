Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434894028CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459364; cv=none; b=B6e5z5MgD5DHNwqgKia1kfGiltjzuvqzqxs6tZMwmAZl/tWQloG5FME13dgx/32/ubEr9+Q/OZ377RcyyXEubPHIlXvrQRPPdjLozMeLlR6g2CqI2jOQkwncRRSCkUq8jJ31+YvlI6JgiRchL8I5+jq1kKSHbVUjnI94r2Yk9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459364; c=relaxed/simple;
	bh=I3pBb0cqJf6o/yMnz0u3cEu8vjLClkjw6M8BELq1wqc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T/WvrPgsb7RJK60M+ShN0XEt8EJXLhkNoGrr6/IZXGVZ+r3hPjKbG7+OUB8dkbWCR4K4FvR1ylfJrm+JuzDebiuFt9QWHOrELabw3hWPGF6HjPlTb33AJ++480N30UXvDq6jfQ2R/KysOd+F0ZnxFKHGBAvg+mqPwshkoNCdSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWWGV57R; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWWGV57R"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5164dafcf97so73619961cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459357; x=1780064157; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRpSSbGONC2clMDNVd/kmB1SrzAs//WpX03C81LvAJY=;
        b=iWWGV57RjjTliey5Aj8Ss5dG8VaOywAzWnhue5nt3t1+8Kq8FTUUJN8nTlXC9srgLw
         PJh/qp5FYP9L2UFPtly5/cHKqLvqHeTss0FI84AqwlJABbbM/NgkAsgLMObABKO6rsJe
         InCV+3BkkZ1H8XV3yU8ts84V8RwOfjeGZx7SsHDbZbttl1us5NAy3+E7cOUmiov3m6Tg
         ImXaM4T/iq6N1kijTkwIdchKAUjGACEJxbc4pzjBqBtkHcBO1Nk9VPk6H9K1Iv5Q2KKM
         Xzczq9/lKcDRayo+6+kWmLzr7kYP9aJNhLKgTKZlNETgRomO16JbEsV3iYGGHw0RfFAh
         rDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459357; x=1780064157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRpSSbGONC2clMDNVd/kmB1SrzAs//WpX03C81LvAJY=;
        b=EkGJ9v1M3lx9NqUk7+ndadRy/j84f/9qsJVrYm6henIdKHgBD49dOJA0N0Is+VkcH8
         tdFV9awDA2vKQ7mv0/GOiIt7wkeAV+qVygETJstOIfdcD6P/QQQxmqxr9RxR/aXwXbW0
         D4nSl7X5XkcAWgqMtPBJnqbJ0t89JeBRQPqJsB5NJpk/jePayY33R7FPrNMuSwaU13ym
         5IT9RdQ8lEgMzduHjxFJuvfWCU2fjlUOSf1rYN7g2zjUx8agkGPMihb0pNOdZrbkhPnM
         V97G62PKJPGzKqVmWFMgNA2U6BBB5SOTvhB19IWsBMko9iBz+7tce4cekW3NW3tNCKoO
         oH8Q==
X-Gm-Message-State: AOJu0YxvN1nfdXYLas3jZ+CyUIWSEASU0NhqsUjXcJKe7WWy4aPwJuN1
	k+F+Eoe9+rA867JCaioqLQzEx0Y9XJUcmE7uJTlFlnhADT3iL2kpq3UdbffIjQ==
X-Gm-Gg: Acq92OHYeHOU8sJi1UEShyyMxH7WGmR32beHEwn9JyQxLiPm8eQeWmPINxUzQ0bLhL8
	FVZXYv6ExaYCMajd6va2AcVnmC6ywhOUmfJFoSAGcN1qUrFoQlNP+sEngKWMuWIRX33E2JXNrp5
	XLFwoXHSfYCFe4AQFoVnetUjSIwbe+5f32Pa5CUJoPUYRgg6EYEN1xEo56rGe2qW/oH/VdRXhcz
	Oyj/GdGjYDQNPMgfQcBiK0kxb2GhC8f6KqrK3HSnEtfugwao+U5Xbs9wT3DRLL3K7xwIZLE2elB
	5pBcEJdUbXAhFJgXfijxRyoQ6lyrjR/k4PXg+YimZHg3zX/F8tA0EB84SThdumz/AuxhbzFvaW9
	x/PXO74ia2TH21JT7jPSIACPXz1nullyiuUeQ8baDKPYiSfLemVw2yW1J78mD8EY/Asgv+kfc10
	q/5ZvnT/kZ2v95zerXRWpnC3x7Jv8l5xy5TCWYYAA=
X-Received: by 2002:ac8:5a03:0:b0:509:3940:30ea with SMTP id d75a77b69052e-516d46421b3mr52511791cf.55.1779459354691;
        Fri, 22 May 2026 07:15:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.87.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8d27abbsm14244591cf.31.2026.05.22.07.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:15:54 -0700 (PDT)
Message-ID: <6a10651a.506e0a01.1ac6f.e153@mx.google.com>
Date: Fri, 22 May 2026 07:15:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8173923351388079209=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [BlueZ] monitor: Add support for HCI Event Encryption Change v2
In-Reply-To: <20260522111540.581113-1-apusaka@google.com>
References: <20260522111540.581113-1-apusaka@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8173923351388079209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1099306

---Test result---

Test Summary:
CheckPatch                    FAIL      0.50 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      661.62 seconds
MakeCheck                     PASS      0.95 seconds
MakeDistcheck                 FAIL      235.11 seconds
CheckValgrind                 PASS      228.16 seconds
CheckSmatch                   WARNING   359.26 seconds
bluezmakeextell               PASS      182.87 seconds
IncrementalBuild              PASS      688.00 seconds
ScanBuild                     PASS      1069.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] monitor: Add support for HCI Event Encryption Change v2
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#114: FILE: monitor/bt.h:3705:
+} __attribute__ ((packed));

/github/workspace/src/patch/14589097.patch total: 0 errors, 1 warnings, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14589097.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10239: test-suite.log] Error 1
make[3]: *** [Makefile:10347: check-TESTS] Error 2
make[2]: *** [Makefile:10818: check-am] Error 2
make[1]: *** [Makefile:10820: check] Error 2
make: *** [Makefile:10741: distcheck] Error 1
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3917:52: warning: array of flexible structuresmonitor/bt.h:3905:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2146

---
Regards,
Linux Bluetooth


--===============8173923351388079209==--
