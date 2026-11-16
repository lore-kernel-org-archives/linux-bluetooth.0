Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794795792;
	b=FM84IMgvAqAZeY7zHDNMrsjcnvNliwJ3dQQzXIY1byPWXGTXDHKwAXoPZb+gNOL+l+th
	 8oAJNHcgGH23e4ZK25C7Ia3it8SvP1EbivWtagQGDbn3WW922UPvkyYsIUZHuxaAb1mhC
	 vWs/z5ZOboaWvJZtOTk7ywEGwhxuzzoB6MNcJop1HU3THOXC8DA3boPJ5QOIlRi4hUQXw
	 c8KKm4qzXao1G99qDK2yNP+kuYbsBvPymFLVnqKA7B87bS07bqtA2dpUqM1EXN+9Qn1Pk
	 ++/7iKRXIChrpl0XZq65OUjx/0ucBWL5JakzAtxPeJiIJyrZIYWoP7kjMwIijkhQPaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794795792;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=aZsMbLZtMy+B8Di4ruD/oRvKwHPg9oEkT0LcsiqZdAA=;
	b=x6mBWJn6PhASW7mxqE7x4CQDdn+FkTcKkQNL0FldJpleYyw0I8SEIoyS4H7ya48AQ9gG
	 5rhb5HOQhs2FtfIaDnWMdJiJvRtDCPY9Tpi3pd38aVOBy/OgP8Fec/6+UYa9bz3cIdhK1
	 6KHS07G+adARfVmKCqu1IxRZucKgs82sTcPHHQA8B+dHJIoq4xwk2GqDVsw7z9rlg6f9s
	 EOfIiTAT1G94qZEBbO20gkXNuIQi0WlwLtb+2mTwVotPKZyis3Wm2l1nODuWUPGMddRmC
	 uUBM8RSzHZ6oLRORAb6chmqQvEIjELvURFLPe+LXVkIpBHS3HjIGdJTh3JnHYu2BXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=arunraghavan.net;
	spf=pass smtp.mailfrom=arunraghavan.net;
	dkim=pass header.d=arunraghavan.net header.i=@arunraghavan.net header.a=rsa-sha256 header.s=fm2 header.b=RpQOpjUX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ik+g3aCd;
	arc=none smtp.remote-ip=202.12.124.137
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A32606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 02:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A32606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arunraghavan.net header.i=@arunraghavan.net header.a=rsa-sha256 header.s=fm2 header.b=RpQOpjUX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ik+g3aCd
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id A54261302A9D
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 21:23:11 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-07.internal (MEProxy); Sun, 15 Nov 2026 21:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1794795791; x=1794802991; bh=aZsMbLZtMy+B8Di4ruD/o
	RvKwHPg9oEkT0LcsiqZdAA=; b=RpQOpjUXpVySL6nI/dTFykcj0U0QdGAewzwYx
	pKIVhe8pRlbKSUfCK55Owmzn+c7Yfo0tW11VCvfXfYAGM9VqHwi4vTy+ZdLbT9Qr
	rIKs6m2koV0rhmwY1ogXbjbwG5U5vqWTT59hHT6RZYB4FOWqMTPoCawzuIjOncBD
	sXlE9z/izgzZcKT5j9IzRKfs9CPdfMG/s2BxQoJ7mmbjDzfdMm+38jfwm6asrMwI
	9ckPtfz3tJE8CV7wET0xp56dfYFZBJAz+UQcHnndx4vMTFBmYuJtvtJkILWKC73I
	OJBnCW8qYtnD8jfpjO4hDGRaomhLikaYm8IRNdRr+QL9bgc1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794795791; x=
	1794802991; bh=aZsMbLZtMy+B8Di4ruD/oRvKwHPg9oEkT0LcsiqZdAA=; b=i
	k+g3aCdP4W9pn3B+9H+CKa3nIcsE+dzvlYHzG/t5rSA4/2GGvKfu2MmIitQzf36I
	TVoY//eIBaUoqgwnuuBOR5ejG6RZ2Ba/ypTQ9wdXM0bkw6vWlGlx+YhxT8dYzcuC
	pH2gpahp1QAvGV3O6OLmBPK4cRqhCplOvZ9QyyfnALYmEJK2OD57snQdFxI9MUBV
	32XRulBn6V455sRIjS/5KOOpQ23OhQwKna43as/Ca1BNRcm6S637hmnXF9AUUEPo
	/8xX8Q0FZpu9qJ06SReF2xX8grCDj/o9T7xJhjAGzKg32X0oZxZV96MO2qX8/Vf0
	dzoyGFTbZKrutY+iWDS5A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arunraghavan.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794795791; d=arunraghavan.net;
	mf=PGFydW5AYXJ1bnJhZ2hhdmFuLm5ldD4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lLyhXMof2xghHWUyX/P70OzP6b7hi8EV1yesmnsESjKQcpF
	T7+snH9h+FQBdlLeyIBh7Ba/f8moFGHK2zP0jNOu1tJ6sGEXxL0EiSxiybZD18t+
	tz9eGc+NdaRVmsPDZNkL5OdCw/XOd0eFEMv4EN+L7BI0j//NXPfL8rE6h420nLg7
	9j/f3i+/4He9mUSFNhrSQqhn5Gr2L6ipkkTCXMwPQi8siOYeOzomPE3vH/MzVDXd
	WVq+Bf+AoJdUHjuNOFwg1cKgr9r8hRRDwQT0V8BzpoIAS8wLQwvxhxKKEUodU59s
	f29jqoM7CrpwlN/Kxv541EsERyGGyMqs4ft0ATg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7cbxbSfUL3CVu2F7Jx0JBYAQtn0Kx8yqg2V/fl/JkSw=:+QSZrErZ/lcYvmy+UuyKBox9dxG9abCyYeX3VzSSpVo=;
X-ME-Sender: <xms:Dmn6avJ-i5SrxHPXxVueIS-ud3QBxvUxAT5r3hCaInVaw8eEYsD15A>
    <xme:Dmn6at9MGVJ6T4eJdYZJsS-I02cxDprhzLlkISjdCsK4eHm-ARR-zQcgq4yyoz60q
    yzn5e6LUdwd1mgB5Ys8FSSixTjm18IkFvTxB4FyFU1yS5ttrk2fcg>
X-ME-Proxy-Cause: dmFkZTEpOx0o+EtWDVAZoP7Durn9g4X6cW4F0EjrfaUofsSJXldj2z8UJXehFVpvZLs4Mv
    SuYrcsEd/Ql/HEA/AIic42RkPLKsAOviKaIvNwUmuvq1lSBzWps6h6KEecJGi4plnVcQ3K
    t3VsxObshLIpcxuCIXmjNeIdcLOuLRphJ+JvRBwzFUraFhIa3rMxGWTxxgk7mET4VMPQ8S
    xaMJU/hXyeFW6aFdX2110kDtD90RlsE0lk4UtYv8G0WwnJ8qIYSCDBKOFE7/PegbvUN/OL
    5V7mSrMgkvDBk4/MuCuRvqZZiBAowz6HXQVb9SNOGjTBhxHGoPVjcEFxoF5eqMsJSNTHID
    cL60lTco85WDl4iCqJ+2aesWz0avo21blChnMUm6D9Hv1QmZQBMPAzvki8XWi8kLBbvefH
    fKb7EnlcyZlXymix/SkXnDCJTRlz3Wx6ZdmQEKnXhIApaceIQ3rIrxivGdSB8mFh+S0e5d
    akc9Uzk4me1Nqckd6mOT0N7ZhI/wPW8eDikRY5YuGdWPWWD/XLinvGg0ecQBDRS3Bdiocw
    ZHvhM5P+UXVWGtQlGaOboDiwcZ+3+62RzXqIqbpxEcefmwGHLU9rrA4L2hvCoh+mGUikXf
    rqLBy1PYgjvtznQbJSj90+Lj8VNpsPGqD0TxZEf4lp2u+mHf/TridgpcMzyw
X-ME-Proxy: <xmx:Dmn6anx6x4Z2uZ2BADdYwR167a-QmJ-xMzV6BU2j_2Sb5FjXyjxaXQ>
    <xmx:Dmn6atGcauYVLQa2eqWAb6TWydm1mr4QRmO832_nEHfvkLLvOpzIAA>
    <xmx:Dmn6arzANWCaeX05bziut3vPO_Z5Y8W-gmb9wsjjKcBvKGmI5_VeWA>
    <xmx:Dmn6autF8kXNw8ParqX9o7eg9P1I1lXJI5QK50xRrKpAyghuWUZXIw>
    <xmx:D2n6ahJKkwqhT_flr0gf-e-dBl6nOFg9e9R4im_ATlFMnM1XAkYNc-wY>
Feedback-ID: i42c0435e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8175B6006F; Sun, 15 Nov 2026 21:23:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Aptp0BfnL2lV
Date: Sun, 15 Nov 2026 18:22:50 -0800
From: "Arun Raghavan" <arun@arunraghavan.net>
To: "Kyle Pepper" <cochcoder@proton.me>, linux-bluetooth@vger.kernel.org
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Message-Id: <182c2e78-8c98-4686-beee-9b45dfa02d34@app.fastmail.com>
In-Reply-To: <20261028133204.262169-1-cochcoder@proton.me>
References: <20261028133204.262169-1-cochcoder@proton.me>
Subject: Re: [RFC PATCH RESEND] asha: use robust streaming connection parameters
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026, at 6:32 AM, Kyle Pepper wrote:
> The tested renderer requests a six-second supervision timeout and
> latency of five events. Use these values instead of the one-second
> timeout and ten-event latency that accompanied link failures.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> ---
> Resending unchanged after automated CI PR2667 expiry; no source changes.
> Previous submission: 
> https://lore.kernel.org/linux-bluetooth/20261013035111.522738-1-cochcoder@proton.me/
> Earlier remote functional, lowercase checkpatch, Codacy Security Scan 
> and
> outer-CI failures remain unresolved. Historical local passes do not
> establish remote success; no new hardware or functional test is claimed.
>
> Submission review notes (not part of the commit message):
> Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
> Compatibility with newer upstream tips has not been verified locally.
> October 9 N8/UB500 trials independently restore timeout 1 s and latency
> 10. Completed HCI values change as intended; the variants have five and
> four supervision timeouts respectively. Restoring latency 5 / timeout 6 s
> restores short streaming. These are device-tested values, not universally
> optimal ASHA defaults. STATUS and the other downstream fixes stayed on.
>
>  profiles/audio/asha.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index 8e625fdca3..409b4f20b5 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -50,6 +50,9 @@
>  #define ASHA_MIN_MTU 163
>  /* The default of 672 does not work */
>  #define ASHA_CONNECTION_MTU 512
> +#define ASHA_CONN_INTERVAL 0x0010 /* 20 ms in 1.25 ms units */
> +#define ASHA_CONN_LATENCY 0x0005
> +#define ASHA_SUPERVISION_TIMEOUT 0x0258 /* 6 s in 10 ms units */
> 
>  struct bt_asha_device {
>  	struct bt_asha *asha;
> @@ -162,10 +165,8 @@ unsigned int bt_asha_device_start(struct 
> bt_asha_device *asha_dev,
>  	int ret;
> 
>  	btd_device_set_conn_param(asha_dev->device,
> -			0x0010 /* min interval = 1.25ms intervals => 20ms */,
> -			0x0010 /* max interval = 1.25ms intervals => 20ms */,
> -			0x000A /* 10 events' latency */,
> -			0x0064 /* 1s timeout */);
> +			ASHA_CONN_INTERVAL, ASHA_CONN_INTERVAL,
> +			ASHA_CONN_LATENCY, ASHA_SUPERVISION_TIMEOUT);

These values may not make sense globally as the notes above mention.

The 10 event / 1s come from here, fwiw: https://cs.android.com/android/platform/superproject/+/android-latest-release:packages/modules/Bluetooth/system/bta/hearing_aid/hearing_aid.cc;l=453

-- Arun
