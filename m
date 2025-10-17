Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05A334693
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Oct 2025 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671823; cv=none; b=dYcazXidIDhqb7ySbypHuEvNonHKfJT5OJFPKNdovfT8ENa1btrVRE0neKIDDbSPDdYEiwOKcfAx7lqr4AbvTkF3wjqydT8QaVpy60NN3LKN690FKLQtV49o5EIIhfok7j7TAa4aA4IRmt77QczuDgR/CXzAVReEbUVyqp/Yxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671823; c=relaxed/simple;
	bh=3MqXNJKRMp8loRYFtyFxwjWp0GnKONXmz8BQ7T+WXnc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mqDgQ3O27YI/IVYOdEQ48p81KAKntmxxMb9ZKl/VFUQtlFEw6yoWbv2r98nw0Ahe0XvR7R5vdMRq9DzG1DQ0qbn36Fzu857alBNOs/gLsRjrB91c9IgBb1Jt3w3i/u0G4BAie0tNS0ZBefk8uBbR8BID8ojlcHT7O03pP2LfkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFp+jj9w; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFp+jj9w"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f26db50b4so207170385a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760671820; x=1761276620; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=707Yd9tX73WgegB1gWRKujN2Y+pbyTooOObncAIhdxQ=;
        b=LFp+jj9waVgeH/3+ZzdALlYi3/6w/RZn7dQn08PVBq1z6h5wUyCfExFB9kVK8XzuRg
         f9yS2B2vGD3K2VZCZLy7YJb5crpA0AMPAb9u5HfDYvQcSb/KO+NG+WYsb3pnepTuRen8
         dsroeBIECmXWCKbqPuB3bMgki6ERMeeaczAGQ79RYj4RQ8OkV513A/jgFgMLfrDbiOuc
         sNJwFVBO1eQ3OqazCr+FTNe9EqN+cCMHVKrs3izW1wel4wnb64FZfVyHjaM1DtMsgueR
         sjkB/BX/RcAd94xIUIP816M19S75ENT3ozpY/sFpR0QJY9NAciPoinQ7ymhFHBUNiWAW
         mV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760671820; x=1761276620;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=707Yd9tX73WgegB1gWRKujN2Y+pbyTooOObncAIhdxQ=;
        b=ffRJu5cAZ6kFAHybzm2MWoGesDB8xZIWMaEvugZXmf0Z4ThmdeAgidbyUdf4QnqbFC
         hf/MUEsZOtuvYhDJKSOLOYNBdGd4OiuPEigBoGuJYCjBbBhNo6nbKs3SLGh0jXd4hkED
         z8KncwylxF1bLHYGkHkrYvSZ3DVoTNC+lNeH6RZ2xHWJFz+7MgL9biWRFdiSi8rO1C+b
         gRYuDbVstHIBHF01uw4Y6dqGYM0pqH1PFVEVr20MDpL1tViB+cHkhBPtaSEOym8T4Pzp
         lqBNfaXuq6r3GcfmZA1A0MwtjM/MarRusKuJ5qQIw4mTRzvds22Qp+ugbg6xhAP/8SOB
         Wj5w==
X-Gm-Message-State: AOJu0YzUXqBNtxxOUXOAFrqU90eANQV8zTOZuBHMSErWFudbXY9q3ycQ
	cqPx0VXR9lg1KlxFdj86dx2WMvaAbe8LeKvwp8eZJKCGHhOQgxQuId3IzjPifA==
X-Gm-Gg: ASbGncvypj7B0bByX9L0uf0jT39EIPkzv2Qjz/D2cr6/uOkcHuq03dn5NLYuEM9uTp9
	d6slnu/W9knZRsEzDwCfJwQ+gb3+G3DNQiw+M/33Agk5Yj5EJdI2EhezI9bKUqyanudNAxlMXBS
	Y6ujfo7dKeRFoDDx0oeoELHVyTY3pFPTSovAzKpwBSstkwEVq0U0OO5uzgsbe67FfuDYsKGGK4+
	X+uMBLDnU9phdyTIZ1VoR87yF6r0jJtfmla8LnviJRd4WbxXwqJ7mYdRczAdclUhc1dWlitAJ8T
	VZbVD6mk5D9jsYL78SnZzBZmbbCsHzGwCVj3jVoXJS/yO5nQlxQXd/LSki/Bp9xlFEQet+JQz25
	QSotalQxfQVntN6/mJvPQjcJ082JpestGdwWR+2DBwHvnAR2bGd8eEvTepvSBxDQDdrpWr+/00c
	fd9vuD62RFikcJG5iWdSA=
X-Google-Smtp-Source: AGHT+IHRqhqUqnX+OeJIr3LAJwq6KphmkHoKGp57BQevxDokOxqY3LUXoX9x1hTw8tEMuyGfjuBtoQ==
X-Received: by 2002:a05:620a:28cf:b0:850:8afd:f715 with SMTP id af79cd13be357-89070603b76mr268425785a.72.1760671819803;
        Thu, 16 Oct 2025 20:30:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.117.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f38bf4678sm343148585a.59.2025.10.16.20.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:30:19 -0700 (PDT)
Message-ID: <68f1b84b.050a0220.1c557.9eed@mx.google.com>
Date: Thu, 16 Oct 2025 20:30:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0214968108176777706=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrew.smirnov@gmail.com
Subject: RE: [BlueZ,1/2] shared/uhid.c: Fix 32-bit integer truncation
In-Reply-To: <20251017015759.46326-1-andrew.smirnov@gmail.com>
References: <20251017015759.46326-1-andrew.smirnov@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0214968108176777706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1012592

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      2607.85 seconds
MakeCheck                     PASS      20.61 seconds
MakeDistcheck                 PASS      186.94 seconds
CheckValgrind                 PASS      240.86 seconds
CheckSmatch                   PASS      309.19 seconds
bluezmakeextell               PASS      131.24 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      929.03 seconds

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


--===============0214968108176777706==--
