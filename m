Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1A3859DC
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517557; cv=none; b=WVpWoYi5aGKaEb2RRajJDeX/PXElrHdd70yZaYBlhNpE48po5xtxHTLhZeLfShrEMiXQw+0m4j6DPFr12X1ixd+WuzxvrQHUnWCcZPxKwmfFZRR1xJDhxqZcaWHcuYzAhm0RPYx+IDQk1+Mp5Oh7uhr1i3wDs+xJ4LQaIPI93ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517557; c=relaxed/simple;
	bh=X2ZaTlYzje7kFjFYZcetg02E7VIX90PXMGCFwdvd56I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rypnDdY5JKdGYyc+ZsPxZzdrB/cbZDLbjm8kdSVqIbFavedkNjapY62t4Gw42n2yv0FxvK2FDdOXFWaV+jStt9KpNQ/ZCkV9qli4KkbPkH3wfF0I6CHl0t59M+Q/HRL+AoRgXeGRoxmkYlyQIdzGBC4hRS68VDkXBhb9W15CqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=J2xZft/G; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="J2xZft/G"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso7670821eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791517548; x=1792122348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2ZaTlYzje7kFjFYZcetg02E7VIX90PXMGCFwdvd56I=;
        b=J2xZft/GfA+Wg59CCjHmeWxxaLCdZiW1jmHlu9i9PGpGucBO4xDdNHdUja9rU7qE9/
         OFM3lJ2dNkAAX7bkHnTFshKZACqGC6NgeiU8+gyGyTUkpOKXhdKQWKh0bj7WzDE4blJJ
         uv8i+odMrLbFp97SjKA2zRyICaW+cLCoySLgVzn/S73Ota8bZS1nlSbQKjFNMDFtqq2/
         bXdKa84GQCz/0CYCgWyWbBdy3FCTH9xcYHwqUrLinCd62NGS3XUWdHt+ffuv6QR83jq7
         E6qVo8+kgCsg1zav+A+NY4O02l8H3pO6LilRUCXDtzr8QgiQrOU1IL6PxyYjUFevMuIl
         JsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791517548; x=1792122348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X2ZaTlYzje7kFjFYZcetg02E7VIX90PXMGCFwdvd56I=;
        b=HVvLqWkI8kYdSh1h41gvM9NbtDumntfxhJD8qQiVJD545g4exnn7p85xA6GORhjV77
         NxF0OUguxFCL5MGEccJRvtIj8y89dbS4xRXXMfuJfgEc31HqubwrsCoht7I/OaqgDmT6
         0Ez6wMgBs/R8JFEQX/6lb6eLpSWsX32clLC61Qdq4D9ViAYRe1oHqbNshXg1iTt1uSA4
         HNUXgE0/anu70NfeWWeeEKTOwgEKYMxQHiZm34VnH8maYqfivezzbkd9/Y4zHCIvsj42
         IDpwDco7YN+xV6NWPkArBBdQJF+YL8kkgfckIhsGGYWQJ3iBUAoZ2SzGnh+LxVgcmfNB
         R5xA==
X-Gm-Message-State: AFq9FYI9JNk0D7j6943fU7s6RO2Km0sx25xE4VP5bA2j0NS2/WGE18LF
	/LL/r8Hf+VVIwPtzw2TQ9pa5NjD/imAStFRLMu7YPhrCsM7q/KZHSiPfthVrRrMJQdk=
X-Gm-Gg: AYBFou1tkcw5OZQCbhiHSSczlmhePZTDb0eQrlPIxJBd8NSgFYUhr2ITOqdBRLBSxLp
	iy+ouW7L8nHYSlilV9ZT3/Ad77tQLAeDbIOP/2OlTFtBxDrKwEAQZaxU+XNPYYgIPZAMDQSXbe+
	3SwpQREv8faNXG9FaLY0eO+X2ZZlos3jOids40/m45+rVgUDNUjLMgi6ophdXpkk6LhNCcgTZct
	cxUsQuMwmNIIb58uTwAFHQK0vfQV5Cq/dffVjEpCv/B7oawkRjsEoi87LjCHdtLQJE4jBWRDbL+
	CGXtzaYSm2dgjm0bY0TNSJSrbk3G34aSdHCk+xY5Xp45kF+R/SWTh05uvm7M7e9M1OkuuC+L/fS
	7H1S5/1K2W6bL21tMX7w/Iv0DJAn26FHOLezxq4HDXVxxYtbilaCCjyz8jqeJ4oojzx3GLD6HoV
	Tm50MszPRNFrBSUOduZ8yHv7+M1gC/THAAK0r8TfYVPWFLY1P6UwdQHxAVv3drF7vrIOrUDvaEP
	Pq3Rz4FovRV82zY3EC8Xsgd/u5guz8xNnjik+aAzS3Sx8zNklPs8MrfH8glhWVcXSplj91UVtg3
	S6GL5w7PSGTJf5viI4H/TJwvZo6q4sNnnw+15EgH
X-Received: by 2002:a05:693c:20c6:20b0:352:4ede:e6fb with SMTP id 5a478bee46e88-3537e0426e9mr986631eec.37.1791517547901;
        Thu, 08 Oct 2026 20:45:47 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm2968649eec.3.2026.10.08.20.45.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 20:45:47 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 0/3] Add Role property to org.bluez.Bearer.LE1
Date: Thu,  8 Oct 2026 20:45:43 -0700
Message-ID: <20261009034543.54898-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBYNZLS93hEBfkomBjisijsJWucuxJjz0oCsHsxJ9Cw=DDBww@mail.gmail.com>
References: <CABBYNZLS93hEBfkomBjisijsJWucuxJjz0oCsHsxJ9Cw=DDBww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

On Thu, Oct 8, 2026, Luiz Augusto von Dentz wrote:
> Good question. Perhaps we should consider marking them stable, but
> first we need to implement test automation using test-functional to
> ensure they are truly stable.
>
> For this type of testing we can use the test-functional framework
> nowadays, so we just have to create a few tests to validate our
> expectations. Prototyping something like doc/functional-bearer.rst for
> testing the interfaces.

I can write those: a test/functional/test_bearer.py with a matching
doc/functional-bearer.rst, covering Connect and Disconnect, Connected
and the Disconnected signal, Paired and Bonded on both bearers,
Connectable, and Role.

Would you like them added to this series as a v3, or sent separately so
this one can go in as it is?

Kevin
