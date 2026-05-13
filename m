Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C4346E64
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 04:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647269; cv=none; b=Tz6e7Gy6V5hVp5MPUVoVCbChXeTEVlBYxZuK7dwoS/FsJd57jzAsdoKNqXIHvzp+iPTgjSfHe8h5iBaI/tr9CL/ufPMdvQ/9fpInefYRIVRknaZqnQoVaWt+mRE1kFzFw9/5cAL4054d0Lkarx8KD8YYQ+vgqzU7vRJzVJJ0Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647269; c=relaxed/simple;
	bh=/z4JurnZj/ysuJ1t4lRPNldaQ96IFngs28pVNSbsMXo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sEU7Rlwcsk7QiHYp0zfqh6gHoBbl2UsUmVbS0wUKjT6CTAGiMHrRM6os97YqNAoVz2Q3zXEnpqFtHa02yDU+dugo6GW8OMZo1huOXqU3n5LyPQg7tgazV1acjvHGzhNjpI3uf/k/mluumRrdVjqAMijmAItUzXd2j0qzp6QXZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5WypdKv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5WypdKv"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90f850473f9so58876885a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 21:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778647267; x=1779252067; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KPiXHvZjn5Ve2TyQD9cHuRZoC7o98tGlYm7YaNn6TQ8=;
        b=H5WypdKvueMQq62j4TlFs6JjqSnkfHP2kjyTARY3mvvVBiNEeSSWArUbKR80bVwdav
         4Y+VSqmbuERa3wvArOMVLfS09JSoYgJy3mqRq2mLbrA4tISY0UpmNTsslKYMBgEUm/Bg
         HC9bjBKtzKG5C8UPz3F5lwsieVNszRkIUvvgnkDEy0aq3NEXB0h/8/kuJmtwXu1lpYaJ
         hChEx4zvSN9AWduH4O1tAC+UEZ/FRvD3wA5kIYdcd/It8N2qK2QL04lZXiS2JoWLwcFL
         16s93vWfgg84JO2BiQ9nrq/mL9KF+s470l9dZ5l99wBIazR90RmQDNsD8LRZI0+GnAib
         S92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647267; x=1779252067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPiXHvZjn5Ve2TyQD9cHuRZoC7o98tGlYm7YaNn6TQ8=;
        b=Thb/tWIJ9jnSCIA+mR8DspsGMyqNviRAIcej2sWUOyNACtrSquwHbwtZh/Ae5oCPrJ
         Nza/V/g0TIr4KkFPJzooaSBOcUjQdeFZ1aUbwaSi+jf8bXBy62lwmkAGHl11uXBy+bsb
         wzzkCrGT1FP+xM3MhA88FVeGbPfptGPuZGMZGLOT2qtZ0+XHK1SQ+6+6Gympt1pspfL1
         hnrX8o2D1H7JGaOSCxAWN47g1mZ1Loto4YzOWL95xSdhinSfjgUrlUAlDbGFVdWKh+kC
         Dch0MfcMVcWinLS5rQB32vw+Ufh6NtjCv+qcsPh+fn/TBd1Viu9HcxMedGlw6H5JHvSg
         nN5g==
X-Gm-Message-State: AOJu0YyPp98eq4EPdGy8PgwM8+ewhCFP/OhIwq/Z2locK2dwBAdEN7E6
	0iAsBfoIxxYWXY1OfN93KavriE3umHl33YLCiu+RBinZrhIcP3nWhm99R4g4Ew==
X-Gm-Gg: Acq92OG/QPRsgJipu7O5T6juCcYyIQ8VURFOzSPLZeHt7I++RZV8iOHMemgsenRAF1K
	LEoxhej1tUkmrj2LptoynLJ4S3H7z6rQNsqADuLLHEknqbj1YKIA6ePTea1BldqmXBTuOcmoGxC
	LH82ny8aLKXUdCJ2MFj1zCSxGK78pTWcTzQjaDNbA2tx/ulx0H1E9+bn8rraq1F0sJ7KpvJqYjz
	P3hWlV33UXWfoFMRyoJB2pPrYAJj1ftPyNRxJb9YF1LzObi6nNeWx6jUfaBT/QkWZ1WWLrScGph
	l8k+eoEzW6w0J//I4AfSwdXIt8rBhfIHhlnSbDJP+69eiOh/1URvQuhKVaYQSGteF1fQr34fsIn
	dXHs4sJSUC9vXDPRbYWVB3q7X1C9lbXx6CmUuSqcr9nLBCZrHLy/VeX5RJ3bDxpeCeYu+yDc9Jm
	2SL2fvh2c6qFfVeaaGVbbxU4F1IaYRRcw=
X-Received: by 2002:a05:620a:4116:b0:90d:7196:2f95 with SMTP id af79cd13be357-90fab625a2amr214618485a.19.1778647267253;
        Tue, 12 May 2026 21:41:07 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.232.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c813sm3604103485a.33.2026.05.12.21.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:41:06 -0700 (PDT)
Message-ID: <6a0400e2.050a0220.5b082.58a5@mx.google.com>
Date: Tue, 12 May 2026 21:41:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0380097297474164878=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: Bluetooth: bnep: reject short frames before parsing
In-Reply-To: <20260513031246.651762-1-rollkingzzc@gmail.com>
References: <20260513031246.651762-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0380097297474164878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093891

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.69 seconds
CheckAllWarning               PASS      29.05 seconds
CheckSparse                   PASS      27.92 seconds
BuildKernel32                 PASS      25.69 seconds
TestRunnerSetup               PASS      568.44 seconds
TestRunner_bnep-tester        PASS      18.92 seconds
IncrementalBuild              PASS      25.28 seconds



https://github.com/bluez/bluetooth-next/pull/181

---
Regards,
Linux Bluetooth


--===============0380097297474164878==--
