Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDEF4FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2024 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993715; cv=none; b=ebepHndB5E/fdeq3Pq69f5w3/WcWb2sMFg6P8oueJeQWZFGzl5RPXv/8z30VC1mB6HOFOQ/UksBntTDcxU8dTzXbziRWXbtX8E7+fH6olWNDlfw+ANfmvm0w1eCJIRMyFN+JNMDCe/9blJFwq0oa37avsjyZRxNXjRk2aI6T1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993715; c=relaxed/simple;
	bh=iCoIL6hSm4QHQCjBoNkWLz8cZnk7PY+gZ6zQjNjo/jw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MTcq1mMpvxzgMtCwTYKrVS3IXqGsP6VfDoR2JJQ4yME79AqQdAAy2NlZZ96bXeqGqv1d8Zl7ZtrAr+GaLhZpf81cE5eq6nHI8K8qmPLIWF2Q6Ee0TPtI/XkY5AY3zlRnliDLQ0olj1XA5SVU2ZRvbakoctiN0Xus/F/bRMj4+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzpPJMGq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzpPJMGq"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690c1747c3cso4801476d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 21:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710993712; x=1711598512; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v2X9DLLjh4h83ALy6cSUfLd2rPx9xIZBvxwxrVL2CLk=;
        b=jzpPJMGqu0ZIo+ce6CMndYlyX+FpWVfFAsTHo+IHR2sSNtGEUKbTqjvmxHhX4cakoK
         K8e+SO1AFH+VX8lVUHWNH/H4TkBDS8miwQY+7C12H3D8eBgF8WRKE5jtNWCzkLCU2bDX
         7zRF3pUWxJHmzi4DShQI421m1FhUeMynpzjs3iXJ5C7uRL1Y1mKWLamkB4cCdseoWNVq
         nL3sktjtURh/HJ1NYY3gLNRUlZQSFQY3kAaf3jAmU9UzJGsd8FLvkwKWwj2VwUOWkkOP
         mP+hb5Y9I9RotXnA2sNGkfP2EPbMHTusTTNtWZ3kCwLHchCHN3JAOWnSdNdHTZlA8DAe
         r8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710993712; x=1711598512;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2X9DLLjh4h83ALy6cSUfLd2rPx9xIZBvxwxrVL2CLk=;
        b=Rrw7LasXDZFNVDNMcLmDVR5C3ARzXUF4S6Tl0jhZo6sSoX37E8uWUrLKgihcn28r23
         dBzuc4xv0mEMteYLkI3U0yP7oB15np9vAAc1h8Ll+oOE9Ebm0HojIHeHGN3OuNdX1f0L
         Mn6n2/nXp1jbAa3RofzC1CLPPVDffFIt2TGhJIdvglEouJGKSqpgBNpBBX8qD+mUCfq7
         97+SJhpjwg9btciHfWc0j+ajkakNDwk0w0tKVEJAYnGeetiL78sAXwDcoT7b9Y/XqTO1
         aAZ8EJRS8sbaJhHYw/dvle1iOJ+Td+J9PHSLNs052ySvu/c7zAC2KBIRMCNgtj2Cnspa
         4OTw==
X-Gm-Message-State: AOJu0YwfeDQ8Jn6ZRQpybS5x1b44Ke2uMWuBP+dllbngU6TfZMsc3QaG
	uowB5TdBVEfXkPgHZK6EiIjYJlpGbq4ZyyN+UWtHDSn4CkIsRy2jTrwLPRru
X-Google-Smtp-Source: AGHT+IHjK8r08OOCGgRE/6WalgqNO0/hVe7snIXmiH8vKzocxmnGb5rZo5AjcZZOxYRGpIfyRAdocQ==
X-Received: by 2002:a05:6214:486:b0:691:4d1f:6a65 with SMTP id pt6-20020a056214048600b006914d1f6a65mr2886916qvb.27.1710993712293;
        Wed, 20 Mar 2024 21:01:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.66])
        by smtp.gmail.com with ESMTPSA id gi6-20020a056214248600b0069068161388sm8554109qvb.131.2024.03.20.21.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 21:01:51 -0700 (PDT)
Message-ID: <65fbb12f.050a0220.8470.a857@mx.google.com>
Date: Wed, 20 Mar 2024 21:01:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8820322495049757600=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [BlueZ] obexd: Remove redundant judgments and fix code style
In-Reply-To: <20240321021925.513182-1-youwan@nfschina.com>
References: <20240321021925.513182-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8820322495049757600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836899

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.09 seconds
BluezMake                     PASS      1679.29 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      173.88 seconds
CheckValgrind                 PASS      243.37 seconds
CheckSmatch                   PASS      344.29 seconds
bluezmakeextell               PASS      117.17 seconds
IncrementalBuild              PASS      1440.27 seconds
ScanBuild                     PASS      974.88 seconds



---
Regards,
Linux Bluetooth


--===============8820322495049757600==--
