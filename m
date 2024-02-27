Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCD35884
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073287; cv=none; b=H5vU0gRcIqhonDokGbUFTF4td014py/hihNbsnhX3KGsxyKZrLFgfC3oxZZW1FRNDd4IYkZHVMKmjsA7dLQHGbngjf0HKVaGQSjvk//J7mVBCeM3sM1OUCLFN1+kGKbmb3fiS+KAOXxHWfb82d+OPQNQkenAoXsd8H9fKnkJ3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073287; c=relaxed/simple;
	bh=hjAPeo8KgY7L9d3ZsOxpOgIVKFPMZBOjUZaNEMDy0r8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cHMY4s5p1AJ9SumghOxBfbPewlox/UtsoechKPv+LPwjcqjqLS587U2zPbxbdLBBT5qGvYfDupbZx3VY19lYsYelno0xtaTK8nT0HZL3WGh7KwKE2GSrdSsZUWbi+3s11uK+ni8qdvdwaNbVx03krpL0b+WREdNf77hVCMjPPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpgDq4MQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpgDq4MQ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso4811185a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 14:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709073285; x=1709678085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o3m9ixrFs31DurxwDzRNHeBk7KilPBU409yF/tVv+O8=;
        b=VpgDq4MQh+70DRN346OvNxz/ebuvEhfBJ8qI15ENBYKsdTW/MVzcYoENgOSelgh6gL
         J/gEup328bO0rv+f3qtrvAXUscDgjFDWP7WGtFKtll/N7mWWe5/p38xLdxWKHZkagpQs
         iPMCenICyCt+TbIkGVbr+ss/MpXXCiirNNVnqPy4Ck32amakKtk8VriMqujrw0so+gO5
         cWf/4V63a1UM1ZD5oNKmlApj6nADvGlzWlV/cAxJVDtPAitcmHinsjoJbch4U7UQEBpS
         8T5pE8Bl+XD/AYp1alMg9eA706huJ85DiXOaUFqbKXnpIN4qdg1cxRRGmY7eBXgewNzD
         Xe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073285; x=1709678085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3m9ixrFs31DurxwDzRNHeBk7KilPBU409yF/tVv+O8=;
        b=Qy+mfPP+6qn3kEiUlv+G22FGtkoajtKeN8YsTzUAcEWQZ+am1WJPKaG7rLLcszh5up
         4xe7wiyF8pyu7Ci/WHFRC2Lq8M1doo61PEkhFUEkt1sjnA+xqO5J2UggnHSWsjIoQBuH
         NobPFsSqc11xSUdpXDQVMwckgynlC4ahj7I+N7/FLu6eLwS0k21ESEVArs69vQvfmz0Y
         ymIRyFYPGNXWZvtsUnMwG0sOwILAUiHHnyJNcw0ZYic1+cEeJTCXCANYK0Ylej2mqqsb
         NG3noJooKzN8JzSh27oW2m14+aErDM8uv7F2rUt+hh1cyanFVZJ6SIwBiALF+laDkEGC
         WKFg==
X-Gm-Message-State: AOJu0YyyVxYfbGqC4LD5JrfITqU84ojbU09tgUC6+R2GW2MHUKChcq7C
	J6gp85WGO2aK1WOh8A3VGsNJ/pkH5l9jlXs10ruUSNA7XiRpJ3xvZCT1Ngux
X-Google-Smtp-Source: AGHT+IFCe4pxcl6ICfaXccg5Ev1DNf12jEYFUl0EYbjiKt7G+2l5n9s7CZGkCdAGVdE/iHw86e6V1Q==
X-Received: by 2002:a17:902:8349:b0:1dc:1fda:202e with SMTP id z9-20020a170902834900b001dc1fda202emr10763954pln.51.1709073285322;
        Tue, 27 Feb 2024 14:34:45 -0800 (PST)
Received: from [172.17.0.2] ([20.172.28.133])
        by smtp.gmail.com with ESMTPSA id ja9-20020a170902efc900b001dbb06b6138sm2009559plb.252.2024.02.27.14.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:34:45 -0800 (PST)
Message-ID: <65de6385.170a0220.c664f.9be4@mx.google.com>
Date: Tue, 27 Feb 2024 14:34:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3530683975577613767=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_sync: Fix overwriting request callback
In-Reply-To: <20240227220428.2035718-1-luiz.dentz@gmail.com>
References: <20240227220428.2035718-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3530683975577613767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830444

---Test result---

Test Summary:
CheckPatch                    PASS      1.26 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.56 seconds
CheckAllWarning               PASS      30.30 seconds
CheckSparse                   WARNING   35.87 seconds
CheckSmatch                   WARNING   97.82 seconds
BuildKernel32                 PASS      26.81 seconds
TestRunnerSetup               PASS      498.43 seconds
TestRunner_l2cap-tester       PASS      18.17 seconds
TestRunner_iso-tester         PASS      32.34 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      112.17 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.79 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PASS      25.51 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3530683975577613767==--
