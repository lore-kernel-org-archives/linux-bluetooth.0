Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638742;
	b=EDEf/OkZjBZeSQISOuuavJCEulIuKgsAsjOT6m1flsfiVGSf9u2ZNJya74LvXEFRwDKA
	 YPWWtI3uvc3UxgVTTOHrB9R4uOd19v5xywIgHIB1+w0IK4AoHfMGJ0bPrZM5cjp22i0uJ
	 3PQopvHwPA7TW+a55wdQM9r1YCZjFo6n91trVggyTLd8tYfj5piFfwHkUXjQISo39G1+z
	 d5DgSwVJuLkw9k+SZeCFDuaZ3gjkg4i0SjPxWSgCp4vkGS+jfEzFvQ6W5L7Ua3S6UElWh
	 /k9BS2NXD3YllAziNG8lisVOjQ0eyUZKoWvznFT97egNZssF1RjEqfvdCJqj1V/YT3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638742;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=M3eezsuyIgK3nwybmyakC/MworsMBoqtq6oIBsdD+tE=;
	b=yTO2f03JAYaUbN2LMCDWSYtLsYjBIyVQo4Dci3/j7Qjr3JkzPQ7HX1iRJj6RzANKZ05I
	 juAMbxM/kBoOhJEkX9Wr3HNvWVf/DmqzRoa/H/pOGAEymY33rm++b7DOIoXH7Dce5qeGy
	 meBBIdtv/GnH0pUWaRIpdmnTTYA/n4+1+9UmLM2PJjMNAIGgMyZbdUunjLI/WmDk7T/WL
	 zipPWpBM7xv3h/yQGBoNVZw7DX/cQbnpq/9nT/ewBXbuYhHVJ4hk2qdxHNXg/ugKBDj+P
	 4/3LJ/WKuG0fCHhBu5UMjNS8sq8jIaDlH6Gl35vVlcgE9KLJNLYsoE+C4n+2RGCPjuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=sGzoQb8F;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ulQLyYaS;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B156607504D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 16:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B156607504D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=sGzoQb8F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ulQLyYaS
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5371FEC065B
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 11:59:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 02 Nov 2026 11:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793638740; x=1793725140; bh=M3eezsuyIg
	K3nwybmyakC/MworsMBoqtq6oIBsdD+tE=; b=sGzoQb8FSlfUsFJVrOPndIkjzt
	kE40I7aNUVXi+4Q3wFfnOP05glZ0pbGwPW6BgoQCKFCd7V//b9TcueKg94BA2f+m
	9w7sPSmrsimBmyzn5mKm0B4wo76KpgpeIXNMv9anzNBreqCgh6DroFfDvkTK+iKe
	r8SarNe6DhEp7hmsNqpgPNV0kMXNOSaQRcO9r55J6BVT6pnBtXeBdJu4lYpU6K/k
	mmg6ulvyoGn6gZv1Id/b9T1Jr5/MyUlEqWSidrtNmOpTD5RvBBdRPvzkwGB5wnmf
	sESPzNdwz5a/ZdPis4ujkQQHdj9Tr4QUZYAv/SOl1eKF9S2ZliYDWC07SXYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793638740; x=1793725140; bh=M3eezsuyIgK3nwybmyakC/MworsMBoqtq6o
	IBsdD+tE=; b=ulQLyYaSIuuHik9Bx7i30O+ibuK22mhfbsBuCddeREtJ7uRoRKd
	+u1uaX5rhygRk3/+bk/osixwcKYMNHqF+8HX73uWq4rgherjxIl7j3Obfckiuo/E
	osDRGFATKPuRQ5ZpNd0SO1rv402vKSUN3RZAJ9PwjL7GEpQZwcQb1Kaml8oh3x+v
	HWAwsvR30ycsv4qq4d9oKhBftIB4xBEa6ULgOS1+0+3Y6A6mOWrK8QbJ1pfI3khW
	1mwit+b8J5XXcig3ueGYrIRW/+SGgIVEkQQwNsGXWGGyBEkWUZkz0BAEfcifWOnb
	zQixuCFV8y3zTVCwV1q35H7dJkFbSaSDAUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793638740; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:e6LB8l4J4UWpzN0+aTVvVUwqGJCaz2XP9THP9PyX6KMZSqv
	Rwywn3M9p1uN+b7LC8vO9R8sKgY0wYU7+ZBjrqIYYtVmD5gFAdmzX8NcPI5MLWWs
	bPMMMDHaLC1HZtEgY5QiyfdJK/NCvmboLnA4hAfF/5B83NhOR/7596R1S1P+0/UY
	wjOvCY4NquLCy/7YHWK/y5u7wl0Jay7TdQ/Qg3ZpsGWSR/fwwlVqP8tb1iAj5EC9
	cGcTEvuIOpUcYUbSqjBEhViL+sfWNoHLBmR76RagsoTPLiQrwrMxZqjtdsBBeIQ6
	aTI0ONhxy5gZMIpMZcyqpg2IYzmV2axt0XK/Pug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Aktz/cN0hOPJhmHpxP9DOHFJhk+nRLbFzCFak6LRPfU=:5+a/GWJPW+aBNSZRfLDYw7TYit46Fh7RkPcYuf2+rkg=;
X-ME-Sender: <xms:VMHoanReIfPY4mZ6H2zzR_MJlJh6GoSg8r-iwSwLl-666_75uSurMg>
    <xme:VMHoalLv4WuPXM2xapSXNkcrvIb0FrEdmG-omzoFS0aDhtMq-s8CdMVrlbVE8HcHp
    AVR75rCl6MikDmw6ClQmsdEqMpswkfrBmJjybgnJTxS56BQTqc>
X-ME-Received: <xmr:VMHoahQjiuo0FzEXnnCdrsg2epOi1QVpqF3sAJGx_jCuWFUlKw3PsTwAtDfu>
X-ME-Proxy-Cause: dmFkZTFPXn2hYcKuahI6WM8TuOSCrGJoOxGIZRhohOINH/8S8Ajso1tTvhc/iLRY5vquD7
    +BO10uekoDUMUXuDBAwu1T20ExL/50qHgXDvpOE0z+NxxU26uzt2Uur8zLs9AlLEOSLByX
    YPsr13hIBd5kWOHeMWfiu5KMivwRabJ6XHBB1k+75zbYeHTepqAdQc5G3W9bi1VdKb3vBy
    hSDOiVnH0ca4KiXzpy8Zl/PulwIOcE3bj6ce7N0ttshUF4qGJGF5A9ntb4s9TGaH7yDxJq
    PmQTuD4rjrqnSV1F+9t9gyJlkfa8z39vvObnx65GfTu7JTRhOxKlPnw1Tub6HTUxRCFMQy
    2+YQ29D8qC7mNvWvoFJryy3ccNVlxdHtce7fqjx7xHGIfHfDmbZWBhMSObVZEwGCctzx8X
    RqfZRkCNXNglhoMbDcc4Im7MbPEAjCeLoVD8OTA/WFHFHyoJpMy59aYEqf+5iFOvC4f6t4
    fVRbdJvUdhRdLWD5UZvh/D4VG5G3AWxl1CCkxpKBPWIlHgMDDM+1CTPWUrBM7ih9OIJNpQ
    Jbc2cX+y73LFr5gXaiSCqJvwDe3gaWDIFRaCfVIdAC4DfXkDmFEBcPx2aA0d5umV8IEfKO
    sAQtcPTtSx5+IyV7Xgrz24D9e6/FJieqTh2kBCmqvpV3eZQITvCM4kcH1s1g
X-ME-Proxy: <xmx:VMHoalL8-S31qF0mUd27tMGANRSqI2tL-W3V1FYeP-CQRjN-bDKmYw>
    <xmx:VMHoas-6gJBVrP1VW2150cMuUXD5et5SPZce3pANHCi34Uy7PCSMjg>
    <xmx:VMHoakKo4AISBtO6iBKxyQcFn8j_0A_XCgpslmjqKc5oIn4ZgP2RjQ>
    <xmx:VMHoajH11f18RC4lsdRO0G0Cf-nJ7gFt70NMWGG0dhyIZddL5lWeyQ>
    <xmx:VMHoaqWPwvgdhlX7gQAGhqk0DF8NsG3B7QR_wI3F0PZhjOfC1-LVzof_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 11:58:59 -0500 (EST)
Date: Mon, 2 Nov 2026 17:54:01 +0100
From: Greg KH <greg@kroah.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>, security@kernel.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: L2CAP: Clear request identifiers on
 incoming LE connections
Message-ID: <2026110247-steadier-squealing-e571@gregkh>
References: <20261102124735.23199-1-enderaoelyther@gmail.com>
 <20261102124735.23199-3-enderaoelyther@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102124735.23199-3-enderaoelyther@gmail.com>

On Mon, Nov 02, 2026 at 08:47:35PM +0800, Zhao Li wrote:
> Incoming LE and ECRED channels retain the peer's request identifier
> after an immediate response. The deferred LE response also leaves the
> identifier set, unlike the deferred ECRED response.
> 
> A later ECRED request can reuse that identifier and include an unrelated
> channel in its shared-response handling. That walk matches on the
> identifier alone, so an LE channel is selected too. If the old channel is
> closing, the checks can refuse the new connection. The check at request
> receipt rejects it with L2CAP_CR_LE_INVALID_PARAMS; the check before a
> deferred response returns L2CAP_CR_LE_AUTHORIZATION.
> 
> Store the identifier only when deferring the response, and clear it
> after sending the deferred LE response. Keep deferred ECRED identifiers
> until the shared response is sent, since a partially accepted group
> still needs them.
> 
> AI assistance was used.
> 
> Fixes: 27e2d4c8d28b ("Bluetooth: Add basic LE L2CAP connect request receiving support")
> Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> Built in patch order at W=1 with GCC 12.2 (x86_64 module, x86_64
> built-in and i386 module) and Clang 19.1.7 (x86_64 module). The x86_64
> module builds with both compilers also linked vmlinux and modules.
> Sparse checked l2cap_core.c with C=2 after each patch without
> diagnostics. Smatch reported the same pre-existing l2cap_chan_connect()
> diagnostic as the base; no cross-function database was used.
> 
> Coccinelle 1.3's use_after_iter rule found nothing in the changed
> functions. All changed functions were processed; five unchanged parser
> gaps also occur in the base. Hardware validation has not been run.
> 
> The two-patch QEMU/vhci arm kept all 445 established channels alive.
> In runs where new ECRED requests reused the identifier of a closing LE
> channel, the base and patch 1 alone refused 18 of 18 at each site:
> with L2CAP_CR_LE_INVALID_PARAMS at receipt, or with
> L2CAP_CR_LE_AUTHORIZATION in the deferred response. With this patch,
> all 18 completed with L2CAP_CR_LE_SUCCESS at both sites. Two further
> requests per run were refused identically on every kernel and are not
> counted. Partially accepted groups were not tested.
> 
> A KCSAN kernel with both patches, built without KASAN, ran the patch 1
> close-before workloads without data-race reports.
> 
>  net/bluetooth/l2cap_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a21b2d70ad8a..0b6eb082f3f7 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3972,6 +3972,7 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
>  
>  	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CONN_RSP, sizeof(rsp),
>  		       &rsp);
> +	chan->ident = 0;
>  }
>  
>  static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
> @@ -5311,10 +5312,10 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>  
>  	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>  
> -	chan->ident = cmd->ident;
>  	chan->mode = L2CAP_MODE_LE_FLOWCTL;
>  
>  	if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
> +		chan->ident = cmd->ident;
>  		l2cap_state_change(chan, BT_CONNECT2);
>  		/* The following result value is actually not defined
>  		 * for LE CoC but we use it to let the function know
> @@ -5550,10 +5551,10 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>  
>  		__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>  
> -		chan->ident = cmd->ident;
>  		chan->mode = L2CAP_MODE_EXT_FLOWCTL;
>  
>  		if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
> +			chan->ident = cmd->ident;
>  			l2cap_state_change(chan, BT_CONNECT2);
>  			defer = true;
>  			chan->ops->defer(chan);
> -- 
> 2.56.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
