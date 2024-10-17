Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884531DAC9B
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152215; cv=none; b=Pg3vRG6pc9xnPHIdDR/Eg5xAOapMd7QfewI7zsrNbfImRXtkuQmmmZWHxEWjzORuqFPe57ZzgcK1IyuW0G7aU+jrOEdMm15bzDJQyJY4txmxQEhf9fFxuFZZwy6ZacR9BG7iqP3Ix/RuL3VPuiOJhghDYPBkqsenpmmNI4eZahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152215; c=relaxed/simple;
	bh=i+KaXQoxy9qJ4KRSPxEyKoum1/UcCV1Ta6bxo8S0UnU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z29YAvGuWxL+I/XTCHXoImxCnaAW5+3VfKnzegJVTbu5xYf/bOd+RHA5q14KZpuQ+NSk6QUxlE1yt63DM+Ny4yHoKcCDbxpq9BObeHoj8c99BYzcerYFURU7uzqWefmdWvI2mm6c+8SIHVlUqTB8WCqvJW/Z1+Q5sj6PIaKYcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsBGlwuV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsBGlwuV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4608564478bso7094791cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152212; x=1729757012; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zooXwQxCn1/Ma2x2/oPxoYAxFafX73CEkoy4rSLCpfk=;
        b=OsBGlwuV7tYkC0iV4LrSLu6VShEyO1WXCAtHGZzR75cg/1+iFJav0mH3qN+sK/m9zF
         h4bOSlgrWzDbExCuQkTjfdRENWDyaV7ShIy5JQrCG1OKbXwFnafm1iuq290dm2hdBauV
         /3Q/EWi1cKpAsnb45n9utcW43LFuKH1W3/vAGTJm7ViYBZKrGwdYozkAuqh5yst6ywyx
         A6VcxRf00491QYXFG01RdBpXgWprnm+uzBUD1p9QKdcG+zBlUEukxu1yyMr+7cE9YOUk
         MT1QJic9DW99NSP1Fm0JQcvxGFIR17XkYKMKjCzT2IbS7TJM19DQwEMfG8C1GhlD5ofX
         3WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152212; x=1729757012;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zooXwQxCn1/Ma2x2/oPxoYAxFafX73CEkoy4rSLCpfk=;
        b=LF6YYgTz6DcTOeIasTCl1moFu39tt2cTarCnUzOFbRPMy29gU4oOXF4liJqpBMHLBS
         MPljU1F2mme+/WMx2kf+2QEK6HU6VPE7JcYVXpGJkKxJ3McsuIHAlReEpo26hV0lHkRv
         rpy1955i/iUYQnO4g/NEzaDxptMktGxWR6Fpqq6fPORC/v+A6o0g/lWifHaQyosBfJsx
         0U5W9Z7VCT2TWbYatBz/OzX77mvA5QfumKVZ60gmFYFnu6wZZZThCaeKQWW5MfvjFRbu
         Y4JTEyqxU32eiMKt6HUYhKyNhKsihmm0ERxFT5a+LhkdAuRWemv7s+9Ls/pXfO5BS6zU
         LwfQ==
X-Gm-Message-State: AOJu0YzOu2uCVgDerVOGXJTUm/ZyCmgTBftm+zefL09DiVUa55gp7QRT
	3y0D5KP1Cx0FOChlaTGeas4mO6xgy5Xuy3xinY4yqp86GP7wSW3oDWQHbw==
X-Google-Smtp-Source: AGHT+IF1ll0XDyWpTcqT88N3KUuY0BGt8wr6dOikpV2HqsyqgRT4ul19nLTvLFtBPRXOodudIwumFQ==
X-Received: by 2002:ac8:578a:0:b0:458:2c22:e696 with SMTP id d75a77b69052e-460584c3a90mr296909301cf.56.1729152211872;
        Thu, 17 Oct 2024 01:03:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4609aca53bdsm7394371cf.54.2024.10.17.01.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:03:31 -0700 (PDT)
Message-ID: <6710c4d3.050a0220.47c85.307d@mx.google.com>
Date: Thu, 17 Oct 2024 01:03:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7874107862548044489=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Move size emit signal to plugins instead of obex.c
In-Reply-To: <20241017061331.2097436-1-quic_amisjain@quicinc.com>
References: <20241017061331.2097436-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7874107862548044489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=900075

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.62 seconds
BluezMake                     PASS      1607.82 seconds
MakeCheck                     PASS      12.84 seconds
MakeDistcheck                 PASS      179.74 seconds
CheckValgrind                 PASS      259.12 seconds
CheckSmatch                   PASS      386.74 seconds
bluezmakeextell               PASS      132.54 seconds
IncrementalBuild              PASS      2172.38 seconds
ScanBuild                     PASS      1212.41 seconds



---
Regards,
Linux Bluetooth


--===============7874107862548044489==--
