Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704898;
	b=KMjClFQBHK22KcvkS8GKL0kxRYJk8a+EMzBjDz3JR6ZSSqxUCrElQwWlANk5FuBABoeb
	 +va+ciu/Ez5u+59JBgOwr8S1H0D/9GL+3464GK/XhmNzvUJU7m5AhG/xU2f6C+GIsrMHV
	 rGXDN58YSqIB2o+aWOxZ5XZ/jRcDlVcpvQXIj4pb4tz0HVuI5X85tTZYtlk5QRm/fS9nZ
	 wUpbCbMu5A5m1oZnhl30QUOdQdiISCh8PWwU6pUts+uxor5n3NGjrEEwS5xMBmy/yYZBU
	 ZIDh1p99gSghwQR4UlhNvKnqeuARLKz86UyMm9LfWmXIA0SMuAH9ci8s8IkukYD2Ucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=UuIRT5s3LTNuq1/NXJeLKatK/oYihprTxFNHRQZ0f1w=;
	b=lXBJlm9i0rOUMhbgLHj1X3MCkTAoFLqnq4W6SbWwDt6iQuwl52ejdgqTmu3AMX192fXq
	 yFcX5XwzyUe6unHzkXbE3I59TVryviXI3sx4Labwa/YtrbxwISEV4sdkn5upsAWA0fboZ
	 G2KWCberGcqp+dlgxRkO86E7FVuqH7+23JnrrKDGun/nC3gD2g7qL9e0mMrrFHKfzAdqY
	 5VWeQD1JYAVw8SQJK/dJMYd0+a0Bhd1Mj/FJp7SYET08+CzZ8sNG4eXtYbfuu0bwQBhI7
	 KccA/LG/1VPGzpnZtVnVTq5VNN4WPHTlh4X+1d+SPmfGb21934G4OQGhIeJU5gLAgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nL46NIec;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E4606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 14:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 822E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nL46NIec
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b19e291cc6so6087442eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795704897; x=1796309697; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UuIRT5s3LTNuq1/NXJeLKatK/oYihprTxFNHRQZ0f1w=;
        b=nL46NIecxxflv4Nl32ll4/DxD/BXOzapwvvVHyNPR2ChYuOBJuA0UHQyl2nrJA6Zni
         AfoLmjR8y+BnCnEH0/baWWARydhxcKaM8RUOlZOc9eqEvMVN2NzenPqqZABKCSuD6nMv
         yncYV85IxWZ4lWaEmFfIt8Mnu5YInbWqUSN/yVNd+wYoRMIWlxP3cLQukcvaBI7gliNE
         08aOUHBPzEBIytT7vBFQeYa954kP36a2zx9cdm08kcpvTXngqikd6Qi1JwCZ85RVPan7
         iTGPRvNsoYdASMq3+bW+Rp6CGZ61PzmUowtWPk0/9sVSEeHhcXxj5WTKbH8k2ybdGiWH
         rB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704897; x=1796309697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UuIRT5s3LTNuq1/NXJeLKatK/oYihprTxFNHRQZ0f1w=;
        b=thi4uXEijG9cQ/XfPqBi/Q4Ac8jHVuuo+wiSbEBhw4jeuvNMwjxG41JGRyv1eFuepS
         kZXnXj2sX3264qIBcPjbR4o5irZpsIjSGoSbaE+KeoKosYVlcuClJ9tYz9sLTwukeD1z
         bJAWIqYY/CFllkE8AcuV6Vpmj2K5mN+oM9tr7F3Q1g9872QtfVp9xZMUz46/+E9YFM1o
         GEtKnTofE5pDl3tFO+wFqqxpvKzayx/08aQlo9ovqNmSNkGWNKgBU+53KoILBeeKC+EM
         8KngKpp7DKEHb7315953AGVTNHmQ+Ol3GvQYDui9m1Vk7HEsyulVFO4qb1q6rCb79Pt8
         6VeA==
X-Gm-Message-State: APuU4Z+oNUJPjy5OFd1nsQSCcJjRvSyiEWGYU5Qs0Bj9exklMBiqZ46d
	bSgxXeBeGfR/kb0MNqTRdcpaHe0Catr5JYSlsOsEqisX4D9OIu+yqSspQZc2ug==
X-Gm-Gg: AZFdTZdIwFznYJ3fTJg8BV/Yri5jantfOG52cyO4n/29VNH/0cYIiOcvwS4TvRwjiwY
	3hJ6luO3ITeLEZjYc6UFNq7xZuc5xXiN3nVUKLSv8toeHu59y0dJMWpo/KOtB2BlvqmJMge0Wvd
	P2v2BQZZOYynIAqtC4+2lH5U4Rim4Ptfrr8WS79pGvPumKYZDQ4RJcC4ewlUunfBqC8s3+H2f6p
	INtSsYmwEEK8lTx04oSQ18QjKb14GSzKaefDQOhVIRFCSrigfw+8yxom/HvZH2bacZAKC7A5aPa
	9Q48M1pLhwedI1ywm1uVpN93dZzPXhRsSBs8FEBvHbAtpm0DSZ7LkouHtFbxRO9/YD3PJnlCUlY
	k/R+AcD3FE/q9bofsK0C/rmblfFhWYZULkf1e6jgxcXgoR7h+if0HOqjOcCqeSn6+W7wrlV+XA1
	asvVUSHs3J/dTUDxlqNLMgpa1UcdUyh/Pht+pe7kaz/s7S5mKZ55PG/Rtw8jIr3r8JrrDnziyEm
	+Lo8cBu8BDJIhpMYUEQEbJPqHQOg8L8DADBY2+Hz3H48E/tcScvR5ZD08Llxog=
X-Received: by 2002:a05:6820:c5c1:20b0:702:778c:ec5c with SMTP id 006d021491bc7-71b3957003cmr12528674eaf.53.1795704897412;
        Thu, 26 Nov 2026 06:54:57 -0800 (PST)
Received: from [172.17.0.2] ([20.15.230.139])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86316910337sm14774125a34.23.2026.11.26.06.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:54:56 -0800 (PST)
Message-ID: <6b084840.98a28ad6.96404.dd54@mx.google.com>
Date: Thu, 26 Nov 2026 06:54:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5090919241144388352=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaichuan.hsieh@canonical.com
Subject: RE: [BlueZ,v2,1/3] mpris-proxy: Fix possible crash
In-Reply-To: <20261126064759.95429-2-kaichuan.hsieh@canonical.com>
References: <20261126064759.95429-2-kaichuan.hsieh@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5090919241144388352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222988/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       PASS      0.72 seconds
BuildEll                      PASS      12.91 seconds
BluezMake                     PASS      169.98 seconds
CheckSmatch                   PASS      178.89 seconds
bluezmakeextell               PASS      59.82 seconds
TestFunctional                PASS      874.51 seconds
IncrementalBuild              PASS      172.03 seconds
ScanBuild                     PASS      575.90 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/3] mpris-proxy: Fix possible crash
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: 01a5a268143e ("mpris-proxy: Add mpris:artUrl support")'
#151: 
Fixes: 01a5a26814 ("mpris-proxy: Add mpris:artUrl support")

/home/runner/work/bluez/bluez/src/patch/15024846.patch total: 0 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/15024846.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,2/3] mpris-proxy: Avoid session->obex dereference
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: 01a5a268143e ("mpris-proxy: Add mpris:artUrl support")'
#136: 
Fixes: 01a5a26814 ("mpris-proxy: Add mpris:artUrl support")

/home/runner/work/bluez/bluez/src/patch/15024845.patch total: 0 errors, 1 warnings, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/15024845.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/3] mpris-proxy: Check OBEX session proxy before use
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: 01a5a268143e ("mpris-proxy: Add mpris:artUrl support")'
#141: 
Fixes: 01a5a26814 ("mpris-proxy: Add mpris:artUrl support")

/home/runner/work/bluez/bluez/src/patch/15024847.patch total: 0 errors, 1 warnings, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/15024847.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2932

---
Regards,
Linux Bluetooth


--===============5090919241144388352==--
