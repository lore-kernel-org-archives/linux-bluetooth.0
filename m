Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FC4A5C25
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602193; cv=none; b=hmdIPfZiP8tO8zDyKCHoBndOjKkrIaAuR+XebZB1ldGOmkqLYwkSkX6ia8KzC9Zyz1ixOpjtm0/eUdlT5htL9ob7vFX3SufYKnLtaoiA1dFiD/LNo0QzrF7744RmdBjHNumqRjlrosbeQ3pX0Yzv/e4Jd97s9zGy++9Y0bzxm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602193; c=relaxed/simple;
	bh=ME2d8sIvyVJEas2r7UU88DDs+giJ3/nHXR2Kj2bTQkE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ht9qJuKDJbWdyS7fOYspNE8/A8z5Yjjd1K6ge6HAeLFakdcVIQkcUGa6hO/s2+QT2SOxBLoYHMPtimjSY7ZLdALOC8DUW1iAbxI2GZNbNWAnh9OzB18StfUBejem0h2f8jV/RjwkFqBitNAMKsaNLmwwlFfjUzJleIqZbIyBnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGjojkLq; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGjojkLq"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9104e54b1abso2522736d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602191; x=1790206991; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lS1yw16PzgxXtKWL/Egx5FMHNI5WHtSD9AEyao+SwUg=;
        b=UGjojkLqS6qUOgBLTsfKNHlSAKhkNfVzyeiJMULDL8eJBHVrrnUprqkj7kcq/vaDJl
         HyVzHoyy5YjwP/nHbR50lJ/SLPsM4N3/2nSQxoqR6dEC4gfT110NaAiaPuMqkIKvp2D4
         l9+ykJOMHsGjU7Lu8czazUJqdF0CJh05/HbqBZUjpsDYr2r3btphbQlnCYtRw+hv54ps
         FIZ0ogw7waQ67uWxDkbu4BKjkiTX1epoWl06zIJtfb6zfzc9FGj1oNxoZ4E035/dGdXU
         97MprDzH2daRxE2AvaNsd7lcUy6NiOLaIJAzk+jZ41K4esHe5IPQL5Zeo6WaYW+Iaj1n
         +exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602191; x=1790206991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lS1yw16PzgxXtKWL/Egx5FMHNI5WHtSD9AEyao+SwUg=;
        b=doyLAq/P2TxYq/cmULK9+hcdTILZ1q8NNy80gtEcE+9LbQmtvW1es4J0kraK6jRdVc
         mZ0+cOZHA6M4JN206X+gIESSXslyC1URKg1GnpC1beiC5wBsMs85LI0DqFSrlU1AYnQX
         P8U+FD1Y/KLOdkghCbyz+TZJHrM2Ps5BqdO/wyNRo4+63llna6qrd8yobUQo/L+305Xe
         DF8vbZxbHRuqe16gTQKVqtYJPKHQoc0cy3DV8mdGCQZN2xq9zRJJ6bYuEQvsHoUnfYTg
         z7+oOSEZBruzJYdJ5brLAbMboB4dumzq05DPU/5p4wQoZltRyd9LsmGe26tKVGopAJaD
         28gw==
X-Gm-Message-State: AFuF++mvOG/pw0ZlSZtQ/oyf5VEHgQPhQZOyR3LtogZ11HdIpH3FiDCl
	qJOTFYXwiqEpr2tZCUhJdnIEBR2bLuAaJ95G3D65GghWeakSZcJEdqd3BfrxcA==
X-Gm-Gg: AYBFou3glHpw0ct8Oia5t/w7zvU0ey9OofopUO2xre7gXShE4eRGiTESbAk/4oyKlr3
	mhfbxD2LAk7wD9DGs5nE+VZnaouVogTv8TL9bc7Cv7mmjhsxJefY8zjaQDflxj5Nyz4q851Mmwu
	lFSYwWmqfOrBrFYJtmulemLPLRPr608OlIpJRdR0SFpNcwKAkj9Jf47sLMqdi6gvbe+x1WG2Ll4
	SHEf5MxefIgZ0SHFHNdQSPnk2GRR7t1AD3+ON+tMQHzQVelly2E401jd+0lzEMq2n/0FSpx0UCX
	ir9ve3aZ5IZ/VeTQBeeiHApPQfslTrTrpvaSjh0q1Ud+rzyEU/M/se/fDArrZ5B8CnhiHP80W7p
	MtFtWt1fIxsZDFVJV9fcQrvx0LBe3hMoHTwfW/pIn7yfXbGnjI+f4Dx1TGPhtEL60sAI/Y4pn85
	UQKBlkk3Y3zzJkg4baaYPXnDI9r22fBtrwvMwSRfufw1GQFq/ACPrvX/As33mOQ/T94LW5bNo7D
	+cl
X-Received: by 2002:a05:6214:406:b0:90c:4422:84d1 with SMTP id 6a1803df08f44-9123d7bf293mr83496926d6.30.1789602191430;
        Wed, 16 Sep 2026 16:43:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.60.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be946f0sm37029226d6.27.2026.09.16.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:43:10 -0700 (PDT)
Message-ID: <6aab298e.8cf43864.22624b.6e93@mx.google.com>
Date: Wed, 16 Sep 2026 16:43:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5096823433279539349=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3] tools/l2cap-tester: test closing sockets with ECRED defer
In-Reply-To: <eb21dbe69ad000c457f63d0de3caf2aa68dbebd8.1788296637.git.pav@iki.fi>
References: <eb21dbe69ad000c457f63d0de3caf2aa68dbebd8.1788296637.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5096823433279539349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v3] tools/l2cap-tester: test closing sockets with ECRED defer
   Pull Request: https://github.com/bluez/bluez/pull/2468
   Created:      2026-09-01 22:34:21+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5096823433279539349==--
