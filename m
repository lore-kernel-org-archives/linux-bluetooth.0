Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233683C32
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926433; cv=none; b=DdUH5jshaoRPib60nW4rzswiucffRr5a7bQn7HTO5WcohP7dHDdg+tFcbW4gyxzcUIQXOlgtBIzZYrMg3S1JXshUeDFxwzWo50b5Nf6MmWd4VMwrd9yuoqtya2vdxXBVwDkqAXjXd5p4c0et2q+w+vTHRTVrTqMvqi0S4HdFCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926433; c=relaxed/simple;
	bh=0E2CM4+M6uHDijqHTuZEXjJqi6L/BsLSuK5fcImCDOk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lhmpg2p52bOwEEt27roQ0nuRGDFNG7GKiZZoiQtqtT2VW7Pn4tSe+Uh7YebOBj5V9gHJRD5KAKSszrPU0kDeulE6JJVHOmzXmQtspGHsxt3v1jred8tobplRJlrcq3D7bPj4HIl0fgELrjJ8BWEqJnSAw8TIiJExc3uHYu32xBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO/NF+U3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO/NF+U3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690578e13c4so11498966d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709926431; x=1710531231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=41OQCO3nJ6ye7/BsY+CBDbESbaLINSNKfISHGllJ7gU=;
        b=UO/NF+U3gtvx0RwORakBzR25RTmDy6+cxyC64stlSVygAx0ykP45nVUUkb2DP/qhHx
         HgeyX/bh/CfFgkfPjZdI9KLaZnJVzCkaC/cJwN1hpO+UyYlk1HXcZMFmGR8IwiBJDGTX
         G5RIxkS+mNkFMKRTOdaZx6sx+TRkvR95tg6tiwjMzJm6Y+GcBSSMTotN98KYV7PBnCro
         Ud7IoU+xqYmoZ8du1jGV76IVEqS0VKkPsa+rrWemv5vrTOz7zJja4EuXYNoCnX7SSnUf
         NA1NkERa6qwUrdyuJIjfmsVtLd8FET/F9n/gB6IYEZ6zhjqTRof2OS74dFmhYyYtwZYY
         yqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709926431; x=1710531231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41OQCO3nJ6ye7/BsY+CBDbESbaLINSNKfISHGllJ7gU=;
        b=lVSIDGKzQ/RLm38dzF0WuY+I6vgWry0XB4ybQldrCIHkwN2o9qML8VIeArAWaJzX67
         BCvX6aRewjz3g3K3z06sfNX/gfI32zzGJBV40/OpLXj9kC9kMy7p/qAwcgBoiWETPEf3
         tSDf7x/MlEJKiUBTy9/3t1gmUA+MQixo8M+Bt4q1bEE8onCncTodsTEhVCmc2dsZ5EpP
         TLLm4v/9uQMSNX9wY/rb2HcWayuwpLvxJgJIf0PXbknYvTkQ1wBt2sFW6KFI98k9faeD
         /Q/Ynq1sHcaSRc66GxSEajvy2QqM/7kiGMZtG97QDwInsrpBhlIOldrHl1x7UIHw4c+C
         oigw==
X-Gm-Message-State: AOJu0YyGx2PYNzs/eIA++B0lV3YA62qejoSnmVrAwwD9a+/UR/yO7rHG
	UWv5hgKOcn2wKtL7RKI4V0njU8mCLdV0Vst3KrkIv1MSypQ8jFllX2AUMAoKDVQ=
X-Google-Smtp-Source: AGHT+IGXZD+j5gcnekTj2DOsIj4UiJdMzsP0zbvgsVM62PVHmZSt1QnB3QNP+Jxnc4/AsCjDeyum9Q==
X-Received: by 2002:ad4:55c8:0:b0:690:b73d:28f0 with SMTP id bt8-20020ad455c8000000b00690b73d28f0mr68353qvb.14.1709926430862;
        Fri, 08 Mar 2024 11:33:50 -0800 (PST)
Received: from [172.17.0.2] ([52.167.215.182])
        by smtp.gmail.com with ESMTPSA id qh15-20020a0562144c0f00b0068f11430971sm44945qvb.35.2024.03.08.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 11:33:50 -0800 (PST)
Message-ID: <65eb681e.050a0220.60e4b.04a7@mx.google.com>
Date: Fri, 08 Mar 2024 11:33:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7580363279129671144=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Broadcast source reconfiguration support
In-Reply-To: <20240308165232.53906-2-silviu.barbulescu@nxp.com>
References: <20240308165232.53906-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7580363279129671144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833849

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      1.00 seconds
BuildEll                      PASS      24.54 seconds
BluezMake                     PASS      1713.73 seconds
MakeCheck                     PASS      13.65 seconds
MakeDistcheck                 PASS      179.10 seconds
CheckValgrind                 PASS      249.57 seconds
CheckSmatch                   PASS      352.54 seconds
bluezmakeextell               PASS      119.87 seconds
IncrementalBuild              PASS      4739.05 seconds
ScanBuild                     PASS      1075.86 seconds



---
Regards,
Linux Bluetooth


--===============7580363279129671144==--
