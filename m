Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC52AE78
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777138755; cv=none; b=hSUVAhlltny//oNzEf9PYRx2fazlNxDbGSdJL3nlCsKy8M7LqoxvT8gvKlBazNlq6scJnerO/T8+NCXIWh8hYAqZJLlRweWfM1OfymQTcPsRGk6o1sAwb3OiW49tCc91ZHSnhW8CcF+znkVYLBu8NM9ckdRWNQS5Iceq2PU9Yj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777138755; c=relaxed/simple;
	bh=qQUbXAm+JVlHnXuMutF6Ev6MjlHb0E9XcsbmRRQ9730=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HqK7rFLHjUyNOhXKxv4UhVHqQ+kopsG4heweg+d7DcXLKFA6fgNMIpxfK94ctfDqeumgt0KTFinBOFLG4xGAUToWHzL0vFPaktL9jqC693+PTkuzfEmXncqK5anESNXoUWf4rN4987uiUeZAfJ7tDNId0BtZMYwWQ6X+LQ436dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYOPi1Bq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYOPi1Bq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c15849aa2cso11832779eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777138753; x=1777743553; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qQUbXAm+JVlHnXuMutF6Ev6MjlHb0E9XcsbmRRQ9730=;
        b=sYOPi1BqFRYQ3rDwDntjzMxs+eGke9JG/TVZUmDZRJUf9qGtg0/Vdoj8yBcZOFvods
         xqmuOZgLMn3W3wZY6QGfTdzmAIooAuTFIrKHUYsV8Y6h0f4pvJhjEXEFARcYARtJkReW
         Il1SQo6iM+HGgE6UCWKpuUwDKd77EBGHajzMWYZkXGBQLGxw1Q1G/AY4u9YOM3ASYnkz
         nSMkpOSFE8eeX+2wPlgFlxZAhPrMhk2JzXTo0HHWfpb+fT6pCt47RRD1cUE+uUwiyAM0
         PE1QxOhOkhqcpJgMhg2h3ELxtrNsxFL6doPduyjiUswEGwwiy59PPQofon1EU0HyEzTs
         LVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777138753; x=1777743553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQUbXAm+JVlHnXuMutF6Ev6MjlHb0E9XcsbmRRQ9730=;
        b=ptbILEG5SnL1hI5d+sQ4p+C/EEp39o+B7Ph64NV+1QgPOoEvtgRpR2UMDdXOYs+Qou
         M4/nh4A/nzqNLkt/En+j8yjJ90GDzQMKfSWLvBv1z2Ijjc6yTs9Zc8nXyXsPS9wjCA1H
         FQioqow+EUhFlqoZkFet8BJHCHQk+CQpQqWXaV7BuhvoovDJOTlJLWqaw3u9qgp7gSII
         5iWfqZc85MOMafTtm+DvcLoD5IsxiZxQxLHoLmvlXD7QQR28puH/wlDmGgJ/SMnC7g+r
         V6EX4a7fqVrMZ0IytvAxBk/2gYcbkqQRZnKDWNOaqgRpkOA3y2vRElqMvNnpalgwMq+C
         YkMg==
X-Gm-Message-State: AOJu0YxNHykmjhGlGGfjDemgpEt7z8/bvEx6Z2T9YQBsz36K4ziifbjs
	ipNiqqHHb7StZQUKgoxr8pI6GzsW8XUAaPEeT2oBBUksLv359YnOfl5/2wJv4g==
X-Gm-Gg: AeBDieu815X5RtiQTHLjsj9nYbwBCx8cTf7MpfXWOtiaV29SiqAg/OEbvgqxDqkjtnv
	KDa6C4wDLupvZUaHJjl7hb5o5owT/fssTj58tRnBSjJWKGdjaFvE2Mxs7WJ3BXILhO9nujU9W+V
	YUhdZUB4EaSwmXiBPvN2q+wuIf8jN8LCvY5gvqkaVJ7D9Iaj5+RSkhJtvxypjuWY89GBotFbKDk
	3SaAXDCfLPOXfdLmswONOZh6mwPG1nTXe7y7Lf8U1C+idDKRgynOT/lHh3daTAFL+FZW+t1JjoN
	pqiqFkjFMocqwtikJu4+Tk1injASGLJF9U+dUwNAsfS6x84eeZ7QZanh1jIfg8UxqWd2QDYdw4G
	Ttv2pW4V6lCGpVfVpC+jhRSCJzwTGU46Ef4tgrVWrznstPAFcsOaMDDJWYoHCGsurI3NkqvCqVx
	7AV2uzT/wyIpwaPWnhIonm04qL5ZL4qxXdjRM6maQ=
X-Received: by 2002:a05:7300:6c27:b0:2cb:990a:b5e with SMTP id 5a478bee46e88-2e477c9bbacmr21969033eec.15.1777138752659;
        Sat, 25 Apr 2026 10:39:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.1.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm36967750eec.28.2026.04.25.10.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 10:39:12 -0700 (PDT)
Message-ID: <69ecfc40.050a0220.90519.cb19@mx.google.com>
Date: Sat, 25 Apr 2026 10:39:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2792737634801318661=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nils.helmig@web.de
Subject: RE: Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
In-Reply-To: <3eb4038c-9f2c-4d53-86d6-f3ccbb7b37db@web.de>
References: <3eb4038c-9f2c-4d53-86d6-f3ccbb7b37db@web.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2792737634801318661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 18
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2792737634801318661==--
