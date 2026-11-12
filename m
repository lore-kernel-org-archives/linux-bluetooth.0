Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443791;
	b=M2comPx7vwSv61V7qHjPo4nX/XI32BTPguZlS+47XR6dwa1XH7/V+nrLPsqj8GCvsQom
	 pSpyPILEl7Vief+uQ/y1IO/FFUMn9I7VloCZ6FFPnX2ycD4krj3tnvFn1v+JBD/nrdaQb
	 kvNFDfm267lk9doLsqPnNseQ/iC5gC6FQF1mskaBWfmuNtspLAz6+YsAzK7QZos460d1r
	 n9W/MHLt+V2J8nITwVptyZ+Iilz/mcGfGiz4MNz6c3SICDh5SvV8laPzV8P+vcuwEEINp
	 knJRZ2oyXnkKeYUKpo9tkLhgivI5rVW5vTfQ9MJybZN+1Qu8SabDe63E/VflkPwnqWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7zJ63X0jgkjz6as+J2MrRdrQpwLSM7QMAxC0I6uqVtY=;
	b=KufM7kNcnYVYVDMgPZFxUlF8ipE6r77fnngPM6xHuuvc/5cRugB/9tIer6mnfcMOE1CL
	 gVZEbAes/Q9Y5IiFb6iFYUNA3JSOM83Z63X8VWN29fV1NNr1tEiGrSLi0AuLWC1sOkHxl
	 R4IXIC16IMD0YhGJWYtFjUFPP8dSeuF4fqpjaP6QshPjaWAIxEw3c353BOF8aSqo5zSG/
	 9DwSAnC0ZebGQY1pnhCQDX2M/Een1WgwhsW2fepAPynBiukGISqhOqNPyLrE7QD1nSGC9
	 Z6x1Q7Q2DGEIFC2VyH+FFM9KUcEt+DTq9kF0HfBeQp0AYhwUp4fq2cMskSoRg4V+Hfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUkgeQVq;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DC606A330
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C42DC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUkgeQVq
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso2478020a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443790; x=1795048590; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7zJ63X0jgkjz6as+J2MrRdrQpwLSM7QMAxC0I6uqVtY=;
        b=PUkgeQVqjxYCNg3AYeFwNC1+2JZMnJIvS7Gt7rKaPSTlNyDST65sCPT3BPpIJPI4/2
         pYewP8kcSlsa+YnUxsLbmLJ2HqYu7APjt8rgRQx2huVN1EvX2cIkSQNNqHTkmx5IOrNc
         ZUS0k+ho/dG6nxUgAuYobnz9Dh4bkWBQKZi47MmZZEHZx5UQOTcCSBBVodZRchwcEmW+
         PrMMVVLH0VTPf/nmU810gIlOnGQCL8KjpEjTZq0KtK+oasEaosuMHxlHmK2uRJs5sk2y
         64YO3gR+6tyHTuhZMetiftgSKJIhR7SitM9kNyPV2N93j1BTDp07PIFmmy3jBvgl8a7o
         oJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443790; x=1795048590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7zJ63X0jgkjz6as+J2MrRdrQpwLSM7QMAxC0I6uqVtY=;
        b=2HFywLYnDuHOcEKClmhtU39eDAj8/Zm4PIGY1Dg7x0nAEcGq1WZK4m4La+wRIgtkcw
         e3v4DwQLhgnmljc1lygjR8DD01SVgEPgVYxl0y33dv2c3RIa5QTCWfHPQb6Y1n2onUW2
         yuEDbGqP9uYIY54mt3wr8FAnRhIRAQ0WoPrUAvHVDRz6KwBKe2wyiNy0o9Tw1PPqkTng
         5rY1ekR91d8pwJqQns50vRumKm9YHrXHXqeEJYfZ6ggHt8xcjgMf/3jKByd2G2WzskSL
         tGQhfBMj+RzboC3fVjKiM81MSu+bpK9/iK34i8wAdLhqxl8ndgdd2OSiVkder3XOh6xV
         jnSg==
X-Gm-Message-State: APuU4Z/gcPyo0E+O5xzWRgMqsaHTrdp9rD0oe6H9rTBvhbrzP1mNOROw
	5MelyESza6yNFlAnsJUtGHAxIVqSnOgADGS+1Fd54tLoY5ci6V8JZuV2qB+Slw==
X-Gm-Gg: AYBFou2zw/b+QWrahOyMqQYSDMphKUl+o2f+wSNHglW+ewHCriAp5emp4+w7pJvfL/w
	T9JhcujGef4v0HHYz6frLlMG/oSq5BZtisSxaaZvcYGb94jBuvEXD0ItVLws6G0MCPa62UYrKiT
	BgRi4sbWYnWlWi3aKTbxthhwK0hw0SqgDwTvsR32SLansmRzWK+efW7/1AdZoxpUvhhK3Xo6k1S
	DvbGy5GVhNU/5lmnpxGQX1YTyansL4wivZ61gfAHq9Ug1SkN70A9Q7AJPcgrau4fFI30ohzO01H
	39KOWiJEAWEwYLP8vVLipNBROrkztgKeN1wiQTd9r1X9OdtREdWL0oQ54dudQv4dCAV6m+M6SNt
	OblDhLxsXuIB4zuhdCiJutkNeDhvq6IePwzvVMhSfII1BNwQY3I4agEmuFqgvZf6/wefInFjOXy
	lDEt2wDhC+kaRio9HiVriM1KptRplGswkVw07H0H+rgMM5wMU1pKtReyldsz8WuoyvazFCmViLX
	8anK7vthz5OBv0MF2arZKjvZbJ0Bxdo21S4ERbvqTUt7IpKQZJnsJXfqvV58R4=
X-Received: by 2002:a17:90a:c2ce:b0:3ac:a139:1b14 with SMTP id 98e67ed59e1d1-3b182f5a137mr4220753a91.57.1794443789987;
        Wed, 11 Nov 2026 16:36:29 -0800 (PST)
Received: from [172.17.0.2] ([20.64.175.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182e0ecd3sm2563855a91.3.2026.11.11.16.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:36:29 -0800 (PST)
Message-ID: <6af50a0d.43eef3f8.13a187.ade7@mx.google.com>
Date: Wed, 11 Nov 2026 16:36:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0295851618972773129=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: adapter: Fix Discovering staying true when stopping fails
In-Reply-To: <20261027171923.82919-2-kevin@simpleble.org>
References: <20261027171923.82919-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0295851618972773129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       adapter: Fix Discovering staying true when stopping fails
   Pull Request: https://github.com/bluez/bluez/pull/2725
   Created:      2026-10-27 19:32:31+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0295851618972773129==--
