Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C964A21
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253499; cv=none; b=t8F92VqRh973LlEIySLNpgb6caBo3R/Xp2tr7BNL6YcBEAlLE2/T7o6ZsHpe1FxyOGAqD2yWD9bPOz2MSmlBwld4zyqkgqAW9yfj46GWxHmkNzAZkDS2ahw6RrogiGdP7CAyOOhoWEGX++ZiWtGY3JvxCcJWjXKbFo4SmLOTWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253499; c=relaxed/simple;
	bh=FtfhF2Obk/P52Jf1rz15EYg1GdcZlLwsO3z6T2rK++I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BYb+3yYg7EiZ029qG92yVht/+GdHTiBZT11hiC6HCSPWiVRhfqiAM3Zufhhr6ZDJElvqTUQV8PUYxI1nhztQ1oiASCSGg5QNcPSA4Dbs8fnFylZQEipQ8+K6y4BPzjGL+VRzKoxfTem438flfub/RTTtHACo7Zc+ncFGXnPJano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la/imG/a; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la/imG/a"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b1e54aefc5so13804985a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762253497; x=1762858297; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QsQZHffKC5zmoyA7xOzz2UPgSV77omFil0XmGnbIZCs=;
        b=la/imG/aXXeDnpP0T9B6Q27L7llPVAdnO5PKEvG7RnM+x9qckfengt1DBbShrOoIr7
         E8Pb0/aG03rY/8uUSeDYFaxI+ttcsgHNuYYdejmt1qnCGxVosqMG7HvT47hDNGtS43Tt
         aHg0BDCs2nyNKFH5LZLbA0mYlYMW0iibkpj9Stal2ImIlZL7DO5MEtGmVEJe+NxBPxuA
         o6nM67601/XNDOJqG1HmeJC+NsxTxJBmQ7OEey/aHbN66ZHCEQbwubNyA8eLj72oFGlo
         SFO7dLSt74xly9Oz4QOV3UvXEJRMvk6q6xhE7euvb3CHo2unXV6a+bHCiNNREHhDSKzd
         ERnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253497; x=1762858297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsQZHffKC5zmoyA7xOzz2UPgSV77omFil0XmGnbIZCs=;
        b=REJ8XJgaTbNQ2HbcFeTmuh8h/LrfNBmpL1HEslTYr2s39TRxNLDeP7rsLd7p+cCqMZ
         5MLIPDigFLWb/I8AL8IV/xDAlJRRdDMCIrvRtBMXEJRSyTdAIyyxV/ca4YLCZNE6sNmY
         O8jew+BTemAaLkR8OpTz4SWisHZBDy6/3+QcMbO6Lkq9pbxY2ESDDa/iXvRFEq4LIC/i
         aur+NzeeoL5pd5YMN2do7Pudg5lq1pa9vq9ASN+ZjTnQTZjcr+FqSP6ZRBCTRCNKaNSS
         mE3yl3r1aIbbsHJcO61vWqrNEgH1rHaCuJeH/E8tvQoVSgpKlobW+itllLqwGRKmqesi
         uS3g==
X-Gm-Message-State: AOJu0YyZjW+cBEE0m78Aw9518J9qJp5Dr7eenonXcQnTxq1xQBTHQPao
	cOfsaUrY3BTkUJPfY5BSsfJJviffZi5Z2E6yRwrQO3rPfZnPMrv2WJs1q4XsoaGt
X-Gm-Gg: ASbGncsY0a/VUpu2KZhtBZAW8GrqiPVuHD3Pw8/x0SqgH2uQ6RxW/7cIctGCNjvtINq
	Hij7CED/jh5/7vXGer3dK5JddLMElkn3Wt5wWsXFuujlpIUjeFsCTniiJxblBwHTsZrvU/3wQTb
	J3N8DZEucfyH0ZfHY1EHJ1zEVLpbK0AOFZABAzFcItoGpNfqwq9BahcpVNNTps5Due/Yp8xHoGU
	GZNI1/jch0q7j7JqQAimr4weqvwjRofY0Lgf8zyZ6YejR1RjjKHDOXggErvY2yp2TtL3SsSWNFM
	K8Tj6EsI20eE3oouAmBTLH2r4WDaY3GgJfXeOopfFrtnHUELmi1FsN0/c2vS30pOspNEywEh8nN
	NnV33gOGrCVCWUnFd4wLlf3Aj091ozkoAH3+uu8DeuOZeTRacFxEcv4VW7vrhAjb/yDRahwKqZ4
	bjHiwSk20=
X-Google-Smtp-Source: AGHT+IHF0bLr5Z2g98Ks9nAxrp+XQoQBotY7OVFCU4Ys8R1amffjs9aLfm+r9biJSJ4Eqal1tQG2VQ==
X-Received: by 2002:a05:622a:1a87:b0:4ec:fc4d:3737 with SMTP id d75a77b69052e-4ed31073ef7mr179372391cf.72.1762253496745;
        Tue, 04 Nov 2025 02:51:36 -0800 (PST)
Received: from [172.17.0.2] ([172.203.38.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbe2c2fsm13635381cf.21.2025.11.04.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:51:36 -0800 (PST)
Message-ID: <6909dab8.c80a0220.293da5.4061@mx.google.com>
Date: Tue, 04 Nov 2025 02:51:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0967572616154772738=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/3] shared/hfp: Add extended response code enabling command
In-Reply-To: <20251104092808.128726-1-frederic.danis@collabora.com>
References: <20251104092808.128726-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0967572616154772738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019334

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2690.71 seconds
MakeCheck                     PASS      20.39 seconds
MakeDistcheck                 PASS      190.55 seconds
CheckValgrind                 PASS      239.37 seconds
CheckSmatch                   PASS      314.89 seconds
bluezmakeextell               PASS      132.16 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      950.76 seconds

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


--===============0967572616154772738==--
