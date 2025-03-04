Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669020468B
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094727; cv=none; b=qqkpJPz5QLzfpR8+cTUhNRMFoRSVsG8SWVvE0R7BRZPa6QpylhJb/jG7oJun7xGo7vpiktlizkm3ZQ0DpgLPZZFlGRK8v0itWD72q5Pa/FmYtMjJwOhLFqmd5JrEnBH0aJPcS/kM1buc1trVTj+SkplqdU5wjFxcMv1EIMJvprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094727; c=relaxed/simple;
	bh=nOVXmPZa9rzGRjgnMvLHeCwijpWhwKq6eU7BYMEMdTY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I1nsweDnRD7jqpzgXNgeka0kNfgByfKNn5OWmyRBNDqxxOE+Tx9C9zeaMVL+do8T68GlD6nODaFgwLOqafMbJJdp2L2xUFBLst37elvB7VSiUzx+R8Lu6RtYf9FU4IA81a+Ktr8puLkDTzCZn53MPSZnXHaPO/Djqp0NGZar04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJFSKIVR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJFSKIVR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so8938889a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 05:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741094725; x=1741699525; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TlDet5WRfsatzGlEXHmpVerijQ26hNrpsdv/qQUzEdI=;
        b=XJFSKIVROwP5p36Mkcg9t71MfVq7z3+sd4tb3my9yZs22dfjB1k6FpzfXMWag5GPEP
         Swl1SAMst9v4NoptnIhBzw51tG0v6baSmvxB3+BLHRywW58zBNlOlga7eISkTAVd1ppf
         aCJ4B8jUZ/O4qB8ahqInGO5XpesvyuZWGZp01ZdEHrAANNIKbVkczJWSTRZKk5aG+IPt
         b8ubrz5uA9GSzRDS54ct3NGiTR0xsf3YbaYlwFhkH+CUXrHHj8tLUFDoZCzgaFwVD32y
         PcnavqNlpKzXyA0DcSrZdhwZ/zdfTTyZw+QgpEKyMJiFhD13CoIwRznZfnqGdFPxgJjD
         EkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094725; x=1741699525;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlDet5WRfsatzGlEXHmpVerijQ26hNrpsdv/qQUzEdI=;
        b=A4n6JtbGDRSZ2lKziHyuVkyH8TUqifb/sr8zugyfUG7a8sccp6v3bZsqToDfxun7Be
         NUN6SMUMPvv6xqKQUt3RmrZwyKXvaYeTTGBs290jJNNfHDbdofZuw/tIh0p7c3uaKGW9
         TUsJpOhNaRabgmPoONbpQPE7VJ8VaoytX5/lA4IV9NtMhZDEXCbDlaIrx+mGIPGIoBPG
         /23TrsHVIliJz1XQPHZsCtbybOn+jD8piaEoLXN/aw0TZ8OUwkigRqpbPE9pr05rKh6r
         4w+wp3r14bdW1Pb3ALbzDNDhKA2CRzQZclUBvvyXfnI3Hw3yidk80ZZ6pBzV9luWGpOT
         FwgA==
X-Gm-Message-State: AOJu0YyHG8+duD6mCpCxxJIpNYi/JLs7MW0Dg+muQqneiKRtnW2XSJ8W
	xCL8LJKNYUh8QrfwXGwB4B6ItNiQ0YO5aFEi/SiL0EjLmjj8xZh+UScodg==
X-Gm-Gg: ASbGncvz25/ZdUKhQPX5XJkSFwDKqoqzwAOUouPGnP5uyyJXjW6eJkMJvk463L3WnrH
	41PZJnx/EXCSzynZOY7DhFBoZx7nvAgklHWJDT/PDPSFO/ePzDN6HtsMkTuomqmAqJN+gwAeavP
	AJAa6l/+dnl2EYmsnOrBlqGJZfpthYWJLBiR00ja0vXU3XMvJHoy2LegXeeLKXXurDXKoWjl5Iz
	QQcH5I1y8GgE+jiOYpptVxCV81s0XzVUhnSSixE13IVyPsLe8f9pZL8zvz8p13KXPUAtdoXbrfL
	zLrw6h+6XLWAPl02XcmTlN0heX8cND/V70BGoxJtOR4c66p6
X-Google-Smtp-Source: AGHT+IFlaGJPR+tnEqwRs7YNue/I+S8FSoqowJEgbUXe7usoZE7MlyXJKw5YTYd6QUgPBjZnPaiYcw==
X-Received: by 2002:a17:90b:5747:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2febaa924d4mr32383943a91.0.1741094724767;
        Tue, 04 Mar 2025 05:25:24 -0800 (PST)
Received: from [172.17.0.2] ([52.234.42.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f97d9sm95260445ad.62.2025.03.04.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:25:24 -0800 (PST)
Message-ID: <67c6ff44.170a0220.2d24e7.3ac4@mx.google.com>
Date: Tue, 04 Mar 2025 05:25:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0626143140899638130=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v5] obex: Add messages_get_message() implementation for MAP plugin
In-Reply-To: <20250304115856.1511495-1-quic_amisjain@quicinc.com>
References: <20250304115856.1511495-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0626143140899638130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940016

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.82 seconds
BluezMake                     PASS      1445.51 seconds
MakeCheck                     PASS      12.66 seconds
MakeDistcheck                 PASS      156.73 seconds
CheckValgrind                 PASS      213.15 seconds
CheckSmatch                   PASS      282.63 seconds
bluezmakeextell               PASS      97.30 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      863.09 seconds

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


--===============0626143140899638130==--
