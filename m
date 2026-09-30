Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668652222D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781353; cv=none; b=YRcVPxT6Kw5tbUjJRonR2PUaE76TTn/Ar2JhwxiEua8InqLmO/N9H9WMPWyGQ4SKRaMcnDp/0lKf1ognKJ+tT6svjhMZRjHoiVGk6zmPlohFxQujhZ7JRGY3AQFArz5XklIQq9MlE0FGWGVAZMyqRK1+tGqDgCHR6iYmC9EKyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781353; c=relaxed/simple;
	bh=NVVNXF2M/yaMHCsKh5voYn6WtbHfxkDgxFToy/U3Ta8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qfz/g98CZhWn6GaLH6YCe6mUmDWAGSdIFW0zuBqb1PJ4PR6D04DbEJvuhD2JJSKnJlrLSEmN5XDSQ/+Dc9Md8wn8t6K1hpLO4AY9Y40JiKE1SM7miSdKuFqoxw7Jubsxfjlgaa1wC9rsO1AsR6zF1OkXrf1f6iWSDn/4tvxN89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjQy6GUw; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjQy6GUw"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6dd42533365so268695eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781333; x=1791386133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QAmqiUnG7MatYp6GVJFNsXf82okXpaut1srNnIPGaWU=;
        b=cjQy6GUw4SlvYFuVxyMB0zQVouXcA7zSiYOLthb6+22MPAxCH7oK9sLUt4R/KF8Ir9
         wVm0lthWZFEIJx9PxpM/I2pegR/9hUxXtVHNlOhw6gLKJNdBXQW69M0hKD/ktHeXAsPc
         H3RoL4cOcEui1ncFIW6rkgKt57Xo0VkdG2Of381tqGKI44JZ0xRKM4TKrangyhZUIdhs
         h0sR2Xoa6/MkC901e/n5YUmSoyK4HLlTSI+o4ttDWrbHLHRUCbjG9Uei+YiN1AhT1Vwp
         V7hyxc71FwTPgkK65M9vpf0aFcOUWJcpJPxvvqf2Kp3dNbN/mqki4Qa1nsuHpEXGIuix
         R2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781333; x=1791386133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QAmqiUnG7MatYp6GVJFNsXf82okXpaut1srNnIPGaWU=;
        b=jbPLZPv8/2NJ5jUOAWALZU/mVqvjHjTwqZrHYnBIze11S/TpVfBfADO6gh7q/ipcIs
         /lTy3rZs73WEQLy6HB0GoqqOPbGik2j7O7HsBskI+hehETpPCAXlztZ0riIVgCPsKZDu
         J8Ds4WtfzjbHsLgRfAGUExrVWbpkXc04jMqtlwvW2H4uECecamwocsfACykuu63Lv1MZ
         h5QRMPl+H73oURqDEXbG3ITI6wVMdUvpMbXeiR2qfd4HkdO/+JdIjOcXxRMHJ5nxKpDh
         teEbsfO6s2uXOBlFR5wNcHPT4aMWZ7hrZPcZH4BayP4fwoSyJ0JPCEWL+9pI79O6/9AG
         D0aQ==
X-Gm-Message-State: AFuF++nbmdJ1/shlSg53bNh4Pn/18QNTi7EP/OWWT/7doCDG/HmMmObl
	TduPvQLHbNRgGsIofkLunWIKZN/Yzv2/2SkcB/PxmLh5QacvWK1ah/1kmy7WWpef
X-Gm-Gg: AYBFou1CwvETALoSkzAcoWeKggfqi6mG95ehzOsI7DoaeAeRMbIoeHSgtGxC6ZacIfZ
	Im9eN83z91kcwLyEiJe0+NrYazrhM3u4R+0lSpDOvbowgiPec8v5ocb9Ke6bxLnIGou48G1vThE
	eFVJ/NGSeQardiqQ5b5Kggh/nt7vRIIRujQh+PHXT3ukq4Ncj+jiuZY5dQFBX4sgQeusj+RoxAE
	2YhhGhN+mjVlAsJoNdB/w7q32F0v6iZlB003IitwAuHP5ViwJrPJZi7x4gyXVh5miOO5O+igl2L
	ycbokI0xlR6pQD/aFZ9leE4zxwsoyNFIkajR/E7VyYq8xh54fSgY+rO8tdBx5WCTe1BPbdqQ7Hm
	9m1XRGFNhHFkuxD6uk0Vq7p7vL7on19gvfsazFAPNjt9KuK8IX7kjzSUlsqklYxtjhUGKFYXgAs
	QQEjNRBBxDuDgU/EGhSGdUFHGkO8pjkCD9cFEwHImYJPxjiDZRHB9fEjUT+eGwQ3yo6PFDAHBK4
	v4yzA==
X-Received: by 2002:a05:6820:1c94:b0:6d7:3933:460f with SMTP id 006d021491bc7-6dcf4a5b20emr1499535eaf.34.1790781333466;
        Wed, 30 Sep 2026 08:15:33 -0700 (PDT)
Received: from [172.17.0.2] ([168.62.197.26])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd988cf6cbsm256168eaf.13.2026.09.30.08.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:15:33 -0700 (PDT)
Message-ID: <6abd2795.2259051f.5aa7d.877c@mx.google.com>
Date: Wed, 30 Sep 2026 08:15:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2913587970596449727=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mk02092022@gmail.com
Subject: RE: [BlueZ] audio: Fix stale AVDTP connecting state
In-Reply-To: <20260930101242.43592-1-mk02092022@gmail.com>
References: <20260930101242.43592-1-mk02092022@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2913587970596449727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176758/

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      21.32 seconds
BluezMake                     PASS      396.35 seconds
MakeCheck                     PASS      3.27 seconds
MakeDistcheck                 PASS      148.40 seconds
CheckValgrind                 PASS      155.46 seconds
CheckSmatch                   PASS      297.88 seconds
bluezmakeextell               PASS      97.33 seconds
TestFunctional                PASS      1153.77 seconds
IncrementalBuild              PASS      394.45 seconds
ScanBuild                     PASS      1136.70 seconds



https://github.com/bluez/bluez/pull/2614

---
Regards,
Linux Bluetooth


--===============2913587970596449727==--
