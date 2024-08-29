Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C11B29AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946111; cv=none; b=it7XUVsrtyKG8iFutO3jzsMkfXmNa+p4AiVZ88ss+D8EK+Khu8gPUIcaKaVz1e/iuEjh+6KcxYvwMg++YtuU3jpzKcnPnSuGdT+tikrOz6Rv46ZGgt1saBBEaxAN0kqDQd1wmTiWnA0f99qCi+QmpQZivgn14/649nx1ZoOf798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946111; c=relaxed/simple;
	bh=grs/AtLFNEEvXqZ3xdFRHxgsVmRtLBjJ92wD4XVUz0Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ufcxMaB1iwS15QTand+rTrWMHx3irqhH36eR7ei35S35yWlPKsW6mt+627E32hfIkJUaVtVNmw2Z+E7YxMTojhokKp+O8rbeq3q0wMFqP62sv5IdQLeYlR/Vk2eyA+N5AHQLxvI5HR+9oZ0zADZ3xu85xfkREhAWn6mymxMe38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYy8sz0x; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYy8sz0x"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d4161c398so3188305ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724946109; x=1725550909; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LNDPY12kT/fpmYbIJbuPv72qGhey2HKqLVwQMrW0oTE=;
        b=IYy8sz0xK8y9OTvtA5vkmfKXmqVGsHmYrcOu2FApFicUqmcrxwuJwW2u/gwwiOmBNS
         UE+lx3nRjdcCBOPZJFayPANWQiMDn87MpDjK9XSVLkxfwLVB8m26+vVlUY3E4vr+usqg
         UeBPma1qx3KwU22LTNkQL/Igr/uh/Q98O46IGthK9AzSa1Duy1qw9vADDDqp4+w8seJO
         672Lt/Q1X8PGT5WJnGTxDMQ1VMUCVTWwQv3NG+BGCV2xYv4ylfzErjY18vAX9WNfzlJP
         ttBsIZSzxP1GDV6CRsMOJQuQrT3q8WJBax8i1fWRxT3uxHF4UOsxSzQky1Zp2O+5bTwt
         ByFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946109; x=1725550909;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNDPY12kT/fpmYbIJbuPv72qGhey2HKqLVwQMrW0oTE=;
        b=akgX/XBTDYvRqksG2vnf5N3R55q/E+Xkgq3C3y7GXda6O4F1rgSsDu63Ylb+2feklE
         7uqEkcR4L1kxnJxPahvJ+stRN9EVyNT7t0QagfbGSWf3mTUuAp08/bENo3ZPj78o3V1Y
         tn4yWAeK2REo/wQmUxtZw6Bp1/1Wmww4doZ6jGZ2GlA3CoRRDt28d0X831kJtdc0bvCa
         qH49ReLgbwzs6+Ia04mSOKljMHuLEdHmjPayHNSX7yDi3LFa1swj8keqI5JK9NprtJrX
         tIqCkL/r4QRIjw0hlC8VNbiOS24ejOQBb4zFubik7APq/7Vq2wK7asFK6KJOAFpun2mj
         4MkQ==
X-Gm-Message-State: AOJu0YysUnTm+ricrG4C52qAbwGwVTIZIw0PkDxH3/iMOctEeLOfFB0S
	aRGWdvrGeqpSACW2KJJVzD/Im+RYV2A/FLu+gtiQ1G7OlDJbUTs3QLf/BQ==
X-Google-Smtp-Source: AGHT+IH69fBjZA+WtmQc8O0B0hom0LYugSDn+9scet4wrvIaJ5rxqSPFQ9dIRB4frz9VGR+kD3aOxQ==
X-Received: by 2002:a05:6e02:174a:b0:37a:7662:7591 with SMTP id e9e14a558f8ab-39f378ec209mr42369375ab.6.1724946109000;
        Thu, 29 Aug 2024 08:41:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.142.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be991sm1368287a12.75.2024.08.29.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:41:48 -0700 (PDT)
Message-ID: <66d096bc.630a0220.13053.544f@mx.google.com>
Date: Thu, 29 Aug 2024 08:41:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5867923870000309832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client/assistant: Enter Broadcast Code as string
In-Reply-To: <20240829132507.4545-2-iulia.tanasescu@nxp.com>
References: <20240829132507.4545-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5867923870000309832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884775

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      25.57 seconds
BluezMake                     PASS      1900.51 seconds
MakeCheck                     PASS      13.68 seconds
MakeDistcheck                 PASS      187.15 seconds
CheckValgrind                 PASS      261.31 seconds
CheckSmatch                   PASS      366.95 seconds
bluezmakeextell               PASS      126.65 seconds
IncrementalBuild              PASS      3394.10 seconds
ScanBuild                     PASS      1079.53 seconds



---
Regards,
Linux Bluetooth


--===============5867923870000309832==--
