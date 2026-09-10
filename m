Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E1568FA1
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062234; cv=none; b=ujJgUJ3DhDWtqNxblLdHqoFx0n5Z2Y6c46+J62uOcj1UM6Rmk9cMMFyy5y78knsYaHAiTcSiZCTQ6RSX41nQm8+Y6iwhLVR3RHqz95p7VPJTfShB88UMEzpECJ2Jm7PotKuc0M1mKkFQzsHA3MOlI7ZlD8pp3FmPoAPTyg1+vMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062234; c=relaxed/simple;
	bh=d7bmsRxw1zYwIwTBUrCFU4qA7raJbGjBTiACQ8NL5ro=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gunTYXiBPZE26LWEOC0l9UQBNWz2G28h1UNxp6drhorGJMKV31PZXad4I5UPQvl+Y9V+jz2MHdZOWTbYRSmAM/Zb9/P4C0lqy99PVk1B84GPk4aSJtZKu4RWDA884QMH4fhbU01b37hBLcC4bUktL23DLhPvu1Bw5Y0Q22CFgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcSz/HmN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcSz/HmN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so58086275ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062204; x=1789667004; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d7bmsRxw1zYwIwTBUrCFU4qA7raJbGjBTiACQ8NL5ro=;
        b=lcSz/HmN+vZnzIqtp4m//ZgqwF8+sVwRhVFdS9yv1rWhiSVpYpGfkDNYV3s9C8WI86
         1MaPNV7sC7pej/Pq5YolaAdQwGI+/RxDlkec1/c1jHQJl0mY1fi9G1JpOX6W9eakufW3
         NGUAlAoj9htPiwUxp9ZzrxkOZPJ239VX/QTpGf6pjzy9mnmWu9FH1vwZ0ITO0q1GrZ7S
         vC6zhWYSBN7nEs38H9t+oLUcK3xmURAE74/RzMgGUbhp9ttRB+BTVmaOtWRKHnioN1km
         4zSY9hBuHqg+PseU3YYQMr5P08x9sszowH/w9YTnDJ12adaIRnXGUQbWP9/DJRV7XvnC
         ZOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062204; x=1789667004;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d7bmsRxw1zYwIwTBUrCFU4qA7raJbGjBTiACQ8NL5ro=;
        b=TYnw2l+zAUrLzmdsW+mvkkLFl85FQYM7ugguFyFlzkCFW/kl/iRciTO99gZTTr4HS/
         jKhBcqr87mC9UcdRNwfeMcov6z3HLbcmLyS+xqsHhpfSgupyvG//WZ91AkKnfJCP9bOe
         Gmmd2FDiqzSgDdMnSYGOpK570YE+f2x1kMKNRXxFZ3IHrePbeeufO0OhjqjXRjDV18o0
         YUMEa0e3sfHqP+/nBaDo1Ev8KIPHZQVGEM20XV9yoJ+XjFfKQpr2iGKmf0gKrjeV0FgZ
         H3UBE7Ix5v6fIdCuZJEF2aupRZoCbl5akRUjVJaS9a+E9J7DqxDkoMHusYb/lvHunvGN
         OKoA==
X-Gm-Message-State: AFuF++n/44uMoJ9EIJA1YITbrDIq5ZfJGSsbINLLDasvPvubk0VWac4h
	WDEwyOrDOw6DEmEMXnvxw31b9kFo3V5HEpNJDhdDYczmLm5tHCoxZ5QA3nV/fw==
X-Gm-Gg: AYBFou2oX3eQhNy9wZxX9qYUQ8cW4PvdKraMKmBorcnmONT41/nq8qwmYEBf/oJ/s2l
	WYv94Kq1ATTySKYvus5cQqM3xH1UUAXGEghhruStoH9RHI7RVEjFU/3cvPjLIvtO7f9qoXE6YpG
	LHVVfUhtp6gt1hjiQRolofshHu71b9BfkVKDpaTZ7TLiKu4thTrkTf4j3U9RkRpojda3vTvwbit
	g4+1Dnc/eZfOPxZDsw6+yU+hAo+L5eKrjg4lWTjJNSZBM4LSieXPm118F+jAMu15MhvLQVxXCdp
	PqBtUz0QYZtkpXjSLSmjLewUQyOMGT5+oqRIW9gcf7vtFC1KMORH+zH/8bHm4ZNG+Aorgr8nJrH
	RjyL3b0DnFUcwoGMa/DCXD8NvvU++SB8PvnLM5pxmRhXhaIQ9rjKN0e88OwIsFDbZZaU3GsJhZH
	wHshT71QpJOP3j4Vi3wWbgjYAP4jgpci4BSS8dS4mwCF9I3dK0MDf/YZTThby0KKY/k6VZiPesK
	Dq2lQ==
X-Received: by 2002:a17:903:178e:b0:2d9:2688:8be6 with SMTP id d9443c01a7336-2dd2a45aa50mr8432295ad.19.1789062203894;
        Thu, 10 Sep 2026 10:43:23 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm53679304eec.12.2026.09.10.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:43:22 -0700 (PDT)
Message-ID: <6aa2ec3a.496fef5b.1bdc8b.de24@mx.google.com>
Date: Thu, 10 Sep 2026 10:43:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0394795885476926501=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: monitor: Reference request frames on responses
In-Reply-To: <20260909182840.1289776-2-luiz.dentz@gmail.com>
References: <20260909182840.1289776-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0394795885476926501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: monitor/packet.c:13947
error: monitor/packet.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0394795885476926501==--
