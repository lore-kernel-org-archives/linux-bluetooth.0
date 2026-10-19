Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040648877F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396277; cv=none; b=HpPbZ9Pw28fMDpZ9GVVGk8ISIZlakb/7DAaYzwg96i9Qn/BcWuzsTs9QoMYS97zJFo4/odUYqE0ElnFsmhOLGqcqzf5MRpHxK9cIX5vmrMDJnyI8D+/ZBef87PGCq3y7Cq58SSeXTrg5sv8uXBzHiiPLil8rs31u5era7Aodk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396277; c=relaxed/simple;
	bh=kK7EjX0q6IXqPU9k6oON4MGS2hR8/SaQtBRfV3uSMIY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gSGtJdUosaAnlupmha5Mlk1VBn/i7v6LAK6dLY5EIFaA4nZ9Uzz1M8T0k+pt99QE/eBhhVZZfQbfiveSnTXjQtHy/wtv83Tt0eeM/Ng6HyRlHkF1bdVz530VwruccKJGR80eWrFP7GxYYyCqtV1QVGoL6xFq4rzjC0fqlKJCCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEi9NMz7; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEi9NMz7"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-702dedeb70dso1231964eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 00:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792396273; x=1793001073; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xtq3dKxhyqb172MMo2XQ3R5eqp7mf5OSLjtbIUIDANk=;
        b=fEi9NMz75S5/nV7S1p/vdcMDSPrVcMxVxdTPhDpXnqQZ67PvOd9gTrvgb5Lq2RoSwm
         5gRDv2BKq7dkflh+QAWnlYt9WD2K6nigi0FO3U8lPG0HzcsCT2wCKod8xyo9WXp5kOTj
         BGBIUKBuAPzHJK3+jzhff0hUac12VLt+KuDBdy2c/w/E4dipRC9hJcMcq7YyZHbKNXRS
         glMpRoS26XXSYEc38c4gyoMwSInGTi4W3TDxsENUHeIW+qocUnMzx4IAdC/8AM13B898
         oCU1/McjsqPRFHTmUdrlgEVRH9L6nHIRdMHgphe86amCDQ4xAksjPnqoSrXqAj/b1lEv
         i8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396273; x=1793001073;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xtq3dKxhyqb172MMo2XQ3R5eqp7mf5OSLjtbIUIDANk=;
        b=nXsL/lvrWs3fYenCpHhUl1hzZvYpqNUc9XkkMlHlD2/RzBSCwsI9hOCmM+03QRtyLA
         C8A6NckURybjzaEZnpdWSEEMzY3Z5kJ/hWO9yI5ZF+EpFuCbsr9/BdPZNdVp9T51iS9E
         eRRZ06XuVSxJADCd/NI12m9gYZP+OSEZ+qpfr5zvZQOK/wVhdYdlNPqz5a+YkQOM/VH3
         LmwphdRQJMnd7BsyAXlSHR9v7Apa4H1Rjk62CXtQM1EE/MN+Gmx3kQD8baQw103QgVC9
         dIgkQoTlQ3Lg4uUYSu3+4UYH6QkczcPqLKJd8yiB5R6ijmCn+Q+jp7rzd7KqXDI2Y8Gx
         qSGw==
X-Gm-Message-State: AFq9FYJnRWcWqwCNg2cPjhycB6Ffl0wwmVQ/JpSdLA2Ks3IOb8TWHqdg
	XKZ8ltH77BdtFtlyrMX6dM5WFEiGgCQhcLnAk5IYshHhphtnC1777WKDO8yLbg==
X-Gm-Gg: AYBFou0tRMmVmrnYln4Fl8cU95L79Y92Xn8FdDq2gtaKCEy4ThOoXXBWDxkfe1tewW3
	DvYlDhIAtWH/YqT8hVNvQIG93Sd+fgam3UAFZXdE+0Dp9p/z49S/4szWWqScPdVbPjohEgDFVs2
	L6VF+fL4zfmRLVeVKHXtr9KlzOh4Kd4gyaMZ34zNCpxCoH9Kcm39AKRJohlam0cjM6iBGcbTNu1
	LRxarG59gUomgHTabA3WkrxulildhjVPcN3o6UIDdCjMglPaCm1XFUYtmoRhM8WUWp/VQ67j2lm
	KTwqTNjH8RJSgQdyEMyIj5g01KHbzGqqR+kdOEscUCbpqh6VtDGVB8y3mMdrjNqlYZcsArqcTlR
	ByccFruh/QG6hcn4qpAP6FxQJ/IWPIaAiyA1d8S6V9W3+qFkFmixbuvKv1j5lB7hxUr/NAdUzg6
	qusatA/43BimvYe3jnkoDMUYL/fFHC7c9IMpeON+TAvdQ2fkacWwi1hp87DDzbpxTsqj8QIoIi9
	1fmJFwNFq17/ctqVmY=
X-Received: by 2002:a05:6820:1341:b0:6f5:a49:6163 with SMTP id 006d021491bc7-7034f3866b0mr5331825eaf.0.1792396273577;
        Mon, 19 Oct 2026 00:51:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.169.253.131])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8429b57870fsm8511863a34.0.2026.10.19.00.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:51:12 -0700 (PDT)
Message-ID: <6ad5cbf0.2a54a8ff.daf5c.5143@mx.google.com>
Date: Mon, 19 Oct 2026 00:51:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4795170577637974446=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [BlueZ,RESEND] monitor: Fix legacy SCAN_RSP PDU type names
In-Reply-To: <20261019041009.9720-1-kevin@simpleble.org>
References: <20261019041009.9720-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4795170577637974446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188585/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      14.72 seconds
BluezMake                     PASS      215.23 seconds
MakeCheck                     PASS      0.68 seconds
MakeDistcheck                 PASS      109.94 seconds
CheckValgrind                 PASS      111.54 seconds
CheckSmatch                   WARNING   190.23 seconds
bluezmakeextell               PASS      70.84 seconds
TestFunctional                PASS      904.89 seconds
IncrementalBuild              PASS      215.94 seconds
ScanBuild                     PASS      747.23 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3925:52: warning: array of flexible structuresmonitor/bt.h:3913:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2692

---
Regards,
Linux Bluetooth


--===============4795170577637974446==--
