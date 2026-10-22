Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674792;
	b=mADANMGUa5ehntU9/Vu2lsltouY9eyX+StuydDuWJCTqUEx4AwQ6mLAbkmjXQrAhZbg7
	 NhO3OuVGJwmZv+i9wRd0thh1LKmkNGd0dQcMhQIzgUUP+w0DymXENLKGL0Mt6BVmbANWc
	 fAuwLImwsPfOt1pGtChnofJPQZMOf7S96R5ffXyn61MKdGm3AIHr4ZNPyeCqEpFk7ocGB
	 W8ryKhuTzu/PB57gpbbLwCs8c8BBvP6L68iChRx7zr+55U1H7himob/I478mQ47wjsWaa
	 GKYIszjKUyJKDBKy5u8lbBG5Equ5sVzzRbLIkrYmHJriyLPeafeBXuqGAOmq0q24Jrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=sGyLFuhO3GT62G94sfIvw+7i73Qjau5Nv2ndumXshMs=;
	b=oJ5IUFORx3KRwz5+CmBY4JlkKhfsYQX0xd88erXu6KT8kMwKtP0W+LOTgEorHbB2EFOy
	 aAeVsGlGBavCbgiupuhD0HtK6MsSuTZR5/38zgfUPyTprMGtwAG+2nBq5e5WLmpCbV+OL
	 IjsqxDMMZ7EyQFHuvBTJn9+KNxaW+d/AzK4fuszYtqfjbFTKGHNvnsCWHNU11xd0J4tho
	 oErM3SYso09cgBKofGv2IiiKP0kJTEVbB0dpmEgLd1qinKRqEejg5wHC9yAqnhSMBXhdH
	 NRHugdfQ30OMZg7GigpSi0n6PTxIgCyyi2iKsmph0Vt1KW3vFfpGvlc1aCpyQWXY58A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rZY01IyX;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65470606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65470606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rZY01IyX
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-846566246e8so794419a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674790; x=1793279590; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sGyLFuhO3GT62G94sfIvw+7i73Qjau5Nv2ndumXshMs=;
        b=rZY01IyXiZh4AkKB33YAfCa8duCdNcJF23OrFYI4sSyRv6M/GY4jp2L0mD2WtLWrwx
         c4UXF47AbYXVYcx6DB4hFMeLHLnA0DYPFzW724AIrpIAuOXeLfgGRYaHdJAszSHYt/u4
         4enaGmKrFFtdiy8q+hmH0nYVPe+Aj94vBCg/9+sk67LKk8ZeqqUZrcb9gakDbB2lVkGd
         MnWQmhorX/sBAjqVKOC6lOtF7Q0rCMHSM76aOJpXcLMZKnKX+WEN82HlFIj/Bjgmtrsh
         54RgIIm+EZNN2s6uqHuFyi8r0l5b9yC836ZxqA/+f7hVZwRx52Mlq2zSp7cqUoTdE9QE
         9uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674790; x=1793279590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sGyLFuhO3GT62G94sfIvw+7i73Qjau5Nv2ndumXshMs=;
        b=Ypuve59RIT3UeXFgGJqd9dZhrWKyi/onoIZgE2U+LQO+Irji1h4SMTUJtT53c4FN1P
         0n0IG9+D9p3UGDEGpxHN7u20zSL7VPVDSo4WRdjBKWEILjPh2hraLzPr8sIFIIlcmtx5
         LSGEjWo9fDij4ww+i1vxQggFxF/8Zj0+mhlMCwflRRuXtoYx4L8zavzNly8A9ILkAhKs
         tlABgk/NORHcjihzS0B6WyQ6BF21S7EdGSCtg4rxwtYMXPhz0L3ceCp9y48qn+G76nZE
         jWSKX49IBE/a0xUPQ+czYyaTmtGJbrmFSy+4Ne/Q5Ef5tgiGja0/ZD5LiulA5BSzUvDn
         Xcig==
X-Gm-Message-State: AFq9FYLHXlp/zFF9DvSoSAwjuXSgadmjqixVX05+6EtkYfHqcnSlSEr+
	2PYEMS3J449iBgm2EvBUePRnk8iNRX8+rDckhhzgfeYtDEF9LW4bhqGPc8TOvw==
X-Gm-Gg: AYBFou2HxHNMbYGFlxqmuz927w6SKkMeQLDqozh5S9NCX3faKLFuwKdCqgJNJ3ZBrr1
	9+DvK5sxBLn3SXizWnjbP/eiOfkMqaa+ZEtND9ZxmJ8Zdp6TzjujPf61EIeJPDPCjxKAyCKNmM2
	4kgghwyFgNooXrEUcMNkE0qps6BZ0je3XFMeMRqrY+1JwycUlC0TIRSRqXhHFjO1VwK5/ksEsV8
	0C36JdfqiM7dMXjDo0EaFwD9xXbPazFDvPD4Ot2RR9R44qIO1qr+rgaGe0J9O4lB0kaDhoZBN4a
	vhOK+DoKEEU3LfwK45LHhhiGCddrsVdJ2S7c9jEwlH2T2UAwO+IEJJTiebQUq+Wr15gkNNUP3yZ
	iMxtnkvsKvzV0KOHrtq3fWAFHAPAlZsGvsNOJHMf+M8kvqlBQhMEyj/vwoYj4ZcneD1ioLWpUDX
	fFMx3aX5foKThxam7hyP7TXAvrYNccLduajt7w2QKRrjSbMfEOG4OtxuUqAOPHIAmQVxYb0Zfrt
	1FMnDwBKyvzDBbcaQIDogz6arSqhIKJ7MHbH3cqLYibVejmMs1Zp3/LxJzCLMw=
X-Received: by 2002:a05:6830:4391:b0:82a:1141:e62 with SMTP id 46e09a7af769-84e33802f0dmr1303162a34.20.1792674790357;
        Thu, 22 Oct 2026 06:13:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.253.101])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbc7d9c39sm5191372a34.4.2026.10.22.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:13:09 -0700 (PDT)
Message-ID: <6ada0be5.d47bf0d2.8dc80.282b@mx.google.com>
Date: Thu, 22 Oct 2026 06:13:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3200689349759447005=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
In-Reply-To: <pm-bluetooth-objects-candidate-0158-v12-0137c5e23ffb6986d911@gmail.com>
References: <pm-bluetooth-objects-candidate-0158-v12-0137c5e23ffb6986d911@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3200689349759447005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191277/

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.72 seconds
CheckAllWarning               PASS      32.59 seconds
CheckSparse                   PASS      34.35 seconds
BuildKernel32                 PASS      28.54 seconds
CheckKernelLLVM               PASS      29.12 seconds
TestRunnerSetup               PASS      643.77 seconds
TestRunner_l2cap-tester       PASS      14.29 seconds
TestRunner_iso-tester         PASS      10.27 seconds
TestRunner_bnep-tester        PASS      2.94 seconds
TestRunner_mgmt-tester        PASS      85.11 seconds
TestRunner_rfcomm-tester      PASS      4.22 seconds
TestRunner_sco-tester         PASS      5.35 seconds
TestRunner_ioctl-tester       PASS      4.44 seconds
TestRunner_mesh-tester        PASS      5.29 seconds
TestRunner_smp-tester         PASS      4.83 seconds
TestRunner_userchan-tester    PASS      3.01 seconds
TestRunner_6lowpan-tester     PASS      4.19 seconds
IncrementalBuild              PASS      26.39 seconds



https://github.com/bluez/bluetooth-next/pull/981

---
Regards,
Linux Bluetooth


--===============3200689349759447005==--
