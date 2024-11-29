Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660A2C18C
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2024 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899869; cv=none; b=EmlrYyl+AnoxpfCWc8czRzs4SU4vYXpwJjRIvTwa3aIjectUYGtOKuiVWFX9VO46PC/51ojO9Z0b9+M44kriJcWav9/AscurDR7lqQ+msu9FgOYmkV6/d/MKHzd6zChoX6Mb68/4yzbUT2OTf4CrBH6KGIbR5a+/bOSszD5feKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899869; c=relaxed/simple;
	bh=LxyOhNNWxkYo4YhJQw3FYghep1A/k5HvKmAUGChwd/Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=I2olc53QdaADlgXLF1Z4DVX1DCoAHse/HRIjv7ygSdade2VGWkMyZHaWIpn8ZPYSHfhKNURnpkPWjQK/a/vOxAvGulm165n7KbCFDo6vGEfJ1e3KlMep8kUwO0ZHIxIb9ojdisNLgC5qMKancwCs1lBGGVpc7v3yPE1ObHANs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQskyUFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQskyUFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732899864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxyOhNNWxkYo4YhJQw3FYghep1A/k5HvKmAUGChwd/Q=;
	b=HQskyUFU6cCOuZeK4lNBIea4mWAbjXV451wfI0eLdX7JDthSPzVYv4HiF4tZX2lSsNKEFg
	XOHFe0nPzXh3g0Ph3bWjfLLI1YcjbXzNWDIxiaPmvmdKszK4ZAT0r5dHWgWGWYkaRlj46q
	ajQuOlZA6VG9S6xRQQOdqoXixhup8Tk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-xgmFcM4xMU-2MKgRRGtVjg-1; Fri,
 29 Nov 2024 12:04:19 -0500
X-MC-Unique: xgmFcM4xMU-2MKgRRGtVjg-1
X-Mimecast-MFC-AGG-ID: xgmFcM4xMU-2MKgRRGtVjg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE9C7195419B;
	Fri, 29 Nov 2024 17:04:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC8651956046;
	Fri, 29 Nov 2024 17:04:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-3-d752cac4be8e@rbox.co>
References: <20241119-sockptr-copy-fixes-v3-3-d752cac4be8e@rbox.co> <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: dhowells@redhat.com, Marcel Holtmann <marcel@holtmann.org>,
    Johan Hedberg <johan.hedberg@gmail.com>,
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
    linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
    linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v3 3/4] rxrpc: Improve setsockopt() handling of malformed user input
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4022660.1732899850.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Nov 2024 17:04:10 +0000
Message-ID: <4022661.1732899850@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Michal Luczaj <mhal@rbox.co> wrote:

> copy_from_sockptr() does not return negative value on error; instead, it
> reports the number of bytes that failed to copy. Since it's deprecated,
> switch to copy_safe_from_sockptr().
> =

> Note: Keeping the `optlen !=3D sizeof(unsigned int)` check as
> copy_safe_from_sockptr() by itself would also accept
> optlen > sizeof(unsigned int). Which would allow a more lenient handling
> of inputs.
> =

> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use b=
y userspace and kernel both")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Acked-by: David Howells <dhowells@redhat.com>

