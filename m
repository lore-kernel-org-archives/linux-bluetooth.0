Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222C1DD0F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949161; cv=none; b=bv/uTs1olAmnM8FCuYIK+cKOjM3kXjkSgemkbhiq4mCus6O/DYy+J0i42XMFy5tKvS9mrWfi560LUOdu9xlrifRD6UZHp+MPNAf0PxFVfiUtiT/BUb5j65PBGuuCerS6QhDb9SeOImguxmfphOhei5oyuw1TPl1M6xPgZOWGQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949161; c=relaxed/simple;
	bh=c/35DPVFvQJOgI2sHAoCkJLl1+WQHIpDP5WP8hSec+Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Gwwzt38/EIps4dQ6WOuxhxvdJy3cM8o37RR6NOrLeIuVarPxgjJqr4Y14mnvGJVBebqYuVi0YFb4uPjVPyN2urRmCji5k4IL5YNSngww+Hcw4CPyq5ScF0Vbje/gsYQFDz8YPxgZRqdXnZ4ozCPDlIGzjTX92rkPVvY5fayQ9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APj8u4L7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APj8u4L7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so3012125b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733949159; x=1734553959; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=apgFxlVsetWtGIj5mX6nyMctiHc4iPmCxFeMXN6YxSw=;
        b=APj8u4L7E1+1dDcWC352kCs7voJEMGmfU1n+t5+rZWp06ebQ13vQnunjTS+zSdu4Qf
         /DixH9cRAWjsJXGHFjH+vMEaKCaN3Bns2Md7vVVxDWTwtBmUuakJ7Uq5i4NK8UfIFYFr
         c26a9peB7D+Tp6P7KyOooh0vRMNdCUvi18AiC7dTu7gwbDL060ozIVWOxPGqjhvnCD5Q
         T9ArIpvi3CLlNtIifHPrSxGw/8If0PIMCq5s7OXOHddB9xA8/Z+YnDS6Kgk5yP551cZe
         IMzO+pM0YmbpkUfEW1uMzKCMHaUmKkfNB5lBUtitUELMUxJBHpeox914EeSkPWCRDyEm
         wM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949159; x=1734553959;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apgFxlVsetWtGIj5mX6nyMctiHc4iPmCxFeMXN6YxSw=;
        b=hCY88ukkzmsSkZqg3r4ChEX/lnCO/U8Sz8cj+8PChodH6H0+3WyL8oT8eJc1waulAt
         Q3Llkqbg7mZxJMFtw8y66mJvoZ49iwaoC2C0fV6YXBfcXfB1NicCGlfWCMva0i8ASAvp
         Fd71Q0qhQdf2sNjJT6iuu9U6uX0uaY5HiRMhm84j9++1PtkdDNwZ2xBsxP23Sn26gjzz
         LYXndMGYxDVnzh+PotBHodCRyYM0jT1sRFcu4VQYJA3qNGOsv1/uM54iBIJDKXKnPD7p
         XROUPUVnNFbqPi+nNTOgIIe3gin7Un7Q7Lq8s3b06YkC4xvmAXWCl+ODhlBcFc6F/3hT
         elbg==
X-Gm-Message-State: AOJu0YxydxanNQCIljFdB7xPpz7KLsTb8B6bIEHnX0hn7vJHBCI26ty+
	BwAQr8GRNHn7TVkiECoUxAS4CZYtYZPYz0wVYcrzImzXZfuo6iwQ5k7g5g==
X-Gm-Gg: ASbGncvTsw4Va0dTxNfd7AQJfDaUO2920pDorUZM4ZWb+5Q7kylpfYhjJ2lLR3CHPkz
	sDb8Ltz2hGZbwtW1ArDabczQBP+Ng8dVIYmGWmJimqg+xKMpTG6Qtz7OqUVB99Deaqe2o/cbBQp
	qzpJjolFxhqOqKnNynTpAONbvdf7nQMbf7Hxsv6dvcP0xh/ZYkUsrrwrpkBCuWeSLv102Ph4LU8
	/RaqtZQl6BnScnO1LPJ6vPOkVRe7e9GpLb+k8NpVcrQ8hUe1jX7wHxmKQ==
X-Google-Smtp-Source: AGHT+IGYlNYJ+uMrta/7ShIOT0a3iDs3mRJQ1HU/D6ZjblIveLpGWHkrucaMGUiaDUzwnD3TqtEgKg==
X-Received: by 2002:a05:6a21:328a:b0:1e1:ae68:d8f5 with SMTP id adf61e73a8af0-1e1ceb1004amr946361637.26.1733949158757;
        Wed, 11 Dec 2024 12:32:38 -0800 (PST)
Received: from [172.17.0.2] ([13.83.1.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeed027csm5705810b3a.131.2024.12.11.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:32:38 -0800 (PST)
Message-ID: <6759f6e6.050a0220.16b0d6.365a@mx.google.com>
Date: Wed, 11 Dec 2024 12:32:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7733328684342460847=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] tools: Use '>' as prompt end marker
In-Reply-To: <20241211192210.1864347-1-luiz.dentz@gmail.com>
References: <20241211192210.1864347-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7733328684342460847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=916922

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      24.51 seconds
BluezMake                     PASS      1618.75 seconds
MakeCheck                     PASS      14.19 seconds
MakeDistcheck                 PASS      159.14 seconds
CheckValgrind                 PASS      212.20 seconds
CheckSmatch                   WARNING   272.75 seconds
bluezmakeextell               PASS      98.82 seconds
IncrementalBuild              PENDING   0.48 seconds
ScanBuild                     PASS      846.42 seconds

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
tools/meshctl.c:324:33: warning: non-ANSI function declaration of function 'forget_mesh_devices'
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7733328684342460847==--
