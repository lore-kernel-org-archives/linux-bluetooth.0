Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0673337B87
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569354; cv=none; b=LUga9MiQRVP/vVKY5SphnXYOAKZqKSUOJnPXacLMR/sahtgKB5IYNDoMMKz6e4GXwfLUo5ozl6btirCoaxsF4JkvzwikzKpqkYhP6AqFPz54Eu3TwiKw9QFMDvx3MEdtSORrwFEkv9SAQqIz342c6xTS8L7md3kGxUM1vi5MWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569354; c=relaxed/simple;
	bh=PDOs13ikocPr/k2LmhrXjS74pfsy2pJc6CpLY9Xh3mg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tHv3MrMe7BtDxCI0OJmj47qPI7zhocs6xQUiXPLy8cLpr9zkHFyGZKv3IBghfFHgos+znFYNFSkaPxbVAW711l/FDQdrkfamE5/+hC+poiQIvLUaKWfJiQFegySofMlvORRRaHOqBzmf7PuPEUQeZJqKNmV7ZcslDWqrD0bl/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4eS/bnT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4eS/bnT"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50fb1ad3734so19002641cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569351; x=1778174151; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gdZbeeI9sxXsLk05Llz9VUmeQMwCaqmlde9eVqY3q1s=;
        b=r4eS/bnTXS4TqZWeNBYsNt+QOXDJXErIcP/t/3Rz9qcDbzMJdSQQEL5nGREnc1izVC
         h9G+iruH5wI9k3RVTFU032MbgOxNInrm5k+3q9lchFjpWHvLnoTwxX5zmzgThBFjcLMR
         4qio3rZyAKA8v+Wj7AXZe4qaoAZyJTy8huvMWmEccmC2npbTEX7QYNzfG625J/MWxF3X
         6eHmIb4NnZTzx57YPdTkeOiZWFsrbVFK/r+elmxG4rKHK3L0heUKfoDC3V/FCQ2pHrcf
         4LZxmtI4QA3fIqA3x1QQLoBPid8hnHsZ1DWhyiwOyJFFG4XBJ3npppD3As7D7u8vK0px
         ROGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569351; x=1778174151;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdZbeeI9sxXsLk05Llz9VUmeQMwCaqmlde9eVqY3q1s=;
        b=op0ZTsCXvzjuIgb+HJvEmjHrx9jQdCqnjBldjMUp8cu+XccfH+ZitVulI6bttYp7SO
         C60gMFeKBWkbB1WxOvDWgeZgsLa6mIaiqDcv4ygFsytND94tyjPd/e0TKlShqpnwpYke
         +9R/aBj4UiY/eXvGYDAIfClZNjduSh3eiQI8BE3EwETVmC5WaMskYzotTJuJZ4OJQ+vD
         4LmqCMYiDjLGGHCmrswHtAVPWY4VKIzELC9nNTm4D31pTRlmYcBZals3kn597K7MdOEL
         KXm7IngAtRBqY3cwO3d2rk1mpnNr2XEuJkikYJNaqeIUt1A44idirtnhUNY4ehafQLIA
         0HcA==
X-Gm-Message-State: AOJu0Yxi69+fwinM0mMTCzC7Me218MtRDFxujJQdL4G/di2Wqlkhn7Eu
	HkCxI9sUQ3BbUCSNYXz3KHUm3txRxJNZ7uCVYHUAmitF4Gdm7wClIvZGZSPrxQ==
X-Gm-Gg: AeBDietI6CYBPVsiR6xOTFOK6UhNNpkL7G8bAL0nw6EQLenVrSxipeIxLvCm9bQZSDu
	KuDgdRvqlUG1gnWFYM3oJBDUqNJW20igWkdAFxNNYhZA9wWQ9p1k2O4khdREO4GX1KKhklLcFAo
	mhgpyT5CM3wj0iApHgXY+V0UOM8iXkR9YzgpB6ctcPehVgevbP0+m6v8OwjeSddEKRQJDR3m5JE
	xiUXood0ZMCUh7doecBneEkqFYQHlWiOWGdBGDhTQVNwTWH2+r/VITnDkZVmKx/quSrJywdiSls
	10sKBz1RGub9hPB47crq1tjtyxDaIpcKdM+Yf9AJ5rPOnDDYFsRf6XeS09ki+yMYw70EQgDBsM2
	HEwD8iNGFLOSs84gIwlAx6BZWJGFJ2T/BGzzMXnBUMaCi1oLPpQ2I4aIJS1r9bDlr7KEN7yqcQl
	psDT3nCS2VXGhhhMCgtG0HOOBL6i9EDCK3e4hK2wc=
X-Received: by 2002:a05:622a:8310:b0:50f:6e68:d71a with SMTP id d75a77b69052e-5102d1f7603mr32836531cf.28.1777569351383;
        Thu, 30 Apr 2026 10:15:51 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.245.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d310ee8sm119091cf.22.2026.04.30.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:15:50 -0700 (PDT)
Message-ID: <69f38e46.c80a0220.307c02.2ab8@mx.google.com>
Date: Thu, 30 Apr 2026 10:15:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0465216949808047933=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] bluetooth: btintel: Add Bluetooth SAR revision 2 support
In-Reply-To: <20260430165123.1070214-1-kiran.k@intel.com>
References: <20260430165123.1070214-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0465216949808047933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1088244

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      26.51 seconds
CheckAllWarning               PASS      28.79 seconds
CheckSparse                   PASS      27.30 seconds
BuildKernel32                 PASS      25.28 seconds
TestRunnerSetup               PASS      572.34 seconds
IncrementalBuild              PASS      26.13 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/136

---
Regards,
Linux Bluetooth


--===============0465216949808047933==--
