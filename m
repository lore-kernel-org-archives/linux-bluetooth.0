Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623338;
	b=X8Lj2PRN1yd7aZx63gXwviqUVslKzQB1V0ZejOmZ7/khuSSZtF9RIfu/BYtJHvZhimXk
	 z4GPXbRup7pM+c8IU8e5CcaqwJbssG18wZcFXyu9QFxGVaFh2eQULyxgYk2LjFj2+SSRQ
	 9tZE9QddnnT3DnPv+El9WDkPcAP2K2ho0JuZtxDvsD+/VKKctozrUEXpm5S46wx6lKHAV
	 I/HKW44UjUXMwowC3nlsOTClF0ig8ABr77HbTgEIVHXVPZ6wH7seK8ERJoley0H6R3iOm
	 nZKXLg/JmOcsdu7A9E0s8/yw91rQ0OX3zscBI6hKOAZo2y66gRTpP2Ezev9qvb8Dt8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=b9QTSwKbKyVTJUwIeQeOVDyZiogeYB55U+zV9lh+aXU=;
	b=nCIvaOOYgXGrC9S3BhMvOj6Lg/Tvb4CP2fCkNpySUCaLSllCm9Ms++kvBOM/+v/jh07Z
	 5zkLiY0cURl5q3enLzkOTndaQpF4RNGKSvOu3Ih/XVf5wxQTxJhzI4tDK8kC/rvJWX0JO
	 DPFdy5ra2GFX3sXCXuOGvtBe2kG6xXkgTzQ0i2g9s1xL5La2lYQrMl9Rwy6WFC1zGLPME
	 3REQuvYhQqX57aSN77oS28Ns71njO9MpsSEArtvmb77lwfSuWhtrgkv83yhgFc0+ixJrL
	 VC6vL80SkI/H0V59FEahnnsCHDTqE1vTrvuDBsAf8Vf1F8zgsw5DYe4Ir1d1KCnD8Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqnjhrgi;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227C606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2227C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqnjhrgi
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so9923130c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795623337; x=1796228137; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b9QTSwKbKyVTJUwIeQeOVDyZiogeYB55U+zV9lh+aXU=;
        b=yqnjhrgilaQjobgeNJkbDF6Z8Pjap18+QGaQU15c3u9OAYfkHPqCTvUh2H0wEgfrpq
         WWiR3rfNUwHuWh6PKHAiJD8D4EnGLQQTFIDqNZxyQOnRJ0x5gHpYqNca3zEI83ISIpgn
         BJI3NHHvELLMbgccVybOJOWRMQup6ajoMauY+nVJH7vHpr8zF7HMXU8LA4eHCVE57q1X
         PRN5eUFFQUX4vTO547UQB0whw2vNDiKPn+7l7IQpQVGmdPWqN9pIkk9RTvk0ycXbfnpf
         YznEr7K5Yv8MBuFInGYwUH5qaJD0xaJsRtLJQA21HifFzosRZmqp+obgoEnuK+shniJJ
         PKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623337; x=1796228137;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b9QTSwKbKyVTJUwIeQeOVDyZiogeYB55U+zV9lh+aXU=;
        b=ATrE/cQJWp1K0b7yxuOpCz/Pe31TrbNAbRsZtepm4H1FYv2cKT5xm9eyZ8dYhaILAr
         J0gl/bR6KsyEA+hF82yf0zxJaxPs0fBLhnnIan7TSP97f7NHk5mE1dkyGo8gLN7hGscb
         1bgxIhTsvRi9Aydif7W9NHYi30QQRS7Kfuk2RSydPHMUNHD6ZUfw83EA8lFv8khvtvgZ
         3K4u/6pIfM01ZnFdaY/uYd683/4zDjocizEYap61ZkYDHErmxxRsympeoarN/yoJG8eI
         NITjnN2pzmW50u2Tc3KJO7PkeNYDfGVmuSmr9nUX56IwgTK+fx6HopyPr+7oH48W/QWW
         JEaA==
X-Gm-Message-State: APuU4Z/ZxuMJE6HxS4RsvZAUCdwPNvlPjBziNnp8e+38J7VgPvrTHIW3
	wK8HMDONwAZOtrr49pUx3NfGCFQeC+AWKi3KE4vbOrLnpaGBueQ6J1ZNmsc8dw==
X-Gm-Gg: AZFdTZdS/rg96EPK0vdmxk78ql2movcWbENkapesHTlwRCJRomNiS1RBz3S4PpeklEf
	f8L8TqxAMXgLZWmGx21g8HIOtKUOOyx2LocO9xccuX+q/3V/vB8ZYiBMHJ8NZxpdVFI5mTPb0ks
	IB4nhWiDOeugJrVcykR73Evhcbh+7MNIjCmaeJsvZ8qWXrCHSXs7uTwdQhzOfhYJ7W8rkWgwVjT
	q6aFZhmoZ8E7ZbJ3UQ390XdOmRGkPGcwtq8igLIjJAAnYezxqcveKGXqUAxA1e39RdzwjEV2BWI
	25BdmG8T8LWKJyAdLGPwHt7BhR6WMCEJAzHckl8KoGQEUJx9qeVXuXvX7NbOUeKzHo+9NIS2f64
	ZgkvvxylA5L9nGJuyn9aorpkjGQZFBxVaN25L/bT/pk1tbGJWefhwjmWqoRvfph8xJehhLPuh9c
	gGThXcYjSGfJnBBkUmLzo6MHlxVWSOVjwQaZ38unC8b0MpQRdR3XriHwoPU6ZQTwbwTS7f0SSoN
	u7Z40TEw0FKako5aZyKjms4OzczpY4GYSjQ22hkhEciL34Z/qLjhBMxUDrlWHC6
X-Received: by 2002:a05:701b:260e:b0:1a7:e1c6:6f33 with SMTP id a92af1059eb24-1b5568d3ca9mr18312475c88.30.1795623336952;
        Wed, 25 Nov 2026 08:15:36 -0800 (PST)
Received: from [172.17.0.2] ([57.151.136.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm42203188c88.15.2026.11.25.08.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:15:36 -0800 (PST)
Message-ID: <6b0709a8.8af4976c.1dde1b.ce60@mx.google.com>
Date: Wed, 25 Nov 2026 08:15:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5227615390084032319=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: monitor: Add an OBEX protocol decoder to btmon
In-Reply-To: <20261125133756.551659-2-frederic.danis@collabora.com>
References: <20261125133756.551659-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5227615390084032319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222182/

---Test result---

Test Summary:
CheckPatch                    PASS      3.96 seconds
GitLint                       PASS      1.58 seconds
BuildEll                      PASS      21.01 seconds
BluezMake                     PASS      307.88 seconds
MakeCheck                     PASS      14.97 seconds
MakeDistcheck                 PASS      157.65 seconds
CheckValgrind                 PASS      377.66 seconds
CheckSmatch                   WARNING   329.48 seconds
bluezmakeextell               PASS      103.64 seconds
TestFunctional                PASS      1219.62 seconds
IncrementalBuild              PASS      368.86 seconds
ScanBuild                     PASS      1123.99 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2293:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structuresmonitor/packet.c:2293:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of flexible structuresmonitor/bt.h:4208:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2920

---
Regards,
Linux Bluetooth


--===============5227615390084032319==--
