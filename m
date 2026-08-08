Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4497E3C279D
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786181334; cv=none; b=NZWKaSfA2bHRgSTrXt5dGlfLIViDjKd+r6M4opNItrVL7psowKMtwQw05Y+0S5WWQ1o2gDF3Psx2Z8xCSdFRRul6cf11GmG1xIOaztB5RILIxm0QTH9L2COOKsWnMDqMatTLK117447ZkbIMCwHDaTw2ajJZWp/OIBCU3OghgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786181334; c=relaxed/simple;
	bh=UDeAxOyqt/NegPQOG6Eh0EIALVryM8GMR7fqSCjMVs8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IOhV6mSYuhFX8sU3iB6PhalGg/hVFldbkdnyW0u2RbAcpoG3n28PjYi5epHAI0MLsZB2r3ekuAn+RUS3Jn2RKvPSwf1Hel5NfhUpEuwf0cJFsL7onLIFA9d0KQ1irsq7/KZGUjCu5D9AFn+GlvHHPpqXwhrPPQCVHkUzM3dylo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8j9Z5wH; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8j9Z5wH"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso407464a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786181333; x=1786786133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sReOVU8Y4zr6CuWbRu8YAkg8qP/0e3sXyrcMql9QAAA=;
        b=q8j9Z5wH5WyOoX8NNa7bfYtPupqpgSndKFJThObGNKxFU4GOe77//xngxEFa4qFtZ3
         lQrjDS5p3e0BDbtIj9G93C9FALAQZJ9/DTizFXdWJHbKp7xTKePWQt9hgzWKXE8Bwcz7
         kKgBgvZvR4GgokL9bOrV+J2Nj+N68Ax+Cf1T/ISee1Tj1kldPbAAzzIVYKQ23l5TpUeI
         /55z51ikTfL+s5wC8rV7f+ZaK6M+H1/Ss22Tg1Skv5Gnts8rwF19U1XcC7aaZtNxpNGB
         IyodDjo2TIR1E8DPapjGDwqOqF6cJO2DVBxfbDtgg+/5Am6O/320vIXQVgcOl993Xo7R
         r3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786181333; x=1786786133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sReOVU8Y4zr6CuWbRu8YAkg8qP/0e3sXyrcMql9QAAA=;
        b=dmjQBayQfEKYfBNCmM/LzaDx7OJNNrYRRIPEaA4EK0VeE83eXHESWGWzMl8YgRLCBH
         HSOkX3dQ5ua3dKTzME3alU6tq/aVXxiAqDUoGpYeuHWqyUGB3Pi0LznsApMtUCIpTUIr
         IRkhqkPk94aWCxaCZpl1dNN4z75qMaL8povBUxipe4pKnkrf4/r9wmrjkZ9jN74gb4eg
         vbYRZLDmI8Hie3ZIa0UTpxCae3nXlWx62p8OistOeyU2hTDI+18SBEZknqMIIM45TtYA
         LdbaRhX5K/+huGfxQ/GZZvkGgJ7jHcLEXtnxzr2q47ReQ4fdWzVTzZTrF7odYgl7rUri
         uetA==
X-Gm-Message-State: AOJu0Yy+JNYjTopxywH9RADdszaQHgLK0jWkrYX+xCaS+l/cDBe94uSH
	7BrAvwvQgfdw+c7A3rKn9sV/lzskL+uxGCez1X9eHHxSR3QqwyDKJy+pWOUFxw==
X-Gm-Gg: AR+sD13InZ0jtYYOYO7P2kcnqTdTbCn/6y4e+MV0iQgdYkGd8FTJPDUHePNkNbr2Jhr
	Nwt/L/hbEHj6ZzuDCwl+kkR8DmDZDRi3dxaI5YRNxxTiGlpV9jTIrR66Je7Y92selQcTNQgd3BN
	RmYVkDiiM5Z/cwzCF3MHi8o3c3zbiGPMVpWjC+ayBfaMuCk3EC6Jun4RYCHTg8NqY3Q5kCTxhgQ
	TUtppogBYLSfR0pGLLH93/ilpHY7iUIqweU6KpTY0XZISmlguwdl2L6zpmFBxZMeFdgxVI+x/WA
	HYgAtC9A/tMmCK2KoRKP0aYi5rLtKwlXth97m8INg5AKemkmIPeF8JE35GQuUaRPbryxs2UIIHG
	Gr8wxfYdOT0VI1c8ao6Sk9dOpGdafFYpsaIoBpi/nI/pejMUVWyrsbaUr6Ec/h18yy+otPI3qIH
	t6e4BD+2ZOdpBoGTaQdiv9JXDaSB8x7A0elB5+vNE1bnZGdL/yF/Nuld3TK1uglGI2L/KXE7w5S
	ll/lA==
X-Received: by 2002:a17:90b:134f:b0:38e:488f:7068 with SMTP id 98e67ed59e1d1-39261f729d5mr11038835a91.2.1786181332590;
        Sat, 08 Aug 2026 02:28:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.51.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm27066624eec.18.2026.08.08.02.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:28:52 -0700 (PDT)
Message-ID: <6a76f6d4.4b9e17a8.129179.7233@mx.google.com>
Date: Sat, 08 Aug 2026 02:28:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8514249882696112211=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] emulator: btvirt: support debug for -s socket server
In-Reply-To: <3a0785ebc5ceef448c52d25545b142659d25ce24.1786177678.git.pav@iki.fi>
References: <3a0785ebc5ceef448c52d25545b142659d25ce24.1786177678.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8514249882696112211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142579

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      16.09 seconds
BluezMake                     PASS      456.11 seconds
CheckSmatch                   PASS      230.38 seconds
bluezmakeextell               PASS      74.82 seconds
IncrementalBuild              PASS      452.57 seconds
ScanBuild                     PASS      686.57 seconds



https://github.com/bluez/bluez/pull/2389

---
Regards,
Linux Bluetooth


--===============8514249882696112211==--
