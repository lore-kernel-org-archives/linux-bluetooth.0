Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699E3F7AB4
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983553; cv=none; b=O20CKoUYPYHqpqX/kROBRbvN2AHv+GzoWEt1QGMiXtmS094I+nLtTZMc8JH8AhQaXG0GAlq8kIKPr5DuhG0FiYfryXtl2QCrIM4jzLKLNKuQkgMTpqQN7FjRLKxLduz/TK/WuF+pgxH4AQYN3uIqtf1hi4ky8KdF8TbnhO6H8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983553; c=relaxed/simple;
	bh=NlzCQf1zx7qjA+KDWerMH4TMI8AuK36jb8QhvRl+C+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhUSjHKXIihwxjsTGD8uyazeDTfifE+jj60PgEPniHCM/s0mNsdcI/oFJ8jaEQ1SWZkFzt5bCly+krt94h5iSSq/0QTn/t+SBTwWHFBas9BUh625idUpJbBgXdj3llFwEGcOc1zkqvnVCbOVaz+bVXyJWy1qQ+esNulbYOhnR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMwGXCso; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz1exjXH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMwGXCso";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz1exjXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779983548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKX6Ymx1leJt5qAO9KB4MjFbf+Uq9JmkuK+av9nrCKM=;
	b=ZMwGXCsoi4Ns8/oexenj+y3EUUXDzEnYuI6Vo6W6SHrX4Ygg4ZKVxaTQd81SLhs0GgRuTU
	p5bHrXiT0DlwNQpk3M+Rr5WCCGCxz5TjQSk1/H/Wda9yZYPj7UviVdlCrZ0tchhjaKqlm0
	OZ7AVDotS1x9ApzQNu89vhtbvQ0Iflw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-_6Aijt_jOoW0g_OSyRKXtQ-1; Thu, 28 May 2026 11:52:27 -0400
X-MC-Unique: _6Aijt_jOoW0g_OSyRKXtQ-1
X-Mimecast-MFC-AGG-ID: _6Aijt_jOoW0g_OSyRKXtQ_1779983546
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490261c79fcso49846425e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779983546; x=1780588346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKX6Ymx1leJt5qAO9KB4MjFbf+Uq9JmkuK+av9nrCKM=;
        b=Dz1exjXHif217fR/15lRJlDGnl0D74PnLO8WCfPhKkBKMQ/f5H5e6Gz0GHoduDP8nl
         5KyApVKTugNrdhT1xeV4uhRBCP9XOBOcsN0074e0xLewpSUnHmUtFCCG/QPtLpHlCIpV
         kyNpG+r4TQItGfoC177TD7nI6dB1WoDZuzlDLGz9DWmpCHMl5aHq8n4Kjk97ld+UhMD0
         m4erqf9zS10wXwEmhmzeOmognwrjv1ZOXuMgcBSrre2kL2c0dOrYKxSzzX3opF25AGju
         QvQyXFvJ9/fqVkuYfOmDPv5gLI8RBKsND5CdIot3Z8omxQN+MecSiV2cSP/qKQA0Tjx2
         x/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983546; x=1780588346;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKX6Ymx1leJt5qAO9KB4MjFbf+Uq9JmkuK+av9nrCKM=;
        b=M7CiBSwQXpZM21np2bcPzNTwrW+o1pc44XpgSmxEE8Y5eDTsibusIQuncIu4vmuhIh
         lL5+Tz+VVKpuvDxyArHdd7ky4KxkvdvyH3nyMznUWsEinOOkIamFfpRTKC5otsAwEdpU
         m2c2k5b8FhYKghhBeZm/c79q5jBh9qEyQiDmKG7jf7a8eY6I0kofkaGAx1TPF3ONraV9
         DcSj/aaDDJPs0ODWHr0FgtQtz0m08ZzQbTgftnnJO74D7xQJxE/kRfXgnX1uGkpuf/x3
         wcCPJd6dohkqoAPH0Y/+KeaqFB1nk+yriwUTWGh5VEElv/yPCnGUNacngDEkh/HhdAa9
         nc2w==
X-Gm-Message-State: AOJu0YzODxOz3oe600OcB4EpBgp+wJANc/oLqoq/X8vOwHn+pZQGz6Xy
	diCJhF7onbr/UPRL0p9murpaBbFastDLHERxQ87n72GGHqxqMJZ0JhI9YSwN21t0RltAYax+V++
	aP9JVtMDfqkfFNaU25bDtHIxbTuFbKhKbHrgBvAqHtyejgJgLp06NHR4cNeNItLcMSYF5+5H/JS
	fY7Q==
X-Gm-Gg: Acq92OGgyEjRS/kJBVyv+uMHpM7AtxzCy4AUfcfYQPcCuXEjOHeNSCkP1thmk+TkINn
	x75XuDMUI1XpDB37iiDRINCoL3gWWM8KiciqRRzR42fXXEom15iBCzJFpq8blhReV5nDiNwdu2B
	6UmXt5ct1WBW5LHyoRQGg8n2CidAt6HRBgG1fd78FkrN3GRwaBQD5ps/qcDGP1Dv82RW5tlYLNI
	hIlH2UnqopLA06mAC+34RKTJZNzhivdpDwtioKVB1fkqL6SawFgrOkwh9zeFEy+n2SrwemWUq8z
	b/sX44sWvRT400ObAjO/I7wnAn7i/R1p2xm9av+okAkn0B8Sg+j94JHCCfKi8Q+H/Qow0krM4kH
	5+tgtHSkuWGNQROnJgdE2G4RSxeKHzI14b6H9sm1DFigMklIWkPSUHN6+skASyu5BLQ==
X-Received: by 2002:a05:600c:4f14:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490947a780cmr36959835e9.8.1779983546035;
        Thu, 28 May 2026 08:52:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490947a780cmr36959385e9.8.1779983545558;
        Thu, 28 May 2026 08:52:25 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a82ea2sm85074295e9.9.2026.05.28.08.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 08:52:25 -0700 (PDT)
Message-ID: <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
Date: Thu, 28 May 2026 17:52:23 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-05-28
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20260528131839.462344-1-luiz.dentz@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260528131839.462344-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 3:18 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
> 
>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28
> 
> for you to fetch changes up to cdf88b35e06f1b385f7f6228060ae541d44fbb72:
> 
>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci_core: Rework hci_dev_do_reset() to use hci_sync functions
>  - hci_conn: Fix memory leak in hci_le_big_terminate()
>  - hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
>  - hci_sync: Reset device counters in hci_dev_close_sync()
>  - hci_sync: fix UAF in hci_le_create_cis_sync
>  - L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
>  - L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
>  - L2CAP: use chan timer to close channels in cleanup_listen()
>  - L2CAP: clear chan->ident on ECRED reconfiguration success
>  - ISO: fix UAF in iso_recv_frame
>  - ISO: serialize iso_sock_clear_timer with socket lock
>  - HIDP: fix missing length checks in hidp_input_report()
>  - 6lowpan: check skb_clone() return value in send_mcast_pkt()
>  - btusb: Allow firmware re-download when version matches
>  - hci_qca: Use 100 ms SSR delay for rampatch and NVM loading

I'm sorry, it did not fit today's net PR; I started cooking it quite a
bit earlier than this one, and I looked back at the ML only after
completion.

/P

