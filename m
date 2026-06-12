Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18984218EB1
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282549; cv=none; b=Rd+GfVekDlDrmXTYhH0GzSzu6br+Nar9sSvjkvxYuT0V9/jucT0T9WkLLG9wiFthkl5ZSrLJyErqOs0BC0aEyVbnDz74v7a+KnUYDxIkg/71ZHWIqPCRbaoL76v4p3R+hTPmKojBC68ClFTxiz5NxMuY0cNxj6CBTi2f1oyg3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282549; c=relaxed/simple;
	bh=/Tqlc50+h9qpLqG/SJBQnvh2Oxdh7i8fyF2n6ff//2Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dvvNGvwl7vinZGBxtuji9pNVN3qyBpKJqxy2fEC92KL8+2TwwiXrUEJ1fBaPYfrYxCVBChvgJiS+bnz3X2U2qhP1HB38cs7h1Ds0gWuuVLaVrGkxLcpp0WDycD2mSDjGKZDj7Q/pZjtXdhqGLHzhu1mpavvO6YqMjOHg41M1/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=JIU5IXT7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E+89cOVk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="JIU5IXT7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+89cOVk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C11C7A0119;
	Fri, 12 Jun 2026 12:42:27 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Fri, 12 Jun 2026 12:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781282547;
	 x=1781368947; bh=wVpbky8czMLX76zpO9njxOrhHlIA5DYLbPCYbSeXiWw=; b=
	JIU5IXT79/RraC57PDr4ufgjaA+DE9tUOK5qEYDjSy5oaaDb2uU7ZaT3b/fzRgCA
	zX+ihXnkqIFUaEdzXYJQKpK2wONM54/gy9z5E3xbPvWv/iN9Rf7Ltby/x5aQ7mNn
	YmDbFwO3qSSeY67RGrIexlO1eWJ4tzbl5+07F7LwvblkCsMnqW9U023TBza/gbY6
	i6TTB7PQl3sdwOhsvX84OMcO2kl9h+3MmwH825E2pyTXO0RYhFL5OKss4c4H+3dG
	etsOJTogpCYWTliK66P35Uhj6mFw0kcL5qPGbkpKtH4F4874hFBJiqAfVJMGQB7q
	mE1dWgEFpKVJNpY1KmCuYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781282547; x=
	1781368947; bh=wVpbky8czMLX76zpO9njxOrhHlIA5DYLbPCYbSeXiWw=; b=E
	+89cOVkGw+IfCF3QpOxyion8f7OQhWa7vJRQwy5bKSWDY/hJbJiF9mwfVOxX3lZM
	1rzPquXnIeAZwPovBNmA3dezKcvsHQEFjPxNXJpr+XCIfFem0qFKCi7DS7rleai0
	h4CWMATjOEjKJmWGwTvSQbC8Mva73DPBvkjpQ3BFGOyejKH9TUG3y4SugWOoSsgJ
	3puYZH2AdpxQF3maj2LjnLrPBngsgvB2x6pY01e99GJQBQZa60jJh3E530wYJy/Q
	gItAVmNHum8dHm5R2bTJ1UV2rWA1zCmcI85memv9FXZsMZvr4hc6yuNS3cGaPIvp
	KuPAF2Zn+bJSa4JZpTkow==
X-ME-Sender: <xms:8zYsauXOlW0gquvBvo7oItXAJbBiYKSwpatF_tbKnw-nxGrFO0FRZw>
    <xme:8zYsalapVW3CWEGN1IwFpbJ698wn3hZox9qH37Xjfl0Jn4bzRNPcW7KEqH2Uiz_Ld
    9xSKMwjGKqBADafR_QNnjONI8x5cNPy6tN2bXxKr49edNlFut-Kqiw>
X-ME-Proxy-Cause: dmFkZTFMvLE9+qqUX12L7ghg9XEiz/R4W/8QETQGlhW1I/fcrMZCirrcvnYZE3pLXRlGKi
    ZJFYweJ+YsoaeDm7Kmg0ECxg8mJw7grYcuF3BqcOeCjsybuFmda49ujPRAkmEyFiwray4K
    62hstDoXTo4qAdR1EA67yH6lZMURwabREXzAYRUkDM8o5fVI9H7TPOANOOC5s1gsPT+6z4
    9kMf9jVP6Qnm/TPmiQne5uDTNxnYaQAsZ6pdK+DRPi0evSdJrTaYAB30fEhI8+TNm8m/Dx
    UeuJj3xn7/jIUg71iJc9ikMBqyOED+5QVJ2jSH0TdazH7ZLpP1EgCdMMdOAQyyCYtlakJH
    Gx1K1l1DtC56SAl4iknpoJPNAJRFSsfbXGkUiaxhCYJDJmVdr6ftlDfnPplJRTR6cTf7vd
    AtLwt34WBqUtbqkwkrz7DomlN35j9I+HdBUcTT4EHJvBmHdWwWPfq4Psj+0iBKAC0Ydj3O
    bvIqPyUid3hZSfcKDes8HLdqk6knEnQnK25K+kuwyerIfxpMxqORfWPXvadYOW/V8z3UBX
    CqbDvxvu1eSsQFcwKfpHLclvTHE/mP0nZQz7321orc/JIfkQmGT/JJZ5dyxTxtKnDG4kjH
    +eTYXJFnpOGgfI/w0ic/2fKHZUvtZqzI+nAelYiQh481tvdfOFyMxVRVprjQ
X-ME-Proxy: <xmx:8zYsalC5tZmuf3pT0kLe_UOxPdrI2VHy_SVbpzHwwQD03Yn2GWJVDg>
    <xmx:8zYsahcQeBQsz2zjGTRHoXc795yGhleslNmxCZuq3K4rivc-wxu3Sg>
    <xmx:8zYsaoIBjkZn9gXye5rp5z54_6mrvtMkeWngA1Nhq1ClWBlDXa8MTg>
    <xmx:8zYsasdbQV3dRdma_Ui_UwFjUnsGlcayVEE4oAqsHZHrpB6F0ATzFA>
    <xmx:8zYsav2qtPy_x9oXgbAv57qWn_FKsVM0we4GdMXlevXfJ7DYf-O8RPzi>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18D87216008B; Fri, 12 Jun 2026 12:42:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AargogGGpPyJ
Date: Fri, 12 Jun 2026 12:42:06 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3cb0a28e-6526-495b-919e-19dc2849d82c@app.fastmail.com>
In-Reply-To: <20260612142957.524526-1-luiz.dentz@gmail.com>
References: <20260612142957.524526-1-luiz.dentz@gmail.com>
Subject: Re: [PATCH v1] Bluetooth: 6lowpan: Fix using chan->conn as indication to no
 remote netdev
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Luiz,

On Fri, Jun 12, 2026, at 10:29 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding
> conn ref") don't reset the chan->conn to NULL anymore making the bt#
> netdev not be remove once the last l2cap_chan_del is removed.
>
> Instead of restoring the original behavior this remove the logic of
> keeping the interface after the last channel is removed because it
> never worked as intended and the l2cap_chan_del always detach its
> l2cap_conn which results in always removing the channel anyway.
>
> Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by 
> holding conn ref")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

I think the 6lowpan CI failed because of this.
What about backporting it to stable here?
b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding
conn ref") has a cc to stable.

> ---
>  net/bluetooth/6lowpan.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index cb1e329d66fd..dba0c9128cf6 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -801,16 +801,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
> 
>  	BT_DBG("chan %p conn %p", chan, chan->conn);
> 
> -	if (chan->conn && chan->conn->hcon) {
> -		if (!is_bt_6lowpan(chan->conn->hcon))
> -			return;
> -
> -		/* If conn is set, then the netdev is also there and we should
> -		 * not remove it.
> -		 */
> -		remove = false;

After removing this, the remove var will always be true,
leaving the var and the corresponding checking redundant.

> -	}
> -
>  	spin_lock(&devices_lock);
> 
>  	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
> -- 
> 2.54.0

Best,
Siwei
