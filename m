Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354619DF8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598857; cv=none; b=RKL7zf+X2rX4c0FS1BSPkUt5FwuQzRKfPfO7G4R9bhVA9g0SiNmS/BswhSBi4wPxdKB+6eU92Y0RDZuMJvQvLbPhaegiFoVsoTLuUZIlYJqJp5g1Ur4V0nOUWBNBMcyAICGmt9HLJLea70mY8O43EcGWjX09E1xFLyMwoEBlvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598857; c=relaxed/simple;
	bh=qghP9xxaMp5hzSUv7bdHlp69tks/o4eZn9WUFnx3fsk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DLFxWdoq8ZN6DgNZpXyJl9norgsLxyovbTAYGGjUjTupO6tJ82Y8Lm7jI2BlVFY5JOkaVB6QsgVFEadyQXJyzM7OH8ezVIINtxqBsMHHLxoLm0fXw9rdxm8jfYoyAE39PM04E1vsYbgIkLfKWXzFEOsp5LbEWbo77wJs/VV6nQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqkHXxj0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqkHXxj0"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b14df8f821so475502285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729598854; x=1730203654; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rwA4JU7oSOH0lZRtsZyD+yav94NL5hiVglF6GcmovGw=;
        b=QqkHXxj00304jtHNd5vFch+a4Jqih4Mk4eJK1AV5H6QLGgnzaHJ/vqmacvBejkbL6F
         nAM88tOIpDEHNy0c+Wq2I0nSX02F+mwlDxQLAwziq1z2v4llPSViorl8DkGo1WBvxeOf
         bPTADSzP2wjWlO22Icp1+9J6oO6G9RfBduS2XBzFHqh4TPP6GQ78o+WLLjy5qDPeto8O
         9N+X03z/2uMW05exhriElR+HbdMXaTfu1pX8xMPeQrv3qSTAPIgZ3wDRfSDuKWcZz4eL
         z2Of4UHgat1d1aBa6Ju7zxZkrveIwdhe1v95FNLPlVtd8jgnAI6ryk7xytOq9Sp6JemC
         VD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729598854; x=1730203654;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwA4JU7oSOH0lZRtsZyD+yav94NL5hiVglF6GcmovGw=;
        b=lG+ZbFYD/Jn8rx5OcpU8AKfIonEYdRF050l9jLTMry9Lgbh5i7pjT/GnFmsD8/0oS4
         7PVbydI5flA75+5SLLFcgT+cpLE+IXZbZBwfPc9vuyLyty3ZaQ8iObGOtF4tC3yK5SQZ
         qcSU7EpnWjLEU1NGsqYpp86S33kfyNmPQIcmsTsifYKDeFwRmAH7EDNXBCquzbWZKiyu
         8arHo4Af/GsctrVEKFODVCZll5ZLsp4U4n78sV63UiBDZ+b9vJiU86+i/YTfdfzMC2IB
         1YQZYM4UqwDvi9kHlfInY3eQuAImdpK8hZ2OI1+yGffpZd3CQr14xZyuwiFdyJ7rxBnK
         7aJg==
X-Gm-Message-State: AOJu0YxMs86BQi9HtuNa5pHjycqr/7n7/uaRdyeB1JbuqRA32TZ8+D09
	lVAzJpvebSjofRfESjcokYFPe++0TprE99QItpfpuY0ElMSI3i5wCl7QFA==
X-Google-Smtp-Source: AGHT+IEqA9To7Ud0BpGvcYkxzn4HXlZEIcVCI/nwEKbfZtYMbAG2zCMv7R/3BrYElkc/ngjhnBTsSQ==
X-Received: by 2002:a05:620a:1710:b0:7b1:4fab:4418 with SMTP id af79cd13be357-7b157be08d6mr1952103985a.49.1729598854218;
        Tue, 22 Oct 2024 05:07:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.53.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0099c337sm28216736d6.97.2024.10.22.05.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 05:07:33 -0700 (PDT)
Message-ID: <67179585.0c0a0220.439e0.7eb4@mx.google.com>
Date: Tue, 22 Oct 2024 05:07:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3092079153029372041=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v2] obex: Resolve SRM issue for PTS testcases
In-Reply-To: <20241022102222.279614-1-quic_amisjain@quicinc.com>
References: <20241022102222.279614-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3092079153029372041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=901785

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      25.15 seconds
BluezMake                     PASS      1662.17 seconds
MakeCheck                     PASS      13.12 seconds
MakeDistcheck                 PASS      181.06 seconds
CheckValgrind                 PASS      255.14 seconds
CheckSmatch                   PASS      358.32 seconds
bluezmakeextell               PASS      120.60 seconds
IncrementalBuild              PASS      1454.48 seconds
ScanBuild                     PASS      1047.25 seconds



---
Regards,
Linux Bluetooth


--===============3092079153029372041==--
