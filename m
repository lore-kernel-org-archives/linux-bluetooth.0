Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B8449B17
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792597; cv=none; b=oCZEbZFE15R2pb5NDJX8jVRx9N8fG6tIxn2GQVmO8lwodJicsT9zmaQDJW9dvvH+YlH4TR8ap/N1F/hr0JYWfAFgU7X654Vtlox/bIDJI4l6Jldg9zn8EcPJgMcr/ob5D0JwcTvr+18sI8xbBQg58aCRwzHXkx99vY+ru49Xt+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792597; c=relaxed/simple;
	bh=Fg8g8tVY4/HGCPxqcXIdJoga4sCt/2sY5dRQfujpE8s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CVWCEFVqp5y1aidrI9f1VpM8EaeqHnSse44DlEW1WRi4smcN/W3JE0yvhPSiqMwhIXjyZyY4r5bW7V2h3a9HutUgIzOLrxhW6wPPFZsAHNE28Spafi3KXyVHhWTueXkGmvQ6RX/+cUwvHlhaKrw2tmw1KYLV2eHA+mRaxl6HTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzZxVtF4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzZxVtF4"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4f9b643b13aso1575436b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792595; x=1792397395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YXmzUXHRKQZ0i3Omy+p927pkbAwZnxqoVPbJq6CzqgQ=;
        b=AzZxVtF4BnoiCIJeLN2uiYWmAN4aGR0rCwTJQqHUw1ewQ4qJk6tWgz2NpBtlq2aH7y
         n+GLnaPhl5shm0mgyZDGKqLjwdy6HuATTnhk24DYFFmGEqt8xwuldoFESq+8TuPRVBrz
         lKbykGYTEJIncoFupbe+h+OZhQLJGWOsHb6uPqAipDw0CM7DUO9ZXO7CgfztugwJJ+qa
         kZTzaJHqxABtHVJD1GY3kyJIUe4+vTXSLLGp2xCAvPrd2KcoNdU5HEYouvPciBKGmHTR
         MHoUkEI0yaG6RnLwdiSP5Dps140+NX43+vs2lhggTVcaFT3+XEYYH6ydR0eB4nlnfagW
         rcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792595; x=1792397395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YXmzUXHRKQZ0i3Omy+p927pkbAwZnxqoVPbJq6CzqgQ=;
        b=dq0E66W/RGQ4znAy/oH/qzg932ndURXXQnH5c8mt4EJU5wBtyEEMCQ3F3LjR3LughY
         9lN0SydER5YKMjojb5cm2XWa5lG4h+MxeWuWFfwqORzKDLGNrSoMw1JBKKttEFHlAAjE
         8dc+Xc/wX8s5k8k44bY1HR/RJYPw7ypHyA7Z2IKA8F+cB5klAz7jBb88V8669rTHwYCz
         /DqymjNGY1uRAEtovqw7PNCH5gG0WJZUKwXNCmG8BzOaVqBlVwNPk8qyf9t4+LwTcFQg
         fBqHMQ0w0gAmbRrR8WhnKv6MAw9InRgBDV/N2cC9u3Padz9n0W2HqBjl+XJbc7cRhsKq
         ZuIg==
X-Gm-Message-State: AFq9FYLQ80gAjuyoZ+FEoP4i6CVMRedqZYCijjn+mBkLZHcBqD6ZitYM
	s3I3MNOnPZdrSbpnA8P6wxIgAYv9aZwqAG35frm9F5A74gZ0dpDw9oFwXCjIWQ==
X-Gm-Gg: AYBFou2c+18rxorPEojryxdC4h2gu1on5W7r0JhlHhVbbbVfDP3Sx7j7ZGAfAwRxaiU
	MPoVtBLV0LGLmuXgWTpQTjrm0wzm6Zujaev9/+0mMt6DwzP00pi0vfBiDJN3HD1X3tLEKkvG4TQ
	Na1CJ5KorvkZ3rLwY2nEeR8VABUFl/p9yqp6sWr1YdlglUzUQU4vje+HFBL4bFDbuLk+A8n/KDt
	RmcL/OekuaDDn6eUyQjELqdzBimAVQBe0nTFmoHcPJRsQ1VxymUk+FBFsI89b9itiOGGs1ywypz
	dBeQlhY0ZHIGjbAjPcapdV0RAxeG0keTcsvGLUIDqD1OaWD5/coXlB085xwQ4hzZHd4dIh2A0La
	kNDQDkVFKSqu6ZSvCaW7tABE3rVMUIp38ylXKJqz1jrVv6wyffB99/gn8+TwyR7yuUUwWt1R1ON
	OMAfKtdgjkyU7U3Xum5+T0Dllydftento1oTEI66TcxkEc5wKLVrCXE7JVjhVo/rCyzWN2A8iom
	N19SqxkDg==
X-Received: by 2002:a05:6808:130f:b0:4c1:5614:acab with SMTP id 5614622812f47-50c532f8aa4mr7822079b6e.37.1791792595196;
        Mon, 12 Oct 2026 01:09:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.207.117])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe916sm10843912b6e.1.2026.10.12.01.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:09:54 -0700 (PDT)
Message-ID: <6acc95d2.4583f060.2b2b51.53b2@mx.google.com>
Date: Mon, 12 Oct 2026 01:09:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2709682311724843296=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: mgmt: Remove mesh cleanup from the socket destructor
In-Reply-To: <pm-bluetooth-objects-candidate-0156-v8-fac4256cb2701c21549a@gmail.com>
References: <pm-bluetooth-objects-candidate-0156-v8-fac4256cb2701c21549a@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2709682311724843296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183547/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      27.24 seconds
CheckAllWarning               PASS      31.05 seconds
CheckSparse                   PASS      32.74 seconds
BuildKernel32                 PASS      27.06 seconds
CheckKernelLLVM               PASS      28.56 seconds
TestRunnerSetup               PASS      675.02 seconds
TestRunner_l2cap-tester       PASS      14.36 seconds
TestRunner_iso-tester         PASS      10.20 seconds
TestRunner_bnep-tester        PASS      2.94 seconds
TestRunner_mgmt-tester        PASS      59.05 seconds
TestRunner_rfcomm-tester      PASS      4.19 seconds
TestRunner_sco-tester         PASS      5.27 seconds
TestRunner_ioctl-tester       PASS      4.40 seconds
TestRunner_mesh-tester        PASS      5.53 seconds
TestRunner_smp-tester         PASS      4.11 seconds
TestRunner_userchan-tester    PASS      2.97 seconds
TestRunner_6lowpan-tester     PASS      4.13 seconds
IncrementalBuild              PASS      25.22 seconds



https://github.com/bluez/bluetooth-next/pull/900

---
Regards,
Linux Bluetooth


--===============2709682311724843296==--
