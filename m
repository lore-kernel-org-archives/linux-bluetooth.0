Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CA2848B2
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407854; cv=none; b=PCHgEO9fah2nuUxkYIjET9VhY7X0bMBWFLDy4EGdB7UZcu7lJHMt3eInNfgraBVikkcjRbPVpgNttjYpyoWjokauE7WpuHcPpbcXUUu2WMolMMGKODYv+96KeRvMH4zX3NTyGg06bNxS3J3w0SNs/yl2IGZm743T1eRyZ1vCB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407854; c=relaxed/simple;
	bh=HRiOsPEhB1phTyCpWIN3nB24HGrm2DWlYB6m104+t0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MX1Jjyhi8SEDebCTe/ROUhDRctUXI8iUq/V7iyroOXdkiSaQIQ+sUR5T6wtFLTZsRZ4wjbeLdsoFKYcaKc7VQ1MCzHl6+q2KlxWTXtnAeZWVifclBeQauuUPdmDyFkt/fDOEyiKkECTQAiLMgjuEPC+ueCQxpRQyGcYV/BQtPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4jpC1rD; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4jpC1rD"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1233bb90317so2612266c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Feb 2026 11:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770407853; x=1771012653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mHSf76xGNHr+SN0jXyCPYa97CqDhl0RvUV63o9ivkAo=;
        b=C4jpC1rDJBCPcZMAoYiHqvd63JsPvADiIBPSihu/1NLF8Q/uhisSYfTWOlJQayYDi5
         ayeDsmbFFQ0Nf3ALLRawno73MxoFbbJ1F8VFpEZzuO1l1Sd1kqAQkgJOf8qto5c/nOUo
         wsI84Vk0zWTmsY0RJJ2vDvrfvMBlxK9ANonuM3SMrCdJBqXTtXfkGu2uGMw/AV0ipyqD
         8c6RkKQL5rkUCAJ9eR/IrrxfIeoqiyrWMEELCLyeOSgo7A56NSOPmmPJfYPwPUBgZLw3
         dhAk4OJ3TB9DG8fxDgXf3m9BQr9mla6946+PhCUULNOAsIQUfCM/+D8/OrOnbeT+cCd0
         sAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770407853; x=1771012653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHSf76xGNHr+SN0jXyCPYa97CqDhl0RvUV63o9ivkAo=;
        b=IkIvgLBoevzgXBKhwuDZW/GF6r7rNndo89y8SHExSuwfLzfeYn6BGgQTDLhTdrh8AQ
         eynkZHTdv3kFbmyByXdX6BaPM/HE4eTFuf06xQ4N2WDRIemxwqtcLUfbQM/kW+iZQP1a
         2GVVV6VUVcIIFe9+OPAKyIYBGkQJRjtHQm7hUetBRZFZ8bc1jGKpo4ne42ug625pkClB
         oIOnUegbO7zR5v+xxNTBSzIlXFHtm00154GPQB6yHA/9p487ABPC2Lf7pdjDOaFsuPI6
         yf9Ng0J9s3jQfJkLv0ZvKxvhLH2UfuC70aiDVWr5wGc92zq/2jAQlYFZoAVbeFdgMJDr
         R23A==
X-Gm-Message-State: AOJu0YzBSvU68/lzXJtIf1vY3Vr9LiCzCCSNPvXVeF6/MpzcwvXxvjsY
	B1LcPLmNzlLbmaxUPqDPpH5NghYcmwoknNx6kfJgholuRyirCqdnvwpPtlJ44rdA
X-Gm-Gg: AZuq6aIitI6KqkPHAva+K9tWZrkFupIL2/O8hR+UXwF+7ueQ5R4zHeYWVNtepL/ynpT
	b5wjv/grujrh7yQsKfHjdsXE+6M0xCQtTT8ZkREX5rv7xQPmH3QyUl34FCVMjq8n+gLNd3Ineew
	tdkeGvxlWrlxhjX/t4pqyvqCo84CjYeieJ/ur9rukwn+jaYj/5frvX9YSY+5h1md77lOajR3gSq
	b40kqeVCzSamB8smQVlMBVxsSFg0VoJFgkjN+E1cOHrZdeRKGOoq/XdX+8d6d3nYtGxGS5x2dlU
	S4TQpm196hZFfL1CLqj7lPirbafCiv/YH70d8lLYgvq13YE0PSNCUme70b0HqUerOj2c86WVLdR
	Fd18cc/dZ3mZ2hfwf1Hfm2kJLnV/2WQw4EuezM449VEmNpsYY531lUZK1KHLh1xBkWN0gJztszH
	BzaP1RWuNmYJgzq+M=
X-Received: by 2002:a05:7300:148d:b0:2ab:9d23:f0b1 with SMTP id 5a478bee46e88-2b845c43f75mr3077340eec.13.1770407852515;
        Fri, 06 Feb 2026 11:57:32 -0800 (PST)
Received: from [172.17.0.2] ([20.169.75.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3db4asm3183223eec.18.2026.02.06.11.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:57:32 -0800 (PST)
Message-ID: <698647ac.050a0220.32cf0c.9d85@mx.google.com>
Date: Fri, 06 Feb 2026 11:57:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5334353373598868791=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] l2test: Fix not being able to use -X ext-flowctl
In-Reply-To: <20260206190345.329635-1-luiz.dentz@gmail.com>
References: <20260206190345.329635-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5334353373598868791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1051705

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.49 seconds
BuildEll                      PASS      17.67 seconds
BluezMake                     PASS      631.38 seconds
MakeCheck                     PASS      18.24 seconds
MakeDistcheck                 PASS      217.45 seconds
CheckValgrind                 PASS      278.03 seconds
CheckSmatch                   PASS      312.23 seconds
bluezmakeextell               PASS      166.72 seconds
IncrementalBuild              PENDING   0.43 seconds
ScanBuild                     PASS      925.76 seconds

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


--===============5334353373598868791==--
