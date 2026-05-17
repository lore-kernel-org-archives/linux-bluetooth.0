Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20511322B8B
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006266; cv=none; b=b8o8c2LqhTyyYTPnXwvm7kNu3ZdTJ2rtcdth598d7PaTCDbZesKReUBMuVhQW4/0ldBdBOBj6/J26WE54R4XuLvgFg56wWuQPxKChKoeDxE3QjFvETbL3Wrn3AyTS0kFG7SOl7Y2qz6iO1+r7vx1UnPDxD7WMEhntyPqXVwBrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006266; c=relaxed/simple;
	bh=JvHIF083HBJpjyPxxwWwiRywF8jwxTAexf4HqJDS41c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RKv8xfR7vyA0B2NbpkbMTBsPZZndzxuVV6CueXQFKlYABM0p1WPTT8qF5vxXHlIFAuuJ6SgFXb64zMx5y46yrN1gbmSRaWdc+dsdnRu+CA7K3sScTrhDRRsuPI9tMf0a1P/tQmkJVTVp8oTJpGrzSc/y7CtZ/RiZhu5eXL2UmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcPNeR6v; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcPNeR6v"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5148cbdea08so12562501cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779006264; x=1779611064; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tibmtocOgXZsOfA60e62T1IsHXn5O9hskBi4AJe01BQ=;
        b=YcPNeR6vZSmBLYcTXvGLdZISnRLTi7WOU1uE8HhuKhj6EzvtCJVCG1RCT/yEQvPfBc
         pvDnwA5veTE7IzOC2FXDCf6w/79g93WyK0T1aAqTMAgpmDGm+5xW66A6pixMKvpxLIbq
         2pOmMTiW31wZL03kHvTOgFCZsORJdsA8fqT0gDhZurCKq9j7VSK+m7vqwPiX2UdhrvHS
         wu32mmzvCsrbXE4T7O9wBx1rnd6ACrMolDzIMJ6kPoiKcx81Ccycr6aClO/p22HppxfF
         38txZfFM122PzBVsp5N6CkjhxnAAOpOHzg5qMEuM/OiIk2MYKhbl4hrUhxVIKI88XCbu
         gevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779006264; x=1779611064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tibmtocOgXZsOfA60e62T1IsHXn5O9hskBi4AJe01BQ=;
        b=gfGTfYyA1ihvWEUG9GNsebaTrYhkdZYoy/XPz1hHFFRXIRwS08Ib6npHtNUh/iBmOZ
         zt2Ulov2RkgDHxRVrbxyCjxRwXLzoHNRJuHMlTNULJ0jIFJcmvo4CvAZeFwipQP99W3w
         HLBHz3TCw6gF7plbA75Cav1UJ5JpzEvpmInDqPJP72pED4CvqdNDziamm7uY5ya0ilbF
         DPTXV72i3WddK3W4M0P6t6ZhR04x0qZ8t8mzX0KWGm3hQRmIZbnGFWH4ZrCkBEyEqxzT
         Mz+iNZySy+Wn//9Jn7lddpx1HaNTVFb2gw5MWRzKCj0g29sbCxRUe1Nwy+j5TZjtM/Aj
         M+ZA==
X-Gm-Message-State: AOJu0YyI/Jmt+l4kihh4oo+zTAaN+nOXMxrZMn4GUshzH47xUwwBYOYy
	UbJjm7pQxGx7QHhD7ugzoJgTvugJSb3M+ywm5MdYpDJNl3ELzBSiZa+KDWmVTA==
X-Gm-Gg: Acq92OH9QKHxaSVBpPowOSRUmEvg1HupUciYcFZ68jLIYgfCK3pfbOKyp1aBtX9N3B6
	A+4t7BTgrKpkSweYRd9Cqbrl7iSB21aKxUb1IXGdPFDBQoiiiN9+sad8jAj2HkCvddL7OcbThxk
	0QeBZStd2edRUlzEEicT1esQoxXphRBBq4kdR5TcgkTVtPzhc30FBe/pKH3vA5Ah7u+xhop3OeL
	N5urU1mvIzPfjNr7CcISaO95kKpz+HJ4lyzelOnIlZoycgLtodkMHNjMZhcUExBmigc5YlS/enk
	euNH0IOKqHxp+NF08lLFo5SAa3bQKi0L/10HwaNHGvH5cfHH8sTpry866ftT5vJqcH9l4z6on2Q
	VJUGG5c0swckcPXyGMCaFEMKPqCUmHTQXOnRbFcVs4VN7GVF0YGNLnEv44lLG1nfW5q/vE+/yrr
	XfDhv9Ot62L5oxf8LKGphiI1kuVP92l6/a+aPXbRrT
X-Received: by 2002:a05:622a:418a:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-5165a02aaf6mr148480831cf.15.1779006263751;
        Sun, 17 May 2026 01:24:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585affesm96084391cf.28.2026.05.17.01.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:24:23 -0700 (PDT)
Message-ID: <6a097b37.212a1814.2ffb00.115d@mx.google.com>
Date: Sun, 17 May 2026 01:24:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1467480436635483728=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 2022090917019@std.uestc.edu.cn
Subject: RE: [v3] Bluetooth: btintel: Use skb_pull_data return for bounds check
In-Reply-To: <20260517060142.24510-1-2022090917019@std.uestc.edu.cn>
References: <20260517060142.24510-1-2022090917019@std.uestc.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1467480436635483728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095975

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.20 seconds
CheckAllWarning               PASS      27.50 seconds
CheckSparse                   PASS      28.68 seconds
BuildKernel32                 PASS      24.76 seconds
TestRunnerSetup               PASS      525.64 seconds
IncrementalBuild              PASS      23.95 seconds



https://github.com/bluez/bluetooth-next/pull/204

---
Regards,
Linux Bluetooth


--===============1467480436635483728==--
