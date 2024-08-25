Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7077119
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Aug 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724626152; cv=none; b=jLzFFoC5KaoQHx58SXFeMJleabJ8BZ9ckH2V1E3mjP6Y+ykQjR9Fg+rdzogh6UK4gCBph0lZRt99E5zb+nFsn5TrJvMqikctjg9siYxk3iie5YgWwcIwR+l6cI0rb+3BHluDegMgKIcok5XfjdjylzYBiX176inDr4dVtwqBIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724626152; c=relaxed/simple;
	bh=2seqXOWJhLGT64jmSLIYbGhcvMsK7XfCQVEU/7UvBCM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=D1hFb98FgDS5cFEvLgxVDKyFD1D83n9TutETlbGcKQFoldS+ovS01z/wQAEmGmt9nxAMvFa5PluAe92w0aAqoGTbTK+0C+P5d+wSivq+tCV9nDz3xBS4FW3gmXG69w/aQw3vHYt1kXvqAkTu6ZEClSgawHWsX8vPjaP1piIsYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myoUgcyq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myoUgcyq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202318c4f45so37424505ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Aug 2024 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724626149; x=1725230949; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2seqXOWJhLGT64jmSLIYbGhcvMsK7XfCQVEU/7UvBCM=;
        b=myoUgcyqb9QjZhuRNNG47aGCgpl5MjrB3/mwbtlxBWXtFkrRy81Jh0ZnxlaYkEhhqs
         riDOoxUTJWEwIrlEHeH37eX8/iHxvPg3z3Vk6VCrmv9xEmqKaIr1Orry2oo7icxXcEx7
         2c7cth5VcJBwSWpxtMl4hoJEw1X0c8ya5qZK7NGG8FFR8HdkNEipm0E7Cw+MtjKOUFjz
         ef52xNd/+ciJ/V9sVSRIkaMMsHvP9L/CbrwsLbUJtdxL+5+J37oEkusEQDha3T1VLsKB
         /f1t3Nc9psKCiQGqd5WIZ1oMTU6CZvi0Z/sKjsqHqofdEAbuky7cibVXETemNhTVDNVf
         XQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724626149; x=1725230949;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2seqXOWJhLGT64jmSLIYbGhcvMsK7XfCQVEU/7UvBCM=;
        b=Aaor/q0EWq1loaARvB5B60Ik04qztAi+8FqINDr+3QtfSRN1Z+VRNkjuGkwpco1Vzn
         G/nV9vzIv/rv/zv0q+SplPn4THmML7wT+oXlhK1/isQAbSdQ4VqAJG9WsaBX7Ik8lY4z
         IyiamX/hhVp+EZ+PFb5yMc3TURUGrtFTko68IUaze4AOHQw7WKytrN1GtMICWU778R6P
         ZXV5No0/WIN7zSJCQ7uHVu2dfGP0xgxOxz3v2afmySBKzXZKaVtBde+trIJZ2Cj/xFd/
         1rmJ5FglFnHNtmXPAtOJIXVPJ13W0IfL2N0efUo9Lw7VjLWTk1C3wW8E5gLpIt9/JnKT
         jtBg==
X-Gm-Message-State: AOJu0YwR07JQ910BxD9MVmxt9EYVehE35kkqZzFJOFS1uU4W+kTTRKMT
	6bRzEFyUz2zSsFGofhwy9D/kFUjjOZRB87GCoapse0+yjVmGbP5KqtoFmw==
X-Google-Smtp-Source: AGHT+IFgI3pVTIng8ijjF3ua2V7OlZLaBaSRgmovhWm4GwEJSkiYh8jg9kUYjrkEdjdWIymOs045Zg==
X-Received: by 2002:a17:903:22c7:b0:203:a030:d0a1 with SMTP id d9443c01a7336-203a030df42mr103290265ad.58.1724626148831;
        Sun, 25 Aug 2024 15:49:08 -0700 (PDT)
Received: from smtpclient.apple ([2607:fb90:b78b:4b1d:ac3c:cf08:e4d7:66b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855816a3sm58485125ad.81.2024.08.25.15.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 15:49:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Brian Gix <bggixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Applying Mesh Protocol 1.1 specification
Date: Sun, 25 Aug 2024 15:48:57 -0700
Message-Id: <9886C58A-8D81-4C0B-AB56-356D3CA875B8@gmail.com>
References: <66c70155.170a0220.2e0a01.d9c0@mx.google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <66c70155.170a0220.2e0a01.d9c0@mx.google.com>
To: Junho Lee <tot0roprog@gmail.com>
X-Mailer: iPhone Mail (21G93)



On Aug 22, 2024, at 2:14=E2=80=AFAM, Junho Lee <tot0roprog@gmail.com> wrote:=

>=20
> =EF=BB=BFHi,
> I found that the bluetooth-mesh part has not applied SIG Mesh Protocol
> 1.1 specification yet. I would like to update various changes to the
> specification, such as SAR transmitter/receiver state.

Nobody has the job currently of maintaining bluetooth-meshd specifically. I s=
till keep an eye on patch submissions to the mesh daemon and tools, so if yo=
u would like to implement the v1.1 changes, I would be happy to be an extra s=
et of eyes.

>=20
> For example, in the line corresponding to the link below, I don't
> understand why it sends a segmented message for a multicast address a
> fixed number of times, 4 times. This is causing performance issues with
> my product.
> https://github.com/bluez/bluez/blob/master/mesh/net.c#L3335
>=20
> Most of the mesh/net.c code was last written 4 or 6 years ago and is out
> of date with Mesh Protocol 1.1. Is there a reason for not applying Mesh
> Protocol 1.1 or is anyone working on?
>=20
> Regards,
> Junho Lee
>=20
