Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FC42086D
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342752; cv=none; b=b8LicDD/QWZv2xtpRm9J0Ccyw1bIkWvj7YeV6URC6lYMzw8sm0GJbFBtOqmAiXT62huGcgo3rbT7rYsgkGeOrdMjGCsTTTbPv8Nog7TyqQ7lheVJXSQiqAc9QoJHXZEBvzH0xJhK6TEEPBAXs4qNGOoauxW+Vzlhg4ySHyK83/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342752; c=relaxed/simple;
	bh=eKRv/E+7rdhitNlp2pht3vGvS8dtHjWtmTpVxw4KsVs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rE0uu2kyl+9X1/fZclO8saDgAI+nFkawV2bBRmIpQTggdiMg/DqDQCz/CDl1+sCh0pt0mPcRlFuuzzzCEBgldJ5VvgT2ciy0tV2C7DfHaE3sC2CVYMBYyuPJmvq/evpcCm0JY0FTxhbntBXyKY5ZGG+FWC0ORSMXNdFVgiAwwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALSarS0H; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALSarS0H"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1085148a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783342750; x=1783947550; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QUSfsTj08mO0xPCN8kDf5DAxy/MRLhEdDQqXvOxX7Uw=;
        b=ALSarS0HbxeazOqYxyfIlE68PyG+net4Z4mTLFu8B6LlmTpOmk8F4SOycToQLmREUR
         KaQGLUw8AAox2VZSZ/WwTuhW40f0SjjtctZLL4jHa5V0/uPGPc8YK9j3yxc8YRfsGzOw
         J7pQWnJjs1R0wGTBUa5O45aSDQB3CyFt5SjPy5bkzpj4fpw7enI/bbtNJHKwnKUO/uXK
         sb89xnhz+CJZageq1+lNJMiRfPua2Ui/F6iOxjzP20kS+YkKXYVfL0Iqwh01dsD1eFIx
         vtiXAbj65j9l8plf3zHb4h9N2LlsA3aaFe/F0NpZ6r2cf8xX7amnA6zlzwhJaD0coW0q
         X/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342750; x=1783947550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUSfsTj08mO0xPCN8kDf5DAxy/MRLhEdDQqXvOxX7Uw=;
        b=jSzR5dMbQ/f5D/WN4xinZqfiYVWm+A3qAi81P6j/0t98GW9xbOX9CakNU/AGwnLSqA
         /MsLe71VgtC0OnZ8rpWmW2BRA+nWhcz6lwCQPlJ8hNpcXG2IOlQbYc7OzY17I3obQhrt
         4oJ2dhcVs7wYiIpKqqIyL+E+6XgtPzsXeJ3hEX1zxtsx0VCcBBs5ExYGjOYfsBqL0Fev
         /gLmRmJ6rLBHmr32TA5JEUJzT6HOh9PwuEVue3/AI6Jj5RN5LwiiVrFtabloBmBbdqnG
         z7Znha2cha/7MFbUP9OGLWrhu9HlDN4IGEikJXauWd97KJTJTTb4QZwcAxTyhmWRlsA7
         RsAA==
X-Gm-Message-State: AOJu0Yykf+/96OMyxa3NUXJ0iIOXZSSy09pvNU/XHt1HIVF/FzuAPYhn
	wxTDrrMK7T+OOd+tAwz27hkhBHU/XgcYBRliJxO0V5Wedhdv76rU98QtJz6GAg==
X-Gm-Gg: AfdE7cm1GFZCCsp8vmmWlJ5J/GBZp3lAFmOj70KzKvz4WMadeK4PBd/+DXIlZMhVItp
	FOAv7wZOXxKK7VWoltwbo54EAwM9fnpkcNJneiYcOg07E2dcv7QWmgq2cS/Ewf9HNrASTMmt05F
	/SAv5lsr2gP4B06fhpGSYEal364mP087CA3CBB0YIlJ7U1YfMT2392CzXU3TTajZKRM5EwgdMjB
	j34X1HnlTor26Q6bpSZg9n06LRaAM4Wtg6ipp2gvCtbAQNhSHmG/PUTxBTXhrOpOoke21qMHcQV
	PV8OdRhv7voZOsDWPEsbWqT+PIqDlbtk9D47q+PBDxpvSnDQSlGifcKlObtFSkyPR4i93WJ8Id4
	+j0a12dt3DbKQBOczQVRyLwsJsmd+EbnS+7nf9kSZTNqiAvFxaGSabyHxak7GSzJZELAl3pYYuf
	vElMAppBcbwPTGPh0yz3g=
X-Received: by 2002:a17:90b:1806:b0:37f:b17e:133c with SMTP id 98e67ed59e1d1-38758c306f6mr231745a91.25.1783342749968;
        Mon, 06 Jul 2026 05:59:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.26.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm58235853eec.20.2026.07.06.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:59:09 -0700 (PDT)
Message-ID: <6a4ba69d.14d9b9dc.140829.275c@mx.google.com>
Date: Mon, 06 Jul 2026 05:59:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3875402380646491174=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: hci_nokia: validate firmware packet bounds
In-Reply-To: <20260706091701.77562-1-pengpeng@iscas.ac.cn>
References: <20260706091701.77562-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3875402380646491174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1122167

---Test result---

Test Summary:
CheckPatch                    PASS      2.12 seconds
VerifyFixes                   PASS      0.17 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.02 seconds
CheckAllWarning               PASS      28.73 seconds
CheckSparse                   PASS      27.13 seconds
BuildKernel32                 PASS      25.19 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      488.05 seconds
IncrementalBuild              PASS      29.58 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/403

---
Regards,
Linux Bluetooth


--===============3875402380646491174==--
