Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9153438A7
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346090; cv=none; b=Y4e+cAl68g1dV2CAg5X1XQAEr/V5Kq8bv59mHZo6MEo0fvein3kE9j2erzWSdBMZL3XkjVU5n0HmhotS8hPmk0mhnxZA/Rna+VtkORZB56qAu5W2CvyhjBziAOTZx30EGCd5X6trj748kIoo5Wz6N2Z06tKTNV64f/GBp1w9Bpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346090; c=relaxed/simple;
	bh=IteEm8as5ond5qzmuTRFZWAR2tnZyS09HgSdayrWmMQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YTfDBp80QM2weWbqrX4lJSf4XKg4SJ3yH3GWkFjWOooNfqqvwwn5mPZVcNbFhpLgW9tyTErmG71f9UrbLS897oGokseg3pCFhqwo5iU/WKa9U0UjyzgNIviwG5ZEO3pVVZn4mwi1wzcjK1ffHs09fVRcwxyFCFG+0dGcN7NiNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0m3Uu7w; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0m3Uu7w"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c999f162c9aso779743a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785346088; x=1785950888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IteEm8as5ond5qzmuTRFZWAR2tnZyS09HgSdayrWmMQ=;
        b=c0m3Uu7wBYbzGkCfjBEynOJXAmUKQM4TOMs6kRVY57ONArjwl1ReoyRw2Kwt6TaZ2V
         BDj4eQDapq3svZqhOuBVXPwMu6NntsxIWwCysIXLQpsPhYpWnqdM2emZecqU0trDXKub
         R/F9BTkIN5Rokv+N/T+r/Arn7ybtnIGJ4Dn0kEqDOSjUUwL7FDV+EyiWnQx8D2Q79SYO
         vUn2liieMoz7OOMmxVD101IXjlm5vx66YQ9F0sWx5y+fiV1zVj3qZM5OYE4xQ1oXLo7m
         PDnVAPDgwuG9lq3fI+kLbt468U63sDmrLaSqg2kcDZn22P48yQki5cWGNb+E+6zxm8Jq
         Zmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346088; x=1785950888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IteEm8as5ond5qzmuTRFZWAR2tnZyS09HgSdayrWmMQ=;
        b=pYvYO5gyLKsJPqs8MJHSakpdGKienFj/TJsWoonbJ64QjzmmWBtpky5HZo7Gi6wEBR
         oFhQDy+c9Mraj3AAPwwBVFpMvBbjQfQYgU0COlqzwN2f/yEA6zltOHXfAjyI4hD62FO6
         NqzXp6Y5F6vvaksTQecCRWyHnj5rupQuIFPif+kZ28BEG/zmG2yJ8XSlWhzUJguUbqOG
         TLBBLF6wIqN4x6oHQfI4o0O+sM7DDs/Ff0i2Cev4ml8Uj/HwOgJ9AuS5xqyttpLQ6plI
         hAobZnw8iSxcIz2SSHmn3HUjoiu+JxPhmBtfZbL6KZyloPZwDP6CAtaiv6OScNPw2KAs
         LwSQ==
X-Gm-Message-State: AOJu0Yyx9WFbm09l2Kn8KbEXE69E6lnpfHyeChIp3SWIfatG3Tl5gDGj
	gYZwzXSpXNimtFwhIKv9tWKbcEnxKKqm8u09Jl7zQmiu9fBonpaPJHaBiqXODA==
X-Gm-Gg: AR+sD13Q86GySAT7BOP5fhvrGbSOde4jvlPdRyITsY0Qtw1dMkvQundrlo8fm6iveY6
	A/VrL8c4dM5gNQyrYgJoGmvO+Ce78K5AIHhNaBJfz4fzg+2xrDQIE8Jt7W/AtbYdiKwat9Sqo9+
	cZMvMK6P2YYWHAUCtmP9D8S2mfPHuX5JCdaAattpTzEJ+KcJQ4ItxkuMCdVdCm0gvaUXCJXt2Dv
	217x9XpVLFO3wNNfAm9peDS4SpeJsfZsvF52EEYoEbbB7vMBnN3Qm8AIY8Or+z5hV7HHVARViEJ
	NU4Hg1wMFToLpQd9mvUpVdawnrMha2O639cxQhBheDyyfc+6ws3GBNprtEHDnWq2dMfp+axs5Hu
	wpYzRjRlCwrsZ23E2fZKX/zjRaB05MY6RDiuPyhT4Hzg9BaBmVun8mnYY0NZs6cN3po6pRiq4uD
	ZBUgz/P+jlTHufYhmZVXVgxAAyj51MLAMcL/wQQU3fVqSEyoR2qhYUxEbUXzjkpHKAnlnb5Jx+T
	omJ
X-Received: by 2002:a05:6a21:6f14:b0:3c3:9993:d5c3 with SMTP id adf61e73a8af0-3c8aaf80581mr8909567637.9.1785346087585;
        Wed, 29 Jul 2026 10:28:07 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.58.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72735084sm11120517c88.12.2026.07.29.10.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:28:07 -0700 (PDT)
Message-ID: <6a6a3827.af6ba3ed.1bf52.3582@mx.google.com>
Date: Wed, 29 Jul 2026 10:28:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7459376648596102176=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: MGMT: claim pending pairing command before completion
In-Reply-To: <20260729170356.214966-1-nicoyip.dev@gmail.com>
References: <20260729170356.214966-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7459376648596102176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:3514
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7459376648596102176==--
