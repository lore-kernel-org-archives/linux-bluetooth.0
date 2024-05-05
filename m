Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC3566A;
	Sun,  5 May 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714905500; cv=none; b=i9cj8NR6BhKFwaepbqRlncxCF6c8CZcntui0zjzK5HWGUY70v/5a9kHGQFPSoQuYAsFfiXSdyPgi5m2RHRSU4LU3kG2X2a23wrqjmks06GFlZvZlMzeNoGEgiZfH4qITLb6F6TMAUj0M8sOAYn4Hb8tbuoHp5dxTJ39gchrdgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714905500; c=relaxed/simple;
	bh=NNdDnPQlRSRzHhYTvhUK9y1CX1nyF8zPfZQDyiTOiWU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PhO9WlwmZQNAv+exQvyS47XiAp3HnxuF+2eun9kaPeCugdHlPMqip9JDJ2AGPWOfV9+qd2w2oGeyYxdy/kNwn5utmhMWhVDTPdNc71jfYUEMwqG646rEnnyNVp+bE1WH+raaGw3DKkyS7rti0OUHf+Ntgs8CI5DzeZlQNfRaSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=e6NjzObd; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="e6NjzObd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bnEpZ4ek9gyxr2Bjc24kTx45c9ZBkO1BONI1X2l8JAc=;
  b=e6NjzObdZj0pnTiWmX/Kyx8s+zgErFHpasKDTDNtbCSezR8JsaBHIgG4
   GFCDc+mBO43ATzEb6GuI+jMd+LN4Qc3tZH4YtWhnV7BnRt9U7a0QjPR0c
   TxdrSc3nl/xfcsdRT5SxYJ4N6YvHgIQ669pcRuILvgZX4qnTODq5B1dEY
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,256,1708383600"; 
   d="scan'208";a="164542257"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 12:37:05 +0200
Date: Sun, 5 May 2024 12:37:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bluetooth: qca: Use common error handling code in two
 functions
In-Reply-To: <31f78b18-0caa-45c0-af84-c95d525a13dc@web.de>
Message-ID: <alpine.DEB.2.22.394.2405051236040.3397@hadrien>
References: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de> <alpine.DEB.2.22.394.2405051105000.3397@hadrien> <31f78b18-0caa-45c0-af84-c95d525a13dc@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1282540469-1714905425=:3397"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1282540469-1714905425=:3397
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 5 May 2024, Markus Elfring wrote:

> >> Add a jump target so that the setting of an error code can be better reused
> >> at the end of these function implementations.
> …
> > This reduces readability, and backwards jumps are rarely desirable.
>
> Would you like to support any other design approaches better for
> the reduction of questionable source code duplication?

Maybe cleanup.h can be used to get rid of the kfree_skb.  I have no idea.

It would be nice to keep the patch in the message so that one could see
what is being discussed from the message itself.

julia
--8323329-1282540469-1714905425=:3397--
