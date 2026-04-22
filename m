Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF963446C5
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776895873; cv=none; b=A/DcPI2xBMg5QH2ip0IXIQdZXB37jmN0ak7EGdzHGTFZz8d+m+ochTenbItmtvYRFJYGii1+xiB9kw2gH8RNVa31BJlP9BntB2Jk+ZH418WMcbh27jumTZUJzf+8wvnCVoLhjQg6Og/23oX+BgqX+oIRQ9rxoy8hhq/4OT7FuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776895873; c=relaxed/simple;
	bh=eWZt75CD/t+aBbKO8ftYHCcEQdKywGZ5PepZxOKeMBs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k5PMGl0kGzWbjY/dsjDNH8g9+SMRbfen0AeIUtmmWFuU8NuSeAQ+Y6Y/l39IceUHY7WzrgUf55TGfsrJ2wDIOoRRrXK3OlFLMCUpCZeb4jiN9AdWGIb5ngbqeHX/e9y8zzCRcIs3hLtz036mZIMDzVcXw3GCpaTwEVLdptHGBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH1E+q/0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH1E+q/0"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d75bfb259so44227831cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776895871; x=1777500671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sa08b82KSAnKuBuhRBZ3xQ8m0AoNQRN8m6eXISOBllw=;
        b=XH1E+q/0ZesbzyhRaBOvbcuXtTA+vUcVBBAvauzf3KsBbJAcqbP6VGN42qyFD7wNge
         jAHYVY5iK/7Xl6jaayX6SNla4IKAuEuSeTJbUzsSDKAHlzED4HURKLkXD7K+mfFIcvqi
         jYPqlZ3nEyQx8CzpVTMxQOu4tXX+P/01Jhahu1IJxcPstAEuWpKCY93QXZHkfzKKOCHG
         CSkukH5pYBqVZenWawC9y8+Bw72pJ46vlqnPGJKhWYohF1VKZct2uh6J2IJLRxoP8Zu1
         tbr4u8wbHlrr0YHLB0YDfnTFDsbQQRJiT1gdLB82T4uHqWdFAStK96koik2Uu78UoQ2O
         knQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776895871; x=1777500671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa08b82KSAnKuBuhRBZ3xQ8m0AoNQRN8m6eXISOBllw=;
        b=SJYrOe3MZjXAnqYtpAPKcSs9ZTxJKDFOek23tCUg9N1u7z6mjgLZyijXgSEwzNpa8a
         7JRRhqEKFxydSy33D1l03d3bZMAtjEO/zT6LYrUwne9I7TKJ4sLMZScvzLMSso84GK9S
         m7n7PaOsi5oa3VwNqzNjmPECzgtJx25lBDkuKtjo23/rHdNvdvuG1iK4XORNF8jqfE7A
         /wt1W3mKYaHlUWMDDUozzXXLxhSb0hm+It5I8x7tdvZ1/p/k7H9GbORICK1OWIvkUzhJ
         6lHJ7VzuGWWoQ+RugiUTxyswlIMWpnI+GwINxcyPXktTu+eLrcTyLkv+hIXmSLxjOFA7
         ixPw==
X-Gm-Message-State: AOJu0YyO5o+PG3RH9IA+gCOG7Jv9XnXxu8aGV7jEUmPy6uR4xy6nbRlw
	r+fmy1g0ZrM+8c9F4oa7S9uEJFtjOZoJCO8h+lBQMRrg+6CVQ066Wed9aH6ptw==
X-Gm-Gg: AeBDieu5CEScUINm2H5WCW7qOWbN1BSug3FxOWYi0VYfgDIJAptbvALFcaT30Mj0d1N
	iN/7erQSukRVJCJmi5A0TTkj1A07aERAk8HcL6A5kjEVdzge0/M5WYYBF5i2fEPy5JWx8sGN4eh
	Py3Dc2gWwmBjlF3ONyz6/bEHm4WtWgxqxvEg0tCswKgZAVeWSdmrMlWFp2zNGMdrTW+7xkXUNyP
	Heg517VMU93iielhzN8KpgvQDGsDk1dqFG0om8bPoVhfRTSa9XlAHq+/H5oZ/d5STWdrXzK4hyH
	Tqb8+ur7bvaC7CX2qQ0OQtgI+vRWeSB4lrabJ+F5fIc6KIIrvhN/rHYOKYClbDbX2ITLLK24DeQ
	qmY0vdZIAZ9BAW5L5t/C4xfHp0X73qmiqdBC/fFd6WHqzf1Y+kkgNp798X51uwuE6HQrje5cUiw
	uFrK4RRK2wVhQDn2Ustb/+QiRRJXtU04AsmOFjy0qoYws=
X-Received: by 2002:a05:622a:144:b0:50d:a56f:6085 with SMTP id d75a77b69052e-50e36c1c000mr356853381cf.43.1776895871192;
        Wed, 22 Apr 2026 15:11:11 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fad4dcc46sm72242931cf.31.2026.04.22.15.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:11:10 -0700 (PDT)
Message-ID: <69e9477e.c80a0220.31b495.12c3@mx.google.com>
Date: Wed, 22 Apr 2026 15:11:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1993048366265887492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hrvoje.nuic@gmail.com
Subject: RE: Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV
In-Reply-To: <20260422212647.62497-1-hrvoje.nuic@gmail.com>
References: <20260422212647.62497-1-hrvoje.nuic@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1993048366265887492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084436

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      2.64 seconds
BuildKernel                   PASS      26.85 seconds
CheckAllWarning               PASS      28.89 seconds
CheckSparse                   PASS      27.85 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      570.65 seconds
IncrementalBuild              PASS      25.30 seconds



https://github.com/bluez/bluetooth-next/pull/116

---
Regards,
Linux Bluetooth


--===============1993048366265887492==--
