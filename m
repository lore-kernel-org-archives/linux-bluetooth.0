Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC630C360
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623809; cv=none; b=ZkMidadOUlHHNTqWpyOgvpUyq7vifE0rnNwYgWtIVPBtWPDKo0pn9KdqXc9FL+kxtRY4hMK/8ypTs84wWNdTWuNcAwCEtn0z5t+Zkv9V2/lVq7gJ3Grj6MdlyLSnBtLxCgQ6OgQqs+U3Ojp4SM9e90nKtJmqvuCaGws9AO1021s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623809; c=relaxed/simple;
	bh=GtPJY3yyoWgRWuWEvWWoy2sZJYXQbsSsxMGnFnO/8u0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jtngnedbNI67iidXO0vlvSSJ7NN5VyCB/2+yF7HpeW9SVFpv8XZoOSp7y19bizTQoZEyr7TgfC+OATAwPB1eP5wJKIWarMrbI64BjMBdl+cSq3cRueG7l62zsF1OFCLAg53TRZlw/oPCi+Afe1Jhta/hOuh5x+1/PtYJ+3mAbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nza/tTYr; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nza/tTYr"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bc871ecdfso13535eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623807; x=1782228607; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GtPJY3yyoWgRWuWEvWWoy2sZJYXQbsSsxMGnFnO/8u0=;
        b=Nza/tTYr7yS8ourWTH+9Y1aRGKYSGDxQ9p08Nqf5oYpWV0fv4LCHn3zvmgmP213wVb
         VoisTjYOQYbd0Le9Q98pjMDn7hKssUVOB/r66fw3XrtGqOJVDGKqRnTG5T2jHeIPjjCg
         ZnOjt/94c59Z10ATLbwTtfBv+ZM5vA4DRD6I5QywIxCmMdaM9lED9sAhkV7MzArISrLV
         ulRVWDB5NCnR3kPMiSm2o7Ab2EONBxe5vN1ZQ64nVqzlCMP27IYGtaOYsyPsfkEyr7cu
         I23W1DWki8w36smRfG+l3PgLpm98S8e2s94s4N4cRCqlCSIBgGZPYC6U6rNAv0aaAFtv
         aGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623807; x=1782228607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtPJY3yyoWgRWuWEvWWoy2sZJYXQbsSsxMGnFnO/8u0=;
        b=nc4jEIG2PQXveaZD+YlwOnCPT9tDMR+IWiAtz2iB6MmSOhqE0+qlZHaTuz87jfTVOx
         l67CrkCm9LSfeGYfEGeD09WkRelHy7RncBgy5/oxzi/BfcBHlRb6TIAIAdW04epRJKt4
         Cq79AGxCpb0Bi/3nG8tayw/457kTUHCup9kzbXu7CHWBVmLgAUon7ja+yHmFY+BZdH/L
         tAWdlMayiEjODrbFhawT6N/TJ8PKY4XNVp2eA6nX2WRutKteLj48sAv/Mjm+bOi1RKz2
         v1a+nRocZ0wGIcl4IfjS/gJwR6PwB2OK8YIEBXh735MCHlDH8YSGjPeTYw3hLVTW7cod
         xekw==
X-Gm-Message-State: AOJu0YzvPM4mYrlWJ/6YC/YDm8DV77IKXgBOCsuGmh6KQQ3ib19IeqgL
	PP5nNtb7sTMLXk5BWxTDckGqdYg+Oy1tEaqbNrGXQBtCdWRDqqJaUP6wM53ejQ==
X-Gm-Gg: Acq92OGsVBtu6zgl9j9Xow96doyU5tgnS6dr8rS2rBr+1LZMRF6ASwzPKE4+PZf8tto
	cs8CRahyrx023y5uZolDT2ufSfeHcd2efu3xneUArFnfpQng6h9n9Q4y39jxVVabm3BOQUogDAG
	2v/mdv64tgd7T5AWxKUfjUrcu0H2pntAfbU/ey8mRfLb7BAHCr0dJMqnVWI2ToHgfKquFqHjMjB
	4qYtAWc7krArMeteTrqrXDv9eL7tbZXXko6IPnPGvtH1ilaV47m+5xaiTyAhAwIV917DvO2bCDY
	eFBd6biKvalja4CjebV/z+dKPEcm1hpDrrcAyUzBOmUNTivSDsNO96skieMAk9+r+fFuAvpeZjs
	GQ+MK68rSXFLZJ/jSnuDJxAGqOCGW5xCzBYbYyUAe3JCuxPld5/d0+kK9XXfClfBeYmokHux88A
	tJWe0oZrcuqmtTGBXmCwxysC3BJCvDMrU=
X-Received: by 2002:a05:7301:5f81:b0:304:bf07:f19e with SMTP id 5a478bee46e88-30ba5f72ee9mr2366580eec.28.1781623806856;
        Tue, 16 Jun 2026 08:30:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.218.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5fefecsm19390543eec.13.2026.06.16.08.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:30:06 -0700 (PDT)
Message-ID: <6a316bfe.d7da0740.24009f.c155@mx.google.com>
Date: Tue, 16 Jun 2026 08:30:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8702690346909826721=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, senozhatsky@chromium.org
Subject: RE: Bluetooth: btmtksdio: teardown fixes
In-Reply-To: <20260616111224.152140-2-senozhatsky@chromium.org>
References: <20260616111224.152140-2-senozhatsky@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8702690346909826721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtksdio.c:620
error: drivers/bluetooth/btmtksdio.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8702690346909826721==--
