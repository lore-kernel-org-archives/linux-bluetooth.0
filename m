Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C621A01
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261616; cv=none; b=bE5AyNToTBfRzUpxcklXriyeZo6UPxf9OlJhMQDgEave35L3W7RaZDnleEeOS13DC3sXehgDwXVefM99bkg0P6Muf9SH8aUPhDBKo2fv4XQc9S6afmFWI5D6bFT2oCAbXABQ5fAUA5QwZcZI2mYbi5vTutPD4JOXRihaQ+nifvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261616; c=relaxed/simple;
	bh=URPTw1ljq+GRk1DpompXPfbz6tL0v/rX2qOLorNPqs8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ox9dMav80B/uUGSe+tZ56XTySt67tQa4QdOcQcr6aOtKjtbxW0b9C+Whn7weD5eGjuz1fev16EYWjcWm6EYcs+F4LG3FlF4S4HVJSkvIVaxutsc0HvmGUq7L9ie54hDKQLEavDtU3h1J8uqssj/al7xDxfDnU2lie+Aeqzo3qNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWeifMxu; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWeifMxu"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d317aafbd1so97946241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 01:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706261614; x=1706866414; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HeDYYWnWC/Y5ccoYQI3Hz3pIvsbkCEMfnD0OTY0HcQo=;
        b=mWeifMxuxdMaDpj0+C8q3USjeb1tRXi0+bZ9Pxag20RFmafPtxK8rF5ypV7WNI/tmE
         NHphmehXUCE3RNxZGHfI6pq8O001nRMl19te4JlYL070uqUizUSF24C0lx5qMSbHWBeF
         giw5fqhD+18HHHkR8CuYyrjEnzQQsmacJQi1S4ivnTFXKwIOqo4r+5n9EUEf4AUY7yDF
         7pIAaZC6Zsyvs7MERzHsxA+1/KjiIqObUeL+bRl7xUicODZs84W1om5bfwKBv5pSUtKW
         B0DuwKiIV1vKkfcCitL7b60kHvaD8/p6kRlOtuRFfhQ4DGf21/tyS8djv0zwqADEtW6T
         4BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261614; x=1706866414;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeDYYWnWC/Y5ccoYQI3Hz3pIvsbkCEMfnD0OTY0HcQo=;
        b=aNPN0frpZ3gVF5n0L9z5cOmx54P+cp900Z0icAsqRr5kZJgobMdJh74HBrwmFmS96L
         P5aP8g+WwfwWqKSl260jb6pBfKfpQEsHu85cHkEB19aEchDHgN9TyHswckq8icet/M77
         +C2QejGBIgzRPLR965w/Y860ROqNhYCQyeNmCHzJNsxYMFWVF3ZYA6FJqFLyWvyAo7v9
         7W6VA6JnZcCo1YlT+lxcESGE77qH0marcg7CkYBHJzPZJjMsAztsJqOOQ0aiE4jDuu8a
         YbnZ+V8W/mVZNW759yh6MAXB6tr2Sg8DGmwqbqUvJu1fityfrs3ZTRFI8hbdi7o3LKBK
         +uTg==
X-Gm-Message-State: AOJu0Yy6pDlcUtW5S0Lf2NL6QGwPulrBJJRq4DHzmxCmQwdN2dVuBHzZ
	YqW+vH+IhzJzxQ0mQAG2eR5Qp7HUOgqVocpnHtqVbl0OPAZC1yQfr/hpV/lr
X-Google-Smtp-Source: AGHT+IH5MdXgod7Cy3fmhRN6tH5/J3mHtcmxrC31f2dt8A9EYHBuj/9+v/r0xkZgZFB2Apb/8eHdMQ==
X-Received: by 2002:a67:f9d0:0:b0:469:ad01:edbe with SMTP id c16-20020a67f9d0000000b00469ad01edbemr784473vsq.9.1706261613836;
        Fri, 26 Jan 2024 01:33:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUX9m/Q4UUBaTqlHjVMIOkPc+7gH3pRxns5k1/2lkk1+X6IfPXRc/LzSlgRxeg34ZWdFQQuHqOkQybcBB2PC+GVwvG6QOLfHQ==
Received: from [172.17.0.2] ([20.109.38.199])
        by smtp.gmail.com with ESMTPSA id na1-20020a0562142d4100b00686aa6dbcbfsm367642qvb.81.2024.01.26.01.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:33:33 -0800 (PST)
Message-ID: <65b37c6d.050a0220.83910.126f@mx.google.com>
Date: Fri, 26 Jan 2024 01:33:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2225596253719945091=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: qca: Fix triggering coredump implementation
In-Reply-To: <1706259624-12518-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1706259624-12518-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2225596253719945091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820176

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.79 seconds
CheckAllWarning               PASS      31.41 seconds
CheckSparse                   PASS      37.45 seconds
CheckSmatch                   PASS      100.85 seconds
BuildKernel32                 PASS      27.83 seconds
TestRunnerSetup               PASS      446.56 seconds
TestRunner_l2cap-tester       PASS      23.27 seconds
TestRunner_iso-tester         PASS      42.48 seconds
TestRunner_bnep-tester        PASS      6.86 seconds
TestRunner_mgmt-tester        PASS      159.17 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         PASS      14.46 seconds
TestRunner_ioctl-tester       PASS      12.13 seconds
TestRunner_mesh-tester        PASS      8.75 seconds
TestRunner_smp-tester         PASS      9.79 seconds
TestRunner_userchan-tester    PASS      7.26 seconds
IncrementalBuild              PASS      26.58 seconds



---
Regards,
Linux Bluetooth


--===============2225596253719945091==--
