Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C37577E24
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062139; cv=none; b=g1lGWSSHGGcbdWV0P58twBPKDAQkFLUkVGPgejRrgSsgDlTawolEM3O/7oO4+ziUM8oypwsEbqRem1KBeJFebjPazPaPrLBFLJMxUGUECJ1Lnhfeo97Fm/h4HutfjGggnigBcWIMK9+xc5yzSRj+u88U6UbNhB6dn4E3GOonVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062139; c=relaxed/simple;
	bh=YhkZo/yqxCnf8xJzxWIqN6wmw18LNNhPXnJVy4gx+A8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jrtaUgjqqxE+825iOPUp0OEPjA8kidd282THit1cLeotBaIUtuuC1jVzCFF1vt15cENcRdnCJilxfgyc42Bmgxw424Rq9Uvmdj9kVXRcwVfLCsTVPcxCp2snC6eUdWziWwWhxuTsOFFWj8vw3cZlKDe3xc4nGHk7v8Q8tatarNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYaCmRXX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYaCmRXX"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8557c3f270eso5030824b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062133; x=1789666933; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hai1D0R2Ru/nl9n9jd7kwzzHSXEpFr8RFnwSNcBaMjo=;
        b=IYaCmRXXboIm5/lBxNBgoXJ+fiz6IEYA0f3vq1nwJh0IgoK6YTGuahaO/rnaXXT5cu
         41Yov/K9WOMmN4M0GC2DnrYxpJSWFjbjU3R1ivREp8GV6zqzXPmxa9/Dr5+1nuth/I4H
         BPiyVN3h9mr9/G+WZEvYieyLiwvHOtVoc/fSItTg53slUvR7HADb4OXdEdSxW6TBK44K
         Tizg7jy+EpMahgr3ES87meWIGtB9sAUXN05JvIWWZLXGSQFnspNRvH6RCICPezVbgZVg
         +zCNBa5BUe4B3vygDpUHz6k0QV62cVwKn12/gAa/i6nwNLADCmX0w9UjVFsbU1Ta3edQ
         wvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062133; x=1789666933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hai1D0R2Ru/nl9n9jd7kwzzHSXEpFr8RFnwSNcBaMjo=;
        b=n9Fe8AVtnRLTYrBqboNNvF85bmQHObN4VTF0QxMip7UGaG6HmdxAM+LT4O/M2TUgqS
         CGmwsprqrcensmZ2j4VSirJNTvUzjqSrhFkCehuaj62xPXzOoq25UtNwgwubCul/p++b
         KFvAjcZv6mI6b2mvGq6Hb5fZGE3tQklJgMS+6PECbVCl5GZIxnJ4WcrOT3ycC3fkZzq/
         4OXrCSnV3maVFjf+wf0HxEhpPgzlATRMvVS2TXCytej9vwukYyWZ/UNF4K4O+Zipjv5T
         KWEJeu/9GGz6KskYcCUxrvM6FSyhONH0mRikXZEY8tRWgDZMR0vrSe+EkiWWylCCawu6
         Uvgw==
X-Gm-Message-State: AFuF++k9bLkzy5rqrxOTBozNGUFdBdJYrFiGk33Zvlx9rrRiyRSNnXy+
	3IOuttvQPJ275LIlD95/T5GE9+RPi/9vhARsJBV4jYNbTHS85jj0q90kKeguGw==
X-Gm-Gg: AYBFou1WEDcHXKmXjzvJ1fCjGyKWrbWf3VvN8lzqx1xRFU5OpxczcsACI+S4KXH2s8w
	q96Z3LaVbjLI9RhqbkBoBDZl3OFynB6yZBapkcw/EujD++V+6jwJMnN8EnjqQArkXnlsr8P3SoZ
	rgcIhs7gKwvl0TXU585eLtTkQn0fafvrz2I32pNxllOp4L3X9tBmzP0/qVoR7Cpb48UyXNm+rSg
	+cIPSvl2hq+eyBeZ+pxYO5CGR41rxr9/XmI3GK1bnr3qXzTdP1cNX6gXlKGKmrhy4rlI9cM2kQf
	D+hhvuFhoRpcKxTQipig2Ccozt2ljYVtRI95nq8W1+YhrcxA9LG1tj9oiAJhjOZ+whsKqqH0nJg
	QX67zYGgYHdluZV7Z74I7zKiPESKaTPnuBj2XNdOm+UehG3bC4am0GwwXYygkR3E7RNp2bcLLKb
	Yf1iIyXzZ8rvpLd0LEkpsPIboy7l+jnC9xOzKilmso8Q2r7VBIqUKKDjcGrVS1e+QciKn7fIFmx
	28HQg==
X-Received: by 2002:a05:6a20:db90:b0:3d3:ad3c:49a9 with SMTP id adf61e73a8af0-3da3a1c8619mr72192610637.23.1789062133003;
        Thu, 10 Sep 2026 10:42:13 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534152sm52156284eec.10.2026.09.10.10.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:42:12 -0700 (PDT)
Message-ID: <6aa2ebf4.21256627.15b4b3.a9b5@mx.google.com>
Date: Thu, 10 Sep 2026 10:42:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5336194616156765454=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de
Subject: RE: [BlueZ] obexd: Reference count the phonebook back-end setup and teardown
In-Reply-To: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
References: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5336194616156765454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] obexd: Reference count the phonebook back-end setup and teardown
   Pull Request: https://github.com/bluez/bluez/pull/2409
   Created:      2026-08-17 16:20:45+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5336194616156765454==--
