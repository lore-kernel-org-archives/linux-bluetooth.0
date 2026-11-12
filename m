Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474420;
	b=c/sSe1XcJs47qDgmDGeJHHp/+fJx/qEGDp8SVMlbyoxRoj80QBb+lEK5iDQkbRDtvD5l
	 pPy3y4SdS8j35B820u2IaDYzrMqlwevJnSdWo+HLAyjaBMhWStrvc9eYZAeCcrXn2wZ68
	 2cdPEaO/Yeez3Dy3tDkookmeXBrsbe6HYXYfEGr13I3GIHuxPu7cCmYLabwjyiNQQm5oA
	 BcG8yO07ucW50BOSjW30xdhL531sZqg6aOr4ZWtPDTSKkVbVqSPtKtWd19MCRyONexsoW
	 /E9BjNzrEAIWcm6FJLcMsq6fCiVtNCarGRme9eLpgJccnhRuZ3FdP4tPkkWwL79zJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474420;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=tRjCHW5JmHRNfYMVVQ7cTaxvP6E3n7AN8iMMHkTyP+0=;
	b=mfjoQxat/zsar4F4A+kLytgC9uS/iXbG9xzKDIqV+0OeytscB7iGwZFs3PiJ28UK8bWB
	 DgYxItiWNrLrjxnAUzQEwoVhE2Yi1kS4irPP6ati2zhABgvgD+nMVuIxII9RIbsnEBb46
	 cpaZgT1mJ8Z/D0yMVEtFWEskt6gL0zdlHC2p4NtqbzDMhXW0JHY1i32LpEWBSA1crEHw2
	 THuLe0/pTyEJI15cz+49zbUb/ehrBwd8Ax90/Blns45JVYOzgDKE2qAFYzAZj6wxm3Sqi
	 jzLQO5kP0bnBWNF3EIkgLQ1elQVtcM05hjZrxtZv8AL0TiKZ8ubAn9VGWxTlnIMINSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b="KW/OtKqt";
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252C606A323;
	Thu, 12 Nov 2026 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8252C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=KW/OtKqt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794474344;
	bh=tRjCHW5JmHRNfYMVVQ7cTaxvP6E3n7AN8iMMHkTyP+0=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=KW/OtKqtEoK1lsY4m8IpSlY8BhiL7cv5ru/UgX2vN7ctVpvEeFKyN7mBEPDZtSf/X
	 Y5qD1AaQaYz9eCfxVLJ9z0dpLbogF7UujjGh+Lbo8d4EKHlpf+xRFFQV7xU+TEKNaW
	 qojewXUaoN6p6iUeMF+Mw95S7ab1zbWvzvmAmsIY=
X-QQ-mid: zesmtpsz7t1794474342t162cc61d
X-QQ-Originating-IP: IlA0oIyOsGcenbBY3KwfaIG3ySBqnU3pDSZoMsU2a7s=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 17:05:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5635266169473473892
EX-QQ-RecipientCnt: 20
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c32ee5a21c6b100d441d9006521f571ae297a6e48585a5c8ae4e444b3749;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 12 Nov 2026 17:05:37 +0800
Message-Id: <DMT42A4ZNEL8.29E9VX1NOTPSE@linux.spacemit.com>
Cc: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>,
 <marcel@holtmann.org>, <luiz.dentz@gmail.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <anarsoul@gmail.com>,
 <alistair@alistair23.me>, <pjw@kernel.org>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <linux-bluetooth@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Bluetooth for the RTL8852BS on BPI-F3
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Mah=C3=A9?= <frederic.mahe@cirad.fr>,
 "Yixun Lan" <dlan@kernel.org>, "Luiz Augusto von Dentz"
 <luiz.von.dentz@intel.com>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261111094557.443481-1-frederic.mahe@cirad.fr>
 <179442601916.1604530.1705197925952408060.git-patchwork-notify@kernel.org>
 <DMSUPKS0VL8N.1RUUESQVU8FMF@linux.spacemit.com>
 <20261112061951-GKA62271@kernel.org>
 <20261112085617.516945-1-frederic.mahe@cirad.fr>
In-Reply-To: <20261112085617.516945-1-frederic.mahe@cirad.fr>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NxDjMro7FujaZjwbpQQFZrocKL1ZPj9tYsZJZb22KtIlWGb/PMJNxnNn
	ZqTIwiNj10Ki+AEigic7v9bbvThNpflGlEqG3Az/NXT8ZAiCaKSWNRcEQj9XdVmnY8Biwj9
	c0H1OZylVDd6yzxnb8ehKGE1aIa31dwR16fAr88/3b9drLZUXTOnu3XPLEJT8Ndx24heVly
	mGh3VCdKdRhpv8tOa8ppFfKmc1MIzV2vWod+RZBrrBYHz/9/OuKvcaDoVb7J6IbgbUap/FH
	UuoOXOFlQdb4HaGWRtZYZjvSoSUr6dupsTEeg4JZpMJfmi+oI8lf6BNnK5KONFr650j+jBK
	1hn5Bhs/jqyXVQMXAdcNQFX5TxlpMR6HiF2QI/wwwEaEUtiWOWcjR8WvYS8e5FRvpHTA6Fq
	xIxQffBosTmO/Z3jM+AHkS79PC04btih8qyIjfixgnmBtx1ZvBhhHFpiscBrvmybzv7qP96
	sVqNWRxuklX0Gdx0p1mVYIF5hYGGzGp9gykJqYzZFlN9tV9v1TE6C/KidEt0tFdlxK7f3C8
	QwAjRC9DT+VqzHXtz8td7n1Eq0wwphT9/f3LrIwqJ8E+N8SAKntezGwId8YS7Uy1t4wGsqt
	/IZ4vijTd1kykG8bkp9q2pkcLYVAfGuifEbcKYiD3TtzKZzb6nvRmd3Vgywh/lUp03owjuu
	x4TVhVerZaCNRE6Pi6y7+y2z75uQuSFxSyZKzgnIdEI/041XzmfmKgnfS2+DKjWpQPPPdVo
	Gg5USb1Lk6e/oQy4yt7obleXU6LD0RYIDqg01MlX/i4/LAnt7dKU1ZsXclgxVZFUNBuKRno
	kimHabaxyCYIf978iyat9PEAUo6XkSMRFpvt8L1uR7XMf/yEZoZ2wL/JbCA72A6O9iFM3N/
	SPf6bYylwB6uGnyHj9CPMnaKwXrd+DoD8glK5nnW7bDuw99FJV+fOS2ID+ewXmobozKejj3
	10WJdWbmrpXQUWXanhDp1qgzkJL25tykt+eagnYwgjV2LeC7B4WEk6PsBCtrH+/+vDdkEf0
	cMgHt2m720gEsA6vcW5ElqgtmmmCtni9RdnBH/sTtxLg9GOkFZPsW+zETEA/oFVNt2etXmQ
	hNHiuyuj8juXJHeL/9omO0=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

--c32ee5a21c6b100d441d9006521f571ae297a6e48585a5c8ae4e444b3749
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Fr=C3=A9d=C3=A9ric,

On Thu Nov 12, 2026 at 4:56 PM +08, Fr=C3=A9d=C3=A9ric Mah=C3=A9 wrote:
> Hi Luiz, Yixun,
>
> Sorry, I should have said in the cover letter which tree each patch
> was meant for.
>
> The split is fine with me: binding in bluetooth-next, DTS through
> Yixun's tree. I can resend patch 2/2 on its own, rebased on the
> SpacemiT tree, if that helps.
Nothing to apologize for. Which tree takes which patch is for Luiz
and Yixun to sort out, not you. No need to resend.

Thanks for your contributions :)


--=20
Troy Mitchell


--c32ee5a21c6b100d441d9006521f571ae297a6e48585a5c8ae4e444b3749
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIYEABYKAC4WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavWBYRAcdHJveUBrZXJu
ZWwub3JnAAoJEJgJ74D5MzQvtFEA/1OZjuWJIgwA06HIk6xYdeBFMff3E7qYiKdj
v2lOmwOuAQDOFj0BJUXyYaSBUKsihcqMPFi3X1LWjkUMgbppoOnQAw==
=uEhc
-----END PGP SIGNATURE-----

--c32ee5a21c6b100d441d9006521f571ae297a6e48585a5c8ae4e444b3749--
