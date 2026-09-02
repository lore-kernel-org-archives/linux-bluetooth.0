Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3317993
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331325; cv=none; b=iiBNS3vm7edQEwKqXehCfF9525urqJM6SqdFVR1EY6bnqcnxCom0Do6k+MbokiaPaKHz/X6K3MruMWIk901JQlrOLkxm+3OBReSMh2/J7M0Xu2Sf5Zr7SGKPy4uDo1fOuuO51sJP+sAs7G6cpXudpYoZOc51xrSTyXX3BEQ0QVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331325; c=relaxed/simple;
	bh=2JbVigmKVFeZaYoL5LWk8lYuGTmuBRHq0ymqe8spKBk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ixhoUSDRhAg3PnhCYjucGXTS+cj9PxtmfZY7Q2RQEA8uDkIJm1oOT6DRXM0woFL43Q+R3KLeGOgr8ByuExg1RUITOnpyP7ynEUwnygoyHd2aEVjvhNv8krpu6bDn87UJuYsU3YNdhyAMRKxV10h388/2UbZq45XEV3qpJEgOwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSRodfu5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSRodfu5"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb34c17b96so515495a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788331320; x=1788936120; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LuxzRQLXgn6qmEwxLIJUf8/FsNhMk98dOa8G0hI6c1w=;
        b=BSRodfu5AAvUTogc0T/d+hwf/cGgvXuz/WaevzjYrGyZfdqL2Ar9AE4jL4Jg7xSEkI
         xynl7a7tdDTktr2kwVBtS/NfQxZoPMr6FtRuEWE88u2XAEnZY9nkjv0I9KixEhaKRzgu
         Zkg6X93UGEGchaxc5iDBTaxSEWvS9WGCrtlyO2bfGO4ub84n9cZexNcQMvDwYdy8v14y
         /FVSaUw9vd7bp9yN4AxtRM+x0H3n8BhwG/w3+xIsh+Q+otkazn6cnPl5X0qO3EcfeVcg
         7o52Nohh8stNcGsab09pqZPRTTqiRcYyL2hrxVWHXd04WhbRuOVl4Shw58HdmcUNXSw0
         3vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331320; x=1788936120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LuxzRQLXgn6qmEwxLIJUf8/FsNhMk98dOa8G0hI6c1w=;
        b=ERcuoL0nye0TrrpVkJ6k4Qp3W6fq2pVNq6JBmtNqXopDub695wVUimkNmr43R4mwhv
         2GHqJOn9j8Xe6phZV4G9ZWgd4f2kVF1B729xVbH6SiKIr3eP61iNqOdE10B/w54Op7Dm
         ROHUsQLy+6c5uzfu6+gAZ4p9QsMx07GERStxMRBf6ArtpNptTCO8+mzYBxzwkXiv+qq2
         deYwQQkXip9qBro1zyH8Ni1xswtkc3ZH6ORlculYxXLXsj7bYqyL2RyvKqQLoFCO8BOo
         7OM4wZD0zZErhwWPL/KUjO4fpxC7+4cbiCBwPPtYoWoKDmTiT1WJnu/RkdLhqeCHbNjc
         DFAw==
X-Gm-Message-State: AFuF++kXR+pDK3NRvF699xDkn41Mumf1ECDSrEmo8GroTjL2f4/ECPe8
	15Eb/+TuX0J5lj6qiWpy7zw8r3j8v+TgP45mAEYhHrHQOJWD+3U5OpccY9r4NA==
X-Gm-Gg: AR+sD1398aeKc6gnW3CQxaAqPYZMhC2gYG26UltOZvZkGGz5VsUtP39Y/5lBAhATfUE
	J0lbI+sUHUrE6T3rrwtEacgHmAz9iyP56vZoOLsZ2ha1y+Y8yRb6JSJmdZg+kOjSwsX/HEgGJ5F
	l+yQ2YMiO7E46+8NjJmHJfSbjkt8qdV0ofx1w49cA8YxnR4f+jZtzy24JI6dQV0AtUwCJ56uoPv
	7psBVoUxavvMOPPMfeAGLKsiJUgGRwtGRe16Q2ZIn5rPs6vhhH8OBKDvV6u21kXLR1RyC8l+SFE
	RVeUiToPzmgX8ipOgLdxORue7xFcqZVsPVl+VmVsdjDaZ9ytxRCCSGRsJGdo5XHzkFFYIPQTPLy
	oqNTMTesXdqJ20Gx2cJ+dbVfX/rPYo0h70bMqsQLOp9PVVj8GYJBxUX4ka7MztOWuFPNI/o4J9L
	66aS4k/zPAnolCone7mYbx61z28S+Bw4MS//bIuzDtM+mfEItyOE7cgsBTIGhDFU7Zi/Yw1Z0zu
	MHNgg==
X-Received: by 2002:a05:6830:67ee:b0:7e6:efb8:fe66 with SMTP id 46e09a7af769-7f7819b326emr3082485a34.12.1788331320194;
        Tue, 01 Sep 2026 23:42:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.246.74])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74d0b9203sm1675590a34.7.2026.09.01.23.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:41:59 -0700 (PDT)
Message-ID: <6a97c537.c6d84bbd.1b7a1e.04c1@mx.google.com>
Date: Tue, 01 Sep 2026 23:41:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4423179868354806741=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
In-Reply-To: <20260902042840.2432862-1-ravindra@intel.com>
References: <20260902042840.2432862-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4423179868354806741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155807

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      17.91 seconds
CheckAllWarning               PASS      20.60 seconds
CheckSparse                   PASS      20.58 seconds
BuildKernel32                 PASS      18.39 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      313.01 seconds
IncrementalBuild              PASS      17.81 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/685

---
Regards,
Linux Bluetooth


--===============4423179868354806741==--
