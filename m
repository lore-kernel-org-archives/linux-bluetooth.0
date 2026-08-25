Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6703019D8
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631037; cv=none; b=pcrej2acJCz3HVFAUxiTW1ZxLFk8e62l7p8oEces0/sKPZOYhrt/IXuSumt81obYaq377WMF/iOrMPwM31Xi30VqCErB1n7b3D8LWaXK/KMu5VScNdC5KQVQzBpv5OB1R9mWkkibriztay3+AyAX1Pk9hwnpHp9E4zZUNuUiQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631037; c=relaxed/simple;
	bh=GEkY0Wb6shOfoXZnZAxcloRz8oa+M/HSNOZo6NU+pAc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UBY39M8LCp6VhszzOmbGHScXH6s1sXBF8XCEP7h/my+UyRIoInkYdgXn659i9p5YrRZ3oxaSfKOnzT6Tm9QYUWXi/S9aaxMHztoagXb+wjIvoafAtLxQXUcQ3rMDIy0aZPihjlfRgbrfMhtpRZsRGUcqpq5wyWxYZHLT1E3DX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA00gPND; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA00gPND"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso6834387a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 21:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787631035; x=1788235835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JiNFJyK6Ygi8Qsj6q0eL7++sgutuJGnFDU1ah04+elU=;
        b=AA00gPNDY3/0tUxOJt6A/HBORyAzOitbfgu0bdP0rBtBmNbmg1d6l3tqZqlGwxOoQ+
         ngqrJu5Mw59F7UX5MLrOfnxSBbS1RtIHeyJd00DW13GpLOrhrwEvd6rHj+ovJj9BELdB
         IRTLdHwBuoruO///T5kCKRZ95Yx4NIvKo4dxY9r+8UJ8Q+png1qn5OZgMPtUEi/9uwwP
         0Y6Vh452aC10+3+Q9ITc89yguXTPOOLDakJXncewf06EbnohyEeKOBJ0mdwz3JnzhShv
         CfUpkqfin2rFPr77UQ5z5JJXGWgIauDcgI2/UW7rxV8WGGaCSq85a87LrDerXWKe4/ml
         geDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787631035; x=1788235835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JiNFJyK6Ygi8Qsj6q0eL7++sgutuJGnFDU1ah04+elU=;
        b=mQ/hhkcMkQVLyeAYbO1l785mO+TWH6z/wj7JPLvZXwsU107zwNk71wE6BwrXOrfE8B
         1XXSF/WPhA+hQia40oeZy45exf9JiCeW3wkm036SIiNTICuaHqNlFzFOnW5MdWgLQB0V
         +XnfMiu9ShKa0M9SNM72nigFXCiAVi3q2y+wYTkKDsuxGscFY2eGfbdNKOZoJjn33KjR
         8lh2Ed9L0YSTxkFUR9tELeK9S1PO4buTISSBgYqvmKQdnfKH0ptQmVcAm9PcuaJHnXsr
         EKVoyFc53ekVLBGZ+xrYkrT1KJGeESsUinWW5BG0XByhRb+l9IvaaQRAbhkHo+tlpGAu
         zXrQ==
X-Gm-Message-State: AFuF++k6TvaHLC4HvpUVLeDG87eCug/cqrsaZT1UOuOoo8ZNuy4+FLYU
	A+v+fMU6jaEFhCiuQrDQwlB2FxIVCenZ2gqbP0566T0CESIZX8dCUK4VLRezrA==
X-Gm-Gg: AR+sD10kVPghAp59uplI6cSxXMduJMzgP3j3bydneco/fdNrnzak3Tb/2uxv8hApLiS
	zWcgv/0kzX8WXB9GytPvmf6awTlkESSEtxkhgQFtRkb1CWxHyVtjY8h9spwt2f1eYD7vJbAUivz
	mNbtEwzvasj6xRy/fF48ECnvTJGfpbUhALRxm1kbxYFoBReHblI1ClBjCy3lYjnffa8+oKDts9n
	7tLcPu+QAjPVQ4LisWfxgm0ld+7HhvKEKX3wsdf8jfPuq9goNOTXmUQOs7IV0Qpw7HnfDPELjoI
	YIjlCUcSF9WdS6Hqht8lCXf4q3UyoBgiThEBFb+kP9vtGJBGpyi94G6caaDupAvA33nFo6t8MZD
	SMItwB8bYf8zEt3Xh5ASsLhOhDETbEasDw2w5LYx3YH/D4XcIrXmWL9zx22FYxi0NrRbDBCrJDj
	Eg0eCujyHNs+0WNsScC5BhrMrDlDEObe8yD93aXqiJg1SMA5d6J53wAOm0KM3BLPU1utR8
X-Received: by 2002:a05:6820:1514:b0:6ae:4d93:cdc2 with SMTP id 006d021491bc7-6b16b2f5fd0mr20431586eaf.5.1787631035346;
        Mon, 24 Aug 2026 21:10:35 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.78.179])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc866b5sm6181804a34.23.2026.08.24.21.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:10:34 -0700 (PDT)
Message-ID: <6a8d15ba.a29f8321.20795d.5c05@mx.google.com>
Date: Mon, 24 Aug 2026 21:10:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0690000940891605452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtksdio: Stop discarding the hardware device id
In-Reply-To: <20260825033634.499118-2-chris.lu@mediatek.com>
References: <20260825033634.499118-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0690000940891605452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151231

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      23.49 seconds
CheckAllWarning               PASS      25.63 seconds
CheckSparse                   PASS      23.78 seconds
BuildKernel32                 PASS      24.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      401.40 seconds
IncrementalBuild              PASS      24.67 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/650

---
Regards,
Linux Bluetooth


--===============0690000940891605452==--
