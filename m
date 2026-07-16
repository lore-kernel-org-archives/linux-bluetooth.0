Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA93FDBEA
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217407; cv=none; b=EJTroIw/3bUEE6Ys+lj7sjCnJkRzEOdttzNsmTDPb8kKfo7DDUs774Ez27214qqNZXmp4CuPhT77+58NYlbvsZ7BCLDSFEZwpv77oqacUmdN1VbyAQO7uRWxin9QK/jq4t+SOPT3/iSNNNxOvafpRnWmbXUXEPN5xd4DKc/d0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217407; c=relaxed/simple;
	bh=OSjShiURyL5jfIPE+tlTRy+yY+gfyp5f2uNg+yAS9PQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SFL/vyM043SnOQ2ZNy7GxVwrbF3na7JZIGdYjjKgm51VboIU5ZF21K30ln+ifNeYxNE9PhVLgjFS5KUvo/sxv7kYwLMNoLLWCxwh56bjY7+K8EDcJhFJeVY3jDMNXJCSPIVlA+BVpkG504M059yfXN1cRntJORkj1fKaGp+pMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nvsqa/Y6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvsqa/Y6"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4896ae35be9so2831879b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784217400; x=1784822200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XxU6v/YxTovGvOfRipJfDU6Xv5aiM5I0M9iaT7amjmY=;
        b=Nvsqa/Y62LQ4MKlFxddhnbln8NMtgtArpnd1eRMFn2pX5HPbiqtbpMuxwgTFbXXQS0
         C2QsT+24Oget3gYAV3sk3qj9qTZPfLJGK9Cel54KWY0yV6qKRjsupvtG8EM5DNHCTedt
         NO/S43elBTDH+AMPQn1E+IsDXjDcaW4EdMEP/pp5Qa+N0UFNG4BcFqwcFvs/S95mT5uu
         cMpPQe/AAVRvRWVOH55DY1yYRb7zW3qdk11yIlQfBMJmqmBff3jA5SoxSLHy7onzm6++
         +twVW7g4WMGIGoj/pH/bnUIMhdb6R7L/zehI4zFrxWFikwaUS/84z7n8SXGTy+IZFEn+
         dBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784217400; x=1784822200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XxU6v/YxTovGvOfRipJfDU6Xv5aiM5I0M9iaT7amjmY=;
        b=bB9MN7jMR/ZcdYYRwFRyHr7YP9cwfSqW4xwj5VSUF74dNlsPEZL508K5FzhfSHNC7H
         6yHar68CDWAUDcLGwFdcsI6bIY401jWxoahJ3RSWa85IwWqAF/iaffQmlUA4fxiyHhjk
         uQCIUdjCsv0W045VG1NC6I5uYC97iS8vgUkroOOvi9ckiLGS4NBuTq77I1CjxLxOHvOy
         pCq4LW0LnjeVAtDQ9E4+UIErxNQqGw7wYXa2jB6iFjBoOrWjBR/U5qaAqT+QdiFbbxl4
         1gpSqKQiEkZIkVy7Fb7EyZsofTAZapD492wT5XholUiznfIU9iBY8nw8rx4Hi7+7kk6q
         4Vfw==
X-Gm-Message-State: AOJu0YyO/v7Nf6bn2HcliPxek/3jRC77/v5Ro0XLpVkEiSYC3JL+w6qp
	cOTng/lroKIrjN+QghdBCJLK2LC1C464jQlnqQunZqaV+m0TotnKRL5iBlBFPg==
X-Gm-Gg: AfdE7ckeNTs1wHxDC3TwhoYVOE+vgrxfSihnH0AUbYrNn3CDxLpX/jWEmhpmesJqgBN
	gx7MGH3UNOAPeUDwaA1FwLmfDci9+9qnztPjsHYhZ6CS0biWkC75SNfxhTP/xbv9mij00bmOtYT
	xvMpqVKZsoCdiTUfpmUrrcwGDPmHKVkl8pArQNjnEHdN5hB26rADhU+yrn2Q7CwBhmVKhOjyOID
	7xpB3+tePOjorj7rN6fBfEamFiFjuc+UhV26tv+VyQZWYG1gjymVOnj1MiPuHw212tz/Xm755X3
	rKhoxy1q9JDtgYCzhZMXKr4UvfLTHWGzMcOOo1cDw+efTS7NhoDOyCjCsckWnva5O67/ZwG3RL0
	kPGujQrst1D/Xkkzya055Tjp8mWm68MnI+orMzBeUyzJJ94GwTjuZt9fg7KsZNZidEGt5gufMq5
	AsPc04Bbss2Q==
X-Received: by 2002:a05:6808:1a04:b0:4a3:2bd1:5213 with SMTP id 5614622812f47-4a4961017f6mr5210151b6e.39.1784217400226;
        Thu, 16 Jul 2026 08:56:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.167.83])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f31sm18278218b6e.4.2026.07.16.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 08:56:39 -0700 (PDT)
Message-ID: <6a58ff37.dc971d6c.33bddd.faa9@mx.google.com>
Date: Thu, 16 Jul 2026 08:56:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0268388248199203268=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v3] shared/rap: Add bcs_procedure_data aggregation and procedure data API
In-Reply-To: <20260716141706.3640868-1-prathm@qti.qualcomm.com>
References: <20260716141706.3640868-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0268388248199203268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128884

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      25.39 seconds
BluezMake                     PASS      528.52 seconds
MakeCheck                     PASS      0.99 seconds
MakeDistcheck                 PASS      155.98 seconds
CheckValgrind                 PASS      147.03 seconds
CheckSmatch                   PASS      296.08 seconds
bluezmakeextell               PASS      96.95 seconds
IncrementalBuild              PASS      511.73 seconds
ScanBuild                     PASS      882.80 seconds



https://github.com/bluez/bluez/pull/2323

---
Regards,
Linux Bluetooth


--===============0268388248199203268==--
