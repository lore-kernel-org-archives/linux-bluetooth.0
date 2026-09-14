Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57B479860
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424799; cv=none; b=gABRLAD68n0gDYh7fQl2lrMy+3OcpXp3wY86E9kVTmdoIEgoUom64zanhFi5zhUMe9jA/+kedNYo2K4lccKUx1dGuVo2tSD3nEkeoBMSEfFPkZoIeyzTH2qmBtcoLnNkd03JzFQ52y8ZGFPquvAF0difWGdQz6ASkhpox6+TkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424799; c=relaxed/simple;
	bh=gxjHwooAIRp3m/xtMm4pg/VR1qXewcSLAGfwreNN1Kk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ujwkqCM64v3qK5q6iZB31o71y6rjhLHrNcQ6a3WR1kKQLoTIaqUqnk/kwp2UVPAaReBRmvujtudYtysFPzM2bNW+f5jDMP2/kcP8kPRMypQseWXx4VMqrSfNqkAoYtlnCBdl1CUN9yLT6FN9XWekD+cZO1BT0UJ1khkujj1j6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tjri0Fhi; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tjri0Fhi"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910c9fe21so45836385a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424797; x=1790029597; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pVtdiTQLCGZpjhaUz315yh+/HlnocentIWbIIAeGHrc=;
        b=Tjri0FhizALZCNVqkUU2jnOWEFgsRPk9FfKWJQRayRyM8RGhFhrqsEBCprYYtc1OJy
         Rr6F+bBTMXH0u6CLsTleCUS1U/Nn12b2KRU+d6atrlXreuY+nJz7yzf6qMSej13hbJZo
         9Xl4E1UGVAVJDIFgrWnNuozugvcu4ZYf7nWsvKJ2UHIBcQ5OZJQQ5LpIDrHGI9xPrAy0
         POoJNmvpRaQQ1oLsbFWRknvUMH5j7MKTrOxfjmZEDxpp3taFwF1unaZUA/dGVBJAF1vO
         LkM5bWJy3uGEb991b163E4N6pQkyB0LlQvwHvgWgdWQTTJ/+PTead6HNWNnej1MmoGmt
         wRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424797; x=1790029597;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pVtdiTQLCGZpjhaUz315yh+/HlnocentIWbIIAeGHrc=;
        b=io0J8/gN3p2+wBb5ehpU/JDE76IRKQU+V/T1Uh6a77DDdw1+TrhDEwyOvq2fqS1MiH
         eBRlhlXHQIPIndBVPOmjU4hL8Cv70N/O+5VWZgc0c96tfKQNswJZIwm+/SbnnLtzrx5x
         6RIDyw5Hq0CyBXgnRe90dgQv/xK7y09Tn1DqhOxQZflOWXsBFbpHI0I+8pHN6ZY4EAPk
         CrsymBOK7v/IZlEsXbE0Xy35lXhqyx19tPOaLLgRnMqnFgHwziBhrBA/isNmGKKzG6J7
         4xMeH+aORgfxKmybcX7CU7eX8x5h+K5gAQurJOQ2UlxovSd6ZWO9d+4atQ8Kpcoujh/S
         Dhkg==
X-Gm-Message-State: AFuF++m4XKeNjDKE+egJI2jQUMFQ81IcPJMuRnG5SQQnwKFuONWaX5dZ
	aag6Okqnuxyzx3yfpGDCeZvwg2mUUD4+rRa/NapWIdP/o1jJKxFTJluCsWFILQ==
X-Gm-Gg: AYBFou3kNJuLk4UCIOeiY/8GEnGuTu8tYX5nEiwFI+D+qaIcQYqDdaX2xEAecatPtuo
	N59KiiEf3Oy+3AMwVLOVW7dm1goqoimL5XEf/W9e2i9a6BA42t32GiozFm+rueAauhZPEqZKlUB
	ZqO5Za+6ovRSleh6Sz2ANX0IwHSkoMetq/sjRBktLH4ubPvZidug2nsKOoxX2hdjO7+uBJbQoHh
	glnrJ6pWpmwE000sMjnG91H3VKNC2puK/yVNDJflDGROA6SP9TPKNCLNwlwzW7Y+JrGLneKkSy8
	IuXTJQMZ8Zq5Aom0Do89hyCvAr1PEizQZt8ZrAYXLu5LrHnMvwDeLnc3d9rShCQJcwTgN6Nmf6o
	PIg0/b7Wvl4bSLau6mIdvH4Zt/kXWuLMVfHNuan+WzmV/EZ0qbBcPq65+CUAexOH7FJLVOryBC0
	IeaVFpMBraHITCjKxPVmyA8I19SQ88qkxskkTnysuO10xXOy7w6YHHbiFASx6vwD8NN04iu87vJ
	3oCzA==
X-Received: by 2002:a05:620a:84c5:b0:939:fb9b:2b4b with SMTP id af79cd13be357-93a3457486dmr191305985a.5.1789424792515;
        Mon, 14 Sep 2026 15:26:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80462ccsm1098757785a.21.2026.09.14.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:26:31 -0700 (PDT)
Message-ID: <6aa87497.35b683e3.5ae4f.95c0@mx.google.com>
Date: Mon, 14 Sep 2026 15:26:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0333676173396945354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/3] emulator: bthost: add function for sending raw L2CAP sig commands
In-Reply-To: <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
References: <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0333676173396945354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v2,1/3] emulator: bthost: add function for sending raw L2CAP sig commands
   Pull Request: https://github.com/bluez/bluez/pull/2458
   Created:      2026-08-30 21:15:36+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0333676173396945354==--
