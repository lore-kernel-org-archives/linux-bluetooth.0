Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EB336EC0
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703196; cv=none; b=cwTFfARua1MH31h8o9vVWokj8P8+ucp47EcTX2AJMbpQOnD2zyZfP2+VNJT5P91q4Pg324TfW3nGLS9mY16KRqh5TP/uV7qvggGbWE7s0St15LTKJUfoEUp52nrg3Kr/rO1jm/voKskbbpww7sgkxeNUfG61Ysu/yNWWtjkyv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703196; c=relaxed/simple;
	bh=iN7V0m45l6HAOLbmXOwnU+M28pCIrQv3JO6UcaEq/YA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DeObm1fNjmwIqxRKNk0kavL4BV1fZ6X3TGE6e0RQWHdJMXuljWyR+Mk/LcT+ZAgoVm89Fhqo/AaCY9Fg54kZuG1cjSjDCkiG2s1BWHnHXUzohU8LFch+d0a1wnA2Rb/eWczpSiolW+LWFSfvNhumZmdUb/r6Hg5SDWiXZvXQrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y81ifIUK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y81ifIUK"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4cb7e10efso8863972a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772703193; x=1773307993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=66TKPR2k+PruiWqlaQtONzpYwiis9NnuIcxq/vlYlEI=;
        b=Y81ifIUKtXw0YoMa42lx7a8qmkoIRWVgcx3OBvFjFrQVjsol3bZTJXD0SCKpsqmilh
         HrPP8fonfwKQeo+BcS0d7j8kJFnc/uyoQIZVX5TYfDtR5W2KGe05LUwInL5EUlry2z2v
         1KbAbi0YFOHUxyCXmT4KLO0xU9fCdQOwURGMoR0zlOZKGTQ5uCnnGmPR8RQZBqV01lKD
         iErCk+KwS1vhqlI8SS5YEPEtvchQQV0DnrITvxOH+X6/wP/uKa/kzryBSykowZKddBLd
         UdQ9SvvqV8y/DiSsIygFMFTzm+fDMGstxA/58Ht7HNNP6DjxZn8gCOZpEuu82bKKcIJy
         ZnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703193; x=1773307993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66TKPR2k+PruiWqlaQtONzpYwiis9NnuIcxq/vlYlEI=;
        b=TZO5n7KjwShTdJZSKHNJFJvbNxgXH/Et8yX1D1z1s0esaD/GaO4uGXTZ81qZMrqi9U
         NjZZ7wlJ4q84uGt4myGPDGXeStAYxPWy+amvL1elY+JoKVA2V4ASoI2Lgfx+fXahlgl0
         QlWV7SQ5Dl2plVH4RNnL4Pc8tni54zwwEjyPbVjuPyaC4HjS6rGxND2i3z/x40Ruv3ws
         X6mpZTkFubRcEAiD5DIsaFLfsIZMLhBae3H86fj4Tz97iwD41d/Pp+X11UYBhzSV8y7J
         Uc2Lt5qpejE+uhKM5GYcw+XGk3JFj4MqfE87Kx+26q/IG4UqpLLz0DdlD346K8jCU1ZG
         AYuw==
X-Gm-Message-State: AOJu0YxEXiQ5KqNxliQpKTCoDrQIy5FYILRFiDcVfewsGUixt7XBRU6U
	OX6xBmbQ/hAIL55l1p7ImMmtYBXozhwq99xBqDdLatLxifleeVi49OgAIvqgBw==
X-Gm-Gg: ATEYQzyYIoopzvyQeH25qCSu0BKMY/uklWolQ80xG1RLDI5a1ukfJoMRNkQAihASJSq
	mGeN9kYVbTH2L8HS9F7XsTS675O0SVCo6neD/mMGr9WlSCEXfSuI5rSCW3mQZ/gark3bw5/O7DQ
	8vtZ0PCa5oFkE8tVz4PnSGq7pW/x+o2Tef8duGlTBXShh8clxXwSgbojLxkYsvUQFPU6aXSp6xw
	PxhsRaTQHbTKCibtxYQCn7hk3fgC7Xqpm+k9V9uhupSZHp51fZom+sbVBaE76ijDExzetP5R6O4
	7vKloyUsuHiM3xyhSuO5oynAhNcDiBrwb5nh4xU757u2pVxATSSrs3YOspMSFFL30AQPQyvcifl
	iPaGqh/7z3vVRH+shqnWyRgSrA+AmURJrOM+NdrD0AwGDdAmEwg3bjC/e3qwY5NW24mV+EVHRa/
	rG6naIqVuCVvV1t02a2ZDJUDp0dQhLwGjxakUXEBmc
X-Received: by 2002:a05:6830:2647:b0:7d1:973c:80c3 with SMTP id 46e09a7af769-7d6d13c167cmr3626789a34.28.1772703193283;
        Thu, 05 Mar 2026 01:33:13 -0800 (PST)
Received: from [172.17.0.2] ([172.212.167.88])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58647b17esm17538041a34.8.2026.03.05.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:33:12 -0800 (PST)
Message-ID: <69a94dd8.050a0220.34884d.4906@mx.google.com>
Date: Thu, 05 Mar 2026 01:33:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1060298676260143880=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v2] transport: Fix set volume failure with invalid device volume
In-Reply-To: <20260305083833.369358-1-jinwang.li@oss.qualcomm.com>
References: <20260305083833.369358-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1060298676260143880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1061791

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.44 seconds
BuildEll                      PASS      21.59 seconds
BluezMake                     PASS      671.54 seconds
MakeCheck                     PASS      18.65 seconds
MakeDistcheck                 PASS      249.31 seconds
CheckValgrind                 PASS      302.37 seconds
CheckSmatch                   PASS      367.23 seconds
bluezmakeextell               PASS      185.41 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1069.71 seconds

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


--===============1060298676260143880==--
