Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59771E489
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209969; cv=none; b=RWZT2hzU0cFe4Bbh4hIvcSPX7b62cDM4U6KAg+g9ZfW1x2hzXICcBGzlGXWrN4lLJD3yz6QIlY7HoN1ADpiulU8C4iIAWQGhr4vVxAyFMWG8CkEBDxaOzlGtlBTuvmvdGPdqXZUT9eZWBNtYFd6kZjAzuQbWBhIHQZSCYkqT3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209969; c=relaxed/simple;
	bh=Oalzgp6XQKm4ALaovRuNYAtfIEiMH4QGHnsm0U6W2aI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mTgnTJCHWcops13Ia4W4ewQXSSMzqJ3Xa7zkk2bCKxrjUP28lB/khI72gfAsb4sty8zHHi2sL9uGfVB5l9H7WdZoHicNAtKGgBFJgK0WTVHtadqoy0PRBi2xjtdQ9ttJN+V/7bElUfr4L9MG/duOvIrHZk8dC1nJxPLP+Neo480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVtebD5c; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVtebD5c"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c597760323so622443685a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744209966; x=1744814766; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CeLcBSPRogOnt8wf86XeWmcI9ZlCm1WT0fvnNhH162U=;
        b=fVtebD5cK9eEo5WlRuEf0OzZ/63GybDW8GBKtPB0k+eWaJu7irwQM7Xa1/2TX9wh4V
         SVqUJFXcD90MYnxQQufZm+/rFpgzd2e2TNL8b7qLH62uUFwRDqZjKsTYX8koE3Cyt7z5
         iPPisPPft5E6xYKR901XaQkS1rRQO0pKE/81TFBqNlygLY/inOeIRUAxuPX6pKRnC3kb
         0IQIA2ZQ6ShSLft8AKn+H03zokVgGyWMfRdHLSQrrO5SvgW7xWAsh27D7ZCevLHYBO0V
         ZzBpqRvvSV8uu1UYJe02wRcmZjHrXa2cAQJbTqqunvfNCfsBcA8oi2CqXXefopdVXg5B
         eazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209966; x=1744814766;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeLcBSPRogOnt8wf86XeWmcI9ZlCm1WT0fvnNhH162U=;
        b=m7z4YXrPX68yug9ypVsDgcoafw5lZl44sWWyW8y6Qs8+SFkk0YDdC4wYao5WVKBXZ+
         +MqUnwbi8gZv6xE7xK25qdRAYWg0IDAcXFy+Dhjy9b601vWDsRpzqyAk8GqhVDDx+0Z0
         DIy8iQOCwZPif+7KUVXOvTHoIgRu6yCQ/qpT8AbPzIpN5wJxeTHBPoyZi569/VN4lQAw
         0lSZsG2jZPkjoU8G+lf7QrMOpyMaR2DUs1CS+Tw254s4he+mh0Sxqj3VVTNzRpKQmqiq
         IJAl7Y78Rl40SYhBUrymY042qMhYOIk+A4hwbtcqbLqwzzUFh/igOwbDmv7Wdgt0s9WJ
         2T4A==
X-Gm-Message-State: AOJu0YwIQTijhmG3ouv2VAHGC4yz/O1ar/Vzo85D5btcio3QbEFMc9xo
	3mD6deWYxHVtDjfNCmaINnbnszi6H83k8FqhTkvkbmyQa/Xr+YwTNnhMfw==
X-Gm-Gg: ASbGncsDSW44zeQ0TNCZEFqSr3WnAx8PtRBQxi/2bShkEK9D02Pch1LAkwehHQXAVUg
	j0bxoi+tFHO8lkavEc/T31rkJJFztsemohFeWhKDG4x2hKM6i2Dg0dyNOICH8JWyjkDdfTy5kJM
	rdEL7b2cmZSlRKaogF6N5nXYrEanszeo9QoxLj5/3Pd43/UN82Ys6XVgKpNhuxF5mk331x7cCi5
	jNTnnY407hwRHq+zLuV/tFcQD7cjp6bZIjAhw8vQRlbUS+lPW5TmHhbsl5+4hUPh+qZJBN19M8R
	v0d2JeW+bQNKuL/i5aLp+KxDsHrRtfEdohBJPsFksU4bPQ==
X-Google-Smtp-Source: AGHT+IFPeKQ15l32LC6Da1oVznG82SMNEcDP9G7SImNY2q0FI0LFXtlMKEBEJpy9KMCIZ2Z4CuLnHw==
X-Received: by 2002:ac8:41c4:0:b0:474:f4a4:2ca9 with SMTP id d75a77b69052e-4795f2e604fmr31698381cf.25.1744209966278;
        Wed, 09 Apr 2025 07:46:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.37.237])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964ec55ebsm7776251cf.50.2025.04.09.07.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:46:05 -0700 (PDT)
Message-ID: <67f6882d.050a0220.2bc70c.28a2@mx.google.com>
Date: Wed, 09 Apr 2025 07:46:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7933126966535752304=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Send response to client for Abort request
In-Reply-To: <20250409125232.1385922-1-quic_amisjain@quicinc.com>
References: <20250409125232.1385922-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7933126966535752304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951544

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.97 seconds
BluezMake                     PASS      2729.14 seconds
MakeCheck                     PASS      20.75 seconds
MakeDistcheck                 PASS      203.15 seconds
CheckValgrind                 PASS      276.19 seconds
CheckSmatch                   PASS      306.03 seconds
bluezmakeextell               PASS      129.03 seconds
IncrementalBuild              PENDING   0.61 seconds
ScanBuild                     PASS      907.51 seconds

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


--===============7933126966535752304==--
