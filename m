Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECC42465C
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169980; cv=none; b=SPeKi5fTlXvHDQI/U0Tyrm3+FfsLInxyZUF9CSzGZiMysqzy8u8U+OgZnR0v63969B5ozqsgP/vULXrJHI3+UMHOym0oN0ol027rtmnppZUgD2im0EIqKi9A2URO12U2wANq09E0suoQd/Zhl7yE/kMLFcrnmLaqDBZ/+40hCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169980; c=relaxed/simple;
	bh=jIBatESieXhi4v9QdSiolfeDjlTt/b0WC0sxih/7v8A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FT5uAbDnLSwLg8mvUZvEheXE74b5VKMG7AbLIgvBpxD2tC6BEVwiCySjYlnkdNBfy5092QcCpQ8p6TVHjMkPqcSvhm+JvEMOocCwaSdlZRf377iMF1TQfBc8jf2ewbSJad9hVWrplaJHDyLw557CRwFv+ut5wV6/MOmFa83By70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXFW1SGm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXFW1SGm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf27856f9cso38004245ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169979; x=1785774779; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jIBatESieXhi4v9QdSiolfeDjlTt/b0WC0sxih/7v8A=;
        b=cXFW1SGmGY6UecK3niY238PcH913xnPSwbf/Sbdr3CNBBtXv1CvRiwqIYnU647w5It
         jtyyi7scS8TiZnjn1BAtSJgAdsNugcbHUpJti+XkxsbNCM+SOj+37nAUYSdGxkYctspg
         PNs3x1R3LOcvhAz+5FQC5j1fl1wzZNu50g0A8VM8e61zhTt1Vcch+uVhny5oSR0mSK7T
         g/rTJdcObHzfa8n43/zXKNelt2cl2+hqpvbiY+X0JSqt8tB07QFnDpDHy6OMTFO2bqCd
         WUxNBi6HQA5Mpf1KrV+jNn9aUutOmOWcpjrVQ9sk0uh7xy4Li2SbjyOTMXG8nnw8lDZ3
         uRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169979; x=1785774779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jIBatESieXhi4v9QdSiolfeDjlTt/b0WC0sxih/7v8A=;
        b=FZnEP0zseQbEI3dP9onnlJgV53+yiIYvXG5UtERUCJPGksPBNZCojRL61U8JbHXWtp
         2cvlTivgsJdartDpXIfr2yKG8zonqx+PgpJdHG7QWa1MgXh++pf3KENrZr2JPaRylpbh
         cubVZQTi08EASSkknigovhmFNa2A97CE+eZ7OJjCt+eonldTYHIsJcSoGoB9h1u+97eP
         ZjPlFvLQz4VSEO1j4V9KDGHScU23CbconwKXb0l2KpWltd3TsE0TfVn9gMSSBDCwoHvU
         P93f26qLeFTqjbzhf/fFGvWuigJih1gvJGcjwqAKZ1XHmivH3NqwkjmcQdVbhWriYEVJ
         Lr4g==
X-Gm-Message-State: AOJu0YwC3Jh0ihqn6hdCZCP2uKvpnC42yEE2rJQQkwDc4RrwooCdAEAa
	cixjtA5GViibGjM2+JXdp8COziFwSMy7qGNzSYKnlwNYH9FS1WHviEPU8EQ6vA==
X-Gm-Gg: AR+sD12c+4zFrlXXQRYsCAxcAsfQk6VmV7WlbjBnZ8obB7IiS6e2g2Grl4qn4Kk1cu2
	4AcFAV5mnqM7yze319FQaiL/9slsSwUSbKZkSz8qzQMCS1D2NBEYcsNx/ejFfWqKOg/1LDVppii
	C3DeUSbiWSjxa1Nd8l2R2upmntYfd5UMIoJOO4zz5DSO4vvVSXuHW0bICoWdkaM26yxIqKrmnUt
	jJks3zIInxu6CXo/JzgHx0Pe5WSd4xNtWGukXVtInJM9dEn1YxvmtYoozBK9AvsisHjaCGtOxHO
	QZG9f0Y2TlSqFsGV2MW5fPW/rLSQUGbDhX/mNWmoIXprq6zhaZpGDa/mRsRwTI5Sp/wBuLss46o
	ixOxNw2/znxRMrc8KFVMQBOAxgCi5MlK17HBkROxdeqnNyWIv6Ox4evWjQQ/AUtfY2nrZovKH0F
	m5ed057gZh4G9EmVWHbJ4=
X-Received: by 2002:a05:6a20:6a0e:b0:3c3:812a:2198 with SMTP id adf61e73a8af0-3c6c7ba4081mr335947637.4.1785169978491;
        Mon, 27 Jul 2026 09:32:58 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc57ae17sm29786047eec.22.2026.07.27.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:32:57 -0700 (PDT)
Message-ID: <6a678839.824e11a6.2fe22.d796@mx.google.com>
Date: Mon, 27 Jul 2026 09:32:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6707711396967189971=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rahul.samana@oss.qualcomm.com
Subject: RE: Bluetooth: qca: enable QCC2072 on RB3 Gen 2 Industrial
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6707711396967189971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/pwrseq-pcie-m2.c:189
error: drivers/power/sequencing/pwrseq-pcie-m2.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6707711396967189971==--
