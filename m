Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E4197A7A
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210381; cv=none; b=I8vtwucdKztBtt1zT8GmIrm2YDS71f4Z/FzViFxMukWu6uuevpwdtWsXbu68FeV6h5ph2MMGGJg1Dq6d/aeQqCKVCY2fiJwWOST2Ir1WVn68Xhhh9VCiX6aZVI875D9wkanBYw+nomJ8xZLra5Qe3qlZqoQCGmiOOwk7tnBH0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210381; c=relaxed/simple;
	bh=Tvb5uRuvy9cDLAxFAh7fr/2cL5UwIVF+zwumJiP66fI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fYRTaKAciK+n1TOTMczfST4OEugFDvz9APhZRqw8hRToafCRCTcuF8Ury0Mq5uyOKZT/fcsvRtPHk/zTZb3cwND4IqoNPgls9iHd9x4DyDwZqzowU+yTGPRNtIWs9031QGu0up+R8KAmBlMwdigQ4LTYbvl9BDtksqVcIJituZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dok5EjFX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dok5EjFX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so35937936d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746210378; x=1746815178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/CjxJC5IT6gzn45SNYniyMF5KZqpsRjcQ6NzIKdHVBc=;
        b=Dok5EjFXC4J2k9/n3vbvofYGxR5C235aA/9fsD5n2CjkGYbeQ2qV2TQ8tmvvV3SFyn
         tpXvPN5ambScZtB9nifFtAAUznvjCn0MPgFjXn2U3lTgM/zC0/yctsOLKeSEdtxYgDOF
         bt9NicOG1SvoxXk9lPQRSN4jyQ+2hDNgYtYvniQuMBiszL5H+VwZ6/ZFm7Ju++pcg2mK
         OY0DRDPOe12q++Vm6Iz8MqT6LEGAlw9VK7B/p1vn7A7Oy0mtTW6j9NIuQfwUvkUObkGA
         DLo+z8weD0eKzGHUJkUGptnPDwe0ubK6CvGfita/0CedzHzAmzCl2hsiwMLmZq0vTa1Y
         s6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746210378; x=1746815178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CjxJC5IT6gzn45SNYniyMF5KZqpsRjcQ6NzIKdHVBc=;
        b=U8D5TsNuncFKETZhk6lBUxVBIyadrfYweta+4ClxsfgbQyQkt4Ga5O2hrSBFCJkc08
         eP0TCqWt/tcZCE25HGnd9WaI8nFNIf6N21o188w2DOHDEGxoa3zmYCiqhXK9bq3bxdd7
         JSTmkUtbwJwPORAQjj49YZG2AlB25zFeEn72YQzy/ICpedNIBGbB7h/rr+ZdhrclBFsj
         EtiFCodKWFQ/5sd4CqkiCMsqfw5Lx2tgH2Po3QpmY9Ou3Vr5KlIoof10QmqEXRlhtQ6D
         CXtspvBghMnyweX2V+el7rP/mtxy9GAummo65dg/Phf5yazIJmXm3xMoYJN2zEu3TCEs
         4Vpg==
X-Gm-Message-State: AOJu0YxFelDjxy1NctUNx93ABtjIsqCqZbiKufKK8d+UYKScc35FTza7
	06tFa5/8uEm5rdQtxf599irjkD91UPw89v9ick11rkM2zHM+LEXnFy7e5A==
X-Gm-Gg: ASbGncvOVH9kB3y6MO7s0jfl/S+UWn84Ge2MfItkj+zJHiFZZB1j3QV+Wwaey3ZvBym
	ldNM7HxnX4oHEDPPbXQakrxIyC3sjni5uSjD//Yh1iAi7J7iMSuY49KrIyinQe7B5EUFZ2ES8Hm
	Xorha2XjyAfR+ighrgaKIyKFbBhpzbbss2gVakC7Vrc6eLgHEYFYvZxweGX1OOvHjnVyYuUHPcl
	YCaQTfrPNDDdMuclWZFkiGsCXT29c8oAJSUJ6uGCsaPRuGq1bJYy5g5r8ErcKePGHG/m8Y9LXs+
	mPZd3XA5bz7ao4WPYtcDzQOEhl7incN/bsDcSuUfLWl7TQ==
X-Google-Smtp-Source: AGHT+IF6aN/ZDNPlDc32ID7aReygfORpz6iyKhRKYUOI1UWa6cVAIJoQ/NkxV3LRLHoMyi5a7cS1Qw==
X-Received: by 2002:a05:6214:495:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6f5155ec7a0mr63393696d6.32.1746210378288;
        Fri, 02 May 2025 11:26:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.79.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f44f447sm21413906d6.73.2025.05.02.11.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 11:26:17 -0700 (PDT)
Message-ID: <68150e49.0c0a0220.17f0cf.ecae@mx.google.com>
Date: Fri, 02 May 2025 11:26:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0587337900686271400=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] input/device: Fix not sending virtual cable unplug
In-Reply-To: <20250502165821.2753353-1-luiz.dentz@gmail.com>
References: <20250502165821.2753353-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0587337900686271400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959160

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.74 seconds
BluezMake                     PASS      2637.67 seconds
MakeCheck                     PASS      19.90 seconds
MakeDistcheck                 PASS      196.58 seconds
CheckValgrind                 PASS      273.95 seconds
CheckSmatch                   PASS      301.48 seconds
bluezmakeextell               PASS      127.98 seconds
IncrementalBuild              PENDING   0.20 seconds
ScanBuild                     PASS      892.69 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0587337900686271400==--
