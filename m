Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A004400
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528695; cv=none; b=OWjMIaeQOcHXf0lkHd0auJwwXbjbTGqUDQEHmSXbIXe86WnLWLbsgDC7bZgDXXAbXNByIk+vDQqwFWjE3u862BjfI3ybfKPQDBZrVfS55oLcgZpwSgpf+BHADUJrsK4Xa78xDhcdasnRHwqC1UhlZxvEX2TmgnKamVlmLo/oXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528695; c=relaxed/simple;
	bh=enPKWSFBdH//frvWvnC9NeusjTVRT2yEC80gw6X0XRU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AoK4EmvxYAvEQcSulGDr9IwxiUFfAyPT8mVlCN1RTp7bW/qe27UMrjFmPGUYwtN+R89jaPus8t9r3cCJN8cZZkHy+D8Se+bMBNFzYJC8L//3tANPzqpkIR0fp6MFZowvTmFdGh7Pqv3RE/D0PvXvEjsBS16cKbaoABNSjUe7DDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNWQcan4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNWQcan4"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43a14bce92dso41004601cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 18:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714528693; x=1715133493; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=enPKWSFBdH//frvWvnC9NeusjTVRT2yEC80gw6X0XRU=;
        b=PNWQcan4LTRwllyh1bLPhLTvNtbSVSUGnpmGmkKX08I9gMQ9L4uCnC0U12h9G2tGmG
         byTzFbEFk3BmA6amrPT+3tp5JHJ1fLcyZ9pZrKFV8O8GS/Ep5C/51UR4piPCfuz/NTTP
         eqjDDKCVM/gXFVQgvEPauHP6wjg87USHJxVEMKY7GYayjm++x5o3il0E5bisnoxs4mlP
         ziXo4sU5MPe5MDkFS2JCXW7OxPW+TP8OUTypJiqFkaMmD+QJDGxOmNOFXMwOThufsvS1
         Jvp7WQ7H28kAUCY6dnzGuarDD/YQtsKCa/CygMtVUo5vdq7n5s737boYpxlp3kVFTk0d
         IOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714528693; x=1715133493;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enPKWSFBdH//frvWvnC9NeusjTVRT2yEC80gw6X0XRU=;
        b=dVbOSR+whT7ThWC1kNdcj2ADWLyr4nPUwLv20dSpfVFR7AExgVI48renFmOyXYuqQw
         6brvF35nqqT4uzC+bYWQzeX3SZQ6MALxpjVZ9hY6wxiIWlXLnwQA1aAwOglye1kdqAqT
         NECFKj5Q6LOd0UyPrkgItJLxvR0V5wtXWAldEIJys/JPHpAvXMipEnh3cM09fMlugLoo
         AolVs9dhegdp1dlyeJ9OOk+mpUn5clj9RK3Px0pMGKOYfivDPoPS3/zBDhjjp1Gm5KPL
         hg0F6ocZFSD8o6shSqLYbOieM5AdaqLxc4ySsHMgtYscPzPKQ2223HFN1I3rEtixdijo
         ipOQ==
X-Gm-Message-State: AOJu0YzfKnPdFXKn6XWsUbltAcY5SrskMOcP5s5x5kjKYS3B2j/pplv3
	z0dMUvGhrKucl3RkUjkxpBuSOXU1WGDl0nrNHaFutx9lgQGKl6W7UgjmGA==
X-Google-Smtp-Source: AGHT+IEF6Z2b+bcleXgj/7Ipmo84RVZpLL/5JPtLknCcKvpkNpVDfLVxnOmcH5nqrXcp+hocYKtsqg==
X-Received: by 2002:a05:622a:284:b0:43a:e2c7:bf71 with SMTP id z4-20020a05622a028400b0043ae2c7bf71mr1330514qtw.52.1714528692874;
        Tue, 30 Apr 2024 18:58:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.98])
        by smtp.gmail.com with ESMTPSA id hg17-20020a05622a611100b0043ae2fd5a7esm2431898qtb.23.2024.04.30.18.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 18:58:12 -0700 (PDT)
Message-ID: <6631a1b4.050a0220.73505.120f@mx.google.com>
Date: Tue, 30 Apr 2024 18:58:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1507880324878424180=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v4] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
In-Reply-To: <20240501014335.2329860-1-iam@sung-woo.kim>
References: <20240501014335.2329860-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1507880324878424180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:2768
error: net/bluetooth/hci_core.c: patch does not apply
error: patch failed: net/bluetooth/msft.c:769
error: net/bluetooth/msft.c: patch does not apply
error: patch failed: net/bluetooth/msft.h:14
error: net/bluetooth/msft.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1507880324878424180==--
