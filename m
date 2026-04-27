Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DC31A807
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256941; cv=none; b=kn1kHnLyqfd2PJbYbJ3wlcYGEreDhoYuZxuhH1YVaMKyAozSfkrcW3HgyDqiUZYOV3yE/N16FImSTzPa8Sc/8ceswAQvJVXinRg2ca02RBVAAFyemrH8Ft9uUPu7hslfRhF/cCpFRNRYVm++IPeW1UI7plkgmMnwRq0djtU12qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256941; c=relaxed/simple;
	bh=RfNS8MbxG+hBT0aJ9rBu5h4KGslKXlwKmK2t/Ziabc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkkGosxHQ2YM98VGgy+tmBuF8dHSE7pyMcUgV2F2NAFhNxi31aoAZv0LJwTCwdU7VkpZC6LNkiarYPf19ol7K3Xyn14ALtaBuXEDTYYDxPDaAtPnQR6MudtIsMO89Q/Nf60p1dviEQCMIcrjkQgTmfnwCCRG2beb1dULf7dHiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=VvJ/YVlp; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="VvJ/YVlp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1777256937; bh=lbDmxon41suG9jU0funrhpIFB70heP9yFLk4CXBX7Eo=;
	h=From:Message-ID:From;
	b=VvJ/YVlpKcPCnMQzPPFWndOaooyj+XuDliLpVThl0iWyi4oQO+BHgPbQEyRxuhxAD
	 V8L6FQW2O4Klz9TlRdjwmrvVdTYrix0zrfIVgucBNDrgS+7kifwTQpKqXVViXdIv8x
	 Wp4BAXKA4NcS6n0jdjUJURBFjeef7n4CgXlYgONg=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 23225C0D47;
	Mon, 27 Apr 2026 04:28:57 +0200 (CEST)
Date: Mon, 27 Apr 2026 04:28:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: Safa Karakus <safa.karakus@secunnix.com>
Cc: "security@kernel.org" <security@kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [SECURITY] Use-after-free in l2cap_sock_alloc_skb_cb
 (net/bluetooth)
Message-ID: <ae7J6Lnx8vwfTgLe@1wt.eu>
References: <DB4P250MB08058DC86977A3A6F25207CDEB362@DB4P250MB0805.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4P250MB08058DC86977A3A6F25207CDEB362@DB4P250MB0805.EURP250.PROD.OUTLOOK.COM>

Hello,

On Mon, Apr 27, 2026 at 12:09:38AM +0000, Safa Karakus wrote:
> I am requesting coordinated disclosure. The standard 90-day embargo is
> acceptable. I will not publish details before a patch is merged and a CVE
> is assigned, unless the embargo period expires without a response.

Too late, you already posted it to a public list (linux-bluetooth):

   https://lore.kernel.org/linux-bluetooth/DB4P250MB08058DC86977A3A6F25207CDEB362@DB4P250MB0805.EURP250.PROD.OUTLOOK.COM/T/#u

Please, in the future, read Documentation/process/security-bugs.rst or
its online version:

   https://www.kernel.org/doc/html/latest/process/security-bugs.html

Regards,
Willy
