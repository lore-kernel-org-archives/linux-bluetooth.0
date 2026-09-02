Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026E41228F
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386311; cv=none; b=ht+v3SiRyzxDU98vDFpKhiIE+hF1pC3Ao3iwLhYIgRaBIz04YezDohGDVVlH8sGWGgoo/vkDEXs/4iyV0/AdqdYSekQAsg9yscbEi1gSCNREZYJa1uMIQz4pkTSlxhO5+5FVhhOvI8AWLaP4THQBMbeN7jkZb2J6KTOY6MYGt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386311; c=relaxed/simple;
	bh=2rh8+OvzNV1DFkegI6WRYhpduQTcHHo4diDagiz5BT8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wg92LXg5kXh7I9OexHZqSC1FS3drYFC8J28OH7pN3qDa5cezme1lSOi5sNx2iB+RP3Aix8cyMlGcYRwMWFqc7iM12vJ/ZRexjZhsx/Kv6IG3MphEzIZE9vXhNJy8y1uccpB6uN9iAlxBv20cjP4FjOHfzdzvKNhuoCd+zZI/9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMnKewUc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMnKewUc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so276531a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788386301; x=1788991101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8SsmyVdIR9KzTxLncwYB0s8GEgYDwIO65J+RgVjWlqk=;
        b=mMnKewUcqqziZyUgOKYeK8V4p2D9UsoVYIbETrU33LUGCKw26llxWB7LAQR/51TAxu
         F/RUBBpitEMYKMFZiRdz4H71JZaKRJzkthBBbqVdiTI/+BwkeLl0q9ZPULiveYuV1q38
         cvof+LyXfoQt0848L1KRgusjqUaYXDUuOV+HeKmZyPu1R0dzaItaroE97LWYe3u95jYK
         wCLsc6fi5ElMJqVSeimFWaYtEojdLou0l5CB4R+JKXX/0UzNCtOxP78ySmDeoBkzyTl1
         N5JIqKkSDG0ZuF7Vq67f2Q9qEacUcbgRZnosXtce/9R5YROHm3ug1LaW/jZp3ye5lAoZ
         GiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788386301; x=1788991101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8SsmyVdIR9KzTxLncwYB0s8GEgYDwIO65J+RgVjWlqk=;
        b=PLE9Kdz/uwlyJBxreRoyon5yLErkbeQOkfg7Rdi0gc4Zyqy7jD2u9cydbwrmyFCNDy
         NGpunSKknsCduWpyRFISsT2kfiUhazQrJzL1h4lTSVCdzmj266oAyaXry1ly0dUABi3w
         vo6mx12OPxzP0pj+aZlSXInzSGOXTwGGpATv3oeXDtVX55LpSdza+99ksWZdaqvOQ2TG
         vjDxfFEErZc8i4Gpk/qg6W1yegsZlNkagONE7XB+qAT/GHi9eh7jPbb7v224G/jypIAH
         WjY8CdBdSVt2uxUgIarIaTsd3K6+UTiylyQD2Vik7E+wSY0L0yAQ2nVSV3hfAzmTaFAK
         uwtw==
X-Gm-Message-State: AFuF++mHHWYqhIDKjajyiqe9+Yg7E/4CFiYSzHeX0BOEEUK8tT4MSk0K
	KHFIybdbY4aA5iKc4gvHIGciHmXJZHdMAGNMEN9xEolE1eFTHR/erHLMkhllSg==
X-Gm-Gg: AYBFou0kgjS0OWA3kRE+mc2/CDWL6hWzgjNsOhUwT9XyRwAzZXJTIY5IGu8NcjVztbH
	AD145CfSvc/4YzsTrqhqul1/lua55cnT9Lq0NY/Z8KNxMbVW0jp6wP40Xdn9i8X/UsvfSDzT15l
	XKWbBib4m5Hz6er7TvYV9Dq7IofyUiAtOIhPrqon9pq3k41Z935ijT4NDAEHPOBp28AX/BoVodR
	8bJxOWm+1g8yZrXgqYXc58HNLI0krxpCSWOUyn9egmB0AFlZMpfDnfpLTt76sv4YDMSWh4SlYvx
	xvjkGlczw7LNOEB0j3s4sk+yUL0zY4emVSkCrAo/y/Sro8jG8cYxVJSo+7OaxFfUT4ryrskMBO9
	b63g1ulqpNXAMDoZ77WYwWqVyVBVSmQ3YUqXOfvYJxGf78Jevm6sPFIiEe5jXrfFoSxLeK0gjG/
	ox0Zsrii4zgMp8Y1T3MzhJGG02WYigqrw3pR2m/JlFcSImarLKbf6/Ll4xztscbLChvN8m
X-Received: by 2002:a17:90b:3fd0:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39b07fed101mr2052751a91.10.1788386301346;
        Wed, 02 Sep 2026 14:58:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.47.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325367238fsm997508eec.2.2026.09.02.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:58:20 -0700 (PDT)
Message-ID: <6a989bfc.a865c849.178086.014a@mx.google.com>
Date: Wed, 02 Sep 2026 14:58:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0725087634288674816=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i@rong.moe
Subject: RE: Bluetooth: btrtl: Don't leak return code when parsing firmware format v2
In-Reply-To: <20260903-btrtl-fix-patch-sec-header-rc-leak-v1-1-0ce37e2149bd@rong.moe>
References: <20260903-btrtl-fix-patch-sec-header-rc-leak-v1-1-0ce37e2149bd@rong.moe>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0725087634288674816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156419

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      7.11 seconds
VerifySignedoff               PASS      1.45 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.02 seconds
CheckAllWarning               PASS      31.61 seconds
CheckSparse                   PASS      30.12 seconds
BuildKernel32                 PASS      33.64 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      521.59 seconds
IncrementalBuild              PASS      26.81 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/691

---
Regards,
Linux Bluetooth


--===============0725087634288674816==--
