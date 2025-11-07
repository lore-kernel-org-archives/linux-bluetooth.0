Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA33054E4
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511305; cv=none; b=d7+PuyQ/ljpgdve8II34IMbVacJJAeZpurJt1p6nioYtrK6a8+Oq6b2TU0jR5IITgvlFL120K0KU6Iehl6uLtVliDzVo4Bp0Al4lTMpFcptNgiUjcFCgMxmeg1kE5545W+ICsawsM6MYNG4w3KxJNWYwDqdWhzvV/NRjRvhj16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511305; c=relaxed/simple;
	bh=D/51doOPhMNwI5MMuP4PAT/40KLZ3l/q8KSMuafXBMs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sGMwayqVlpqFQlRf8fxEdOteGOe9J46N3JUvgs30AS7r2gyjXUFy2FyHZt8Z9Q5Dnv6rAWs8N0IkLk/NP0OvJz33GtMF3yXJWSdxQGsD3y6BXiRf2SByfOOlseeshmaAA8D/vBqE65icIijRv7BdKt2WKIqL58mB4qpI98JSimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ6xE6vG; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ6xE6vG"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-880438a762cso4060636d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 02:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762511302; x=1763116102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=46z51wyqDNbWlMToWXhkzMALXGSaptrm/ToZ3VUtpIk=;
        b=NJ6xE6vGzciBW0r5O7zVRFxdpEP7dYQXjNblXDGJ40Ky7XSbNIgjMzeR93MjrYjVJs
         M/VA0i9o8+NeX48qXTGf4+wskACnA2+eobLn8noqLyxBqH8ptKpplpXi4bbbNOEzVv+v
         Q6Wm/MzijiapdlDu6wEdsqdRws5tpDT3qD8B77nN6bXPkKmRQQ7zQ8pLVipjrI+Mr3rh
         /rotYzh0ZP64TYk7wWwPwrWGzhno+f4JQFoXrkDnMJhOhgScsqivseKxrj6KQpYvzoir
         D54+8B3eYEaqB9Eoy/UNXAk3L+74UQqa/kgh5kCRR0jFNhlyLGvZojJt/IX/xG9J9phk
         v0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511302; x=1763116102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46z51wyqDNbWlMToWXhkzMALXGSaptrm/ToZ3VUtpIk=;
        b=Bzv6P+Ewo0EW9J0lyG/usI5Qq9pMTT4m3Zdp0YLnY56x6lSwLKW9kpr/3P75EMy1rO
         ZG1foRpeYR994u0wVVsT4jIh2bLyscRWd6t8W/3Jg972YcpVlBfCIdp6zImllcxnGu+j
         pGdb79pSjzolDJWB0FCMjp0DWnCMWIORFK+EbCD10hLBFuiiVDT5b9FHeQPE1HER55AS
         /fvMrGe9w8T1MqiO+bYDJhqtKJSwkp3/gRCQpcKDlBxeATUpIuluRlFr7dG1GuqyjK2Y
         o1ho30padb1PZA9I2X8DuKLJ845HfuQe3O+EQ+I/F4veH2FktnDKKr/fm8RLR8il5Py1
         kBJw==
X-Gm-Message-State: AOJu0YxKYasFoXOP5EENl5amQ/tp9fvBD3g1zPYMa3xUtCHn1rnGLtq+
	CJCfO/Uqzvi+uc0/9ojeG04XkswSQFoN4wSHwVQcJ1R0mDy/pxXHi5bdFmaIqA==
X-Gm-Gg: ASbGncuILBOEjheXA7nwNwJY6L1qj7j1eEXL0hmPcnNWSAn6OhN5le5WfuMH+fiurux
	KDfS9kzbgUbrQjlp1T1zNXhQa4GfOuPqR620HzZ42+4ygIkMan0SpunwhHajSBSTaH/brwL8ciJ
	a4UpRrvzWrnMP0GS3MoU9Huidgywp4/eL6hMeRJHWll4H86ATT76HZ0z10Dw4NVi1GV1foxu+Mq
	Y/2nObMqCJQTIqof7FOatPl2M11ZOeC4zszPg6fo3BwXihx28BaAFBr3k6Rl/6CXgvVmlOdgcZP
	qh2uToB+fzZ5/E7xqOrEijYtdX1LWbxNJylPwpT9LkFJ+BTVVHYNJrM0gsDJQo+W3gKzZJ1KsrB
	gz8pXf7z6ZV2Pmk+mTLX+eTcnlLDw/HmMoftXXH9fuIXjTC0aNQNRCj3cbWvD1Lysms2Ap6ulKj
	+NviHbq1tD/j+cPjacIA==
X-Google-Smtp-Source: AGHT+IF3vL3F+A13adCuBz0WsCx5lF7UeAWn+b0jsTxCMQyxwmNRHPfBCRQKgv79vTwO3pHLap8kYA==
X-Received: by 2002:a05:6214:d4d:b0:880:88fa:d742 with SMTP id 6a1803df08f44-8817678270amr29006546d6.65.1762511301951;
        Fri, 07 Nov 2025 02:28:21 -0800 (PST)
Received: from [172.17.0.2] ([172.178.119.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082906016sm37031506d6.22.2025.11.07.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:28:21 -0800 (PST)
Message-ID: <690dc9c5.050a0220.572ff.9020@mx.google.com>
Date: Fri, 07 Nov 2025 02:28:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7016656184810299828=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pvbozhko@salutedevices.com
Subject: RE: [BlueZ] avrcp: fix AVRCP_STATUS_INVALID_PARAM
In-Reply-To: <20251107090016.89520-1-pvbozhko@salutedevices.com>
References: <20251107090016.89520-1-pvbozhko@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7016656184810299828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020791

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.64 seconds
BluezMake                     PASS      2717.04 seconds
MakeCheck                     PASS      20.58 seconds
MakeDistcheck                 PASS      187.25 seconds
CheckValgrind                 PASS      238.81 seconds
CheckSmatch                   PASS      310.37 seconds
bluezmakeextell               PASS      130.12 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      925.28 seconds

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


--===============7016656184810299828==--
