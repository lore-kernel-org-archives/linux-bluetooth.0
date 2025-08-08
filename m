Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876981EA91
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683908; cv=none; b=Lqw8V2ysGBSEza+XhzzNiaBiOcTQQO+umdNk2bvmHE+sefEbrJ/D2rQxb6oAdxdKKZooAJQ+RiClwqu5unXC4644dzuAiUV4QOxgFqK5DuiqZGRc42Gr3H/Xu+E1LeawSaZ9IUDLFiV7kICODFcywKGYveBpokmZK/GcSTAteU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683908; c=relaxed/simple;
	bh=5pUFMjPosqEbSZlSx+3mRMuCW4vMd5FdjeZt2wUtA6A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fj7g9kF4IgLDO3S/0ySTfjTVKxSLgkUvrix7XAO1/CKGdsagS353ncduFD2vcjOI9C/+jDDDlO1kRtVHUUMj04msagMYIUPH74UuBJcWbY3GrjzN90Wfw/RNz1uEcPGs2vnd/SmKcQ3R4DTqXHK9M8QBoIE3en87NZDcu5W9BlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHpmbcv2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHpmbcv2"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7074710a90bso22339616d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Aug 2025 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754683905; x=1755288705; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8jrohdztkJhSC4BFpVJAhNtG1HYX+6yoJrDA4zCr9M4=;
        b=WHpmbcv2/401WbETyu1oK44QCW5RdLCgdmofL7QCxzssj0UCroGV7Ja30zvF6MNl4d
         td2GocKfQGEeaTElmqCiyWCvZWHE53fHjh078jRXCFfKTWn5CuhY0ti06uD++m3RYKQa
         vblKHPn0Mo+Er6vCQXQP46Xoyag9GeS+znhTRj0jiwg93dOULd4edpNF04iCygHSAsvP
         aH5VdMHDfZvkBxwxCz14gCMyHpGenhk84W/rv5Y4X9Cohhw0PZylgfwoGHqdND0A/F8h
         lasNDNtFvw791MhkBvyKOgnWO7IWwttLND3xmide4Dn1oy2xTI2vEdbXDRIm25s/4d2v
         qGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754683905; x=1755288705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jrohdztkJhSC4BFpVJAhNtG1HYX+6yoJrDA4zCr9M4=;
        b=HHfebC3KUdC5pANFXnCRFeuiUd6OOekVu6PFshKlsnbfTC5im4w78hWdGhyuu2fqFr
         BZOHhLAh8xqW7sTLoxewV1buTiajXDF66HBDbjAhNufrKUOBp/wjNX5xIS+ke+SzCUdt
         5y9eFass8iGPiaC42lKv8rUav2C9lbRFKPvg2o4/G38+HuV0Fp2YuZ1mHTTFuV09bxUn
         TylF8IeEdbi45J4Urxa1q9stb5GbOv/1GYBDMttFrzZjue03EeiY63rQqRaBdVJ/OBM4
         8LiQHAKJvlunU+CSZUEooPJj1CN036KjRmRLHif3P0KfXhy+elo3qxoqY1W91qV84IXl
         8uoA==
X-Gm-Message-State: AOJu0Yx6SEoWKUNWcVaRfOqNCzqYZudZ6j0o4nZCblO9QCbOuzfCH6eH
	lgG7cVLivzh05pilkr2NfBOqjUNNg5AIl3zFZSCQDJwULqivmUB7FfrTkm45MQ==
X-Gm-Gg: ASbGncvvhrDdY4mFkKrrc/0BPWtvQHkwggHXmK+f71de2vKrm+N2wJs4xYpy5wo/s3Y
	/SxtbY44CTJS9ZkC9mh/aPUm6LKIiDTxQWQ7S964WszqRmHFtdQri9nvkNmHxJg9JxCao8W1HK7
	wT+dnzcwLlCIvIJAOyfPxGqw4+rGUeDVjGNUaeWY6oVUrQiUlOPdlziJfqOY2rQIb6DmWNXmr4l
	efLf2CkJmg1sDvnl3hy1iWxhthS25h3eelBNh6ADTj8y/YsrGfvoBrG9fJNxBRenc+x5MjZ0juF
	IP83Da0Oksex9pfmumvriNbwgAQXeaKriURQZcg81r+l7WGh5hbXy6oJt6DLJS/E7QXV+FidY+9
	D0spAuFk0/nw4KYzxIhkJvkwrMCY=
X-Google-Smtp-Source: AGHT+IFiCjfQPCyT88dIfDHlTKepmyWXDtCsgKvB99vnDf+fyg7EQ7otiSX2o+IR68w+HAxVEULosg==
X-Received: by 2002:a05:6214:f0b:b0:702:c4d8:ec02 with SMTP id 6a1803df08f44-7099a4ca54fmr52024496d6.40.1754683904838;
        Fri, 08 Aug 2025 13:11:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.7.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d6db9sm117209996d6.14.2025.08.08.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:11:44 -0700 (PDT)
Message-ID: <68965a00.050a0220.b3f56.38c0@mx.google.com>
Date: Fri, 08 Aug 2025 13:11:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1113489708258333737=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Various BAP ucast server/client fixes
In-Reply-To: <ba4236637aba9c7bca5d93d375236e1fcdb8b9eb.1754678883.git.pav@iki.fi>
References: <ba4236637aba9c7bca5d93d375236e1fcdb8b9eb.1754678883.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1113489708258333737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989501

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      2537.39 seconds
MakeCheck                     PASS      20.49 seconds
MakeDistcheck                 PASS      183.87 seconds
CheckValgrind                 PASS      234.29 seconds
CheckSmatch                   WARNING   304.89 seconds
bluezmakeextell               PASS      128.00 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      905.96 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1113489708258333737==--
