Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E821E0BB
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506194; cv=none; b=R26vjRyF4hb85D4jQ508I5W1iVSTP2uojm7q7tr+ZoFa0DoUamk6Rid48lHi46NKsgTVL2t5IvoYkDjaS11o8IrcGaqGqrrzDvKdoRR+BIeve6yJ1pzibhrbP5daLrcvV7KutIInNidup75B67CAbEJkiXG9mP1mZHAPnZOWPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506194; c=relaxed/simple;
	bh=zK7JS2zTnpfAtOkd0DHcPBHIFS/kVoJzPULkctYKzv4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AQWs9AJ6Sbj9s1FfkRMYP8N8qhqA/0Tbv6Xkmh7PAxktQDjG+wPQyBpb3j20gYMYwjijPr+FukDxvmRuxM45RmY0nMu62AiNAhkFx148qMPdwNJitP1JPixeNbPgf/I1Bhi4LqWyVYXKBAwoZSl2kwF8cWJuq5l2ATvBzBA1LHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0p4ol43; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0p4ol43"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c7336ed99so1277738a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 21:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746506191; x=1747110991; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cTHcJe4J6B5KuoYC1E02PDWuuO7MI6/medGe8PlaoYI=;
        b=d0p4ol43knmnRsHJuggIITeV3D28s9H9a7ERaWi+F9Q1zNIm0/ZpAL9945OjU/Agx/
         VYIqhJGtPcFZqGsnI9zFs0abSVzH7p/QGI56YPhwBiN86L8Zz72PRO82eUNYX18pJTAu
         /JIuRRLO6H3g5Xe8bLIKZg/6ltcXueYDWDyQbeMnqjl3MStIRfgzfd3hTsfVJarRTHpy
         1bYY4o/0nOobpk1Qb7xEt1e2vm7O0jEbtKnT+14VLzJXhiI7y+nFzIKdQFvr/cff78kL
         ZKLxW0OqNTNrFpAGqCVUB6USOSN8xlNJ2nVk+u0v7Q/8AqOW+OP2gUVH986+GVxX6Foj
         npng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746506191; x=1747110991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTHcJe4J6B5KuoYC1E02PDWuuO7MI6/medGe8PlaoYI=;
        b=UGhaYR9M89VK53nh87ZXyfTWhmXV2GaCpPNJhLSOxos/oSsVncU+FidDtbPJkZ29MZ
         TWTTdbHKiw4FxtPncYA3tEn809E9qQJfyUBOha2HnxkOOmC+uwjxj9B98xjfGbv8DYIa
         fz4vZ5q6/VuhRcnEK1f/s7xJhoq7IPnyxnHBCQ1G+4qeJcz66fkX6KZ6aF3DlnMyECTS
         qQxK+WVc1y5F943k1AV58nnv9EegEzrh3DMn+oEidpiyqoWseUv0tNVLxXqy5gyc0Von
         kf464kjXV/CMJ/uSOH/5WWvRoIeP9y89YajI5O1PB0eRgf1vcVIN8MohSW9jFTLsth3s
         Dcxg==
X-Gm-Message-State: AOJu0YyZBqL2MW/Jp0EVGSurirvsqk5YnI48jFCUJlmvwPz86jO+2ZGR
	9hXr7OlzY+pDsvkqhUC2QHtF6Rydl/BIZMF1/WvsyMdAQs0ZjWnf7uSwdw==
X-Gm-Gg: ASbGncsAYh48qjpEHiIKqR67P5Rj9l+WuI1JhL7CuMPQlpdx5qXcc6Oo6U4XjaNXJX3
	Lvj13FTJQx3VkJPM1j4E1WrwfeE/aPyN1tn4WBJZkTo3/1BZ+CaE0T7CKwnF0f6aCtOAG4BhTmA
	Glm5O0gDtA7uQXIDyIQx+pmdJh1FflSO6P8UnX0ywhM+sPT2vJdXJbm5DjT2N48QHd2b2vvxQLH
	AQpS8MTDD/yg0hGsTe3MrnRFUkkSesNi3MxRBRpbUbw6i0RZfD0OlDzRviL4urquSaiZMHd6EEL
	KZZplh40NaMNbOFhwaWJPh+lAcVnE6tg9oBMTd8DqqGO32s=
X-Google-Smtp-Source: AGHT+IEw1/Pg2QiCxHbKAGxEOWDBBBcIBN0MxEpTANuBpKmNODsfzevHf7bEsSiq4NXkeLTfCMwTUA==
X-Received: by 2002:a05:6830:6317:b0:72b:9316:d593 with SMTP id 46e09a7af769-7320623cc19mr1189725a34.7.1746506191634;
        Mon, 05 May 2025 21:36:31 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.189.156])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d31cb7e1sm1874837a34.27.2025.05.05.21.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 21:36:31 -0700 (PDT)
Message-ID: <681991cf.050a0220.22ebdc.0202@mx.google.com>
Date: Mon, 05 May 2025 21:36:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0611119873984060988=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling
In-Reply-To: <20250506024822.327776-1-en-wei.wu@canonical.com>
References: <20250506024822.327776-1-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0611119873984060988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959837

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.58 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      26.50 seconds
CheckSparse                   PASS      30.16 seconds
BuildKernel32                 PASS      23.80 seconds
TestRunnerSetup               PASS      454.90 seconds
TestRunner_l2cap-tester       PASS      24.33 seconds
TestRunner_iso-tester         PASS      31.28 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        FAIL      119.10 seconds
TestRunner_rfcomm-tester      PASS      7.76 seconds
TestRunner_sco-tester         PASS      12.90 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      7.06 seconds
TestRunner_userchan-tester    PASS      5.26 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.234 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.135 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0611119873984060988==--
