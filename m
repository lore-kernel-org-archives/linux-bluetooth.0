Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D84204090
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680767; cv=none; b=Qql+oKXSir8OvePVQ26VZL9XpBo97E+i1deTatkmUvx3EWuYmwR6k5F3MeNWLHwH+qMznvmy4erdQGxfo7+YHDlmE7lRJLzaiom0WjZrYnKW+noLyBAbzX1+zvn6vCp3L/p13KxhC/G5UP01KkXt2TsIi2boX3RYaLg7QU1GqR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680767; c=relaxed/simple;
	bh=8FmIo9lAgPZa5Vv/J5LrL5KoVwigs5HCQivCbmncgBo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SBz7TKLdrmPr1WQEWCF3oAYNpHb/mCqArMocKQ15NC6zh6wSbRR14FHnF7vt3bLbaQ6ef9LmBHJLjl7gHm5edUrmn0ZxNX3Bat7KHdWPIc5npzhNfTaXbqfrD7+c5okULEhUU3SxTEtH3hfK7YzBXJvst9KlH4uACazt5arDE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj2biKvA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj2biKvA"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso73840b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680765; x=1753285565; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8FmIo9lAgPZa5Vv/J5LrL5KoVwigs5HCQivCbmncgBo=;
        b=Pj2biKvAEU2m4Pe6SWwl1EY/G9kWi/gLOo9QmDlWkdQZJXgSeKvCrsJXbR0iV8PAeh
         /kkdcgdz8ibykz9uTpDbRpN7cKhZoFkEhyrYiTvWxDL5YxKRHq4bb1DxFlBDdwPU/hTC
         deJoBY8z5yuJrnTBUVTwXYw0YI7cJGtTt4oLPIvGFeZx8zGB3C4UD2cpCY0azrCzAIHL
         jzp3nmINLJtwOTDhLlplRVsjCF2WMVPsFHF27ig7WknQZLJ4Yn87wrNaMF2/3zk+2it4
         z0pSMnKfAP0c7TEHBlbVx3rnOqTAbk1wbjG3LqTb9N/dDqX6IfjopmqbNCz8gf4sZNwx
         ZtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680765; x=1753285565;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FmIo9lAgPZa5Vv/J5LrL5KoVwigs5HCQivCbmncgBo=;
        b=p9cFTHjBCh/Tqmk72h78f6meoF2yYavyBffiMgUZqhGTStiA8iqLobjF10m5PNVDwW
         zy8WIglyoFPfqirhyfgnRfZwJeqGc386HyhpQJIZmLoJcgBoxmtMYzl2P4ndbQ2msez3
         zMs8iPAWhzjSYNsT58RT3ociiFsLT2dENlc35vwEo1eRrDmPvmJOZneHUYmm05zcwMY/
         UR8vhM/BAYqApflCtnqJH71z3ifZ4gwXz8Cv3UDL9/7YMzcIECJeNk4UsI8W18ZHYw1Q
         q+/p3T3uMVG80WekBf0KrIxc7aw0hTfGdKmZoWOEgh6CVXURfL7wrbwZrxaQF+9HhmDp
         5XiQ==
X-Gm-Message-State: AOJu0YxlB95s0gsI4H/x7kGYbARxkuAuycPODlHtdVhQrI88DIxQiCsw
	RbqlUoa8Q4lawTauh01pANUaSIqVu2yWK6m+n5+LsVzALWSI5xzxGjVxgwl/Sg==
X-Gm-Gg: ASbGncvYHWR/Ua04uZnvDBH7IOq5w+ddMyrcZLDnRxrdsesL4z4fggWpKJkdBtApkMw
	IH8v+zVhXIU9eUd4FVNoJpZeGnWjMM/VHlLiADkEqEdV7XvZG4146zXBYFzBLLNpSBavAXLA0U5
	LrbqCDHlMMsGlhcKoek/T9NQd1Dj67MTSAdjaUAFEYvrCqbPYC/PLdxSayCCojUGbrl3tSaXsuS
	qafhuq7unQJI3LE6oT4VXxN3eA6QjM8pYxY/pH68Su4KZE8PeA92OrabxHqnApmhlOhKUdU/yDU
	/ymyP9OI3uePYqQ7OQbTySouTDGwgNvCJxxEf9L3VwR0bqNtMsOPw3la5uaiRo2SpzsRw2adswP
	UPmZQOxfVGVitrzgqi2ZxvmTsa48KUw==
X-Google-Smtp-Source: AGHT+IHIF2o5lXkL9MkngDz5sKCc45WSJ8I7MejCPI4aGWfWn6ucLZqeOjrQKpFbQ8QzJZJKm9t1Bg==
X-Received: by 2002:a05:6a21:4a8c:b0:1f5:769a:a4c2 with SMTP id adf61e73a8af0-23812c48bd9mr5204277637.22.1752680765411;
        Wed, 16 Jul 2025 08:46:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.182.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f56a9sm13759908a12.59.2025.07.16.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:46:04 -0700 (PDT)
Message-ID: <6877c93c.630a0220.2a28de.2b4a@mx.google.com>
Date: Wed, 16 Jul 2025 08:46:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2252737138645973602=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [RESEND,v3] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
In-Reply-To: <56318d97-88a4-6688-9f43-4eca4b8169c2@salutedevices.com>
References: <56318d97-88a4-6688-9f43-4eca4b8169c2@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2252737138645973602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:29
error: include/net/bluetooth/hci_core.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2252737138645973602==--
