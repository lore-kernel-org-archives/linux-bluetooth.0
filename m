Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20037481FC1
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573023; cv=none; b=jzc8bghwsznXgbo/12zNYMMmpPPgowcVxwXvYZWFEa1SEtRGJ0mHbPyYp+2uoQ+90gXCLZm3Qp+ShWGTIO6Fxz4ASomkIGknKFrZfiCBHf7D8Ooyf57zGfb6jAj6pjEzERtPoCmRXFSGWdmmHAtugFZyre6cRhZQu+vBP0UW4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573023; c=relaxed/simple;
	bh=LQzigvJFwZM3cRP5liwRaI1a2e97PnJPU2JcOLx2emg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kxdOyQNPFCzFLEF/RFBN1RwHiaN25BdatyN3zxo+Pnns1mGUT0FdMZYFgJwkAhuVGyVurn5bpRFP6eex4nKVQn0NVgP86jqRS18pS1Z63jLDNBfTEQzaNmaZW6Zz2+zL0QAzuk34kL0EoI8T8YbktpO/MiUDTVkfri+JjoRdJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KETYYOqH; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KETYYOqH"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1332772f6b3so2125902c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573019; x=1779177819; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ISwBHfYRHmkcw1RO1YliePHGI/H6EhoAdcRpG2dy5dA=;
        b=KETYYOqHzufw/5Rk/TTZykQr8y8KmwrHvpzuXMOrH15lJSx0rxPNeiBG+nxFI2qYnL
         SbkEbQouBiRX/zagBEChO1G+3FpSDcgQjn6JjijsIne1F6qJgXaL2bmIQYG6wsbEndhP
         IBb6CGY6z+8JABOuzM49tfXiHH/yEUEBvQfwWseTZDWakZflB85FE6FQjy5Wca42Nlsq
         109LLKwFwdGLuiwldfygGrQPXVLvnZNzpDdgpJ8nNOTDQ9yknF99EvWhr7j7/Vj8BJec
         R8nMvTOgWi9RfjuBsB7lgVElJKjZTHx70WnGoLzldO3EL9/MAd7teEA5wUBScPynZjvB
         11Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573019; x=1779177819;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISwBHfYRHmkcw1RO1YliePHGI/H6EhoAdcRpG2dy5dA=;
        b=MUujIzr5jZs6N3or2I87WjBT7N+aITv7IjN0MIiQid7KCjHneDoEHHQYFyYdW0vTXC
         +L/4jr3O+zDZ/37sIZuyIkiG0llgej4JcBtrnsS6kO1V7RIj3lvO4YE3NMrBQPETOwn8
         QhjekyRJMJ6wEKRn3hgsycjjJG0V+saYpEN3+ed2jxOyBsk9uB1GvMyXN6HoKytuvrk8
         x08yGjRWuOxOb0g+IbV5rntcfU8s0ler2AS953Q4fmurW3jh1yhhpkQpyX+9iRiFi1A1
         dUFwRNX7Z7fNALBHBCgBnsF7rP4PUvXYUbfMW5UWygjcVxQYDm5y2+GNd9FPtJ4RQeii
         grTw==
X-Gm-Message-State: AOJu0YxmQOcX39iVXsjrn1nVVnxyEvippD4MXUztXF3zxDdoEKMUdfjM
	Nz7BPVJqjFsnCLbMkcC+Uj3d5GfgfYhe0vDTG38pjWvyZnl42BZDXfnlBVXDiQ==
X-Gm-Gg: Acq92OGsQ1SPstRE5bik8RT4PuRvGLVwIHaUoEGuJVH/ZAPdbhmFyWRWDtQEYLdUL+N
	iBnWrCFs3MsL6XVjfJf8wtXyQ9bnal6ax/st2F+xz3nUkhZFg/8k6uwKTU1SgK/3jvzrsjNCeYB
	3/AmJIH+gPlOcDpV+sQynQ+66O33P60Jhwh7lGVBS3sWVdC4G2VKIH3rGOb2vJlNSY/wOxXrQbE
	+1ajDhc3bnxAWi4FUZKH8IVusyjDn+Ni7jtcgdZyZspQW30rDME+y+uOpDpBL4Sngt0CZYpHLCT
	k6r0LCoz5KX4+dXqOj6gk2qRRCk3DhKM3pxvSRY3o1RNFr2z8wtO5VvoHKYN1Kbh6bMLqMzUKub
	5i0A4KMtT2SXeOSdqwXqB3Cy6uiXUpTSFx3L/TFnLKauWMz3YQcZ5hdS85Qg4w5rNiYZPTUP6h+
	lfW4AIqWa84eb9CNKsw7cE2qcKHaLi3A==
X-Received: by 2002:a05:7301:24a5:b0:2f1:496c:94d4 with SMTP id 5a478bee46e88-2ffd57c4112mr1055420eec.4.1778573018884;
        Tue, 12 May 2026 01:03:38 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.62.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c3b301sm21106370eec.23.2026.05.12.01.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:03:38 -0700 (PDT)
Message-ID: <6a02deda.050a0220.36b705.aa78@mx.google.com>
Date: Tue, 12 May 2026 01:03:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8784248870114816142=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v1] Bluetooth: btusb: Add support for Intel Lizard Peak2 (0x8087:0x0040)
In-Reply-To: <20260512062045.1213631-1-ravindra@intel.com>
References: <20260512062045.1213631-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8784248870114816142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093290

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.54 seconds
CheckAllWarning               PASS      29.03 seconds
CheckSparse                   PASS      27.30 seconds
BuildKernel32                 PASS      25.44 seconds
TestRunnerSetup               PASS      569.49 seconds
IncrementalBuild              PASS      24.94 seconds



https://github.com/bluez/bluetooth-next/pull/176

---
Regards,
Linux Bluetooth


--===============8784248870114816142==--
