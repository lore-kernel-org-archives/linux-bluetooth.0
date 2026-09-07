Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5F42E413
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796176; cv=none; b=ZftMu26NqXwH1Hs27FWWANd86OlIxsNUpOqdRlr+xQ2fRQlt4hhwxQ4OoRxWdcy6vizSls8AtVNJreiS1LaiHOlC5FTaPdSrDxHPrzXlo+OkTwUqK1v4hFBm4LlIGnuUiI+ifYmfO3T65y0+f7s2LMWY43BCvTnHjInePCGWNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796176; c=relaxed/simple;
	bh=TRFvm879Cvt0TUc7FFuRGNHfqNEI0ZAaGzFnco3gbfw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jOXpbhkZ1b9hxaCmzH6kOoM+N6NHIyou3rJXrAWLHIk0cZZLkN4tHrL9O6KU0ofm8KfGw0ZVHMfl6XZKDmsH4M/0R/X88YItSyrqsqXSwKir7S3mi6CuDGKD+DaPERO2T9C1UnBIMfPhvVnxQwcTpOwTv3BFKzP83V9QVYiVdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOyQOKWd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOyQOKWd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so5913428a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788796174; x=1789400974; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TRFvm879Cvt0TUc7FFuRGNHfqNEI0ZAaGzFnco3gbfw=;
        b=BOyQOKWdHcCXfuScxsRgXt9WFJ96NHjwjr7k36zLK2m9VGRHv4vRJ4MWaCskTEw+xj
         J5CnTsGmb8HTZVfgEsa6kLfLRsopbWoeFKEzowzpxFv29YirISmmGQ11FrZCYxwXqdcE
         HAo+vSQSLQD0fLjUFIicZtFAivxml27EZqZJ2s5FeVU806c5jZApKn8gG5uTRasU7uDR
         y+A/Mg62+n8Wqzhmbh+OQ7/nqKibQZjgiUiY0wui0rj5iWPAP1H/m/xVGckO9gGHfVnP
         dNOq72M2z/EZF6r9gudXohD7cCTUmdrukB1frK6zcXeLZzLWQUoEo0B/yudbSVkdLWP8
         d/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796174; x=1789400974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TRFvm879Cvt0TUc7FFuRGNHfqNEI0ZAaGzFnco3gbfw=;
        b=bZsEplv/gV0EtimGvtNX6WVv2g8K6jloLCE4+brYDVyHGy+Nq3Q6+jDuWOlmAMLyuj
         NCMT2Fh89q3FqkyX9fZxtUSb9WmpH8TjJ0lrH8utHQDXzzGhHnQN8FVNxd1RGc/ejv2l
         v2sFW+/KbI5+9ciEkJK0c2zy7xsrP6tG97HDcW1F2csZdTX8Ppz2cWt4kXH6Tg91d9j3
         KEoNllmapt2vllbYtf7piP5BVzSDuZCQwbhTFhGI4v7g7Xw+B+eZ3sEnegPyD7fuTPgB
         ik7vmzrZD+bGr0eHhbMWfO9o4ikqaaekC3tDCDdU7YbVfPFqU1o7x9C9iDZ1IfZvXssW
         Tvnw==
X-Gm-Message-State: AFuF++nJSd7oBsB1z7HiGKFn6pkVxeMzBTT8NCoWVijyvRL3zHWlnJoy
	pwJAB4+EpsResHKA85+MpGb12LEPRb77UvZ9IIFYVlYbBOf3ONHu6T/Nxa4JTg==
X-Gm-Gg: AYBFou2NXUaTuN+JfuxZG8N0Qd1gVKBijtqrqyIsYLzBytgOi5EBrRkYYZaEAY7AHps
	h2uXh5vfmtvKThCa++8oN9707eg0NSRfnAgEpHC20k4vKDZwrAKulXgMtBOzmLgQCVFjpNK3WfC
	1l6pVtFq65Q7GcJeoKTWHCQnHj/HTRSEUGAjX3tFmDccQy/EtYCfqSonHHT51rRm93qE25c1T0c
	mj06ZJUyFK7hOjsDOfItX8Hs/y71Icgn+cSz3jxCNuKRFBAXrTNIwl9IS/yhJmiwJpFYstrlnBw
	XQ68i/wHlHekpNKtEHwxIlk0gk369mrCdBg9h+zuiOb/x+3UTiaLI7GBR6yTzQuaa8hjjqwJB2B
	SOaeIc53NeUfIONcPY0+vM0qkbD6JrlF2XzP3ZHVePZSfUO3Rcs5VTKMM74Y9uAad9kWJ5WwBUh
	vs2YpQ/z8ibrjtPUTfiOcGMq3XF8bTlgUAuqHALeFdkkWRm1sNWjsH0NNdX7IZzc5iqlbVPsJnF
	TF8LQ==
X-Received: by 2002:a17:90b:274e:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39b2610fe62mr36003823a91.9.1788796174407;
        Mon, 07 Sep 2026 08:49:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.51.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm29348081eec.19.2026.09.07.08.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:49:33 -0700 (PDT)
Message-ID: <6a9edd0d.de43c058.24771f.d4e9@mx.google.com>
Date: Mon, 07 Sep 2026 08:49:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3310701578693105221=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: RAS: Add support for on-demand ranging data
In-Reply-To: <20260907135606.824752-2-naga.akella@oss.qualcomm.com>
References: <20260907135606.824752-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3310701578693105221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3310701578693105221==--
