Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B042125F
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971837; cv=none; b=XSNv16RL2h6mEEeE4BvDZlZE7fEtPHylUtHhR3Xq4lBBtiONl/hSOnGwZDxqKLm1ynpdFHLf547t67IoDzGeWhojIIn88ZcY3dWKnIRG8P8WDBd0U5nauncjRRR/nAIe2AhAiSG4/sZkoNbAWheO6nq/1yfHpL+QfiYgP4yZO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971837; c=relaxed/simple;
	bh=MiR+MLiVTb3fMoXSjKChhApdwaomDPeAnItkF4FUHCY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VDf93d9T7nT8SG8kl//Dg2Cvunv8fWLQN4sOp3r1m9SCR8k2rkqtyuaVaRSP5P0heIyKZFLlE3GE1DuQaHbt3MzhF5mJODj6N5hxJn7QShvH2Bx/Ail3Q9gVqhuYipiwPICkQxf1xOVMWgDWbSiDIHzXX3PByu5UNyTVdMOGzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZNla5md; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZNla5md"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caed617615so44356535ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786971833; x=1787576633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MiR+MLiVTb3fMoXSjKChhApdwaomDPeAnItkF4FUHCY=;
        b=rZNla5mdsuXNciJ/tJ20cXvH3dzWwnNuzja8HLt/+uuBhKNfChNe94LFjeLSaHaKoJ
         JrQ+nmHyoS4w6Gczr03R+rV6AIarnnODSbul89AD7xUcpI/kGjjU//WRonvNUoHkG6u7
         KuFB86i9bFW58wjNKrq/A2Lv00s2YiXq/MDwrp3l9o6Q7lpFHHUv/n71abHd5vNNjgZW
         O/iFVcvm861JGBUvn/OSDOF2xXvPmddw/8ED5nIwKPpvYW4FWMi4txHGH6nv6ak1j2Eh
         b5jptUR2W863bKLDKayjfhmLKtZKEc2fVelStAJgj62/Cfx2HyoIN44bVTp6fqvLrYI4
         M8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971833; x=1787576633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MiR+MLiVTb3fMoXSjKChhApdwaomDPeAnItkF4FUHCY=;
        b=IKGkAfDjCOWtLHOkckupTTqOZH6w2huxfbIipOdfzg8V/xcS3CM0yEW25Q2fklN5ch
         T04V85nFWZfkbO2eO7nqu/Lw/aW0XstGHFD049UAVHaq1WKGzFaU9tvzQJI8r2W+Z+d2
         NuyE9RFXXiGHvvc1OIc7CdOssJ6alIEoWzSELtHFzWm27Kyg7QvwNq8KXIWhJezpDrhj
         LhzLCcV/uaiu+uvM+UCFWeZgp/CO8zDLR5Fwgb8nk48Cnm4JeL209KSa55kezREC+fTy
         uHCJd4oP9QROfby4akjldOlJUcbs4Z1TVT2kkg1JNHVoPPmDj0tpbCvaIxdpxLrrxg4p
         GAeg==
X-Gm-Message-State: AOJu0YwfnSWaGenrUn2xCnays1V6OnLpup9/9t5XQwaLpXN4k2iGHRrU
	TPLqKe2notP8PUDmJLtCZ0fvoIVxWjk20u3fKu+emVXSpypne9iRH1X9ugJrmg==
X-Gm-Gg: AR+sD10vOmq1nd/tjFuiIrcDcVAiGDJd5e6Wam5WQlkvu9B35S3hsA+4ih1EJ8EKdDr
	WXn1pSd8brNtPRjKhfkxLco3N5WUFMT2Xe6AfWiMxW7c3weKytyRnWcf+VSw0woKoyVXLVLsn9G
	lklKCCv47LvpBTh42yhy1SYbvLkWXcOKcL1C9/TavjxwSDdzJOGzQjfhGpz8R6uKOsGktNN80ho
	HJAcDb928f8ol13ayKKwu4JlBPiPrmAv8Sqq57U5eNceLc/7VTk4YkHIFIDo5uHcGwxINntMstr
	3lYSjukaRnsLS6/ge/UJX6d8BMSD+13prcSfzJA+SN5HWyOpGYyh+Jy3M+bP8X7vWZIDP1wXd/K
	SrgreIB9zYDkfMPjsfREpwX2K8PU1L9qGpHiAxlh9iQbznQZBh6ln24l3xPGs6/9i0X1YixGZjK
	kIc7VjZqVfQAlsmApo3vJE05MmjjJOMDE3Do4I4t7Ec9H3cxv6IptuQfXPgtBA2wUgmSw=
X-Received: by 2002:a05:6a20:7f8c:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3cc720307c2mr24866432637.27.1786971832993;
        Mon, 17 Aug 2026 06:03:52 -0700 (PDT)
Received: from [172.17.0.2] ([13.71.232.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326793ca665sm7257601eec.8.2026.08.17.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:03:51 -0700 (PDT)
Message-ID: <6a8306b7.6904917c.2bc6c7.b4ae@mx.google.com>
Date: Mon, 17 Aug 2026 06:03:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4166359024483526777=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: Bluetooth: fix a permanent LE Set Advertising Parameters retry loop after a cancelled central connection
In-Reply-To: <20260817122651.508547-1-valentin.kindschi@fiveco.ch>
References: <20260817122651.508547-1-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4166359024483526777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:5646
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4166359024483526777==--
