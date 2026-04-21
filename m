Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD13B6BE6
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773803; cv=none; b=CIAtz5HyGhW6BbTVWr3z2a1Nb5rWdlGoIqMDClKv5vXwAd7DQshPrGAAtxp9N9y+c1qeMM7hj0Tg/eJZsZL436LI+yhQubF/Zbf/VbnphmLkbrxkcn2Q5Sr5WaqUL778/Kz4YO9j3Je9l38jVZweM8VPuEBUe769XgIKmpr8Bm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773803; c=relaxed/simple;
	bh=Mo63cglVgjvTgROPoHRVlcyT6rpTkbVPNQfvXceRpv8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lc9fTdph4nuKajwYYgofpL+rVIkkAZu7GzAUnvZaclx9lI/u5AOEBwBOBNkdF29YNQg0mf/uVDiv5l40Tv9kjhvaqy9MQJti33QuMiuwgo7xnEDOVipLTnA9PRNBlxBgV2oZHnfYYpivSkSEbNbeqoVOtPzmO3hO2TA5xSNUM0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj+NnN+C; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj+NnN+C"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12db2e415a7so314701c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773798; x=1777378598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+3KN3aEPtf4ep2sbKtbWSEzR9T0JHMIIfqTlGcxBbU4=;
        b=Kj+NnN+CTV1ilTs4nLwjdIl05XArfN4Ax3tX5R83F1sijEtoeYe4ctLi5YpegZlsbQ
         1li67KWN7eltorqg3sV1hrMZhMva7XCpBYVzzXFjIH/y9dSeQ+0mzmsZU4I+HSpK/yQy
         mpY0BUepAXySqd+d54lVvNZv+98p3BTR27BjGoeHm+dC6fucKnzGqZ3wfeA1uZJ+2dsy
         4z2m8V9DPqeEvF1Nk5Gdphkto3Ck7fhLk6wE3TcdSZNfnItKmLkEeczYCwUbUYz37cKe
         acNzP6BBn/u/oBIYlqAWug07Y3MDfe/r3fbyOysTg3x9OYMnI2Whpqe8XJKoso1RHcmq
         bGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773798; x=1777378598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3KN3aEPtf4ep2sbKtbWSEzR9T0JHMIIfqTlGcxBbU4=;
        b=bbXh/DJYGqNC+YoxP1/GnQth6bgCIcA7s/TwiSoIwyzBdb9F8nmQT2tXa0gjBqKgJl
         uYbh+V74l5jBBgHAFcriZ/XlSzVC5O1idvCCedIubKslmsRQ3nFZPezDxK/koqXZeUgO
         z4jv9qaDuOVOdVdO7Y6auXnJxklAkQ/h+kJIBZW0T0RSoWJn7tReDWVtFHJqSkfUxW3v
         96SQXWW6S21d2V+BFOO5HQ9zROW94ZGoJ5fvYBzg9mjUubm3u4ceDJ8knluFtESygjZK
         xBxXZAmgQxVHOPKVE7kFUpdp/zJRYFf9BbvdmB2pshQ3aeDzoDMV44ZNNvR8Nlf4dPEt
         otTA==
X-Gm-Message-State: AOJu0YwKIKziWaluCLnqwb6CG4CH5ManDB1sm9RdAAJ4CnzGknLkomf7
	fv4szKDq3qN9YBEJgeepKyfhBtwBbRNoz4C6hNl273slOAEGajlivfW5ZeszMw==
X-Gm-Gg: AeBDietO3FuASP7WvNSUbf2SVKZPuB6/aVZxmXoqO02g/tWA/rFwNeXGWtX6F3jCVQU
	bzIiSTYL7IyAEGme582lnSxIn5ICsBh3uHTnYStfd8nsDLhig/+vbCNgx+JVY3A4S6vtSlSZq7u
	ZzQC8H1NyLhE6MnEOeE8UIA7bKRtNEBL9ha3GEpk2Yv2pRQcoiq2Gy0+hxOeczoX1wfVbq4tpSa
	wl+qBn3Yb360fE2FREcKGLRVFcBt1AXVlUXneLNrlbrJSj95CY5QgoJ40Ak7mdeEJDU/OF0i9mI
	8/F5/diVHaD0ATt6TUVi/W6vrXaBPX9lzLkFqNP4/O91Rbu1Xk5/sWYF4Rl1RrH7baV90r/BInW
	XOxlwD//dWNj74haNdm7W2yf+MRWWt3PNevGeTVzM3gNYa4oszQNnwTWAyWQ8pSjYROVBZMwjwp
	aFVlzfMgJtAYm2yNJdVLDwo1EWEnTTyqCv5tZpJuOP
X-Received: by 2002:a05:701b:2611:b0:12c:87b9:94b2 with SMTP id a92af1059eb24-12c87b99785mr2422130c88.28.1776773798371;
        Tue, 21 Apr 2026 05:16:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.140.96])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm23769713c88.14.2026.04.21.05.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:16:37 -0700 (PDT)
Message-ID: <69e76aa5.050a0220.f32ef.352b@mx.google.com>
Date: Tue, 21 Apr 2026 05:16:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2527266373779162829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: [v4] Bluetooth: btmtk: validate WMT event SKB length before struct access
In-Reply-To: <20260421111454.3403059-1-tristmd@gmail.com>
References: <20260421111454.3403059-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2527266373779162829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083803

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.17 seconds
CheckAllWarning               PASS      29.25 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      26.72 seconds
TestRunnerSetup               PASS      587.86 seconds
IncrementalBuild              PASS      24.98 seconds



https://github.com/bluez/bluetooth-next/pull/109

---
Regards,
Linux Bluetooth


--===============2527266373779162829==--
