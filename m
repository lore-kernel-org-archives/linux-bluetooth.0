Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8813955D8
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627928; cv=none; b=Nwsl1HId97Wg7l3xbAftFXVmgJfrYqdTyPDh18+prHo93OAxKiPLoR/Sc23B/DNvaLkXs4cAhustRD9IPh87P/X7IUwXPRRnFH2Z9vFSbhgReN58aG7aeJEqRbHOW/vKm+2+ZX1MhyIauRdsBwKc2CyXewYxRuvZZto3ZyWoFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627928; c=relaxed/simple;
	bh=46jZYpNHbnZ+b/KRR7ui9EbIJ1UsbX/Ykn8CZLjCd4Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nUXEbBXIhPYT3WQo2P+B+li7WfBAdZqJJlo+psD5c5fnCnUSRfcU4GaR2I4Dzk5kkfscNxzhLdFTdKtE5KjQ/yhLhR0jJ0unX3reQnjGHL7LeB3cGmZoZKZrGBEeRlbvQUZGQIAam0ySvw2gN3721WS1A2fKhjUcAGhxr+Mjinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmZOVtcf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmZOVtcf"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2257205a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786627926; x=1787232726; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hoiWkmUtnrWPtHSSXxx9g6mug5W1RoQ0DQjHEL1gQfY=;
        b=CmZOVtcfNxKdrzJjKtn+9JZGaRwarzu37uHBUV+Ykkxu/qopLGFvYDzoxU05pL0eD1
         hEb3Cel6DiRqVIl5TvIRU6TC6al3ElamRg9pxlq+p2dXm/+HmcBTAfoyCNWvbRAUOJ34
         17ORaS7k51CTIH+OeTkSOOeKnOk1tFOW+9HaeNlHYRNwHQsDEnJSrcQp7AYoproIxBYL
         HQlO1WJnHwsnadOXIUndYOf9JW+Ss4D7Ormj19zUpdDITv3uNIwXkIwh6geEYZend9NA
         5qoAL1SqJHFD7zvsbg5aghImAhg0BBJvy5tZ7tfFLX24PS3d8ew7pBwGgt253BNv9h0F
         fvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786627926; x=1787232726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hoiWkmUtnrWPtHSSXxx9g6mug5W1RoQ0DQjHEL1gQfY=;
        b=EWdzFXwTO5UijdJZMWvswRgOFjq3Fdra79vfjvn1V//aO4h3vZ+ZmppQMsS4xdeX/6
         WAVafH+LXP/GphwF8+O0uT08fh47ROtXGtd1t6D0+WH/qHtMIkOPvDE9JWnnnhA986MR
         IUiUgQ93b8B7gJsiknr2yZ11kZ0kbp77tLUbGj/v+CG4uaCUw84RMz30/sE67saYjhvx
         1Yiu2wl2CmW9kUDEFvV3DzAYQE/SVpv+b1wbAuHBHAVfHsqc6giDqRGCVLlh77L5MtJU
         MdaLmHA35ac+wrX9DTzALGq/Uhl48LlJpbs0YbsmlZv1XDt9UssAxo7Xc4LJY2gc04Vy
         O+Fw==
X-Gm-Message-State: AOJu0YxPMI0O0EwUjgjvzVWtY/ZS6b4KKDizkd8WNBMxuLV8T6BW+Hb/
	PWQRs2Y5tdbREtC8SVTy8Vhu+FoQ2gmOyXILoYSx3LR9w9YrvA5SnXiKZHfThbrR
X-Gm-Gg: AR+sD11iXAifq3jtw5m8InRmjrf7a/wnJeut+zMwV2z1SNBSgP6kQM+GhUombIwN3l7
	CYSJE5pnKbjQ3nA8T/7ZWnikAFJrc9gVKlfOoMU70iGPBq66U7LGnJTRKnR0TaASpc0qynUfZed
	EgI6iEHxANWFCc465PNEgHeQ0X5oMsMs84iLZ1ZcSeMXoEBksPxCy6wqE2GfRS/xmyN0qZ+X/RE
	XYLt9xDQnlpJSo2+eopT7pidmk2myRckSlr21yRKyr1wnsxdWETEAONMHHQnab7eQqEpdB05YmC
	x6lPQjwVXP+LyRb+TF4/ZkI/iFknLAWN2ccWMVACbgouEPgQnRGztszj9ncTUJUUb/lToiIXEWI
	Yg5iikL1NHfdHcByT6u0kpQclp2bp67Ee9FQCS52yoIGuUBt+iKubKDabX4NeZt52TFiijkkVI9
	+bHHrBAmqbsvOx0dc9tlluB/pTlG7GoRQUb+MY/dFtLqQBtUP77qQpNkzmdm+d2Ms=
X-Received: by 2002:a17:90b:5626:b0:38e:bbf1:de34 with SMTP id 98e67ed59e1d1-3931e03dc18mr7511047a91.7.1786627925760;
        Thu, 13 Aug 2026 06:32:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.76.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cefef03sm3579567a91.16.2026.08.13.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:32:05 -0700 (PDT)
Message-ID: <6a7dc755.dde95cf2.1c6530.7ef2@mx.google.com>
Date: Thu, 13 Aug 2026 06:32:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8443928718644341900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2122295973@qq.com
Subject: RE: [v2] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
In-Reply-To: <tencent_E5954D5C14D99713A73E3121B97EEDA6170A@qq.com>
References: <tencent_E5954D5C14D99713A73E3121B97EEDA6170A@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8443928718644341900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145404

---Test result---

Test Summary:
CheckPatch                    PASS      15.26 seconds
VerifyFixes                   PASS      7.01 seconds
VerifySignedoff               PASS      8.18 seconds
GitLint                       PASS      20.83 seconds
SubjectPrefix                 PASS      12.21 seconds
BuildKernel                   PASS      38.19 seconds
CheckAllWarning               PASS      32.14 seconds
CheckSparse                   PASS      39.00 seconds
BuildKernel32                 PASS      29.53 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.73 seconds
TestRunner_iso-tester         PASS      87.09 seconds
IncrementalBuild              PASS      41.18 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/577

---
Regards,
Linux Bluetooth


--===============8443928718644341900==--
