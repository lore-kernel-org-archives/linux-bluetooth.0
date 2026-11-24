Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.78.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512021;
	b=a/A6XuuFlvzpS+cwMigQLi1XUKnE4SpQmkC5oEAHV9KoztHZ6bzfHLcX5GiOf81k7DoR
	 GzUsp6bw5SUwK1X9K/s0r0uLbXvAxCsodmewbsv4r76UibPtFEMsegdWs41JyoGNob9eH
	 7SHQxGLCoTQ9a4YENOEPgWe68srYPQ9LwVmP2mKVpk9t4rrcT/2dizkHJzPayyLjQp6v4
	 IygFp1UU1zzHmB70SAaTcpCCkxivUi6nE8Dp43lgZNwLS01rlD/aPAVWSzfceXgJZyJAS
	 rufnvHrlsxj2/BJHVXQml2qXNmJO1+scUn7NUQaW58uNgZRVxBRppk6qO1RfHcOOKEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:Subject:
	 In-Reply-To:References;
	bh=ZeaTjX3IolJnMt89jRgwGpklIuwIdApUfNDGy3K8IGU=;
	b=VNYvstQyRlq+UIR0BDr7tmmK8Veg1UMLEUe0aWCnqluGcP7V77eFLNsY7UipeQpM/LMr
	 sXll2Db36ZEtTN3w2rTJj2Ru8wiz4MoLMA3lASZ9YZgyQf13g25p/wGffDoNv3l+nzElj
	 E4+cc0HWifeLcmRCBO6miWO5HKHnnnpyp64FDUBPyG8TpFMrePFjh9/eHxfUd4kMrUqM0
	 DfJTDRQgU0TpOEoGJ1VtcQXN/QK6DfS3qqp5zqLvCMN1r3+suGMMW705izILTmeCGWDJ8
	 JN9L4RFSUKvO1Rf0U/+KkRw8trQNwOFb09mtCIrr5FuNCI+Eg5hkY5Hcs7Q8a+DTUuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=EOngkENx;
	arc=none smtp.remote-ip=77.75.78.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE4606A683;
	Tue, 24 Nov 2026 09:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FE4606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=EOngkENx
Received: from email.seznam.cz
	by smtpc-mxb-5bd84c9575-nc5th
	(smtpc-mxb-5bd84c9575-nc5th [2a02:598:64:8a00::1000:947])
	id 51ffa03be7c50d225470ba73;
	Tue, 24 Nov 2026 10:20:01 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795512001; bh=ZeaTjX3IolJnMt89jRgwGpklIuwIdApUfNDGy3K8IGU=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Subject;
	b=EOngkENxhi+7LJ9gmMgpyV2F8bj1MNZtWwtuyvCOqDZX9bz4Dr5NWHSMjODhKidGd
	 wJXhd536f4itBQW5Au7JdiaBR/u7BHsnQ4ZKeoFm13jHkIdwigu9jzKB1fo1pea9jr
	 A5VC6mH+6wpacK/HNF4Aw15M/6tb/vpuqDN3OTGw/Q2ztON0Mr632cQlK+kGKU0swB
	 DYbJfuKuz5oZn867nEsubteiJPKaQAPv7zXGWDuMGuLTnLoyhB+EIwQq+EORd3ISIy
	 Bput570errp+ORQVPGjr4pk5FzIektJvg7RrQWd+N4hJvcB8vYZjzQjp8qDwFnqMb4
	 g4kQ9eS86c1+A==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-64857bf5dd-bzn46 (szn-email-smtpd/2.0.97) with ESMTPA
	id 5b782ec9-8390-402d-8e88-51bc5ba6f6a4;
	Tue, 24 Nov 2026 10:19:51 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Tue, 24 Nov 2026 10:19:50 +0100
Message-ID: <179551199007.2729171.13548577895540787684@podgorny.cz>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
Subject: Re: [PATCH v3] Bluetooth: find an RPA peer's connection parameters by its identity
In-Reply-To: <CABBYNZLFtpr8xFjnimRZ9VKOsEgUV-Gzf61bomK4u+SMEyqBxA@mail.gmail.com>
References: <20261109-for-upstream-le-conn-params-rpa-v3-1-ad1225bb0b8f@podgorny.cz> <CABBYNZLFtpr8xFjnimRZ9VKOsEgUV-Gzf61bomK4u+SMEyqBxA@mail.gmail.com>

Hi Luiz,

On Mon, Nov 9, 2026 at 1:51 PM Luiz Augusto von Dentz wrote:
> Not following the comments on this one, why would we want a duplicate
> entry for the same device? The comment say it is a new entry, but we
> would lookup so both an RPA or identity shall now result in the same
> hci_conn_params entry, so something is off here and we shouldn't
> really need to do conn_params_resolve before lookup because lookup
> itself does it anyway.

You're right that the comment is misleading. No duplicate entry is
made, and "too" was the wrong word.

The resolve in hci_conn_params_add() isn't there for the lookup. It is
there for the bacpy() into params->addr when the lookup misses. Without
it, an entry created from an RPA would be stored under that RPA, and a
later lookup by the identity or by the peer's next RPA would miss it.

So it's the resolve inside the lookup that is redundant there. In v4 I
split the list walk out into __hci_conn_params_lookup(), which doesn't
resolve, and hci_conn_params_add() resolves once and uses the result
both to search and as the new entry's key:

	hci_rpa_to_identity(hdev, &addr, &addr_type, &id_addr);

	params = __hci_conn_params_lookup(hdev, addr, addr_type);
	if (params)
		return params;

hci_conn_params_lookup() is hci_rpa_to_identity() followed by
__hci_conn_params_lookup(), so its callers are unchanged.

v4 follows shortly, as a series: this patch is 4/4, and 1-3 fix what
Sashiko found around it.

Thanks,
Radek
