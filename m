Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366332;
	b=Rso86rY7YJekE2A7/dOQHZHWMPLIS91wif6YM906Zx/NJmEoOu+cL1D3IGVQewNtF9MC
	 6kXFglQnkRnI2PONSsuBOIRIArFilG057HaCCEo1P0+Fo8P6L0khwW+4HSYIVXRqtxbKO
	 P/YJDlFg/oQzRaFMgCY4U7/nUB02k9IeQw8jtu9PBEVj/Vkga8uELmq3nKTsdv7gSN3zT
	 lKMDjL3aUYP9VGFKl4iKgwJGsNF3ZVtqKzxEadKe3Xwtm3KtSvqlGWOS7UP1FOI1j79dc
	 tQqzMHHH3fSf0db1YYT03t9GU/cd0UoklqbOv1Wsu+xrFrUk7ekqLMXUduxi+q9Bb1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YHcjNw5f2TDBjRmrNYidHtl4wac8rZ07i9YdIWANvXY=;
	b=c6tVxoqvsrf7mIWMrKQwXjnIgZHs/ToxHqgqEYXkBtDgN0Jucv1fwvmAmDaU+ek0aGnC
	 xECV3oaZQP6Sb96vUen9Qy40vI9/fXDp8oPV05++cDVB1pZCEvx3rBq7FJizzXwqfanzf
	 OzzeVOyraDV8y/ZAUPQiWSIc/7d0ltlb0igvF+lN8zI4vkCVY94l5NC55swnx4QA4QrKT
	 Lh1P0BNE6AU0fJl/coJhDBB6y67u2+3zJWQ4rcjRAdG28hjcbr6gXlp1pRugnnKg1nDLS
	 X1LnTpVtU+TUdeXT9+ILE3+CDOpveIzNrxXR62eLyOytmmlj8kF2SW7tMdGxUesGH3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tR4WlLAO;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3013606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 03:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3013606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tR4WlLAO
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso254825eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 19:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366331; x=1794971131; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YHcjNw5f2TDBjRmrNYidHtl4wac8rZ07i9YdIWANvXY=;
        b=tR4WlLAOBK/yQNUTd0YXH/Bl/5gMrbpv+X63q55mZJA2GzdeUWX9LAQHXwneMyumnb
         4ttMjXhZ4fYrkU12DtQoGEl/vIOSzPSI9yu6YnQxj6oHYKaawIEWiAzBtvxOvYlQfRjo
         cQZi2VJvNsLVZ2c7cJ3YiHYZbxee/7vAMKoGxF7ee/K5rOZhEH7I+go5YK4ZVngR/GYi
         Uxbt0lWT4BuvDf5Dght6L5z4WO0mh3NLpTmQ0lwfNGP0cZTWh6vqQYVD7X1Wnbai6/75
         mhz8E0CWYpfgwwt09HhiqrCHSFu0LADZFui7cyBcaeZRktSWMaWkoGdAzSQ3/Rc7B/Kf
         ydbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366331; x=1794971131;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YHcjNw5f2TDBjRmrNYidHtl4wac8rZ07i9YdIWANvXY=;
        b=k2CL31yHJBIhtvPnYQaz1Zo69n+Vz4/mpazya/wVq+f7R3DdaJ9kjBMaJa4vgDZnvu
         8R9CTNrqc8Yl2hleLAMCStVUVaYu+IPDvk0uKoFvHCtsBMOvJvKkW4DuPqFymo1pdgu0
         nEplgA8BSD0Q6zvHHr/wQbsE0DTQs9BwLUaVqGeYf/M5apWuV/s6KY2t03toddhcve/R
         rRNWwwVvBrfYQMmjOl0LrAetMZcq9pHiewXD4uBTxxOWQRqnN2VVAZ8nGYO6nGUDX7iV
         NhCA+R1DnPZz0rdYKmhDM7MzhLnUsInfwmv+HNtmhS+8QrCMOQkBTrBxMc6V3+XWaORT
         czSg==
X-Gm-Message-State: APuU4Z98B7igHWzgwOkn+JJd2wokwyop6D6gMO9i3aqqf7ChmGJr8Vlk
	rmkIYx3jn95MH47OOjrVl3290cojxsHvQo9fOnwWwoQIDfE0rWh3s4w8u65ZCA==
X-Gm-Gg: AYBFou1evCRRahyWo8W963XCeXSwsHijIHBLjMhmqnQ3/lvhGe50Cn647sAauqXwurT
	IRvHzPPG9EeVENwyX/SzcaEcu2QIQjXsLvA1RshyPyULhd9nUt7GRu9o3Do9x84nTcyuZQJbjG+
	KOlA/02fb/ZvwYHl2jxC961zVm04Eh82a4EukTkheG8yn7NTQgciWWHEaw5dzHvSze8JZyjj1ex
	kolMUepUX1iLbB4cKqTW2LN6sP20l1uQ7RV3b4XIuE9Xbkl29rvjSsNMnSsmbi9k9iBMSjJr22r
	cflk4e6HILVTUrmKojBfAw4+DZh2m0gecd8Z9HZ+NPRezAb6kYI8zXutONH6aZ0FL6xr9OdJ529
	5ot3dDhcCAo4nyFAmrM+QqQa0LxpkbYqgmi17+pT1v/ahyPbFyHef7ucZq9CHSt9Kfb13D5hgS7
	dd5Zuk2q+EL9qgK8fEBp2oOaaRStlx8fNSiHpflWiWnL9N5h2DoH/8FbDaEYXef8VdhqY66zODP
	6MD7npRbipCZ7qBpMrQXmLNbNG6RhhZJO/TUGpq7fwA8FJ2O3zaP7ececv5LHQ=
X-Received: by 2002:a05:7300:7316:b0:372:b76a:6fba with SMTP id 5a478bee46e88-37686278be4mr2574463eec.14.1794366330813;
        Tue, 10 Nov 2026 19:05:30 -0800 (PST)
Received: from [172.17.0.2] ([52.190.140.96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm11185077eec.5.2026.11.10.19.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:05:30 -0800 (PST)
Message-ID: <6af3db7a.eb646aef.1eacb.aff0@mx.google.com>
Date: Tue, 10 Nov 2026 19:05:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0226982570616301227=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
In-Reply-To: <2b39b535cdf993b8e363d96ed66e58f07d7a42ed.1794349049.git.luiz.von.dentz@intel.com>
References: <2b39b535cdf993b8e363d96ed66e58f07d7a42ed.1794349049.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0226982570616301227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: unit/test-bap.c:4952
error: unit/test-bap.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0226982570616301227==--
