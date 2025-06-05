Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE4727468
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112252; cv=none; b=HExEt23FnIqKNdBMVA9riqYXsdO9U5C9z6fyTxP68dqQASgCBk+8/0iFcGYB15U3IhQoe0uqT0Q4FJpDSjM6TG5lH9tTAOAo/Cmrm1d8/XgkwbtyL4aLyFQ3Xj7VYLW1seS46mIRAFl2QlQmHuoN7DcH8xOYlx0gFlliIi2Hg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112252; c=relaxed/simple;
	bh=HkYtbbQjZo/XnMKTrA0BvPF1m3zXQZheEmygU5iD0eQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M4QJALzpZXykj3s06PAQ/D97MLuRoc4F9/40e4BQs/hS7ORzeiavGo5jNd2F6UA92LD1ewKCyuoMthJD33aYhGiQvC+mzIBCUqShmUKPYYl3jMcGEEjyzkUBw9AMHhn5iwu2G/OtwJZ41KNF3ISfzfyDXXWue27kJ7CUwmBjE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjjKKQcO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjjKKQcO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a4323fe8caso4086541cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749112250; x=1749717050; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JmJXJvnhkgeBzOB1nKmRH8KZFf76YTVJyD9ZB/8UZjc=;
        b=IjjKKQcOavBRc3cZt7Sg7ZquOahkTJF8eqDyd6poNI5TfNyx0YHX7kQiEwF7TsRTRx
         bjZuUbxrdW2vqn2PkZI8P+PrRTp8lFifub9PiRxtF514EvYC+q9bLkaji0RJOqfE9hY/
         mAF7CyY3gQrCeZEI8Ttd3G/4JlL34cYESlOVJA//2L7xwMMLT/KoEX+Rq1K55HS7WrVF
         yS5vA8dgwXmsbIKx96/ttizkGDlmsSKKfP0LX86ovxB83TZCWnrXRHPptiILHCVHDqHR
         2JAPmOFRkgZKA5dlJGyRl8Y/QEDZlKM71v545djEaj045rH5mVM7AmIYXPOZLlVTEBGi
         ArWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749112250; x=1749717050;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmJXJvnhkgeBzOB1nKmRH8KZFf76YTVJyD9ZB/8UZjc=;
        b=EIsKAVmevF7GJ+AY5yKpIfjJzjLb31m8VgHNTwD/0iDddlJJuupEicaX2cHpL7qi40
         xI7KSOMk9Vmn48YI/He0uXkI6/jBAKU5ZqbShNl/q4Y+NLdMnNSO0tirfZ5yBkCZ48/o
         Ip21+UwbF8ADNBvd9Gua9vawzJdl9JDBRfeIaFpNJ8mVWEhitYK7AZ1XjZo/4uOdXhgi
         RFim7wSG+7LTLJxyK1gjlhNv50VtAaC5GEBc1stit1+liEWW7R+UKNLs4swxxovIXjhK
         JKbW/VLLY5iRfODG67xwacLyg2d+kA1a3s06qlhcuxJO69rq8OO3bFqgmX0kELSd8rLS
         i1kA==
X-Gm-Message-State: AOJu0Yxr6jBdHC/4rEnkMNP3M7hKMVJL+ZRJejRbNdWraot4MIiHfCba
	rS1A2tfeFtgNgbaId0TuxqfWd1bqx+fW3JMNVrPzzsWuejColTropXMMwUDsFw==
X-Gm-Gg: ASbGncsZ3elk6+0wUDms9EO76MwJuoKL26+ZU2XMIN/9lHIa+9nwsAGsvohiCA3CPCT
	VLiJ0JNF7FlZZ7qvGGuYlympCo48WE83brwgp4eS1AKGaT67/mp7Uk+ybzEtNcVReN6//5AZ54m
	otXV0jZwhZONbYs1pcVC/WMpEPweeeNkaVGFzj9gTN2iJmU4WG/CcRNOt5VY13Fdn7F3PFZ1MLs
	cPyRg3DZJWTcyBriDACjBKLKZ/MrpIkC/RyTk4/4y6dkWm1msY1ekPdgLD1T0rhzPreebk3aHxg
	2e1A+7WxdRtQUsP4wmuLvUR3/B8eyFOVnnBX0NzawWr3R0AFblA7FVxevD8E8n+28yX3
X-Google-Smtp-Source: AGHT+IH/awx0toUU7BarFZ0RwmGwBEbcNiZuuQLZ2AAiJuUaj74rIkbJRono8UXA7Gb5F7SsJTppRw==
X-Received: by 2002:a05:622a:4d94:b0:49a:8542:b496 with SMTP id d75a77b69052e-4a5a57bc901mr89736851cf.25.1749112249576;
        Thu, 05 Jun 2025 01:30:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.55.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a8435esm107407831cf.78.2025.06.05.01.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:30:49 -0700 (PDT)
Message-ID: <684155b9.c80a0220.13bf94.ff8e@mx.google.com>
Date: Thu, 05 Jun 2025 01:30:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7918501830137405229=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, magdalena.kasenberg@codecoup.pl
Subject: RE: monitor: Add support for decoding Channel Sounding
In-Reply-To: <20250605065913.1446880-2-magdalena.kasenberg@codecoup.pl>
References: <20250605065913.1446880-2-magdalena.kasenberg@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7918501830137405229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968819

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      2632.45 seconds
MakeCheck                     PASS      19.94 seconds
MakeDistcheck                 PASS      197.92 seconds
CheckValgrind                 PASS      273.48 seconds
CheckSmatch                   WARNING   303.07 seconds
bluezmakeextell               PASS      127.24 seconds
IncrementalBuild              PENDING   0.22 seconds
ScanBuild                     PASS      896.85 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1876:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7918501830137405229==--
