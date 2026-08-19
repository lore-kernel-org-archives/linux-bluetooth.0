Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778E389108
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147619; cv=none; b=EGs1/wtLIh5cJB53i0I0NXa4Lbau3hXRwg/ig0drmqzB4jLUzi3KTOdTQTnltDi8IzICbHUQo0yQ7TS/cwkHGLbPBwKQG+u2K8fsrxw7tAJVfvS5rikB3fnt8rSxauNx2V/Nolx01xr7NlzNAujteTOy0ODO0zTwFMlkziTyCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147619; c=relaxed/simple;
	bh=dKYg+PwXS5gPMvOMs9VSuTwQJt6xTx3dWq1YJFa1g9E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HEstiWl2VNBcWaGJ5BqvmCFwyDljXIy7VHOp8Ez+cfGtTpD+MPRpJuPsBLopc2Qm4cC0a1w2uydUvz/RK3XHoc/777MkaQLHYdMecreA6VkSohe2ml7bsNTuSfxMRlV1IwhZ0RYmft5GG2ZuHet3EtH+zUxqXHAIkeyrfB/28wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW9AYaMz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW9AYaMz"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso14865755ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787147617; x=1787752417; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1COoMnoWsspalb/snxq1hZRnW04eRIXqCMzK6AJqpqY=;
        b=YW9AYaMzBpqPExtatw3uWiiajotLLqXtOw7u8opSVHn3I09aMHS8Ic5xJbhMHvLYWo
         uHDPVqOiY5muct6mi3BhZw7l2W6D/D47bKJQXgBVdkkT0eFSdiaypTl0YWq8yeBOaK3B
         jET0MZQYDZ9KiaL6VgWSxe/n2ONRAWU67oVHjDYi5CkuOm3pJbRMPuYb753wJ0+rv6aw
         YjNSJlULZbJNHZpt3U7sDJxLWclv0Ztt7auJZ84Q2c+Ztb79Je88sD++puVFBlXL6T7R
         RvL6kKYXN8PbvdhElyR0n1BgnxrkITIrt0kdw8XA0DJVjhF29NVDO89J4TwikmuVwdzD
         GUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787147617; x=1787752417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1COoMnoWsspalb/snxq1hZRnW04eRIXqCMzK6AJqpqY=;
        b=Sdgy5m28ChCc+kqZtIv8i3PD0zZsU6QZLAWKJfJvpExgl30BLZyz3+FegcMLEgKmQ8
         bG8UMWo9N8YA3dkKLKIvpdldx/rjun+m4+8IIBxVPj+tH3/S402NxNMU+33UbNy0SgjH
         SZZF+rVCCWmEODgM7qDuj+n061P6HlpN3aIMNovMLImpoJyAY/lalAntHNF5cstNx0sl
         p/lpyxged8McOHl9hoAJRD8w0JRatqxDbebtMW2SV6RoJxcifaxeCKNDEakvpufjHRh+
         zm0oIFOBUs7/Mzw8NqUdxIHc4ZJQIU7IDRwl1+u19IMrLnWpDf4Tw82LFw9Ivn1gdQS7
         28DA==
X-Gm-Message-State: AFuF++krwwNfzt6h6wUj9mF9ouCi3sBrDqWf8zmQIcojUIn98Ia4iC2+
	StbxcrRW/ZvcumidMI6mdIptfcvE3LQgOCx8m4KtoSHQI1ML7+DQYbhUDjiE6g==
X-Gm-Gg: AR+sD104Ddl/9klwi/Lbd6ngCdGO2KjB3yjkqSxO33mc4/NH6DfDrPGQrwOKwoEZKiq
	3qwrsTJygAY14AP2uqVGs2n+ELRyiymJR6Pz0OYS6w9ykk28ZfBYBspF0l/Tjg9PPXvYCRgCxwq
	poXRfjh1Rp2yh+zlUwiKEqN9V8VEfChMkIWy97nkVMEgTw86gqjZwk1UFtBVNM18ysdGnVjPYew
	35YQ1oq1s5q9y17bsDghQyy04CI8mUFG8te3LT5CKRFTQbmprUu9YxV69tArFqdNT6g5BCr+UqQ
	M/NXp1zUXljq0Sd+Zim83kXOLfFl0J1cOZ2ZVkC81nQErC3laCvxtQtzx0hZEvtSLHCeOvsVoDJ
	iQksF/RFva0Zna6FYfpnlPrelVcurZho0LLA0WWLpI+wcxJ6KVCbasbI7zmUb/SbSRwvp/sJso7
	rupd+v+xi9ugONTu2NKls5GN435Obenw/j1VwuyYCevEFJKQ92AkS+RA45Rhxq/N/ZwYBF6w==
X-Received: by 2002:a17:903:b4e:b0:2d5:ea01:429d with SMTP id d9443c01a7336-2d60197e7b6mr96604005ad.14.1787147616955;
        Wed, 19 Aug 2026 06:53:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.214.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf13f4bdsm7847589eec.20.2026.08.19.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:53:36 -0700 (PDT)
Message-ID: <6a85b560.3cce8983.306598.bdde@mx.google.com>
Date: Wed, 19 Aug 2026 06:53:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8089144896616499872=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Do not write to the serial port after it is closed
In-Reply-To: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
References: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8089144896616499872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148470

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.66 seconds
CheckAllWarning               PASS      30.19 seconds
CheckSparse                   PASS      28.77 seconds
BuildKernel32                 PASS      26.67 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      506.63 seconds
IncrementalBuild              PASS      25.77 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/616

---
Regards,
Linux Bluetooth


--===============8089144896616499872==--
