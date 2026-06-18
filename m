Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F832AF1D
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781743976; cv=none; b=EsQCq1+VuU/jz9FB1mNVpf4NOLp3HIpvVEFD2ic3cn8+WV/sy4LyBkCYDxZgSC2D77++raCSefZ4yc9jOIMpHMgddG+TmVwVpV78n69p/rpTafIZD3y04V8Hd+z6BtUwCTgWwc8CDdsSWHHEhHyCSy8konN27x+NrMOXS/DBvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781743976; c=relaxed/simple;
	bh=yVC/5J28lMoFOurFbq0cu/04LSd+4+q6gsUpYwUAxoc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oXjLpRfEzxmbAJn/ojhvoy97CH5KDLMnFFjaSo1lPciOTNlRBDIrJDmEi3PVoLXKisDpo+SV5VSBji1i49lu+padj+IY+hSujsqBb9lNDyhMnOqPqFxv8fDjjmtY6LZi7kMj2Tv5pC9mNM4dBotJvdeknYFddRccrK9e/Sg8RFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c96enfjc; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c96enfjc"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e8aa31e9fso208280eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 17:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781743975; x=1782348775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uWgpW0mN+3N9FGsu0q96PucWBZuIfxlHO91DHhxdvBA=;
        b=c96enfjcDZT7J6Hg7Wf27sbw/z9vOekulXNZt1mjDWYYX35Ymtb+zf+zbbHS5LfVUD
         +Fvx3dWPSzqbHuzS1qQD5OoD5Q2rZhREKObCe6DeOB34gISAkd7sGNLc9ugHFRbj6+7Y
         Moiiqv0LEE16NER5FigTHQSk/WdNoK3rHGgjCFx4NCmmuyqOwpx0xfK2klaOY1QUScaX
         q89Sa7uti8jk4f7ZL6ogz7EfjHaFZ5Mgz6L9QI8OxL9eaoZTtiCEvAlF0MDIy0wkNagK
         I6Rr7ZZW5CQ2qYwybfLCM9+ZQvxmhHyl6kz1I1L16kaKDvM5syfKPwkgLI9s7k/lswko
         AN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781743975; x=1782348775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWgpW0mN+3N9FGsu0q96PucWBZuIfxlHO91DHhxdvBA=;
        b=U5/GmWsdtYL7SoFlzGrtNrs3N9DdyAjTbApnOwvjLaTB0d4bsx5RqmLAoBLV2JfKyb
         w49xU8Rciyh90hLHJZav7xSqFr6acslFfsCLMOHhjWFyAtlzVd/Zk4bwkNdlJVwkKOvh
         5KsEofCtbYl/fYgDZ2bb/YRF/2+1PtNuRwgW/L9k80Fnh0dyuDx+TlDKpHhmapEwjBtC
         zSLdbRYVBWJpDo2hKhJP2lrF66Ie2gupGydnSagGaPcSsWbcpdM6zNyjt01nuqKuYEgE
         XUnxzXu46QVECd2G8oROdVlcZNWM5Om18ziWwJkpZDfqMHKappan7AnU0/ewYnDYTdwC
         35mQ==
X-Gm-Message-State: AOJu0Yz1fJKq7Jkl2nIv2rB75lgQU4y8S0rrP8rJApAt4Dzz0Vjt+iHM
	NkjOiAoGdCoJ6iyP6PN5wySwE1is10m+aNorh5y7MHaJbuH4GsQnTn3bwyjcOQ==
X-Gm-Gg: Acq92OEYKnjY85M8dNKf9XW5lu6ryLZGBwA87Ul75S0yMbKzIuxmppU8GaHlfykrPvS
	dQwejfluQzuG6ersL1PkRPu2s1AKfOs9ZZhZbL8kZ+5q+mblCUK8E5/tKmhDBhAJWK8LJV3EGoN
	Brm2iqXF+lj10x9TejLu07qFGYqNUwhxEhjxKrrwUaKYtnGdkHkqwN6i/8vACQIcNJH/9d2Ius0
	IStpy1jbIfz1WRK2Y6y7deEZq9jfmcgfOjNpAvd3coYVR3907gVVUAHsetvK/Dtf43L72kbj9qC
	lKXkbIsiPBvqIRAiRypfKm/UqTeqsnTE4/ja+V/b6oLrkwcok3VATBdS7er8+w/TUcjj0APunc9
	MHHmdMucAh9e5pfbvX8duXWF82IKa8IKJqg77okELqp3KVtfqJC8b/y8Em51lClvaqfqHJ3bzg9
	iCXI+VziRFTmDrMZNBgz8LdQ==
X-Received: by 2002:a05:6820:61e:b0:694:9b71:3743 with SMTP id 006d021491bc7-6a0b61fd39emr4168745eaf.51.1781743974518;
        Wed, 17 Jun 2026 17:52:54 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.237.131])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308b0149bsm5213740fac.7.2026.06.17.17.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:52:54 -0700 (PDT)
Message-ID: <6a334166.d41004a9.102613.0333@mx.google.com>
Date: Wed, 17 Jun 2026 17:52:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8841798661015776099=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v3] Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260617235145.2582862-1-chris.lu@mediatek.com>
References: <20260617235145.2582862-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8841798661015776099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113165

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.28 seconds
CheckAllWarning               PASS      28.25 seconds
CheckSparse                   PASS      27.25 seconds
BuildKernel32                 PASS      24.82 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      530.29 seconds
IncrementalBuild              PASS      23.62 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/328

---
Regards,
Linux Bluetooth


--===============8841798661015776099==--
