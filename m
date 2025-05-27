Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1311F582A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338323; cv=none; b=oN7GC0D9TMkUC2sMq34K9ahcfp6tQQSwpMS4i4ktfRIGeiZwG5bPuL8NCZH5Wzixlg6Z/Pq4qS5lV4V/5GFGbmT9Qe+92jfsZ/RcSkKYFfRdrql4HjsQu3Vjj/WI/QNxCdJ2/FkjkMsobhIxLwROjxVMEW4qfPsB0evevUH4RqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338323; c=relaxed/simple;
	bh=DyN5mbaCk5UZHfNtBYvgil/iOrmoX6a54ETZDHZqosU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AdJ5okxGZwooZfY8dXiXO9AUwVDIYqv/bhiI5PGcWxaglOuNDDIU8Rw2hNqYQNZotyF0GfRB/Aq25fmto5y3+8+y5HfUMgx7JKRy6IXlC1ya6hA+D91OnlU8ffS0Ly3uFiinEit81pWqbaioic3yWfr+lzlXz12bGVdnzf3SUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDQhTTcH; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDQhTTcH"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0ad74483fso27724536d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748338320; x=1748943120; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fzUfmc5mRQzpUfiCDLUeqRNRsPr2neYrVyriJILtjiQ=;
        b=BDQhTTcHKTKLmcAWngOc30UhJXz+GvdlRoPWvgHk4c9ycUDwebFbBcQEaGpN8YAAjT
         GOn0//QX0TrqAIhwvWSD2bC6XpO4pDJsaDgKIjfEFoWHZCFTbQLcw/Rjp1q3gUULtdH2
         fjHZ9pcq2mF/OrthE9XM5Kl1CIfiPcAunSxLIh++5S2dz/7VNUs1DuVPX9Y4FAUoJABx
         8vlciuCLVLAqiKRkk5jnEN4ugOvynVxN0ce1TDMChjkIIVT852S91HQit+T7Z1bNlJQy
         1NVqZ9TxEVxTXLZnx1UHILtGeaeS4SmxUuVyEyQ/wmzDbvt6t3XVNnBjFLN3WmIgmYdg
         foZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748338320; x=1748943120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzUfmc5mRQzpUfiCDLUeqRNRsPr2neYrVyriJILtjiQ=;
        b=KuYqfLBOhnvu8LWPiAIEIhUCD58EdYCFSNhl3iM+HjipllKaiZXnXWZ5BuGc9IMZeO
         F6jFWnRlydlLpKgLJ6Xh1txwiyYEKD56QzFQwsfo5UjcHD3AEpzy4gVBgEoRzI0ydLew
         60Rta60W836n4l7LwzBZuhBGGPiOG2KOQgbMpnu39xMyfOR4MxVsy39MxJ4vunV7WwM9
         S6L1TKwY7vpBa9osqPwnWzcqnU6soscI0rcdiURp08twELN4y2SboWWvfSu5qRDBX1Ev
         sI3NC8CrxncEUtfKLDW58r2bny4nSp2Sm6hALcuuh83G2WVM+YmuQ0fJIwH+wy7fqIFU
         N0AQ==
X-Gm-Message-State: AOJu0YwXsPOlBtHcImDXPmYVbNHJX3sDDpW1sUE5nGEaZMq4enjKOKre
	T1/cmbWjr65DwQuhQwbyjUqCz6NEt4wd0uLwBUfocEQrpFyAfZTU+gDKckmEA719
X-Gm-Gg: ASbGncvYloYBCz7Z6z2yHLzZ9iSjwlOaqHluQhgtqf9U1JsGoTkQkFg+nFFP8HAAMOl
	n+51zrCemsTN1qkYPLRYNO7hkSyolyi5ByRNPIhgj87orexFKtJKIj6YAblVWLh6o5p0868KeNb
	llN62SjtWzgDH9Ieq32kpvhemYic6ZlAbSKIZOku5YD7LFsPK8aiGHfiSXmdR49LG+5Bion/HYf
	Q0r4UdjsIFJJ1P82FbQZe2dcjMzpf0bWmTgFo7R/TM75ItLemtazKMOZywn+YHfUmfNjmmPxSAz
	qVkmXd776YNTBZSBk1GTmpVL/SfueawqCO2Y7IHHIrA8j/4WCm6kBJ9OIQ+oNXrwazA=
X-Google-Smtp-Source: AGHT+IFv67y6BMFw10/Oyc27fDXVXsUl5UBqvbKscn5+HmXCVFaPQEoMWd5ybKSJEmPZO23hPfJYzQ==
X-Received: by 2002:ad4:4ea6:0:b0:6d8:a8e1:b57b with SMTP id 6a1803df08f44-6fa9d296bb2mr228669836d6.36.1748338320558;
        Tue, 27 May 2025 02:32:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.64.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6faa75185b1sm30853566d6.16.2025.05.27.02.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 02:32:00 -0700 (PDT)
Message-ID: <68358690.050a0220.294dc.8cdb@mx.google.com>
Date: Tue, 27 May 2025 02:32:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3999288579603978596=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez,v2] shared/gatt-db: Add read offset to record the progress of att read blob request
In-Reply-To: <20250527-att-read-blob-rsp-err-v2-1-23c7f749e8d8@amlogic.com>
References: <20250527-att-read-blob-rsp-err-v2-1-23c7f749e8d8@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3999288579603978596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966581

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.28 seconds
BluezMake                     PASS      2579.39 seconds
MakeCheck                     PASS      20.27 seconds
MakeDistcheck                 PASS      198.02 seconds
CheckValgrind                 PASS      275.29 seconds
CheckSmatch                   PASS      300.30 seconds
bluezmakeextell               PASS      128.35 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      903.27 seconds

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


--===============3999288579603978596==--
