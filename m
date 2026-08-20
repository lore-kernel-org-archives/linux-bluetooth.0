Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748C1EE7C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192788; cv=none; b=WOuLwqo5cCHKT2ImbhsKQ+8wFOjU3gX9gpuCcQsUP66zr58TCv6Y1xBGFJWPmLJt+HGrBHZaKCEtvoNpBc0uA0j9qzKdNEG9eAnSDBW32eiEsYYBNNPNDsbfOo9lJ2anPjwsEkXSQWxDUpcAmGYiu3d/JhThHeUbIP2FMlxE+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192788; c=relaxed/simple;
	bh=FOyy/t50ymGdTz/i1Vv+oimzUe0KBCOF6iPFPXhwaKo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o7j3pa98KwGRD6GnrA/uSMk9R9fdmmTSZDuiXEY9OJc6KzeI1FIIM9v0vMY/hoGFll5+2tqIflmaDiWuPQbtCd/NWKVfAe2+y3AJ1Ns9soJf4kLi+ttMLze53PTIV8CpRaBVpD4Mog20owHWNuIBMy43Tp9K/HKq7WeQnFDa5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP3IS+CQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP3IS+CQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so367669a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787192787; x=1787797587; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b5tcneFcjPLStXuuwYecF/RliwNUuIWGwmwLrN+yDuo=;
        b=qP3IS+CQTV5WBJNntv+TbIM+CfoX3GfaaSjjZvJCwzKXoqo+q9IHdfhldYeVSvPuis
         NNvuwFT+melmFEHoXbkiEj/7VxOiGjO93a9AY5yjobcFUAJiBSQlgaPrnJSNPZe6ZonZ
         +ccjuKNLYTv26oGKdTV6NYTuhCvS/QWrYbIfyes6+9VwNmH1N9wCeqeLJjLFU9wmLSb5
         3/Jz+nLDDCIYDM15z2hdOkybxHj0Oh6GTI1jN7/1pENWvuWjAoH/kgRUm2X+X/a0Ye37
         WtL1fPTn4w9Uz/BtERAx9YcIeq8iu6+AUcSuWBcNsWZ3xBp9X1O/g2KDvQAdWJdHDrqF
         Z0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192787; x=1787797587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b5tcneFcjPLStXuuwYecF/RliwNUuIWGwmwLrN+yDuo=;
        b=LTn0e9Y9mEmxvFHrwdyCyeCrjuZ1Lw/OQUmqQekBQ8dKnIaEC1cTPFNeLkztbSLqNa
         BhDOW2niC5Z+UsPT7dFBdguCxsCfIdtMif5Zsssi8LMdPntZW14nYU56/UDSUgGAVYQM
         aOP1GcHpxtwBmwa70Jt1qRsgq3UAqMsSP7uLccP5cRwvxz1N/AwWfmGfUZu2KPkMWF94
         VrlmUqXYoZsyrZurA0uib+Rt3pdKns/KRM1e8+54Y/2U2uRzy2JQrakLOb1IlJnMvLcY
         v5Xf+x67y0svjcXHTVprR2obPw6R9uWkITVULywY5nuqnu/pNrWZMWQimSo1ZtZwHtQ2
         XmLA==
X-Gm-Message-State: AFuF++lvoJLD7P6bVmF+x5bsAn4MyVx4kfsLYhqyfHV5+ZchftAijrNX
	FvSQ624gtiyrNZHwuAN/mFfVL8cR9383aIDaw0S5pdZK1m9BDAxuJEKWsF74tMFs
X-Gm-Gg: AR+sD10TEOSpYnYsh2hstzkloTVxsFXPngSsLPZIzvAbjYVf/2zW7rSDx1lc0LMYlpu
	judbvIm9ji8aBSmuuK2iOSSlyVNrcFwWPjLOj5Ly69afvl7rpn89Bz1cvwKnwvG5nGlnsPuw0SH
	8iL7AtpZov4I/Hp9qvP7+Lfz+RExwnxLGFQ11GH3PqsuNTCBZAb55R4bmrsyYOYYplvUPWRpvlr
	RYS0kRhvHPnRCjDHWIpmjm+FK9oPuoawIRFT+d3FXYQgq77GrL6YRUjFGRAVxjdh5gxTy0VoFnN
	wQ60hP+Nb2YmC87bBnmHAWU7BKqsgyvLnZramo2MAQQ8snBKIQiiAoNMF79u/gYO0e6Cvfsaor9
	rnGRRXCUadiSR0rlYyB0sta+yRDK8875PHF02YzhHapS8zUVbKLjgHwgGBGnmt2zaV+SKljM0tM
	ZOOJovAL1CBM4TjDzJD5hepFJJMZ16YEaTatKN3exDzjWkk98VFpSDk6IjhG79fptJiRxA
X-Received: by 2002:a17:90a:e70c:b0:38d:eaed:4adb with SMTP id 98e67ed59e1d1-395a074d955mr4439104a91.20.1787192786630;
        Wed, 19 Aug 2026 19:26:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.189.187.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef7a0easm13173535eec.12.2026.08.19.19.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:26:26 -0700 (PDT)
Message-ID: <6a8665d2.ef5297aa.34c469.c9da@mx.google.com>
Date: Wed, 19 Aug 2026 19:26:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8005041399318528770=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: [v4] Bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260820005058.1285971-1-lijun01@kylinos.cn>
References: <20260820005058.1285971-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8005041399318528770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148755

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.17 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.97 seconds
CheckAllWarning               PASS      30.09 seconds
CheckSparse                   PASS      28.37 seconds
BuildKernel32                 PASS      26.23 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.54 seconds
IncrementalBuild              PASS      25.26 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/620

---
Regards,
Linux Bluetooth


--===============8005041399318528770==--
