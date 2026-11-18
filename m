Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027690;
	b=iyZp6YS7u2W5wP+KyndPPaCgeFGxEtE18jvBKGqhpfZpHpOhQIxq3h+2cMI5SV36czA4
	 eD+EF1Y+KX+qR8ii5R/BDu3F7KpbIy+F9aIsOHsnZUc5jei/WTTnOnXtRn+JRo8bkXXj3
	 TylJESpU5UiHGzQM07I/zcn1dYOV7MSnAnuIsfaMLXcPbZuqVex+gfSOksVFbEGAXWfou
	 vcCRLGRH2f6eAEHEajtHfdeQWPmIxJ50MWzqBrCpf0VTkuj4Yg/Tu5Tt8Cv/AYcMVVrHs
	 VBtM9ke2TH1RgxPTY7rqbffoDSqxuGtOW/h9Uv1EuKAmnhF+cRWsLNl0vJsUecQGDHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=y8/auo9R7RH1Lj2+i8+CeURTLeIXkYYp7ab2ybzE224=;
	b=Fh72RPGkvnMhiuHZGo70z6/RDxPuXJUdZObmZ4zJzaSPAZV87XRBOMioF2XU5qJlJEh2
	 aUkY+7djOVRnSMiYzuttdsTE20W6VPRj3UDGJ/8PCrIvWEdY/mVhVHTvueLZdxG7KuKOQ
	 lhvy4ykL9HN97JfYUc7zMdg8giyn58/sGYsVxDJOZAxuDhc01h4igXg/wdfNiKC7T7n8L
	 aHQVhGmzC7kR0BHCriZ+hBp3StkQSvb5ziZQq5Sd95SBSXua4r5fMm/yfW1NZ0fyhsbdf
	 jDSQVmhiCTZ8cnWOzrGtpMwgHTz0iVVH495kSTzHg9KaCY99gIJiVOUW4qXAtEbO00A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVaKpBgr;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFD60A2611
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 18:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EFD60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVaKpBgr
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-92123588d53so1346086d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795027686; x=1795632486; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y8/auo9R7RH1Lj2+i8+CeURTLeIXkYYp7ab2ybzE224=;
        b=hVaKpBgrEnKme/k1ySfskLvUGim8UDxoFOp6yJpY5BwB9xQ2MU9qo8s/hSeNeElFki
         +dAemC/4Un0nqg3eOXNVzK9c3mp+ps5rGOC8I9msJWnxrSgsgerWhmDq+WAJ5KaeCZcQ
         bUU/2w37d3plgQmb5XgvA7uddFB/9FdV2S0IXTqYSafaJ9Fs174dJaeXfuyXAA14wzsf
         Ua7P+g3UoEcpfaln1zydl7fXyh9GWUmAkaejjrCRs92GdsKIxNfHPPfhYua55t1FXz2r
         RiCOXXxJeeZSx+6+XV5qbNE9LN/Zt4x7U+eK5ueRt/wph2h21/1M+lRJp9/pxuebaGE+
         krcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795027686; x=1795632486;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y8/auo9R7RH1Lj2+i8+CeURTLeIXkYYp7ab2ybzE224=;
        b=MhSiIcqEMyfRnkKzHLEGJkpqpSE6HPyY1ReZmnJnC4bU0C97zkIDBDxYZyW+80Vb54
         dLVUdJ6pLYBDYXY2QnITffh/26AyQZwmg4BbOwOVBtJiJJWIqb76kW/4I3vyObkT5L8A
         RYL7xLk9tCdq875E87PcvXhSrquddekD2s/Uo3dI9kL1M39AF8gPkydYF3CVoxX+bnn6
         Yg2i0FH4vb6Sy8333DpouoNwccJPZcd3B9Pci7Rlz9LLYHW3yKXvVCoFvHZhwYHnRoP/
         cjzcHuAMUnsvwcE4QGEtd0rIV8LU/b1S9VSYUwF6KHieBMOZcDPPC7jbUwP0lXGprLBI
         GKnw==
X-Gm-Message-State: APuU4Z86hb4Q3ivS4oLVSEUljhAZNd0RxpGxE08eaQQfdVH6sFLoaHNL
	oM8+PVtDJThBbqT83u6L/3dtrVZuvIpGb82OqGYer/TB7KW13Wrn9sdnSMvn1g==
X-Gm-Gg: AZFdTZcP2W8Pt0EOAWmjKAT2JDVnqtQTO/FmJaksaWPhNl/VgcbSgQO0GytBGVY8EOF
	8cBCXb3AIyj++YUc3dIr8+Xg2ZS5/trR9FawHUiMajROVAN4mdWWhbDPY9GI3RBiJeuw/0G3CBR
	yfSg/A5pSdiYN1DWt9A8bjvDJ6aFQKQ8eIZimeXgiYP/sphYQN2trvrvU3VVLhUh4y8DIskqV2p
	CeyGBTxVp1Ir/8wdr6FFH744JJScedRDqt7hjRiLEc1I1r2EgNyjw8AZDlsYeGman/g8TpFiiHo
	heC/AYzDbl5FJyyPQgFBD/jI8n/xKxATHxa4PCCN9PzwkFFjZYLXkOj2iGoLoST0O9N2hPoLw+v
	GKOmoNJIIgbvJcV6Xsl7XgxbEiRL39J9Rmz3DoXP9zgwciGSYJcAytb4lLDkDXSaavQmzQ858pl
	8afEtvoq8J1D17o2Uk6lJBKpdJLYkDa8QNuhpHlPELgh+Q+vWo4s2xAZ7UGuOxbiGdDbsPvwS/c
	uRZ/gFZKhX9LiRNvs/5jZWfSOh9rLP7p5meeFOPUbnD+791HOOXEOWpHhojDQeMZBGcrDTCEjqh
	fo5RSvDtttcfyNN9LwFp9t9h5Con
X-Received: by 2002:a05:6214:529c:b0:91e:972b:ad99 with SMTP id 6a1803df08f44-9212445e4b4mr5876626d6.25.1795027686247;
        Wed, 18 Nov 2026 10:48:06 -0800 (PST)
Received: from [172.17.0.2] (ec2-52-7-11-124.compute-1.amazonaws.com. [52.7.11.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114dbef06sm28029046d6.45.2026.11.18.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:48:05 -0800 (PST)
Message-ID: <6afdf2e5.8b0b0488.1f8ad2.2df7@mx.google.com>
Date: Wed, 18 Nov 2026 10:48:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0739191290414806223=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enderaoelyther@gmail.com
Subject: RE: Bluetooth: hci_serdev: stop write_work before closing the port
In-Reply-To: <20261118124821.3990-1-enderaoelyther@gmail.com>
References: <20261118124821.3990-1-enderaoelyther@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0739191290414806223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1214977/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      20.23 seconds
CheckAllWarning               PASS      23.26 seconds
CheckSparse                   PASS      25.20 seconds
BuildKernel32                 PASS      20.56 seconds
CheckKernelLLVM               PASS      22.54 seconds
TestRunnerSetup               PASS      490.48 seconds
IncrementalBuild              PASS      20.12 seconds



https://github.com/bluez/bluetooth-next/pull/1150

---
Regards,
Linux Bluetooth


--===============0739191290414806223==--
