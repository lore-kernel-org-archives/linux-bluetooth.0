Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD825CC5B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454746; cv=none; b=YSW17JmZ4aETHPaes6Eo/PudX6B0TB0EHuDpQBqNoYA1XRHeEP6mrp9tNTntrhmJj/8ESWGnB6Lq6yJY0oLSHqNkJQfI4yA3h5JruJsZ8N8lwewEUD85Jho5JHycjj2hb9qMfW20CAh3YLCYwKnFDYHhELZ6IM/JzRxHLpNEGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454746; c=relaxed/simple;
	bh=NcmeIzfgNUfUMAHZcqVy8EYd1Ajfd5NOIsvxEVpKzOI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ATI2eby/6rAqtsNBH7+9kLCRviKiE6N2eYz83dcjQ9DCNGL2AsjQmfHDMBKhIegHwclQBZ0HMn2jPGP/3bn7tdsiOFK+EWKnSQCLB8wPhYPz4DHQiJNpLaPayDndBaRQplho+d2Yx5aoSG8FU/a2AcKvZGkWc3FwHNPEq31/Lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn/XZ9tf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn/XZ9tf"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f521957182so26010306d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746454743; x=1747059543; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1iuxvamQE7ZFh9y6RHOzRO26ZvKluwHQEbetJM5w5aM=;
        b=Qn/XZ9tfAiXkL+g/X+OsDElvDkNGbsrhkLfhYrYTro1C5BeZEPGqIRrzqSCsUT9d6P
         eiTDH7c1D9Vw5TTHIHQyvkemFMC6kNPEQG/CLmkiUb/Hqlxk2UxRP935zSOP4XSBcIpd
         592jHUfjrOgm0aDz0VIRuvJZoqb0IUn0ps7IKR2BVi1Yjpqr6s2FIXXpSgGNwv2/uj1L
         uXo59cOJwV0lvKViKUlZAabZNVoP1WefyLVablFTglvruheYD/gb4DL6tZjJAitlGLws
         AevGmT1S4Dp5XKaTJ5YEoKs1S//QY0wPryN9fpZvHM+msxPS40mi/q56acRnYtV1BjxL
         lL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454743; x=1747059543;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iuxvamQE7ZFh9y6RHOzRO26ZvKluwHQEbetJM5w5aM=;
        b=NKxMK3mrsabHsXo7WpTFldVxewXGnnLgNwwh3Xs9bieD7cCGcVpdtjHuG0P7src9nI
         up8yWjtw3z//jizpEygXYHBPgL01qpYmvJNFcZFR2vhwNKZkfQLArv6VjsU5vWwbqt1U
         jKiwNY80UabW5RetccqsswoLZ6QoZxglfYvBz+CO/P08qXgoLnajCeUnfPjXf6yreTgK
         karhUPrZk+rtZms8mk/54XWCh6XwbY3oUnJlrNYMVItJTMWW9d5pXsZJo4OkhwDrb/1V
         UeQsC1pXybzIaghZgCRcftCjARa0uNeAAV/DMbBK5AfBtABgWDGf5vIokmq2zBvZETuv
         paSw==
X-Gm-Message-State: AOJu0Yw7ibB3iNI12ETY0NlYy9zDkX1FuqVqrRaPCKHSeBQ8OhDEBRQy
	ttKhOh3FZHz5RGwRPdVjHB180TeQSxnuA6fms7o37v1bm5hdywwFFV9h0w==
X-Gm-Gg: ASbGncvi0CR8qwI/p/f6MdA6qF4+8RHes+/+nMRbVmnfNs4wmohJfgBpRm/8KsMGctP
	jwem4cr8DnBRoQTTr3WnQAwWvb3+AYbayMFhQ2LQWX8oNtMYawpYsFy0RVi0JJCOO9AT7/E6jJ4
	JX6Erb+h/JHa/ADW4YoLqQYehVtKjc7842Q8XuRYDHdCCqEF6NbEE/GSr/gyeeZ2/nGgoL0ijup
	1Xq29mIYKIqYJK9d1i6MMk4v8i/QOMvqzNhYPI1WaFWYOskTo99rMPcnq/92wVdLvn22ZoSirh3
	kA0MCndOKNtNcvtngvn2J6NVi52vvc+NdvrE32A39hwMgA==
X-Google-Smtp-Source: AGHT+IHzPB94hLOAiCSgNoGfdoQIuZJ3sTX6Z7jRLWJ2BUITU6vQWnps4r9HUZ1ON9YCIIlC6irH0A==
X-Received: by 2002:a05:6214:20ac:b0:6eb:2e88:d47b with SMTP id 6a1803df08f44-6f528c54ea0mr107901836d6.17.1746454743417;
        Mon, 05 May 2025 07:19:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.37.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f480b9csm56467846d6.97.2025.05.05.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:19:03 -0700 (PDT)
Message-ID: <6818c8d7.050a0220.179766.d1ec@mx.google.com>
Date: Mon, 05 May 2025 07:19:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7683460703604547820=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ] tools/mesh-cfgclient: constify
In-Reply-To: <20250505124346.6621-4-ceggers@arri.de>
References: <20250505124346.6621-4-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7683460703604547820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959622

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.78 seconds
BluezMake                     PASS      2776.14 seconds
MakeCheck                     PASS      20.97 seconds
MakeDistcheck                 PASS      203.69 seconds
CheckValgrind                 PASS      284.73 seconds
CheckSmatch                   PASS      306.22 seconds
bluezmakeextell               PASS      128.79 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      903.15 seconds

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


--===============7683460703604547820==--
