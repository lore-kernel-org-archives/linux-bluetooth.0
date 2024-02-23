Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1733B7FBC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696657; cv=none; b=FuEE+/aF5FTzeGpKl88m/rFuydi8EBViyMVefGpDDjOzKVhHBR82ZfLZf25/c7TQSxreRrtU30optDAqd387T/L17pvYOjfiYgimyypEvrJVGV5ELwQ7qAv7uDhfy+9wdCIR5qqdir7/YyXUaaKbbn3n24PolWT2qtDivpkGm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696657; c=relaxed/simple;
	bh=M+WDCwxYb/I2lKBNeUDpWffAenr0fMdi9Pt7TtsSMW8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cKcus7oc6tfNN5yKObWre5unewgntYizr0MCXj9s7QNdn2KthVHjk2mbDyfrsw4isg8DdTSnFZI78Ew2ofKkVF+ECp8WJUPaPHwBw/wHmXhdN8ZbZwRO0b0p9Uj2x/l/+X8FoqC6aV427T2sMIj79uH7YcujHBds6ts8M/vmS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbPynkR+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbPynkR+"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787a8cc7d95so81210585a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 05:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708696655; x=1709301455; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7QlJQtlEYWcnVfm8KIP9UQ5dWrhbTnIpRbQb7tVbXJw=;
        b=RbPynkR+BuTFRPn08YewopBfYilkrFegt2QbXZpwzSBsLGUTD/gkE3q1ReOp7uSLKV
         sNk1dDlpUa6OWsP92DT+3cVBLiFjWcHpSBKP9DYCC8la4jUUwg6pROQAHxqfxdLy42Gw
         bpBPk2h7qXVqUSFXRaF9FGt2LMMiWX8evHIACBTUUf0RNiGIwBo4R9BEB9WJ3U1h+G17
         yIjVMvOOVliaH2vrCJlF2a2WuXllUwVwhZQ0cDIwmNDjNrEDp3Y7nnAjvDFWv98/blpH
         N0O6j25OnzpqUOToi19G3XQSxPacAu1+OizeDPB5B0EvmDcsidyin7VVz/5t/gFDGLNw
         0heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708696655; x=1709301455;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QlJQtlEYWcnVfm8KIP9UQ5dWrhbTnIpRbQb7tVbXJw=;
        b=rRC+sJvWfQtQJq4tuBeOq5Q8uigggP6xpNFUFt6vHr47EzGZUDeOTz1NiAQHBd6RH3
         aWcA2vvg/VpJko3FYhGuCejV23dF/1SsFPbDtO8EzlY+93oeXLnpUeq2EHnPmIkEML18
         +BA/KKxYGmXA66yIapPQjyLbjbzQEWfUFe8z+WvC+kLmoKym0ZtosbuQzGXCrG7k43aq
         rT6b+tWx/7Cd3ggkxULW2GwWjTvPi1h0n3jw2CJBPAfFd6hRj/vCzyhOtVn/hUVltoFl
         AyZ7lG0XHTY5dBVKCGOHwgIkNg2EZ7dhy1QO0DGMdMKaPqJ7G7W65cv8RxOCrdlD9eCx
         //1A==
X-Gm-Message-State: AOJu0YyhBIiWLLSOaV+kkQs4wGosAc/JKHSl9OGPOqvTuzpg97rFtaCb
	puyXc4YniVHKm0qvW0Hg1TdW4AV2SNTxk9j+2vLmr2FK31+l0vZQ3gm6tuqA
X-Google-Smtp-Source: AGHT+IGDJgw3lJZcDsPWdxSLz6aY0q/cvSj1mcnEU0hAj2EiyWluG3VjE7kaU2M9mZudMXJc7y9lAg==
X-Received: by 2002:a05:620a:847:b0:787:702a:1411 with SMTP id u7-20020a05620a084700b00787702a1411mr3106351qku.18.1708696654925;
        Fri, 23 Feb 2024 05:57:34 -0800 (PST)
Received: from [172.17.0.2] ([172.183.77.207])
        by smtp.gmail.com with ESMTPSA id l23-20020ae9f017000000b0078790117ebasm2354632qkg.82.2024.02.23.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:57:34 -0800 (PST)
Message-ID: <65d8a44e.e90a0220.3fb47.c7b2@mx.google.com>
Date: Fri, 23 Feb 2024 05:57:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0549573589369166023=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Reassemble PA data for bcast sink
In-Reply-To: <20240223131442.3077-2-iulia.tanasescu@nxp.com>
References: <20240223131442.3077-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0549573589369166023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=829102

---Test result---

Test Summary:
CheckPatch                    PASS      2.05 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      28.15 seconds
CheckAllWarning               PASS      30.88 seconds
CheckSparse                   PASS      37.04 seconds
CheckSmatch                   PASS      100.26 seconds
BuildKernel32                 PASS      27.62 seconds
TestRunnerSetup               PASS      509.53 seconds
TestRunner_l2cap-tester       FAIL      22.52 seconds
TestRunner_iso-tester         PASS      37.10 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      117.13 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.93 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      6.45 seconds
IncrementalBuild              PASS      50.14 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 51, Passed: 50 (98.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    2.120 seconds


---
Regards,
Linux Bluetooth


--===============0549573589369166023==--
