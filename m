Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119747;
	b=CHJpDuyNnngLEZCNt0uaX5Pa2jYt5ujCLLddsnLzlOs4MUrC6iVr/nPaa8wmvmXoaLTs
	 ik2ZvNh0zc9LFcOY4aONEFZGSUvr+l1biqWlWplPy8wKyTEu1VtaryvsGJszQ6f0J5tuI
	 qeR+JDAyAF6QuAIAMI4xn7qLBfHyJEnAiqPCL18BFbWLdwOKXVXuOvx7B1n95KHfyzLy4
	 sLed+gFMivZVbqpfQj98cRMS5tOO/KlJxKlPovXXCnWx52/9KwbTO+AYEjkT63Uv1J3Ed
	 0rOmiHVIgNJx63t6W2tMJBFSCvyIs0QWz4AJyX9Sd4SK4fA02rNetLw5B1oKRrHwvmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=/1cuRA3Toe0fr9n4BcxSLmpUJtxR7t35h2QjNMlhJNM=;
	b=SGArXpQk7hQzH0YyOpu4bu3DCpLvXNNtAavFWo51g7KAAJu2Sd6kROyYIq3SjdwhBXPQ
	 IfTpja2xtehC+VelnqKgRBm0auyN8kj6muOvEVx9iVuedCY9mxn51yjV+LZX104omSPBD
	 anFVeM5ZH/8xzXZJeAJS9C138ihSSvyfoGIfWplkUNPVw1IQxM/sYuu8M15fkYoHUQ8SF
	 BPS4pEqk5IuDf9TjKO6BWZy0YR59vt6RDPFMA4gSn99yC8l9P2MZiq7YzaMV7l0vj/mBA
	 oBFpGQbrj05anTvG20QXJF3Qp86isOvNDk7ZFRu3+/YMPWYH04fU867WceFgrrOygDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OioiRmEE;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495B606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4495B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OioiRmEE
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8241a56cd70so29347a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119746; x=1793724546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/1cuRA3Toe0fr9n4BcxSLmpUJtxR7t35h2QjNMlhJNM=;
        b=OioiRmEEFlHPZAQDWj/3K5FHl33QDDgIwUTzS2VNB70DX7/+/0pMZzTu2N+ihxUTme
         1hol1P/c9n7B4hsN/j8igVrxXnRs48VYIw5KiUshw81Y5PDIsmb7q+Q96HYyc5OZrRc3
         lwhCtLnF7APi7KlEqz/uehaacsL9HY1B+jO1fLmEJTHXWBUICB7Jv5leymyQX64KNfBi
         eahQn6B3iqLwj/in9tBz3HW/MEu0lbRLH9GuvpfSyFjC+38Hm8tFqi0tFkzx3XNN+MHo
         TA8fDEqBpymFVjobRg+10uJPqeSmDCyDMvreEym1LtHXsv1T2wZp1T3FQ3vLO0rhj35H
         eHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119746; x=1793724546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/1cuRA3Toe0fr9n4BcxSLmpUJtxR7t35h2QjNMlhJNM=;
        b=bM6a0DByQ2PMlG/rJYgIbJfbl/Wz6Q/pbm1sx3V5nYftz7UquirGTmZfKlFbic6/Ul
         aPAmsu9kw87pqoWCkRf2eQzimDhNISS9nYJL6kv9qSELBBpYZLVsnjBajIZPhg08JuK2
         c1Y0vAM2i4UZ0pLPDFvMO2vtBk9DIw0XIfd6kf+OE7g20CYuqfGLX+pKzv0aNj78jR7X
         HSkEQr3oldrPqJZa7Ydkf6HuqaNZE37DCYgqS2Z6VSMcbtqt4fdZENWz0ojhrvrBn/F6
         5dPWz27quAqJzDD3sEgs5TJWtVUmq5LMC9s/uodC9hOn23OhLhTWiTPN1fZfMNu4it7A
         2fJg==
X-Gm-Message-State: AFq9FYKuEf0L5PhYFNfijCW6m/XhaXgdFVSjJjk9fUhfN0FcGROoGtsN
	H65fwVnUVxNqQK2qN1WCDq082JsFQCxSS/qYIrM6TCoP0MP3aDhVwATDEOTODA==
X-Gm-Gg: AYBFou1yiuDH5iGyYWv6w3KNqMQQyRGh4xDgkcdBWk3stYL5KTtS4zeRtWyq0THGpS3
	MsWZ+VNmqZrZ6qHnrEJti/uxAWar4jy70TusNducv5c21EvykPQ9gOFrm3IP55D5C1KKBRmHOyx
	yFedzmrz3wDK96o9sTRbS0/wPzaqmvG3dzcu0BNAd0FGMKtCRHYmubb9KhykvL5g5EZzLIpcOu6
	66L4XszraZm22yPS5iJs0qMYF1CHBojnmU+NLNNAyw4NQvPLKrVxeVb5lI/jDPWvZ+6CDlm2xro
	UBrIK0hX+X7M2TydXFJI/tFpebuUW4bYQxjm+K+jKTfWO6ZSPHlVKrSlS9Mq80z+Ydqr4wYEC2P
	NLkiXYvIEcdS0Pg+SaBTJ+i+aFY48mz03A8G6Mpzcx6oQgKXwurZRhTDBlyPAXQNE/V/coHEW93
	HwOYNWJDNKSYJHVh4a5ZN1hBkpiy5WBIpY/rEBqkF5C+WvLeXq/81hL92fhFqNJ16qTGU2CBP/m
	93HJ8Wxxz5KNN+C9ODcqPviWOS5//P6gPd6Fhs/IBGYkBZlR1P3O7mKz2H0SmQ=
X-Received: by 2002:a05:6830:2b26:b0:845:8d86:9f7f with SMTP id 46e09a7af769-85abf969183mr458a34.8.1793119745777;
        Tue, 27 Oct 2026 09:49:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.239.41])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fbb25f59sm11068390a34.20.2026.10.27.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:49:05 -0700 (PDT)
Message-ID: <6ae0d601.a24a1a8d.10a122.e96d@mx.google.com>
Date: Tue, 27 Oct 2026 09:49:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3433516892078903498=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel: check FIPS status before firmware download
In-Reply-To: <20261027131850.3652839-1-kiran.k@intel.com>
References: <20261027131850.3652839-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3433516892078903498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194596/

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      7.20 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      17.90 seconds
CheckAllWarning               PASS      21.39 seconds
CheckSparse                   PASS      28.13 seconds
BuildKernel32                 PASS      18.09 seconds
CheckKernelLLVM               PASS      19.68 seconds
TestRunnerSetup               PASS      417.65 seconds
IncrementalBuild              PASS      20.15 seconds



https://github.com/bluez/bluetooth-next/pull/1006

---
Regards,
Linux Bluetooth


--===============3433516892078903498==--
