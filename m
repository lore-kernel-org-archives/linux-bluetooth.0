Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A835D235045
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849893; cv=none; b=rF68aSmrO/dnJx0W3/rbW+TbGBzDrsfZdheX4+HsjIWYPAMTqqRV9UNysNYtxX0zntIBP9jTwCFI+aXsFPS4NJbCN/B+wG6lGzN1yBJeXzTiy7fVZX7pueVadvnU40smHT5DAogxlnRHGqnlIBGx4nsZ1+qc6OTkn6V1BnkI9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849893; c=relaxed/simple;
	bh=00Wd44zLPiHN/zL8m2cmjhAA+WZh5hKrrVSzORHQX2Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BTAFd1qKX8i97UF6+Q5wSodcbsLhrH9lCkQW6hwQpDJZsXTRonYbcrTmEoO2ZilbSw6ksxjBG/z0ceyLJ7Wb+tUl9yUWQUZQsNEtAy1ryK2p3pl85TlHVXH3nHW5Ht5B8nmzZTdDXCdlBqxB0n60k7h6EDWAJkOF2ecRDLg3N9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIha9+HT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIha9+HT"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b553412a19bso937917a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761849891; x=1762454691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n+DvsUSrEQR/ORGBYQ+jqG5QOMV2jlP4JWF17FJMAkw=;
        b=mIha9+HTYukKXmrTaxVBBqyJrmuLLDUDiIfjAEXtkV2fqJgK/a4EpgJjq9ghBPlkTC
         NYSEM+hdULlGb2EVhytNpmy4YExZqqX5QAY0IJR6j/O92ZePl0g30eMM6vxQ+CAhlkYU
         n/mXwZw0QibAQqrrqiWzSv08AODDKPPW2iPtNlnIanojJaasTPVjVU5eRoccIVxnvqz0
         sN2MxdPELe3QwCcJaZfznUyN4so4kY0P7gR02cSvtYHWy2tu4rCm2ey4zoIRAERLLad6
         Q9XrW74GMV9HnNiKOHrQWiMwqDkWt0Mg/HxoMrO4hI6o63dk0A59I5Yo5Mmt2M/Eb6FO
         g0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761849891; x=1762454691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+DvsUSrEQR/ORGBYQ+jqG5QOMV2jlP4JWF17FJMAkw=;
        b=lbL2ffLtneUAzd6fwdTu7mkmGWL3116gu8Hm4NQq225vm8isZi3DGroskgoO5/lAbW
         UTd1FbljJounbYQzgEsBY37QkYtVjJ6Mlqqq0O/V9HNxQW9Y0dA+sYGNivLqZkS79vcX
         brHjt+uphsRKWXt+E9BO1LiTPDAowKQpAy4+z58xhRU6GLm5y/uTxDzd/nklGpyDEDOT
         Vwm+cal/+qkKvxm9qXnZ/xCUrYsZraF6DhZjS29dhC8vu8VUlNWrgia+yEWYaLaq9rm/
         Y/wr2AoYblF//5wGrYpU+z8nNaqpqhhThRqZE2wgVMWVsiFezfmA9i7tpwpidHMQR3Zt
         6SDQ==
X-Gm-Message-State: AOJu0YzLmSsd+MxrHZjtGmG2+bpXJDANfdbv2lZbpFiG2KMYxcFCQjba
	/nleVwQxw5ZoD4elzSRkFw8zSAtxgaeqjGOKHaglJqagv0KqQSkfT2UfzLMVHg==
X-Gm-Gg: ASbGncuDVlWRD1aDYXQ9DShP8z4z132RYRQHefIYeU5hkPvka3bHSbEYaHOeOn+QIvB
	KeMmiJvx4rtqNUmNyRdiXQU/GXLu5l51k7h+9qgoXUKnBXX3NwNuF38yaQrm/dtLuDWIoi43BV7
	HCOeT/rY/Bnrk0Jm3GX81ABUsYBiE/QKuIv4YZKpErYPSzL0GoE106GEc8ruA6XLIPYZkvEKeeY
	pTIN8oTssyrfxbzPr0s3DRKEWmfLeh+L4KlGUe0/oIDJtRYJ95hRe1u7wIpWz9YWo+6bl6/YDDW
	bTl7Ycu4gOlZDUybrlkc9q6mqv1UnXQVjojZ5pj3797mnPw0puwpJzhxfFxEix6/11/7pZYpYV6
	cS1Jrfd8HahGre3Tj2Pn+Wwyzvk5LU3PajRFh3Ow74CkIHAoWr1BVx6DN+k0OzN9e8rhRhAL6Xy
	ZPO1nhQxl8
X-Google-Smtp-Source: AGHT+IH+yZo/IjW46yJ9N3cmwHzldq5YiNS3E+skYSZcawcWLEQlgD3rlCY/GSYs6lv6XQaaNZj4+A==
X-Received: by 2002:a17:903:2282:b0:250:643e:c947 with SMTP id d9443c01a7336-2951a4d864cmr10631185ad.28.1761849890303;
        Thu, 30 Oct 2025 11:44:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0abe6sm193845375ad.34.2025.10.30.11.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:44:49 -0700 (PDT)
Message-ID: <6903b221.170a0220.1f352a.d2f2@mx.google.com>
Date: Thu, 30 Oct 2025 11:44:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8714439996852028752=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] monitor: Add decoding support for LL Extended Feature Set
In-Reply-To: <20251030171009.253408-1-luiz.dentz@gmail.com>
References: <20251030171009.253408-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8714439996852028752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1017831

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      2568.59 seconds
MakeCheck                     PASS      20.13 seconds
MakeDistcheck                 PASS      183.58 seconds
CheckValgrind                 PASS      237.45 seconds
CheckSmatch                   WARNING   310.62 seconds
bluezmakeextell               PASS      128.11 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      923.70 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3852:52: warning: array of flexible structuresmonitor/bt.h:3840:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8714439996852028752==--
