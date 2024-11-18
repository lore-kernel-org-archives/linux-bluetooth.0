Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD31196C67
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928340; cv=none; b=b2d7RLFA+uhLL0huN+wEEBR64+v+E9gPGwnRVPpfnj1sQ1VbW7p+yogacxsUfPMjP9YiupsFQdCPmODy1XRji8S8QNUEKoDlukgaKeuFqmJiLQtQF/0V3mhtnnfI/IAobcmZnEhZxdh5jdzGLcPIShe6cGEFvucOhXTd1RhrAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928340; c=relaxed/simple;
	bh=7nODaXn67IyJnhbi1I/9u3nQzgrj9khceOLswOMO7hg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SHWpHjDFO5PLHvknyV3kQdLLoNaY7ZciMga7/ZLpQvFt1F+SKfDh5ziUxRupG9No2ShCdJcAwYA/kPW6kUILZPMr3oB4h2g8vVSiM7Lpt906Xr7bf5aP7AQnq23q+T9yb5JyBYWcnQn1jgJFLZzV4i9YhnQ2FYNw+xfkohLfv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx4MdFNJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx4MdFNJ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460c0f9c13eso33350861cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731928337; x=1732533137; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uVgHO6dGHfSSi0h7Opp1EPZfQNGD+NexfFEgrMn23vI=;
        b=Xx4MdFNJV5qXyC/Uw0BunCfccb70frW3fm93YQDcI1qO8cFnGBm4+WCt7XeHiTfhXk
         /DnhH5Uv4PnbblMTdofTGL5rWS9YKhUsvjnHhzEf9sNaBJROHCTCbvobyUu+/hcyYZZq
         UxfXGgjIOBQmOucFn+XBcgbxiG/XUw+gduA2K9QKoj0vp1q/4wdjQ6QAOpxBVO7Zu4nh
         uGy6fxAtBAQ6R4tmQODkh62kvCY4JZhTHldIrfFkIw1bQGIK/QM9tXaw1+DCud/ORmFl
         ZiV+cpGuXlu3dvtefNbnvrJhO1Gnb1waoGijWm8brXrqlaS7eiYV5JuusdxQ/0AiqR7E
         Z5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928337; x=1732533137;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVgHO6dGHfSSi0h7Opp1EPZfQNGD+NexfFEgrMn23vI=;
        b=wCYa5B4P4VUMfA7RcOzp4z0M2hcd0WuMSDzoTIH4ayhffWqPeceZDoNrhB7fUOBPDn
         gYzMsIPESsYWpHN0m2g/C2Skjja2DpR5VlqHBuQ+5LseRHpUmn5zo7/119U2MUqd4CeW
         RvFhd5RYRmKtfTGozHqp2BGkd2hjV5haJgcehXFWCsfDFrcuLo9tSzaVBrChxTl3jnRE
         NiOVt4Mh6iZqBUSibSOGOOPRfLKOuZHF70L+k4yH6dM1M+PUusiOJogJ/5YPRSweFHAk
         QCnPkRcHPfflSQDhDR5cAuIgObJsr+06w6h+MxCgbeh0LEm7fI/RrFBKnQXsLuPSMwZb
         kipQ==
X-Gm-Message-State: AOJu0Ywx1O9+w6d0QTDSD09itjApZjYLIZscwboysrfsZ+kdx96vPT6N
	1bbqOySdw4t9M4TAYVV/AA0YVUI07o7t3sPmaJVv5FsCkjTOO/86/9ZCjQ==
X-Google-Smtp-Source: AGHT+IEfbk4RCkQZuJ0q+vllgNqYFXH22jeBiHWz9iaZ9Qba5kWVNLYyDng0YWhy9yRfIhoWreaysQ==
X-Received: by 2002:a05:622a:2992:b0:461:5d78:493b with SMTP id d75a77b69052e-4636352f524mr153586211cf.7.1731928337534;
        Mon, 18 Nov 2024 03:12:17 -0800 (PST)
Received: from [172.17.0.2] ([20.55.222.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab24e4fsm56719901cf.68.2024.11.18.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:12:17 -0800 (PST)
Message-ID: <673b2111.050a0220.3bb0b2.f93b@mx.google.com>
Date: Mon, 18 Nov 2024 03:12:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8664623692560914516=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Subject: RE: [v1] hog: Check security level before setting
In-Reply-To: <20241118094907.2673431-1-quic_jiaymao@quicinc.com>
References: <20241118094907.2673431-1-quic_jiaymao@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8664623692560914516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910561

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.18 seconds
BuildEll                      PASS      20.45 seconds
BluezMake                     PASS      1523.29 seconds
MakeCheck                     PASS      13.00 seconds
MakeDistcheck                 PASS      159.15 seconds
CheckValgrind                 PASS      213.41 seconds
CheckSmatch                   PASS      272.24 seconds
bluezmakeextell               PASS      98.55 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      839.87 seconds

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


--===============8664623692560914516==--
