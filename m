Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F434389B
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213091; cv=none; b=PEerEKenrzf01PhxJM79/auj+qFd85WJk1By9bljekaZj2sT1EHR1Pmw7/bQ7mgSZHEV3h3QByoFHEtIfTVL+nlzBKHrSdfa9FQiFFJTKafgh/wH47nCmReYbstXuCeQIjZu11NhQEd4iKDFCOqkaCu8nTyp1WusVT/eyETJDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213091; c=relaxed/simple;
	bh=N1g/F75pKew+MEGs6ZDFR7hq0ICS92l9ABLoZkcCXEA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aXFUhsua1lgI4o9jyFplevOx0shJRTyG5zZWJ/eaZ+ZSSNvqCmPMM42+KWuyqt6XjnFQufrmtumRN/QLi2B54H5g3aQa4d/A9Edlg2tWT8TLFGu2/aYQpDrLaowdmUDGzyFRbBwENSgyZWBMo1MUErYsWCeBC/mVHYNs8O3i3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPpEpC7p; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPpEpC7p"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90caad2e944so415206285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779213084; x=1779817884; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pVi0qBLZITnP7sz7YAl34pKuLun55wu0banMpipfwzI=;
        b=EPpEpC7ppOroV8DCfM6zGsqOyyChi3Mf8KEVjM1yg2b1JiMcUpLmjlXlgNs9+/itm1
         ABfPOa8T2QiOrDa5+XzJBrWU5iyZy1HTd7Ifw4Ch4SsLgoGRnh8z4GvbYa+WtWNOJE3B
         dFQuvL1lsqu4QxjY5/B6ZRDI6SmCv6RuOSvjUDEehO5tAFSo0MzgxdsnF7l6gXnFLUMp
         zwqqeLfzAvKyWqLiFSjvsPxQGMLm6pLcNRy0wOnBTAuj1/YDfOJ4uASoZqe4UotKlFvE
         4VIlyBSJq1yfCfDBs7ZARZfU8QdUZoWjaF90xbYIxUKXFjtsnUg2uEP5JZty7IhPlruC
         JkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779213084; x=1779817884;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVi0qBLZITnP7sz7YAl34pKuLun55wu0banMpipfwzI=;
        b=AnRokkpcvuJKx3VJI7YKhraa8veRuRRD394fP7+zUEGw4kOuflOICaRC99J6uMeaTJ
         WfX29VbIm3rDTrgeS53lDIrdaqiYJZuyiPYCXV8lCdodBfNiZyFaiy0r08cNxXCY33zf
         zCiGl+qalcLbi7NcdOW6hx7QTLTA5OWt7AT0ZuW4ALeUhvI7r4NsH+zHTqlhyBSECtI+
         3yCSuP1dt55M2k46cGsL9Wnvmq06TMByR52US2hL+CcnnovDvI6tT+F/k3A9AnTtzrhm
         /Aa+SN/+hMVcC/SziApijMKsc041Slsv37VB88HEhG1+0nnW2FVNfUq/tECxo9wnkExb
         3aSg==
X-Gm-Message-State: AOJu0YyukEFQcc+d0n54KJPHky4D2UELLMAVpSN+ikDplODypMyoBO7F
	1DVirBGOnBTJU7jlXxzdfZXgiEstv+qD0e3y5K3lJiCuj9T6TDHOS73iuGucIw==
X-Gm-Gg: Acq92OFFR95OZimF6B6HGpQkTcwpEzJzSG+3Q5rT/+5B4yQp6aV+ZXSQ8FCXE2yGkXd
	+eIx0wulNp0izLyekEutdUBJoA4YJd3llVJNJJLifNOSBxq31H9tE56iXK2hJiOlqnWud6RTflg
	J257ObwxPdltJkkrSXcPiphewQPxJ+n8rjtJ0is9SfZ/6YtQ/XNiVyCMHoE7SgGDvr5xqpUVjsp
	jvf/cwEygaRyzjmVqndXck4DJwJldunL7HAxnca28nB4r5UaeluJPDstU17me5tDOsbitZcU9W2
	RYilDJABcTy+ZS1TW+cFhPVaYI/fEbJcryTrjOPoqRZgdRzq7MmLF99yHnIo6yHKr0ZC3GmZmqv
	Vkpi+v7n7Pn6qR3A5ujkinLlUW1ZM1UJJhJY5DEj7XX7O/3xOCVkbwujgvgyf9toPaQJ1YZ656j
	5ykBouscE59khx3FOm69C3jKfMKl8rJmU=
X-Received: by 2002:a05:620a:4451:b0:8cd:7952:d449 with SMTP id af79cd13be357-911ce71c47bmr3121285385a.29.1779213084460;
        Tue, 19 May 2026 10:51:24 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36d137sm1882224185a.1.2026.05.19.10.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:51:23 -0700 (PDT)
Message-ID: <6a0ca31b.d078fdf9.14a3eb.184c@mx.google.com>
Date: Tue, 19 May 2026 10:51:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2063047761558776834=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel@phwe.de
Subject: RE: [RFC] Bluetooth: btusb: wait for rx_work before freeing data on disconnect
In-Reply-To: <20260519154431.13471-1-kernel@phwe.de>
References: <20260519154431.13471-1-kernel@phwe.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2063047761558776834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097482

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.52 seconds
CheckAllWarning               PASS      27.59 seconds
CheckSparse                   PASS      26.62 seconds
BuildKernel32                 PASS      24.53 seconds
TestRunnerSetup               PASS      529.44 seconds
IncrementalBuild              PASS      24.21 seconds



https://github.com/bluez/bluetooth-next/pull/217

---
Regards,
Linux Bluetooth


--===============2063047761558776834==--
