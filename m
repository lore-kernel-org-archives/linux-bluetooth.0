Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60F2571D7
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788457; cv=none; b=A2TVHc0HEd25vob0AlBSt51y4spE9SsPrQ8CGckHJAAPBgD/CDauJ3Utgm+Nn1lumkgveVbYJjuiT42CDw9SzR6N13y67Qn7ulR4ICfTIxt1BB/0buIADQDAkUJGTrK7TvwcVtRqYxJuAuZfxM/yUfCmQXvOVa1KXSDUR33TcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788457; c=relaxed/simple;
	bh=bNNrFllgokX0ZNc7aBA4R5YpoAwBvzSnNMO6TzBK4/E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QBh35B3z9RXHPnEt97mXUZ4SsbrVpRBh7BT9z7eM/sfR5jGqbtiUS0vLTjPwNSwYZarfL3r2nIb+JGcxYgDkb/nmXRrtUHkH5FY6UTD/Oc4ybul3BeZ8uWfbr6jNIlJmfCRooD6l5I0FeIh3ZSoZHswfXyFBZgma8V49XGyiHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5EQzwDS; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5EQzwDS"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso2355698eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776788454; x=1777393254; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JPeU3tns46jFQxhKGL+QpcW73tIlZk2A121FHl/jnw8=;
        b=L5EQzwDSKeoMhbDlBoMma1L3ouvSL0zkHQjYmU6PUCX9EiVZB33Wo+Cxhp9y0V225S
         Q7AwvkW99IrEb82FqfSarZyefEG8eua2nXUmfDdKKqa9UoApkFGr0cGn1RRL6zYpJqNk
         GibU45mKsH22OsJoqkDbGI3CAkZ2pipkE39bmrccnC0XeoWqUqmI0/dx2/POpiAUMwJX
         tupom3Es68INQzJZNoRrOpOVUT+5auhYwpmarBY+WLYWVvHQYnvPWOEYVIFvakatJctx
         RNDEAbh/rYKJMm4UQ+xbJbQJlaZpLmda4BM/7pR5+VO2Fc+M5azuhng94ux/L4IrSwuV
         obSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788454; x=1777393254;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPeU3tns46jFQxhKGL+QpcW73tIlZk2A121FHl/jnw8=;
        b=eDMYEK/Z8O7ZE23IlBHwg/kmGdGpqyR8vcxc3SgWuQq7SPKukFyKxdFyjw/+S+SNz4
         GMJjR364MFQfNKLhlR2iqwaFCKEmnr5bZZKhNDOTLlCeHjK+Bka3Q4Xp0vbEGew7un4I
         AIlvuXXUAwl68mmm0z1Jg1vvCULVnrXN9TA4sJXh9lxy8tHArq4hiW+q6Ay0HLF09jcl
         kFQbt7qKowi1nKzHIKl0yWi/y+nOCrjAYBQioHQRVN5lsTyaBBGFt6mtYdS9R6wf+DTI
         vQH8JqSEI7ZfRrF8pnXuaZBsjA4IxSBd0oTNEDxVdUxyhpa76QImSn7/2OdOKjHPlsKr
         PnAw==
X-Gm-Message-State: AOJu0YyF0NF2d3hrOD/PIVC52HJ9gUYHCIWDMv8sLG/S7T1hMEHo3Fa6
	2yfuogA8uV9h8iPiEKcQ7UnTDIxl8nSFQsrjhK6c6vUaQDEJ76U1uj6PdtIUVg==
X-Gm-Gg: AeBDietzaflI3f+USkxaX8H0fE32hL8iVqCFXsgh7SuGZcq3FMocRXNiN+f6pIoF7XX
	Wi1OrIn5jc6tYKR/lsIqb3nfVkijScHUph3/j3BXPWey3jEYmW+E2jRS7LleMIWQxRqBaDkcD+R
	NwhOhQQ6RXRwb25Nk9Rgn8/gq5HoHU/QeL2ZHkTyYbFhJ2/fK2lXRo12su1LeDMlNRtp0ojhBaC
	oEnjpbUwU6eqvmxIINeU+bZ6DKf7A2cWLgufvWDrofNZECIp1nJpA4j1udvfZJQZPmah2Z6c4Z5
	OotjAsYfKUOE/J0qyOLGacwQmR0WOeOYpENVDw/gt97XG5hnI9yV+G5n1JZs7GO1Epco8e0B2ug
	xk58ihuv8h+r1KhbPaeYz8HNqherylQ0y2ydppvWIwL6arYJEJdI4uILlFxB3MAya1t5Ih4ZlXz
	FhcHAOKSRzIVbfcyn3U/aw61Sa7Kkw+hDyz44flYhP
X-Received: by 2002:a05:7300:7fa5:b0:2c1:82c2:bc31 with SMTP id 5a478bee46e88-2e42dc07a15mr7325458eec.10.1776788454164;
        Tue, 21 Apr 2026 09:20:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm19057040eec.14.2026.04.21.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:20:53 -0700 (PDT)
Message-ID: <69e7a3e5.050a0220.1506e.ea0c@mx.google.com>
Date: Tue, 21 Apr 2026 09:20:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1269646912184743968=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [v2] Bluetooth: virtio_bt: clamp rx length before skb_put
In-Reply-To: <20260421151659.3326690-1-michael.bommarito@gmail.com>
References: <20260421151659.3326690-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1269646912184743968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083916

---Test result---

Test Summary:
CheckPatch                    FAIL      0.58 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.45 seconds
CheckAllWarning               PASS      28.79 seconds
CheckSparse                   PASS      27.55 seconds
BuildKernel32                 PASS      25.63 seconds
TestRunnerSetup               PASS      570.69 seconds
IncrementalBuild              PASS      25.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: virtio_bt: clamp rx length before skb_put
WARNING: Non-standard signature: Assisted-by:
#156: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#156: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 1 warnings, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14532726.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/112

---
Regards,
Linux Bluetooth


--===============1269646912184743968==--
