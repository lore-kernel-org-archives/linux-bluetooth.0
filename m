Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795314434;
	b=tL/0XjXraVp9ebvPGawpxN0RLgswviCMtUKCrilUPrUqfzqTlcsLdl7O5bgf6nZ5iQQn
	 fWw/FMPODTMP4Kyb8etCoNWf7Zx5IEisWM01MxBlMhPGwMtVIFhjLWmOYF+k1fGtNQA/X
	 B9qxt4n7qPUVfsrTDjxM50LXpWsJtfBwQV95clibkrcx6eoOdibEKSxsDoP66YZbdG4RV
	 9C/oZPGjchhq1MmoQ6SPHVoW4YErgfA8NmfhluO0ZdwrJT+YC49YK2lOLUP/FTNYHLVgR
	 NyK1wUpjvxFR5T4MsV9pcXXLogviOuQjaqjZWJqGtNbC63Uekoakr5LpR9XCtXSmIOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795314434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=DJ3CfKAQk8J6kAFNYbnlNaBCv3KFTpxBNZke4nV+xwE=;
	b=KTaq3bw73qs5VaZmcLWb9dOzfqlwYAgO3qC4rs2es3e+tnnaU1M/JyyMXl4mRdaUbvBS
	 CEhVvSvW3rzT+AJdOmTJ4I1UYIUOmiV2HTkrcSsDfQVAJNWct5HSPeN++O59eYEq6764y
	 MaP4doFj+ZpZl9YSZuhlWuPkSGImf4gnZfIi2h9ZQQS+bEq559vWqKLgjxVAIAUe2UzgA
	 SjQwtRsp8F0GVdl/Ocxoko6wBZ8u1cUim6LVZ62fysdI83L/7Tj8guKClO6B7C5jJnWWN
	 PY9UYNjTOBLTwiq4qazLYrfAnEEhsj7V+9rbAY91SAVnFm7r/OYOF1qOazsb4X88eWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSdCtjaj;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E619606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E619606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSdCtjaj
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-94960131b30so225294185a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 18:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795314433; x=1795919233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DJ3CfKAQk8J6kAFNYbnlNaBCv3KFTpxBNZke4nV+xwE=;
        b=hSdCtjajxb5lWFU2uWD/wuQMDMVMN6XJFjjK9XkQKKD5QmLLR3XBpvqP8QqpkXArnr
         OQfzZ3RV9/I8RAWYyxjoKYhAR23MN5B/zumfOfS2hIWEV2Pew4W1gDLU0hZgF0Mqx9Sg
         aEPtiEDKm0PAilKQ1mFHW6SIP5S0Y4P85aXt1r6v9dbwDdPbWAVB4aVlJgwJfmvdLkAk
         qgbAQXGq+3xqjKDK19kUZACCUMmu4wtI8XDPvx5Gulh+/RiLvGpYAz7EodhaW+YIv6d9
         O7cCWgfU4VsjSd5x6t8LC87UjLuWICClVli0Q2ueTcylGDCfnmwPlLK2KIDv3PmTGbnG
         ToTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795314433; x=1795919233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DJ3CfKAQk8J6kAFNYbnlNaBCv3KFTpxBNZke4nV+xwE=;
        b=P+OlG9Pqxd3V05pSbw8QTmWJy6+BIJm6h0XrEEECdls9B5MjGU2/RV2Wdxa0AJ2nyb
         dI2DBI9nKVpMAsCibNDEHFWq3O4CM89CIY706I7T6nQeTxoVHPXviwsTF0pM/zOaHKom
         CCq0xj7d+m4TbU2j1TBP/exFR38zJPLui+IfX7bs83o+72F+csfqlJ0RQEba/PurAlem
         2GH+AkuHpwMRj9DEBG7ozv4uXd5CtYceHKbnFUldIQ6Hge9D+RW14mlij63WrbUUUVzT
         imxnugshYJPADUJT+KNILIRNSH55w60Df4E/lwvuN1sgB3I4Rnez0AmJyAZdf3NRXm+O
         Zgpw==
X-Gm-Message-State: APuU4Z+mU4DH9irEgtvkpUSsX+CcUvT7WpXaeazoMUWBHVGOF4sozTpK
	+rsihKNQyMdTnJXwZxRojZHc7zmcFuLMdoMmK4ZuY2BRQOg5fAudP/qugPFIKg==
X-Gm-Gg: AZFdTZfJpRmbtpOfSq3Xtcgb28aTLQDVxRCQLSmUsvTm2I98WWJgdL5Ut03L0sQhk6j
	mbnYXJhS7fkme0kj+86EkiLSK5cYnkE1t5xSxePUwzfINyf95tcqbE4MTrsSaZ1tMLBp8faK486
	WUAI+RNWZi4NLl8UA13v3RciG8vhmh5XtFXQiOAof4rrdSheUvfiEtBU7u+Ke3V0qnkf7gyubMb
	rN6mZyaNxfltsBAztiJwVx2/sAlUqDscF2cutvLye2OBtvkjUXGT1LpyiTUOe0ZEyMyWHzmKIO6
	eWHKH7xP1MhJScS26VUj46RtroBuzNcrKtqBoG8ZeikAzsL4YMhkaobizBLzBopIi34xVSL4fKg
	EnF2zDYLzPDN5mz/+Whld0nwnmSiomAIcvfgmWtTYip2jozWRoZuH4cwx4dpeZ/QBOF7ZzuePtC
	2WfESP0sxi7ICQQUzIS5CYVUF56fuLjBDUr4ppuSrX7edMPB5fqjgurE4I22IZkzkF8ASYadZKz
	3uqigUnMptj3Qoilmp8hAyV9etnOcuoKeRVIbi0MN5nau6Y7mgHQ0XJGqK7ww==
X-Received: by 2002:a05:620a:2901:b0:949:7473:b1ab with SMTP id af79cd13be357-949ba95df99mr1262181885a.17.1795314433339;
        Sat, 21 Nov 2026 18:27:13 -0800 (PST)
Received: from [172.17.0.2] ([48.217.36.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f1ee7sm517921085a.28.2026.11.21.18.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:27:12 -0800 (PST)
Message-ID: <6b025300.3cec8c74.22cea2.2295@mx.google.com>
Date: Sat, 21 Nov 2026 18:27:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1681766276369869016=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v3] asha: Notify connection interval changes
In-Reply-To: <20261106235122.719665-1-cochcoder@proton.me>
References: <20261106235122.719665-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1681766276369869016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC,v3] asha: Notify connection interval changes
   Pull Request: https://github.com/bluez/bluez/pull/2773
   Created:      2026-11-07 01:53:25+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1681766276369869016==--
