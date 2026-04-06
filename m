Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A234D919
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479480; cv=none; b=LVUGeAEMYVE8CvAF4Hcixz2o/PTyQK7DjQPwC6Fy5VxYw3MNNLnu8VxybOUn+ELnehUVPcvAoqxlQhUfiLrng+QmREt+DuAtlv+PDN3gDFwqcw0/I6dLupjYH5YZiJ9jlWvgtiKqyIv5s0hK0mEBwZjTEpSd/FJTDhHNLzUBlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479480; c=relaxed/simple;
	bh=E7+zKXzmuAIhxitLtioVDlsMYiUixwJWRu3lGhyurxM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pCEmaTf3ktB/zVHr+IBmvRBMC/RweXgHX51PlUsVMzpLYsSkQ+b8Go97lJ6QUfGfdW+yMHHeQXT/1Z9u3U6xt4bBkTPqYNSKbRs6a+oxVF4amat8Sg/wbwjDoDRhC20VRv7EdDCbF+rfVnJlUyHI7qCYbjAASgBf8MA9vhGbBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS/1GAsr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS/1GAsr"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d1b746f522so429918285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2026 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775479477; x=1776084277; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+o1SVnJRoByAbVJxn9gWnlW8Ofr5aiaNZkD9GNmEmrM=;
        b=BS/1GAsrv/aC45eEUAmc9j5YtEOdtYT+q+iOIOMBgj3Ae0HXknoQlZlN6h6ZxO1OdA
         ABR9wElfgq6zzU4HskdbRh3RaE1GuAPKRLKRsyCuG+tbEKYrtqLSx2ILcDHLHYodi/RY
         Kb6Pt38UtcSa3lxcz7k3+eDgGrBZpCPfISZ42TCZ2w7pQxNQgEnP4tAYLehbAeAi3NxJ
         IdtInl+jeJFCrScarO0STOQhNY9TRHoHe1fXVJKmZzf7Ld9g03IwJl34POm0FrpQhfU3
         N0WOD+BIMMLg3ofVCJFLNKL8dGO39IiQ97Y12TwTlH/MNfJgO2V/yTVdUHeSFkV4PJNA
         0ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775479477; x=1776084277;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o1SVnJRoByAbVJxn9gWnlW8Ofr5aiaNZkD9GNmEmrM=;
        b=Z7mzwUiaQq7eA/vXE3wF3ZLf5qMIbo2dQPTZrHXRFnKvnJgoD/xMx4Eb+AJuuioRwR
         OxtLbEgNnnOVTXYsJ0nRNkWRgYx7/DLDkLFQEtNWTe7vZr23sQYzCUcYkl4r75U8ZJjU
         nh9+ggJzGCio7usxR3mKmMTNUr4f8I6zxLLqo1wPjxJoRKo7fOIUYuX09G63h2i6gSp9
         XiV7zXz+ljbfLXT7UdE5l1KBk2FzWY0MI24Q4ZEZhjy6zElesc/aRMROYweIFIE+xmqH
         UTHZk5NuDu3NtuXqAjwsbd/H3vUWZKL3k3egprvUeU3FissYdRT8uhA3wb/xHXh1Tt46
         negw==
X-Gm-Message-State: AOJu0YwclZV3X6pWrt0Z2xB2bkzeeECTe7UI/oHsoX3pk87HRWkqT0QZ
	a8NN27Qnzf8n8fq2r0OykNzKFp/UAT1SvB+Q4aP2kiApF3WxLYdt7ibGSuVOKA==
X-Gm-Gg: AeBDieu8juSNxCaG09k0NRqKtfkKFBHtep39GY8cbBq962LN8gXsj3Tcs+xotDACPCs
	hY1NmaNKClXaKhj9raSvgugOn5wb3Air/T+HX6nsGxfB/o2SP8YB6ZufoA+O+Mwhb3HM+D6wQbA
	4EGaahs+WzSwqLaK3iZisu0KFqszYSd3GSypJhSxWw8fkyM2uzNtA4GgPHqduXM65n+PU75yWKj
	k7JckZ5ooXbzsBxTyD2lCJ7z/LtOQLdeslK8ASbPh9LKpilspteK0i3S6jG2VnKQkR2kq0l+Kvv
	2heKzzLk6swtYGx0VVaasMvJKIadF+uphNw+s3uDKhDPPIy/8mnBF3hUfzcjvqbIGDt9zRHppv8
	D7VsnqHQ/wI3hpKRVTDmxhRsWOhpY2WtQBnpFndwuL603gasnpW8VfQdCD5VmXC1WzZJmcx3ZCP
	ixYvvFJncknknBYrTdAdKB1mlAPKzN0ExyuXsgI6Q=
X-Received: by 2002:a05:620a:2681:b0:8cd:b620:f3ed with SMTP id af79cd13be357-8d41dd41f47mr1729471485a.38.1775479477148;
        Mon, 06 Apr 2026 05:44:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.47.116])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8c2a453sm1082474685a.47.2026.04.06.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 05:44:36 -0700 (PDT)
Message-ID: <69d3aab4.050a0220.81617.eb10@mx.google.com>
Date: Mon, 06 Apr 2026 05:44:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0619604305874713860=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/5] monitor: check data size properly in evt_num_completed_packets
In-Reply-To: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
References: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0619604305874713860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077640

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      631.40 seconds
MakeCheck                     PASS      18.41 seconds
MakeDistcheck                 PASS      246.49 seconds
CheckValgrind                 PASS      293.33 seconds
CheckSmatch                   WARNING   350.53 seconds
bluezmakeextell               PASS      184.29 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      1010.97 seconds

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
emulator/bthost.c:703:28: warning: Variable length array is used.emulator/bthost.c:704:32: warning: Variable length array is used.emulator/bthost.c:944:28: warning: Variable length array is used.emulator/bthost.c:978:28: warning: Variable length array is used.emulator/bthost.c:979:32: warning: Variable length array is used.src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):tools/seq2bseq.c:57:26: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2018/checks

---
Regards,
Linux Bluetooth


--===============0619604305874713860==--
