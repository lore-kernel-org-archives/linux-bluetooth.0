Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD63E3C5F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384917; cv=none; b=GKll89OWwf60ll+2Cb1wA+1qJay+DUps+PtnF4wsHGtP5G4sZhm72JWyD/pPoYzUGBkj/WCdpYJfQHtBPReeIeeNszUEGUL5K+8iyDt7EERZ18CDnod2LQoltNw6qrjYEd8S66eea5kr3JF03WeTKMyRQDVnt6pPIesug+Q3T5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384917; c=relaxed/simple;
	bh=vFBgcOo/VsQl1VwuMGdSeBuJLQXOrQS3PKBOD8n4E9I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cZ+E7pRxUUq+4zLIf7zvX3EIN0BGTDzVTB+WB7iltee7oRbjA+pK0ueLgwtc5YQaH3TujGnbsky0Y4vjC9zCQBn6+DkXe1ZubykSMEnZ9WPnl/6NUNrdOvmtvVVxK2Tamso+QOCTS73AvKQs22/tpb4fXYDVy/QcH5SVW9zOYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh05sIEV; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh05sIEV"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-482620dc91bso180217fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789384915; x=1789989715; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GSbGwR4uOWWtXFgowTXrzjO/7p7gO6OJLtDh/OYDRBY=;
        b=lh05sIEV3ussTsP1vKZFzmkMfY+UUK5RPHU5CLQXgXRHNb47MuafloeCyZE4Ilnyhh
         N3XHSFOtIbjT77VH/czfUfbI3A1WJE75WRA9U7tBP2lBJPrXQ417OwClPTLtn3YSbHJv
         akpg89d0sHDlm6lF6bK9QPRyKVioKC9W93Mb2NCVEcsLUpmVFG2QHkg9fMnlZEphKjAk
         1Mf35k9LtjtKlrjxzdpvui8NhEZkXF9HPDFS4C2SeBNxGRg2aXt9MZ3ZEe2mhHr0V/EY
         TZn3xq+8ZNcazu7bv1Z1LK2zORlMxPGphUOQcikjLsVIaslWoWJxxIWGmbI/M+JHTm0H
         Wv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384915; x=1789989715;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GSbGwR4uOWWtXFgowTXrzjO/7p7gO6OJLtDh/OYDRBY=;
        b=VLcokL/ExdlfHyU8imNFHtrABDJGCkRzDn6+ITdCtVM2JxdnHqNz/i12xTLg2vHXAI
         kj/BPqWnFdssDOM9lv5qVQsc/gFKyfkh7GzCxpkt8S/DO9YWAPXsfi8qtAmdYJGmjLuG
         z0RDIWHf5TsaTwAsxSPcpvwaLUUUcUzWxG5oZ6Z6LtexO13RtSoLtz2rhkkXU3ve3S1k
         316SXzc2cod8bcFhsfciqok+/NnP8WUcUQYudqPD65T7SNaaejwg6V2rN2+qmP3Tawy/
         JVqQjeWz0rRiMnGEQ8FKdjsrNPLyGgJARw9kqeSA5elidyIgeGlA76ZRc+wqBlTOficd
         Ju/A==
X-Gm-Message-State: AFuF++mdXhy104S7M2yJ+gFH/KWmOsSo8FN99P2lnF3HbE/c+SZjWhGB
	9Pgjii47iuUBdZ43ezOaiG3hhURgH6Vxa8EVkjzJiWWEvzzWrd3zWYPGazc5/g==
X-Gm-Gg: AYBFou2IQqeqD0pPFkY4BK66RKod1pEZI7cxvlCPLUdtfiTfDGhOodyqRx8gOVJrlZB
	1k2eNXzRDvRJd24b6FzLbO8sEFDgD0erJjx/cocJrpGkR2ERLDAGsIhEbWTp1UzQmlGxIbY+c5g
	9qngGxpJHLnzj5Ap/QV8ho/Oy49JlbWWxgQG5JOc3Twpsg5VvoiNlEZf4K3BG+rG2OfdyHEps6T
	A9OhxW5+aM7CTSgC3yxNT+E2GmjeTlf6tCWeCoBUHH3C+PVoz9okbz/pv93idZRIF6S+fS46m/U
	YygCIaUYxoUS7JEpc82F7e97yLR/35rye9m6dff0asjsSL+kY0nWdLFfzadeOayNzUfBinaC/1r
	mpmWPBx+EZdL+JjHzv9xXxLd/XZSRrkAUeljJFmWgyFui02GaSDprA538tmOPTbZNxX/tB6TNUI
	nXD0klJUAP3mB3joFQBqyODX6z2U6mm+/xlagw1HUA60pXoUHhaoBetZNmTP2hrMztjC5tpBlVE
	CFHUQ==
X-Received: by 2002:a05:6871:e490:b0:439:a524:a29d with SMTP id 586e51a60fabf-481f7b26443mr2082244fac.1.1789384914850;
        Mon, 14 Sep 2026 04:21:54 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.39.23])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df96217e3sm8563394fac.15.2026.09.14.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:21:54 -0700 (PDT)
Message-ID: <6aa7d8d2.73f9ae50.eb142.7c89@mx.google.com>
Date: Mon, 14 Sep 2026 04:21:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7101434669600501635=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tzungbi@kernel.org
Subject: RE: Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown
In-Reply-To: <20260914094729.3222624-1-tzungbi@kernel.org>
References: <20260914094729.3222624-1-tzungbi@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7101434669600501635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164398/

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      19.44 seconds
CheckAllWarning               PASS      24.61 seconds
CheckSparse                   PASS      24.88 seconds
BuildKernel32                 PASS      23.04 seconds
CheckKernelLLVM               PASS      20.67 seconds
TestRunnerSetup               PASS      486.33 seconds
IncrementalBuild              PASS      22.06 seconds



https://github.com/bluez/bluetooth-next/pull/766

---
Regards,
Linux Bluetooth


--===============7101434669600501635==--
