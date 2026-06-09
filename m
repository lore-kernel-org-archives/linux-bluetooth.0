Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BE3E3142
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046385; cv=none; b=IsW4WwlxmPW8pOyxPqKzDOD9teggJioQy2TmNwIMVN78TFg+b/Ct/4Shz2qpOL99+izQMSA1MUvHk44RUTj7cTEbjVVfc/Alz03HA/rSBfie2js3RC9nLp13cZT9DR0BTW0BGyPxFuoPhxpajfK1YcolBeGO6azOzE3Csjl0iKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046385; c=relaxed/simple;
	bh=5JrHj3rgUGZOhn3Zzeyl90YPDJKKw6fLToDWSSQH3Iw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ISaa0QhE2o1yF9KVEzjZvIR7vQdRTutmElQvUbWWxt1gbzPD8H/IYG+Jf0ImBZ7GKUjG4MgDvsEWMiyrKEJpNgjbhAkFsu0CXtpLPL+TDv1Gw/Kav0yeUMLDgOLT30z5phU82KJ7o6CdHvKfYYldAAbtQhwwHaPW/Djf/WJkKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEAlw4hm; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEAlw4hm"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso426804eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046383; x=1781651183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pKr7/62UcnLDcJAZlIk0XyJlY4aocYlMtorjR1oeOOM=;
        b=MEAlw4hmmOpJmer6fYS+sRPWmv7l3C4zpQ2yZZSJwQw3i+CoFHeuNCXTG1yo0VamxA
         g95ejRGuK25xbVAIonzYm1wOwouSWLK8KJhNInkN59BcTquVCJZ0Pg7OS2jivXxxQQwO
         RnZwzqU3ZtwZRbQVfHgNbwAVlJFyLIfGYeMs/H8YM8GdaQcX9nVUrpGZtSe8d+OWIPy+
         rbXmaD/lUP/tynSm0AjS8HHo3uaOkPLa5krtlRzbTlCWbRZgyS1/CjErOKlkTDnzv0Yy
         1064xadehp02uQOmPuyJu7g1fTwFljzLZAB7ZkZl6iwD9OXmLS/ogpYnrFAdiWMZaQNV
         LmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046383; x=1781651183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKr7/62UcnLDcJAZlIk0XyJlY4aocYlMtorjR1oeOOM=;
        b=nnAB2k5DdVg/oRNXMTusGpOMNLzcD2Lnyy6JtnyaAGeMv2r4EEnhdQCaqfwNqtoAfT
         Cdq0uN2LUCPW/EGCb4yPZwzTwbDjH1AYL6sYasu8/pJp3CmTDsA75/PjwfZ0lj0eG12c
         nxFZwfHQ5JrL76+syG8NLiox636JEJIvZYTf2KVu6g3hh7+lay+2DUOucZxuepRbPEge
         xi17eK4rxZD8VpNTZkiF9Xd/6fTGquDQOd+m67x6n8I3zZ6E8hlkZBGTddEA8nDKADNK
         rLiVWImxUukjL7Wcl+yFk/vqLa7VPuUV/dNJO0NopqRnoCiE/BMSy7lqUJPliHMpWPIy
         id7Q==
X-Gm-Message-State: AOJu0YxmlrrGxIVjFMwK1mGRmrKVyfgfVfcrgb9WzdRa/IiE2CB+m5tH
	PJRnuXtypLH+cIbWUa9+XmdZrobXCFTHmdcMX+G/99uhANynD3h1sPAX2BrHPw==
X-Gm-Gg: Acq92OHH5h0DO9JdKu8njZzSjOrCoGcqay0jNVUfRa/D0SJpOvrHepVEKzVsaQWMWGM
	G7qHEvN5LAJQ4a/1Cstawi9QRYfZh6tgnN95HBtxELqtmCEnn/26NKrh5afnp2sc708yozRQRv4
	2b1VCNHuQc/eSX4xRer2BQ/MLOfnK6GqGDBNn316EIEBcx0ISeD9H+c/Xd11NAuofSTNM/0whtd
	pw0yfCK4RdURcQ2TJ+zZ1UH8H+ONMw9WlF/CXuChYB1GhBV8mZCr9Y4HpFfNtRkK2WPoegiwHua
	jyZOCviEWl/5oBom6n00WgjGRYXjlfcibvEhAYK/VQELv2wHK2b/jx+5vfHPCYsa/d4Pr1E/8AU
	YN4tytm5QAEbwGUJmxrjZ5InyehNinombuN3X0MFAcLEYZ9wZ2VzCjoNBvOx7RBlsTWWsPRlXga
	tcUURosxCexO/cpecGj8GyyxSZNckUEVNXeURIV3SPEMk=
X-Received: by 2002:a05:7300:572a:b0:304:aca:35c5 with SMTP id 5a478bee46e88-3077b22c938mr12588342eec.23.1781046383107;
        Tue, 09 Jun 2026 16:06:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df102a1sm21907558eec.20.2026.06.09.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:06:22 -0700 (PDT)
Message-ID: <6a289c6e.257a352c.24182c.85c5@mx.google.com>
Date: Tue, 09 Jun 2026 16:06:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2529784638699513893=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] avdtp: Return correct error when SEP is inuse
In-Reply-To: <20260609213013.3900808-1-simon.mikuda@streamunlimited.com>
References: <20260609213013.3900808-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2529784638699513893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108834

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      20.53 seconds
BluezMake                     PASS      669.66 seconds
MakeCheck                     PASS      2.95 seconds
MakeDistcheck                 PASS      247.75 seconds
CheckValgrind                 PASS      228.75 seconds
CheckSmatch                   PASS      352.15 seconds
bluezmakeextell               PASS      184.12 seconds
IncrementalBuild              PASS      662.09 seconds
ScanBuild                     PASS      1053.81 seconds



https://github.com/bluez/bluez/pull/2212

---
Regards,
Linux Bluetooth


--===============2529784638699513893==--
