Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225B1EB20
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916497; cv=none; b=pxXuUbf9yM4YKLw4EnOLjLtjng991qzstQHvpjc0rlFpVj8+mEyKwqsUUYmLn8WAsnBZAck2e3YCmH1p4VkyCHbRnLWrrgl6pLAM1tVyrHMBG0NttKr4rH+eD6HE5aj0QCp5e/Bdj8yQvr1QhTqfb2EB1pbBUN8se5k+tG5mgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916497; c=relaxed/simple;
	bh=myvBwoveenN/gyIbtjkfwxFn+z2NzZt/MOM0wa7sWdQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FjoTO05hmmSvlpkpTIV2uDGdMQWAqWinHpcmxt4FW3/ja+wMUKolMBiIEurOnD7PmRqg8BrjBqwjbzom7ghQvobk6s5skAnvCnTJxRbHQdxm49KvZOo4hSR/KVQq7LvDSm2f7bOx3q5/wn4fieS7tqUJfqs0Nzs1AX7U9drbPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5pWphpN; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5pWphpN"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69107859bedso44738726d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710916495; x=1711521295; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=chd7VKNsMAeeXkwyvN3/PX61dunBTRvkAeq+OETKNo0=;
        b=f5pWphpNV12UBXJh+ZyR9pvmsDva4a2iRucTwXpSYsn10lB3bF99cnsW72W31vz2N4
         J61u4zjFapQbNHU1jOHeeZ6f7hykMrFo5nYZ+oLszQO82/j8UA/xN3OqVqG6dc460jtp
         mlvwCVKyvm1xzT4X/BoBCzJXjcQm9XY5lz6LBFLpnExwRTl4ZDZr9JrvCmZ3M+FkfnDQ
         PtM3thMJcZx1wXvXPR/lOa9Xp1Yvj/6tCo97Y/LkjNSuRzY27nt2BTwa+vINUG/eb0BF
         mKQcmQtXCJSK+VqpZiObzc2Ecq9UijUYfSIOz+AwQuKXc3FXERrLBY1x48hF/x3UpyjJ
         oLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710916495; x=1711521295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chd7VKNsMAeeXkwyvN3/PX61dunBTRvkAeq+OETKNo0=;
        b=t7K9t5OMTuxsaje3R+jSGoi7Ln84gJnUWezis7E4ChgD5UOQwH5QcO3M/N/YCB2hY5
         ySmIxZmYjFc1yqkUpf5nJtrBHJ6sJgFWjqCtBKXJTrhOHUc7UgZnItDfEYnjNEsg80zk
         GotZhBI3L1TH4UM9hEbi4vHfsR+92pUaBRp9JUYRfVxxbxc4jDPVT7t5FQjQrItiJdGo
         uurFB54cKo+BRnrwlExASmzlf0v3YXNtlayZq7veHRPJxi9iMHk10b/h36xkuHgdlGqI
         PX7InNgpiNEnFDVUM54H9+nHWvNVK2Iy4TW4k6puB9oHVynUV2RYlihGLwgRTUsvBJ9q
         BVNA==
X-Gm-Message-State: AOJu0YycHZEsWZEZRozdErUt/3nzsAv+Zkq/pHT+LQNLghNmDt/GgUUF
	BcZjz/hcTccQdl+aFfxOZFQuYiN8ElBcbZNQEBkJygxT4TSAewHkkmeoFAXpakc=
X-Google-Smtp-Source: AGHT+IG/EVgdMGSQaSXsA/q7ikhVpYPWYCpI2ZcjkjDfVeBsE6tF02YkSXxh7VBTVlQZ9DedaRRL0w==
X-Received: by 2002:a05:6214:1792:b0:690:aac8:bbb8 with SMTP id ct18-20020a056214179200b00690aac8bbb8mr17831920qvb.50.1710916494948;
        Tue, 19 Mar 2024 23:34:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.123.55.230])
        by smtp.gmail.com with ESMTPSA id jn8-20020ad45de8000000b006961cc3f91asm3339861qvb.20.2024.03.19.23.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 23:34:54 -0700 (PDT)
Message-ID: <65fa838e.d40a0220.8c296.1a69@mx.google.com>
Date: Tue, 19 Mar 2024 23:34:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7577270279884059733=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: qca: Add tool btattach support for more QCA soc types
In-Reply-To: <1710914907-30012-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7577270279884059733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836622

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      28.99 seconds
CheckAllWarning               PASS      30.68 seconds
CheckSparse                   PASS      36.37 seconds
CheckSmatch                   PASS      98.95 seconds
BuildKernel32                 PASS      27.13 seconds
TestRunnerSetup               PASS      510.86 seconds
TestRunner_l2cap-tester       PASS      19.99 seconds
TestRunner_iso-tester         PASS      30.17 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      110.58 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.78 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      31.17 seconds



---
Regards,
Linux Bluetooth


--===============7577270279884059733==--
