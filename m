Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D2318B9D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010390; cv=none; b=m5lLks7Y/gMSBk5NEvTZas4x6M841o8TWq/Ilfix62SEZ67+LvtUPgSLKW2bZDeqxgeTi4OtdTQfojAu0kZYKzmgzWlzcCN7DWfaMyKtu572Z4xfz0t5tA5sOYB4jzqxF0L/vOL5DfdsLSuigcd/wyG5WlFJFH4q+L2UD3GhbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010390; c=relaxed/simple;
	bh=hXCQQ+F7plI24O+TmbR+EtFuKShzDJkdeom7SyhBzb0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IUzVMCuULzWKEC9o3E6lzHCpQ0eYwncHNQt/gL9ay0jjH4628KUM/Wm539TzD0CC0XXTYPcWaVuuQgtJfnTyVm5NnDRn0dXpCStDSuw4R1enlKhvzNpdKs5902RubF+lsmnkDVz8d4Dwc3XYxk1N/mT2YQimh6xnBRQBTFV0ZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=saFdZsFg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saFdZsFg"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efef6533aaso15304976d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010388; x=1783615188; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hXCQQ+F7plI24O+TmbR+EtFuKShzDJkdeom7SyhBzb0=;
        b=saFdZsFgxcrL/HQYunsv5Y8EekVaC5ZYyGtekncK3ZLWczNiEMRZT0sZO30/ah6cyk
         9Fqc2K27DxBiKlJ9xKXS6ZSOgWLRj0xUrGC5xz7g7UivDeEIihKCVZVD04n8bB2ahdYp
         qqv3HEobiTp1IDLsBB+0TQX0d+UvZIpXiqhbrBlLzjv8JdA1lXz7SQlK/BnYgxmHHknl
         ExCDZ4Hy/nuocYfI6zBlHOaHliQkvQBYu5FiwXn77Ognk4/PIXKf4xjgTpRElsXa2nDd
         wnsEs8X4sKHxQAFNRqru2rjUHi61sF8YytvyMBNPOmMz5ey8UGcfBQYO/mjbFuQXlLlE
         5p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010388; x=1783615188;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hXCQQ+F7plI24O+TmbR+EtFuKShzDJkdeom7SyhBzb0=;
        b=ibRkoRB4WIcRAF91Y4JdEZQKw7ENAWr1MEPHrA5ojDihOp4F1FTFbAJjuvy+e/25tH
         v5nOvAVd9OFuntRMRHEOvQYLr3L+7ekPijjom4a9eoikTFu60PpEqAm5/U6XDj1Eb9Gp
         E5szUifI9jQFio1LkggkQ5b6mFwCxjocf7RnHV/l2Z3AhpuV8GpWEzZsgrGgNaoMoFxl
         EJkmuUGB7coJBEhwA8rSYJao1BTXyeGd2+DHTTBrQPUZG3LsGc6mMFzmIYKx49ihrlIr
         UiFnpgoYV6nrpvYXZpOKTU+ODVeW/3MvMNutR71SmEXNYE98/9l2CP06Ysw2GoM+Hgyr
         Yxgw==
X-Gm-Message-State: AOJu0Yxb+gnPv0i6UZtkhi/yobGRyE512LuYkAmTJ96TXLgrL9MvfGv7
	SXeM508rwSHWJ4XplVHWFmhrWuw6g9NAVnMFLGQ+VysfQTI6L8GFzsmklm7QBw==
X-Gm-Gg: AfdE7cmDQP70NpU7tDJKYEs04djNcZeNI0ybZJBHm01u2l2qVEmRBNo9w06pqmlqpUs
	XjsLeDYAizSRUOIXk84aEa5dkMdXhma3rdSfHdWfH3fwnIgIf2YjmFof3E3JS2OdAqXhm2wf+xM
	9rZGcEk8yNqNoRxdOjZEvn0Wo2uJm0U2TU68092XWscau/XrjuK9XZsLGQeiJqDBC3hPwIEWse2
	4eXh4e9p24tuKR0WlRwyIdIduuZt5Ld0fB97xelx5JqiYhalHBa8hTluPYMzLsKRwD5+LJv49Go
	s43r7Ld8mQGTxwSLrnnn21VEwRtS3VuxyJvkLtri/asmMasNrEWWNFg6QRhlvr7b6Dr3KzcBhAE
	yuIzB6IBBjxyUTwLA9/a6noaIeA1RrPkSIJE+WEJQmbQywf1O5o7gL18Q8mSvwOqW/auOTvMph3
	UoR/+21rGkuD9RPQdlRm+k
X-Received: by 2002:a05:6214:19e9:b0:8ca:10aa:e1f9 with SMTP id 6a1803df08f44-8f4248ceb50mr88586226d6.42.1783010388175;
        Thu, 02 Jul 2026 09:39:48 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.236.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f30b94fsm29679946d6.21.2026.07.02.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:39:47 -0700 (PDT)
Message-ID: <6a469453.b63906d5.3921e6.d57b@mx.google.com>
Date: Thu, 02 Jul 2026 09:39:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4517822631415400909=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mendozayt13@gmail.com
Subject: RE: Bluetooth: ISO: backport missed OOB write fix to 6.6.y and 6.1.y
In-Reply-To: <20260702144207.320421-2-mendozayt13@gmail.com>
References: <20260702144207.320421-2-mendozayt13@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4517822631415400909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/iso.c:14
error: net/bluetooth/iso.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4517822631415400909==--
