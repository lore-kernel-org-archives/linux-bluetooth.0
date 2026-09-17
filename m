Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D874A4842
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676804; cv=none; b=k2B6L9RavswYCd/LbxF3EBs++1lI5R5xi2X7BKeWJv9jaNKR8gSJzzyrTszK2fLYyG9A/0YyQt/JFg5pY5GI6Mzn2BdnoOIH7e9VWW/00Emiph5Dp0sA1biLb0cYkevMVncD1xi2yRPvKJ+ITnA+3rv9V1cPntbLtF6pxlc6Ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676804; c=relaxed/simple;
	bh=/wm6upxZhNKjCNldD9EE0n5yIdNuPgK9lrIwGU6QUEc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lNsLj7UzrpoAQqh8JP+KreZXPNGB3R1u2Q/hS20OUzoSpnHVIo8I2WlmzPec9WmmmrntRTCmClbzQD4rZBDtTpg00v6TScUNJT5YVIyy1xzNJRzcZOgCatsiJ93d6FIUZLjWuqq0mmb61XA57t4w+aKtiGAZ5QU/HEepoafb7kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi6MDRhJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi6MDRhJ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caced6038eso11358305ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789676802; x=1790281602; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cSGFqbf3XjQKoM9IeVQurnJH7q0lWkBYjjfyEjg57UQ=;
        b=Yi6MDRhJ9LrvWVAkj858t/31R0nZadrF8vfYStOZG6VVyMneMCehw1cRw5T1Ukg2If
         c6/LHD1Rt9lbG6IlNFhtXa69i8tWPEYRQxfT2z4DrU1AKEejkn9mlVbRUADkQno0ixiD
         zHCMLkudWX7+7bM1IroDrKu9LWJlrr4tO7+P7xZDnVnfQwB+qJAl9oE5GLtk4RkaEK2P
         dTn27ty04JD/u5DcpT0EE39WRj9GQG0QeRw008o8tJuL6aCMbJv9G8aai/sH0NZpO142
         51QUNNOYC5rwN42gTi8hK8/HWiRsgmalboFahfbRy/h9m/EiDCVKWC6U6mjXdkEgkjET
         vgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789676802; x=1790281602;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSGFqbf3XjQKoM9IeVQurnJH7q0lWkBYjjfyEjg57UQ=;
        b=urLat+Vz+ecew3rlhT9N4z9QJeGAWd2+94h6KkNpmbP0SclJrLrdOHLGIMLsCTc1j3
         CQJrV7KC/wbwULiJnw9c134TBu1VpFF+dtHR7B9dS0OiMFcX7UKp2O5bByaBM6azT8KK
         90AzJzDDsqFOLvJZT2HLg2nL8PvHdx9SS8je9ylL/GzB8tn5EUY1V+nPE5ZrUKel1LBX
         hCyR9urQ9ICGyoMYkYQtFJGqCit4V+vRv0JJd1S0pcmV8PL1GUog56HDwiKLXq0dwFXB
         /7bqk/KpOYS/ZwP6V5c6TFoPOY9ed9mmJ2zkM9ixjuugVDRnYEVXPrq1LWHfGJucmAD/
         RvCw==
X-Forwarded-Encrypted: i=1; AKwUvByk3UJGYu3Xb1vWB5aWG8O2bWsC7WTDkFXNOY4vnTMDOu313iYxmI00hBhwNToxpXu6N8OaipSSV+OC7mdjXd8=@vger.kernel.org
X-Gm-Message-State: AFuF++m+X+zWkBJMb79y3Qsn2sl16XI4+T55b9DmbS/qpaLRrj2r+9NQ
	TwOl5uPUl8jNOI2JUWtxHsGem4OUJUTChN3bULtdxn9mZRkH58kjwV54
X-Gm-Gg: AYBFou0D4gd6FY4zcam/cionLZslzt4vjtgeo3wqlXegMHNpktr4HKEd8Yxjk0VfghI
	1Jsj+1rzhqsPhZohjAzOLqNL4CKa73eA8qb3OhpNXXCR/sJ5qGPmrDI15nZg+8fjIW+OhHmpcEj
	EOff+8z7d14U7rDDZDf03fXD1PQBxV/6W8zp26Hkk2yIzBS5ShVcSmbMl4LK4j36Iz+7yOq1y70
	qiY4ToQKUsfBaCBjvDCpX8YTC0KBDt2ys+SziNPDErm1f+02cMNYvOtp7mgxwKHlPrEs+XsQhyE
	OMWUleH3P/MD+x7z/BmmDZUwn9YhV4N/RNvBORbGTY0uYF5jVrfQAsxKyB9nZkp21KSmIjjCrir
	EaETVsjs2f1bugEdvMvS7/yWQtob2cGNoSlSYqA11IMma0cvBJtGkuvki/bIJbsYRAfFOmYrLT+
	dad2krzqd15NgwBhjwY4bs3r9I3py4jr6dv/az/XO1HeTCmkKyUiBc+La5Efvo7+gysROPVszI4
	lkTM652W4lqST9VPrP3490tGcLQhDV/gY7Qwg==
X-Received: by 2002:a17:903:1a4e:b0:2d8:d4d2:d13a with SMTP id d9443c01a7336-2dd9ca3f373mr62050225ad.22.1789676801756;
        Thu, 17 Sep 2026 13:26:41 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a93f1fsm17829614eec.11.2026.09.17.13.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 13:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 20:26:39 +0000
Message-Id: <DLHVH7E0GSI7.EEUHJ5ZOUYIM@gmail.com>
Cc: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <rdunlap@infradead.org>, <netdev@vger.kernel.org>,
 <aajith@arista.com>, <roopa@nvidia.com>, <jhpark1013@gmail.com>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <alex.aring@gmail.com>,
 <linux-wpan@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] ipv6: update NUD_FAILED neighbors from
 NA messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
X-Mailer: aerc 0.17.0
References: <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com> <178966456087.22033.11671220306303617581@kernel.org>
In-Reply-To: <178966456087.22033.11671220306303617581@kernel.org>

On Thu Sep 17, 2026 at 5:02 PM UTC,  wrote:

> > diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> > index 90cd5d8525698..84d70c09205a2 100644
> > --- a/net/ipv6/ndisc.c
> > +++ b/net/ipv6/ndisc.c
>
> [ ... ]
>
> > @@ -972,14 +982,18 @@ static enum skb_drop_reason ndisc_recv_ns(struct =
sk_buff *skb)
> > =20
> >  static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr=
 *saddr)
> >  {
> > +    /* For any given neighbor IP address, consider it an untracked nei=
ghbor if
> > +     * it is absent from the neighbor cache or if it has a NUD_FAILED =
entry in
> > +     * the neighbor cache
> > +     */
>         ^^^^
>
> [Severity: Low]
> This isn't a bug, but this comment block in accept_untracked_na() is
> indented with spaces while the switch statement right below it uses tabs,
> so checkpatch reports "ERROR: code indent should use tabs where possible"=
.
>
> The comment also describes what the caller considers "untracked", based o=
n
> the neighbour cache, but accept_untracked_na() only reads the sysctl valu=
e
> and never sees the neighbour entry. Would it fit better next to
>
> 	neigh_untracked =3D !neigh || neigh_failed;
>
> in ndisc_recv_na(), where the RFC 9131 decision table already documents t=
he
> same concept?
This comment will be removed as per maintainer feedback.


> [Severity: Low]
> Is the new FAILED handling covered by an in-tree test at this point in th=
e
> series? As of this commit, ndisc_unsolicited_na_test.sh and
> arp_ndisc_untracked_subnets.sh only seed absent entries, so the whole
> FAILED to STALE half of the knob, including the mode 2 same-subnet
> qualification, would still pass if it were broken.
>
> For the record, this looks resolved later in the same series: the follow-=
up
> patch "selftests: net: test untracked NA recovery of FAILED neighbors"
> (7be3b5fcfd3f9adb7489aff8013c6d4beacbf20c) seeds entries with
>
> 	ip neigh replace ... nud failed extern_learn
>
> and adds the failed combinations covering every row of the new table,
> including the in-prefix and out-of-prefix mode 2 cases. Mentioning it her=
e
> only for completeness.
>
The tests are added in the next patch of this series

> [Severity: Medium]
> Why does the gateway address handed to rt6_clean_tohost() now depend on t=
he
> previous NUD state of the entry? Before this patch the same "router to
> host" event always flushed routes keyed by saddr.
>
> fib6_clean_tohost() in net/ipv6/route.c matches the argument against the
> gateway of RA-installed routes and against cached exceptions:
>
> 	if (((rt->fib6_flags & RTF_RA_ROUTER) =3D=3D RTF_RA_ROUTER) &&
> 	    nh->fib_nh_gw_family && ipv6_addr_equal(gateway, &nh->fib_nh_gw6))
> 		return -1;
>
> so it expects the address of the node that stopped being a router, which =
is
> unrelated to whether the cache entry happened to be in NUD_FAILED.
>
> When saddr differs from msg->target, and that is allowed since RFC 4861 4=
.4
> only requires the NA source to be an address of the sending interface (a
> router advertising a global target from its link-local source, or the pro=
xy
> NA case handled a few lines above via pneigh_lookup()), the FAILED recove=
ry
> path flushes routes keyed by msg->target while every other path flushes
> routes keyed by saddr. Can both be right for the identical event?
>
> If saddr was the wrong key all along, would it make sense to fix that
> separately for all cases, with a Fixes: tag, rather than changing it only
> for the FAILED path? The changelog describes only the FAILED to STALE
> transition and does not mention this change of key.
This change will be removed in the next version of the series as=20
discussed in another thread:=20
https://lore.kernel.org/all/DLHV5GF21AY4.3GAK241ZI2UR8@gmail.com/
