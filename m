Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F83274658
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039168; cv=none; b=QZDxJkon+q/HGCtXG1f/YxIjFupRzO4GwMEolk6mYXFfPBD02LTgfUOoBSq7Kc/krdu4Q8cTt9w2f84oUF8rB3hIeFGOLnZHNwjFiPIP8AqX1SGqJry/yJA2bE4/yKrZMYXWn5ZkgHHw5+8mMpV5sjXgqZTVIaWMcTmYXbxMERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039168; c=relaxed/simple;
	bh=0/G/yQSkAb4SJWYXVnR/FBweMLYUOuskMtvvqOGCu0c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gylV5PNdSAuma4WnFCD166gsjSd2VGv5MPgf+aD4nuNGbx4L6kMxmKDDaJQQpwq+fLIIOn4VcudOAdfeBspRxlrh0j35E3oU+wwLrNHwtcNPVmVCDquVcrCtDvsGRwn+khBUGMaO9yW0eMhs+xKGwnGE7oAIGvvkY7qB3M33c4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=himLMnJD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="himLMnJD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70d9a65c328so18307676d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756039165; x=1756643965; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlIYS0+U9bHihqOk3JtnTtwySyXP4jy4goOuyMXyINc=;
        b=himLMnJDhKvRj5L6mlEcHtJ4Ol3lU+sdhBaA80yKoLU3VdDIDMHjT/plT/Er3JenE+
         MS8U32pT/rrtxCX6pB6zFoUs3Iw4d1euw5vhJAzyJQOfchNulaqbf3DZpjzSw8MqtSU4
         0Y4roqyAIkXTf9amOLLlR22GlTwVbarT4qbbUckfwLqQ7Htn+hR2yJB/fuDNpzGF1JSP
         16tIn5NS2o68REYKnaJh1/skfmr2/uUh+T3FmbTaE9R8OfaVEuX5nNKUEt5rKMJCSTrm
         LnS+5UqyiXSeJc5zuROfW5HW3DPHFQplr/vHkGQlfg1VazSgPqU7q8iXn1X5LxudEvC3
         2yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756039165; x=1756643965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlIYS0+U9bHihqOk3JtnTtwySyXP4jy4goOuyMXyINc=;
        b=k9ndBNn8AXMUkpPsUsKP9bZ4zAVOQk/PLBgLEtctyBX3eaXYwRil1pKsVhu7KL5P3l
         8q9GKT+PX50IFQkzX2B/rgeQ62triPNWWZJsn/dKiUvBqvYBdM2q9HmSi5Jf4F8BkfSz
         8VIRi/qx8oen3ho1tkXw+rX8YtL47N/JuvPqLDlUUSap12YmLe0ToN5crGx/G3og7ZlN
         CmXudcTX8Dk0w8IJpnyoFEJtqZBMPC6OOfjOhAMfEO886KzAk3MBwVI4GVa49gPllTZ6
         xud3XU5lY++bGqWe8kipcGrW512tbRDr88gwVXCUsJ807fW3eFJC15R3YKYk4AFxZj0X
         1grA==
X-Gm-Message-State: AOJu0YydwUVwX69Stv3sm+7Nj14W740VmxQ6XC5EFof+GaVClB2wu4qZ
	gOwqf1xB4TNVwbpifpYdbz+kXlHHCX8tAP+0TatIZJqis9KXSFvrKE+agYQ3Jw==
X-Gm-Gg: ASbGncvDsezNk7jBEuR1RaDGKrmrtL18aZlYUn/dPkDUt89ie9Iia/CPGuoKz20YFmZ
	CDKoM4UQhDZTVO7MWAHEXQojBXTQtY8LidR534zkpE+fRUHMyKAcOYUuhti1qsdYV+uQKj+NuZn
	ug1iLesCV+K8Doi+2f7tl4bM+PvoCwOUxj71iA/wdvokP98L+VOGUxNrTcxOLpTa/ghLuvJfMRA
	kxhW9oA+IOaIgUNr/aHmdHnxQkFsBs51ysFQJSzmVEQivyYUAJjwqFWO4ybL6ng1QCCShh2caK3
	hFA4Gpmg++176BRKPflK0yuvsomeS46aDUbyggDLLn96gk/UwrOotWc7VfzdAhW2O2QFzLNXjR2
	qtzag1Xo9mbOFSpADW4ooat9nKw==
X-Google-Smtp-Source: AGHT+IHLlDrYlwoSf7GbWJgUKQm9fQl1hQ00dFzMKF/0BkrWnP8zGIGm5vT9cpUS+jDb26ikgoJdag==
X-Received: by 2002:a05:6214:a64:b0:70d:a309:640d with SMTP id 6a1803df08f44-70da309b121mr67564546d6.61.1756039165318;
        Sun, 24 Aug 2025 05:39:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714727csm26971316d6.13.2025.08.24.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 05:39:24 -0700 (PDT)
Message-ID: <68ab07fc.050a0220.28fb10.b184@mx.google.com>
Date: Sun, 24 Aug 2025 05:39:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9092363566564016627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] lib: Add Bluetooth 6.0 and 6.1 into the version table
In-Reply-To: <20250824111932.270868-1-arkadiusz.bokowy@gmail.com>
References: <20250824111932.270868-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9092363566564016627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994927

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      2645.43 seconds
MakeCheck                     PASS      20.44 seconds
MakeDistcheck                 PASS      186.51 seconds
CheckValgrind                 PASS      236.64 seconds
CheckSmatch                   PASS      306.80 seconds
bluezmakeextell               PASS      129.71 seconds
IncrementalBuild              PENDING   3.34 seconds
ScanBuild                     PASS      926.18 seconds

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


--===============9092363566564016627==--
