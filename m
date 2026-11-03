Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726018;
	b=K61qOUKjafBjP5j1IiuFrd9CJ91qOUbFrw/LUkYV+qHm6WWWG4nziAuKu3p7pUNhH4ON
	 JjVO7TpZojZvuetzPwibPJa59fWm5z5wetTIyw9SwJ+0s52UP4ntimN6oimKA6S0PlxdK
	 cv1Lc2EDgDMc80eay66x3UfzczEeSyADI2lbigBs6N4asvh3f/xPZ6HqYb7qJ9GknHjFj
	 xg0EIDQI28qVx/DtbKkOhm5POJNibC7M27Pdh2pGUrClGrefIv7tUSw3nhYeBFSIh9iBy
	 Hp/Uc9IKJbSXtLrVUT1Db/O/h6bPgXZDTi5F8dj+XGAFuAIoqmniczjFU3F7otIuuxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=fjNrS423GVaBROTVZQZCCTVGCtTFbVeOGdB4YXDABYs=;
	b=io/bunplhR/+QTPFspewpAzP5DbZ4O/zrOXfhh7WG5KDrY0hw6Sn0oJQBbF6neABLTuc
	 4l2r52TOVZ5MlVmMrBx7btqS/mnr1KL9A5R9wIM9Almtknji65j6UU5seeiFwvklg8+0o
	 wRJ79FrlEiku07zfIBLlHF0YWfsd934BKtlcBiqaAZgDQFhkfeCZORE7yX7ZIEdIZSKYo
	 CCtANYRRI1C3qURm9iyL0AY8K1RW+VXu15v01je9MGg9CBwwjKzCqkeg7Et22bCuV8t/l
	 vUTOB6W5jrf6RUGGuA/33OoINsKmJEhOLyRQNy5R0zfuiUX3Fi2aman9OGelg5rS18g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUTimhZO;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6A6082BE0
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A6A6082BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUTimhZO
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-945ae2daa3eso331718885a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793726017; x=1794330817; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fjNrS423GVaBROTVZQZCCTVGCtTFbVeOGdB4YXDABYs=;
        b=wUTimhZO91/PiV2Bud/J8YV3ztlsOOsLURlBNnuGzao+BxJVM6Ln4lFWrZaU95Zsf1
         oxTSELrzS3rHBIvLmp9nMS3Uu7sN/MJNSc4sfE95TT+qd/HK0Nc0Gr1+UZMOnv52vAy0
         EOj2ukjm7ukxvYZTzHYRA3CJ2Yf1dbGokuUVek/o0f62pYd0loG58SXtEj7bKJOtfkSp
         ZdenUfmwMDZoaiWlffcbHCfk3zezNN+S7xh5wVgSR9VRqQmRKVrHU8S4hhGCTA4czjO3
         pW0AOs8/isLtV81yNeMzi+9Uf851BNQvIxSWEOTCMg+re/ezfwH2r8vHDhrwKWA7wRYX
         pyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793726017; x=1794330817;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fjNrS423GVaBROTVZQZCCTVGCtTFbVeOGdB4YXDABYs=;
        b=Gy8IXCtMm34TavuWbxfy5uY9tao8azAZragwBKD3/ayWc+emzIfi8zBxzSJ6aDdU2U
         BRzxk1sX+3r+j8/z9mjzxs8JWhAPn4zSYRb/LHURhkpvRssRgDAdUNhT+4bBpVJaOHym
         ahJRTDGleH+nB7GnDNQw8v2R8a51GfQeePXqZhY6GgjZmzlopQ7qJV0BRYNenx2KYc4G
         pBOHJtxQvYj6c0Sy2Jvzti3yTOo0/Jw9x+NcWmJjN8Knv7AXiT8kd/+zLKnonzvyGnl/
         qQY3F7TX0ehQ2X5OGgKGe5bQLb0w5n+Or0P5OkIPJ/IvAow0lFCp61svjS7uYsxxxrWS
         K3Dg==
X-Gm-Message-State: APuU4Z802F9HodH4ksVp1/b5gPtUWcS5eAqJugwqiAwLz3LQRjMIo3I5
	KIXQnaUNUxSib9eksdOpyGdKQj+v/GVHO5C1JSdon9ujB3GdYDKC3JZaRsPVemz6
X-Gm-Gg: AYBFou2Rmi1Rca6jUUgNF1jeSTLFx/EGd8TIpstYPl7ePAub+vPwbmodiIhP0ZMeOpM
	25jDTj6WSKqqHQbppkPyNBNOi3H9qI0aIeTb3DgucLK+eI9stU4biornHbW4HfhufZJrBoh0eGJ
	Svhv8NKGgXyZ24Gs0e1nvSN+ke/A3d6bVP77Oeo06iaUtmUgKXJdFt13TICyDDGREETSxcyNMZu
	kpzGYU+z6nX4wvuSS+T6dds1XrdJ13jD4g8OW5IIp7o1zwtAR7M25qbmMdKyFDJMXcg705iXbzL
	GQpFkw/sy73QkKCaSXs86NHyjjvsEy9moLlpeZOvZiqtrmIot/m5QiujnZPtED8FxJhIuNYJcAq
	Sby18btcYfzpz+b64hTM/C87FQ0KmvClPz7DKb9RG91/g3qUUYkGUNTN6SyT6m9KCMmrce6sokM
	KErI/X8tGf7+sKjFEs8NoI4bZQfAJdrSKqTQQML0wpN+tlaDxpulVG3snmZA1QKCd6ttRpfiHBA
	N7WfwlX8iF518eJg+QGuCQpUYXWBLa9b0WFMEnYAZ/1ZxASIKHInmJcq00vRA==
X-Received: by 2002:a05:620a:1d0e:b0:93c:e83:6ba4 with SMTP id af79cd13be357-944217108bfmr2197639885a.25.1793726016660;
        Tue, 03 Nov 2026 09:13:36 -0800 (PST)
Received: from [172.17.0.2] ([20.119.87.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d327dc96sm12559485a.5.2026.11.03.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:13:35 -0800 (PST)
Message-ID: <6aea163f.a37de931.20a066.ab6d@mx.google.com>
Date: Tue, 03 Nov 2026 09:13:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5745097374824843203=="
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
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
In-Reply-To: <20261103143759.555315-1-kiran.k@intel.com>
References: <20261103143759.555315-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5745097374824843203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200445/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.55 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.63 seconds
GitLint                       FAIL      0.70 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      31.54 seconds
CheckAllWarning               PASS      35.53 seconds
CheckSparse                   PASS      38.19 seconds
BuildKernel32                 PASS      31.29 seconds
CheckKernelLLVM               PASS      35.78 seconds
TestRunnerSetup               PASS      764.06 seconds
IncrementalBuild              PASS      33.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
WARNING: Non-standard signature: Assisted-by:
#109: 
Assisted-by: Copilot:Gemini 4 Argon

ERROR: Unrecognized email address: 'Copilot:Gemini 4 Argon'
#109: 
Assisted-by: Copilot:Gemini 4 Argon

total: 1 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14940452.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()
WARNING: Non-standard signature: Assisted-by:
#111: 
Assisted-by: Copilot:Gemini 4 Argon

ERROR: Unrecognized email address: 'Copilot:Gemini 4 Argon'
#111: 
Assisted-by: Copilot:Gemini 4 Argon

total: 1 errors, 1 warnings, 58 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14940453.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()

1: T1 Title exceeds max length (82>80): "[v2,2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()"


https://github.com/bluez/bluetooth-next/pull/1054

---
Regards,
Linux Bluetooth


--===============5745097374824843203==--
