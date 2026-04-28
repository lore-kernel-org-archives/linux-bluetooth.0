Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2291ADC7E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393624; cv=none; b=N/tYLVkU848/6pwQ02Ab5CpWluKAC0ajru3NsNg7kWOykhheneQFdYO6dyhW9jfZwkQVJkEl4M4+Pk1yEnnFxzVgpoYpiQNnt+9LHdhAeqYm3LtZc7ywaD2NKvcHE7CEgNfaczTy0CUvtH367d4DE7x3Iqo3CvsEBRigXwsswwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393624; c=relaxed/simple;
	bh=oz5dVPUtQpYH7brV8gwV/XDmgafC4wJ7oIKPihNApCc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p9x8PElWqoyNMJ8y46IncfMnEH+s5J4DWcpZxN9u+CnBU+uzD+IC9ESntdLJ0yEf6fo2TlMgBUO9/IeVbQp88MrXmb0FpaLxnspHv/ZxtQ0BhTZd43XMfjXUMd/cdxn5R7qf2XrQp0OJr0jLKM3bgx+XLrZwrWuPYZ/oxpW1UyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJkzoIhm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJkzoIhm"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a747448dso83504111cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393621; x=1777998421; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f6IcvJcUgH90A6NxkjfGGvRpHc5DXzNa8k6WBaIFdFY=;
        b=aJkzoIhmfNAqXirU87sFDCT+EMgk01sQoISW2Awhfe978cfzijIgLaz0MvEeL6MVSB
         JMRjWW4Bm3Ji07uUawu7eHJXUQvZknejLK052cWbvKjBVB78gvbjZVjVgKPWoya0uwa/
         5K5lC+jWjIzkocm88DM7o4+0H3DGGac/UNQ2VmiKiK3huDrNeYNN4ITRmY/XosWHmNaq
         qq/sV/5Nhy9/gKx9X5W1mTPFKfENngEDUNnn16aE5StikSz02KAg8a45DIwlR80p1+xz
         GQNsIQpsC89f2hpmU8llSJ53Ax0wHffFcjhgMy0w4S7rO8waFCQbOnUG8StlJW/2NbSG
         U1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393621; x=1777998421;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6IcvJcUgH90A6NxkjfGGvRpHc5DXzNa8k6WBaIFdFY=;
        b=IRrxkdTraiNlZJ7GU7OgJq1mk+vUx6hxMJecQuNNkSed/iPsKSwQgEJnU2VlqP3W9a
         D0MmDB6TF4DFVMdB2zuPTZeUeZSdEmLMhcmYW/FbkMxi0amba385tNNLfQYlt7RQHC4e
         64umO18njJo2gdvAPrLe3RaHl6/sut0bORV7LrN2jx3219ORiDt7MMLMWUJ5pwIi1o5C
         8dkAQAo6rg3ACPj7Ukx5dLuCi71R8XRkc79+V9KOo64kZ28x6nkDRB+4FHdnpB0Z1hXe
         BO0GCquojO9YrZAbNbVhkWgXFZoWilGFAfnJytOFTojFzryIjuY8SvQuyDKttbhiZ5IX
         G7ww==
X-Gm-Message-State: AOJu0YwVrZRmy5d0YPmYl3FFvez+H1QCXt171QiX05AGjRUSzLoVRWYE
	ysD0tt3S5yd0y25bFDm9kO4dlB4cFGw+H16DIFN5nuXiqUk4+fiP0nk5ySy/oA==
X-Gm-Gg: AeBDiesax15XGQIlV/okCQmrnACLs41OvzajIho/CQsgI6lAGS4g0gdncOfGqFOpZm3
	rrAYW3BFI0xNnZkaknJv4aeOXwnNJfKmdzeJI0h+/MwBUpKnhAX9vFiTyQxODoo9lza61f3XnB4
	mt61+omjsME1v4xh/nrHWfj2+LIxpuBfJdAH30/uNz+xEFKW4UcInFQZVscTbIvx4+LY6q1/d/E
	azMSctO4KkrMOyBisXo4L3HniRwrP0ckAo85qXirzftZpS4K32nZAEuaTkUOoWyf1+lr4JLliPw
	YEQsW54STjNANAqTedfau1ytusw8LnfUdLn+Yi5BLLVanQFicJyU39xdJ+s8J22mi9+qggpE4zN
	HWvH2VVPnTbmzqCt/xnTVDVdIrRx83BFGqvCucqdFJjCkiW6zi+nljRhbc6Mb8XijnhAnxC4CTO
	37vPdqzi5FIZTQEG0KRdnd6/IeWZtCnobeVgSe8SG9rnqaOwQiam2R
X-Received: by 2002:a05:622a:250a:b0:50b:445a:4139 with SMTP id d75a77b69052e-5100e1f673dmr53732261cf.54.1777393621139;
        Tue, 28 Apr 2026 09:27:01 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100e0a9befsm25489141cf.14.2026.04.28.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:27:00 -0700 (PDT)
Message-ID: <69f0dfd4.050a0220.29fdf8.7d15@mx.google.com>
Date: Tue, 28 Apr 2026 09:27:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7369524709130142039=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: client: Add public broadcast advertising support
In-Reply-To: <20260428144008.7487-2-raghavendra.rao@collabora.com>
References: <20260428144008.7487-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7369524709130142039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086916

---Test result---

Test Summary:
CheckPatch                    FAIL      1.10 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      620.88 seconds
CheckSmatch                   PASS      338.52 seconds
bluezmakeextell               PASS      174.71 seconds
IncrementalBuild              PASS      622.72 seconds
ScanBuild                     PASS      975.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,1/2] client: add public-broadcast advertising command
WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#158: FILE: client/advertising.c:1066:
+		bt_shell_printf("Invalid argument: accepted values are sq or hq\n");

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#197: FILE: client/main.c:2923:
+static const char *public_broadcast_arguments[] = {

/github/workspace/src/patch/14544460.patch total: 0 errors, 2 warnings, 136 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14544460.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2081

---
Regards,
Linux Bluetooth


--===============7369524709130142039==--
