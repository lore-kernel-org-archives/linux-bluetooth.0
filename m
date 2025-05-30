Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93225228E
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 May 2025 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748635718; cv=none; b=W7ci2VRB2ap1TPcsP1NWZcE0KgpYybgXV3UIbGMMX2nFVBfLy4ZXAl0FeXaO+4PxASC44cHjRt/wyAhvwwjpYL5MpP/TG8ghT/AaHCtFHbTsl57hd04+8481jLoPnJX5kH8GKMTsUM/66cxXWjyN5g9dWj0UI79j24MgSX7CRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748635718; c=relaxed/simple;
	bh=BeK6LybIynt2xBQmoybcItdsaQgOmWlSfzZNAPZ+lwg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HD7Ya4T5WRhrGiLtMt5ERDmgVjb6Nns4aHqdPLtB4qntST0v4B6MsD6zTH3S7fz4K+1K8oP+9LhL2lXObZsKI2+P6m63ey6bioR0T5d5eMtDqKc/k/5519uhCro4p7zTml4PbiXr353bgdhItVqjvI2aX8o47og3QBk1tWpjr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9cDvCyj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9cDvCyj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43972dcd7so26496741cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 May 2025 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748635715; x=1749240515; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gG5xMYYBud8YIfoY5e3b+aWqyZkW1UQd7KQeZN+82kw=;
        b=i9cDvCyjTMTKJgSVGP9/cyvk/ec8V11c44s1TQfrjQOx8VwWDmjqowgXXG+fhz8cFR
         8pLdSMRPp9sI5NUryczmhZQLLtF5mJD4MVjL8+q7lVxpGVZuHdRVlpFziF6SQJHaTKPn
         Lg+b5zVY7xT1dyoa2A4pCLnQkoJ6lUVgMC32/cZDk3V1DC56CUGb9IGa6tIR6/HzwxI+
         S6D/Vy5yB870eJQZN02Dnd2Wci2P/CINFp2HIWFlwQoPuBZODTt6Pp+NhIQwDVzkg54g
         DdOxQ7YH3iwxVAJMspNofr4DQFgFcc2UInTJwxn7uEs9xstMp8fAjvzoDiMqSXqEy1ZO
         ioQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748635715; x=1749240515;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG5xMYYBud8YIfoY5e3b+aWqyZkW1UQd7KQeZN+82kw=;
        b=vRIWbrDGbFfl4l/x9BUoZcg0uXznPuZc4nUCvlHwnx3S6CIsYWzRsfx32xgvCkLe4E
         otP2B9ToC08LBgVK7ggqEhpk8oMyeMz04ESxN4gXw26o13tB7HDPaGk5zBFRVhC89yso
         ZMxlDXAf+M0BvOLw1nt8jvb34zz6GOIuRUubQWeOOF5G6lt+0kCEWlEIuQ0SmKRLAEI4
         wNFArhS6UAatah4cvk8PBQSQXakmbfMvinmJeKITWMiBRrr9MR1W1CKEzfrgDhXPqzGQ
         Aetkv+FVz9UQy4viKap81mkGPVV/iffFGMf/e7HQlS18vtNSFprPWlCavVtUS8byjPW0
         kTzw==
X-Gm-Message-State: AOJu0YxhRBjzAGVw3e1hz6ayp2zPhsP3jY0o4Yjyyr2HdcoTocf8auOg
	kBF1jz6i2BDnG1+OjOiEWW47K8SNocweyRsYoDvhI/3QEkBkZFC8DyFIYuyoiGmw
X-Gm-Gg: ASbGnculFcY7AWvq5tbtMF5BHFmKbGyMheLzEW6gzxkOQEi1bR0YBMz0exWPGvNOCI5
	yoMGpBp1bYoZsvVkLnDvu9Q5ckHuR/oeU+FrnETFJlu5zAeVt6fa2+OHHDYrMzM33CKWjrMfFjG
	wr/LQ2l3QNJZ1/eER8dE0t4WIZN3KxidXtS0M05qJfRXxiI5goeHU/x2LF8R9fWHEQDb8y7Vt1m
	tQely/+tr2xFN3N2cn3FQQCErGUHYoTtf682jLnnqPX5cdNhv8HphJh9EA2CQIp6898fUkMy40j
	VPzzWSgxhYO+jND5eHVn0BzWOCEPWvKtaXlDX0m4ThOCQRVUrtExSrfUfPM=
X-Google-Smtp-Source: AGHT+IFxc1BqKNPMAHhY1IdwV1VMKoKtjVp6DqOpNYtkvTMje7fGTUTkzPUg6bd8f/CdoU3bZXrlXA==
X-Received: by 2002:a05:622a:5883:b0:4a4:2fad:7cdd with SMTP id d75a77b69052e-4a440070658mr57067671cf.24.1748635714974;
        Fri, 30 May 2025 13:08:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.201.159])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a37204sm25159781cf.60.2025.05.30.13.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 13:08:34 -0700 (PDT)
Message-ID: <683a1042.050a0220.39afe5.a4fd@mx.google.com>
Date: Fri, 30 May 2025 13:08:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2287225733026248957=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Remove extra identation
In-Reply-To: <20250530184932.419785-1-luiz.dentz@gmail.com>
References: <20250530184932.419785-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2287225733026248957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967697

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      19.99 seconds
BluezMake                     PASS      2588.45 seconds
MakeCheck                     PASS      19.88 seconds
MakeDistcheck                 PASS      196.93 seconds
CheckValgrind                 PASS      270.70 seconds
CheckSmatch                   PASS      299.01 seconds
bluezmakeextell               PASS      126.83 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      890.33 seconds

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


--===============2287225733026248957==--
