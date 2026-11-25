Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649709;
	b=Pb8iW599ltFEfKeNgSsZzIJG/9fXsh1rNu/LuDbL5F9LAdm0+ZNux+BjuwlYJIswjD70
	 cZ86SQ4PXqcw8fDfseMTW/srEW4wnV47SGq7XW3d6O+JqZ2EusyRXkQJxwLv6l8So2RCF
	 ZmtluDxZKavGFxniavubd7dR5vWaphRKK1Q4VqcxztXW7HL8iCNBmmjLNK6AoGFx5aQsq
	 O+c+FQM1BG/lnnPdV5KP5LRE5svKIjQNbs3g8zvgiM9dJkvSKasgeR5b3Z+4EpVSdh7no
	 LD7GEOxE29RVOqAzlj9TA4XtYw2tPdrbjA2k4xa/uYy53WI3uguqwP7MnqCI+kQDx+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649709;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:Subject:
	 In-Reply-To:References;
	bh=gSEmXqM6V8wSYfp6E41r1OyFxVNG0CnBNhPxZPhIqyg=;
	b=1oMoxR/Jw7gZKqScIAte/MYGCfQ6Pe/oQYj4Jj2M5PXfLwQ6/Yp7CM99ofKorJ6erYN/
	 nrE6KrVE8zCezZ3uDTZO0EHqTIUhQ7p54k+NiXhIQTmG33+fIxVB41LiDfjyD7LMls1WK
	 kp1scJ4Zokn/Ow3nDhSz3I+nlyTv3TY5ZRlkxAP1cgBqjlx7EUFIsqZmKj0yFic3XkrK2
	 pW6by3RH+JtfZlRa95pndONh7iGj6+s6cWfXWE5IkKfoRVXtZAq9hWZcwKNjKuiI1WzmR
	 3iwSmbKyftZ5xqLZh9CCPx71ZUu1AhLaQKSmK87JRT71eEeMWkBOz2O6OrAxgHyhmDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=MQXHWXj7;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378A606A31E;
	Wed, 25 Nov 2026 23:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2378A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=MQXHWXj7
Received: from email.seznam.cz
	by smtpc-mxb-5bd84c9575-j92sp
	(smtpc-mxb-5bd84c9575-j92sp [2a02:598:96:8a00::1200:505])
	id 4a17f904fc2d541d4f98e34c;
	Thu, 26 Nov 2026 00:34:47 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795649687; bh=gSEmXqM6V8wSYfp6E41r1OyFxVNG0CnBNhPxZPhIqyg=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Subject;
	b=MQXHWXj77fVVorE8h737vhmmXcL8Z4i5SupBUQ/adb+NxVSi/kkEL+bBhTu327Fii
	 aoEo0yXnsoqF+Fye++C8FQ767BXElasGq6qrNnDfpsPadvhxF+pRikk4FpK139Yz02
	 krcvgUArnyXok433QX5WdY0x+Z1Qs9q04QLZe1CuJ/uk72cBSGUaQz0hA7ymUd53JF
	 sIdQM2c0dzWk8pv7pkb6YaJLCWoi4HACS7qVKpk9YVmqROH8JD/zWNnERvBSrvCiu7
	 JR+OC79TahjmrmDaBIPj2piNUGYGPi3hpvLIEfJKNWfPEXG+nnIKYieh03Dqyl/rf6
	 AwvJaLFeo+EPA==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-86b589c786-6zt8p (szn-email-smtpd/2.0.97) with ESMTPA
	id c8d0fc3c-ea31-4eb1-b9ad-8a72ebf4e8c8;
	Thu, 26 Nov 2026 00:34:08 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Thu, 26 Nov 2026 00:34:06 +0100
Message-ID: <179564964690.427195.4070648561936692133@podgorny.cz>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Johan Hedberg <johan.hedberg@intel.com>, Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
Subject: Re: [PATCH v4 2/4] Bluetooth: connect to an RPA as to the identity behind it
In-Reply-To: <CABBYNZKCSXsMb++hkgxk+Q8m1W1=+=Z_sgpaQFgWtnSJg8G43w@mail.gmail.com>
References: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz> <20261124-for-upstream-le-conn-params-rpa-v4-2-f2dd5eb41f45@podgorny.cz> <CABBYNZKCSXsMb++hkgxk+Q8m1W1=+=Z_sgpaQFgWtnSJg8G43w@mail.gmail.com>

Hi Luiz,

On Tue, Nov 24, 2026 at 5:35 PM Luiz Augusto von Dentz wrote:
> Any reason why le_conn_lookup_irk is not incorporated into
> hci_conn_hash_lookup_le? That would mean other plcares that want to
> resolve a hci_conn to a peer always lookup by both address or irk not
> just by address.

No reason beyond keeping the change small. I went through the other
callers and none of them is hurt by it, so v5, which follows, does
that.

A connection is kept under an RPA whose IRK we hold mostly while
hci_connect_le() is still creating it, since le_conn_complete_evt() and
smp_notify_keys() both move it to the identity. The other cases are the
time between SMP adding the IRK and smp_notify_keys(), a connection
that was up before Load IRKs, which nothing moves, and an explicit
connect made to the RPA before the IRK was known (more on that below).
The unpair paths remove the IRK before they look up, so they don't
change. Given the identity, the other callers now also find a
connection kept under an RPA: Load Connection Parameters queues an
update that applies once it completes, a pairing reply goes to it, and
Disconnect cancels an explicit connect that was never started. One
whose LE Create Connection is already queued is over by the time the
Disconnect work runs, as both go through the same queue.

Four things change with it:

- hci_conn_hash_lookup_le() moves out of line into hci_conn.c, since
  smp_irk_matches() is private to net/bluetooth.

- hci_connect_le() reused a scanning connection found by address.
  One found by IRK it must still refuse, as v4's 3/4 does, so it now
  returns -EBUSY when the connection's dst is not the address it was
  given. With that, the separate IRK lookup in hci_connect_le() goes
  away, and so does v4's 3/4: the combined lookup and that check are
  now 2/4, and the old 2/4 shrinks to resolving the RPA in
  hci_connect_le_scan().

- hci_connect_le_scan() reuses what the lookup returns, except a
  connection still scanning under an RPA that has params of its own
  there. That is an explicit connect made to the RPA before the IRK was
  known, which is never started. Both connect paths refuse it with
  -EBUSY: a connection of their own would be dialled to the same RPA,
  and le_conn_complete_evt() matches a completion by address, so it
  would complete the older one and leave the new one blocking every LE
  connect after it.

- The fallback works from the identity only. Resolving an RPA given
  by the caller to the identity's connection as well would change
  what Disconnect and Unpair Device do given an RPA, so I left it out;
  I can do it as a follow-up if you want the lookup to work both ways.

Thanks,
Radek
