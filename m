Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F53E92A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938372; cv=none; b=a6sOmNQBdaxc2KdXfqxUfOATpem7uDoCoiNCsOC1pJiubNnX4eVgMVOFBdJx2HfkILQAb70YO7u4WyrrDlcl3uF+YxgGJphm+dZuTaSai0q76TnH4snFa+ekm9fR3QhokKi2/ZAtDtNx+7Hs+BNdpa9kChTP9k96INkxJoWIIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938372; c=relaxed/simple;
	bh=ixpMFnX1O51Cb3tD9iU8aFLnqLY9765ngoFr8JrKnBQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JTum3DWJbDaeU1kpRJtgbVUSZIsbAcpReGTmlBaL3fsdJHbz0V/xiIHcx8CjWXNcZtGvPMHzN+nH15b1AYOevI1cIOctVOIu1nA8zgz7K/qCjlw9a0Tt3+rb93SCLeI/lxJ0MQ/7Yhiiy8zYrSoPbsqy1GfEL2pBz2Bl+WEnhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dus1diR2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dus1diR2"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c15bf5000so16798011cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783938369; x=1784543169; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p+GLlzylWGU/n64Vo+IYlS/ME+XZBmzTeoPAzCzL8lw=;
        b=Dus1diR2rGmuPENCLIkt1uF7yNPeV+0HLj5xbuSWvpRuH1cWSjmzp1Wm45w6mb3GBW
         w5OtLqJouu8ya/Sm+dOmafxD+tMydkC2ay+8q9YH7WygH5+pI/73nf7WFp5Ss6QgtsZq
         hK7/ZcGj+jX8p5EM0w1SWn7be4nl+c7zVUiivhtXKCOjd/gpLi1D2H99u/Ljal/6xMlx
         OoBoXsMzpigWsO6zTeMN/4U3N/BcCsdX0pwVsE9BHuSnGoTm04bsQ1mRTfp9L3fQz7FK
         /HkFg0Ys1FtE4QIWOm0ij3TPJLLT5x4PCKsoIkVAY2i+0xDIQyaCik9Bp/cYOoaE7oWJ
         uO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938369; x=1784543169;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p+GLlzylWGU/n64Vo+IYlS/ME+XZBmzTeoPAzCzL8lw=;
        b=eMeNMcHCu1vit1t1uk+dXnhmIDsWOhId4jxSSuzu0hPcFVfR9kJU0U1GTitS8qdwh6
         GbCRBubFpE01bX4bJTZIT0dmZ87w7aW6tnH8wWGoh3aWn7mHF8KlEMatlS6NAX4YPhrR
         wpRq9m6KMRo+884E9BpZ7LOW9uqCWOLcDQwOCnvN8IYRY0xB3cVC0wugmT0AL398xMAv
         DfVK+jJvG6CMpZlgxtHt0vY7gP82Y46NFwtfsg9lcohoJhM48MIAOY6G6LFCmB3zEHmc
         AXOp8OJGMwW6z0TvmdqpTB128nKJUxByKghJJv4MhFqvXKromd4MI3VbxUE0JENY45al
         Km1w==
X-Gm-Message-State: AOJu0YyV2L/YHyqhFySY9/0MRpQKAhFKyzuhOJIYrSV3tMZP7Jkv7ocR
	+6xVc9hCFvg8necMqAqxmyk4vUGrzaIrUQxrLZPie2ocPEUIUjevcWE+yTQBiA==
X-Gm-Gg: AfdE7cl3wS8bf43vnQZzIKagz5OlfYYp0L7Tuun5rQQYYPUS9iBzOoimy9NyZP9ybU/
	PyFftaPH9uyw2RCGJ0tHhlz6QL0XSmYE1++D3pcaD7vm7ePx+36wQqK479Aj+f9eshfpCb+VPVB
	l9dvZpUcMjdJ43yLTergbFjk+zVtI5qzvYeouLFrffvKrDxM7Njg178P2RQWNjLfhJ11Rl2bnsB
	s1PG6aJOGzATWovhqoAZC61x72RLoggHtmAleKtwzARZodGf5WQmwf2vyItKXvvQCh4C92slVk2
	9UxfGfCES48zjkYhFWj5hK97Al0Ms8UWZiVfkh2dYfE3NFsV2Fj8u1uH/X0d+uBJ47fB+G9UctG
	caJxV0jIJ5OtPL3a3i61RfNKD1UajJ3PkhnA/smuqZgR6ki7L9A30N/Db+4AeE0h5mlwKGxeVVy
	7izjHHZE/emfJ021XcOck1
X-Received: by 2002:a05:622a:50a:b0:51c:f33:9be0 with SMTP id d75a77b69052e-51cbf213f2cmr87152221cf.55.1783938369170;
        Mon, 13 Jul 2026 03:26:09 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.177.106])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b44sm78584971cf.30.2026.07.13.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:26:08 -0700 (PDT)
Message-ID: <6a54bd40.97717f65.2b92f2.f3d2@mx.google.com>
Date: Mon, 13 Jul 2026 03:26:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7449500749679794843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raoxu@uniontech.com
Subject: RE: Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
In-Reply-To: <0CB2D8D715AB9933+20260713072543.3348755-1-raoxu@uniontech.com>
References: <0CB2D8D715AB9933+20260713072543.3348755-1-raoxu@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7449500749679794843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126375

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      25.62 seconds
CheckAllWarning               PASS      28.33 seconds
CheckSparse                   PASS      26.77 seconds
BuildKernel32                 PASS      24.74 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.82 seconds
IncrementalBuild              PASS      24.43 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/428

---
Regards,
Linux Bluetooth


--===============7449500749679794843==--
