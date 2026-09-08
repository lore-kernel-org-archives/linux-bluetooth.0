Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3175908A7;
	Tue,  8 Sep 2026 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906586; cv=none; b=KGg9DtZdnvooV0Q4UxyqrR0zAYyXbjVk7RnrCqrkD5uJaY04RUqprjHhYBiy3xVxbNWi4ld3L6im0hLZancScQWS+GPOCCpWv3Iguam5cugE1cVcnsVFue1V/7McKvyv8eigwkzmWOLWF48geR5DWzhrEgKOUi/FQmD0oAzFbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906586; c=relaxed/simple;
	bh=34hTmnCR0N9guRDXxlyaOmYbh5vZfhydP4hwYqrWJjE=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:To:Cc:Subject:
	 In-Reply-To:References; b=o6Zj/mLepawLjkZFyohFNNZxIrcxfDOdVL2h2UtAQ3tvOeo/4Y1Z6RhbcV7kZSyD1rhtwjcby/j2IERgqwmybQxsfluulwLHGPHR/LoMNHCoQIMw7ygHX52xAeEqXNfvW/3f9YvcKkOdweKBMeMaemGPRCynQA+FUGJQ06WDWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=pDwE8d+8; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="pDwE8d+8"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-9qx89
	(smtpc-mxb-7db765f675-9qx89 [2a02:598:128:8a00::1000:909])
	id 5656cb1be06c660253d9d153;
	Wed, 09 Sep 2026 00:29:27 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788906567;
	bh=iPpGEL8j4HQ/8vdnw58WGEmPElhHmAPA/EwT4tmUFxM=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Subject;
	b=pDwE8d+8/wBAPrj/mj5GQm6VLANIJklvpA/ObbuShdP7eF+F6DJAjb5sJR9kbJlFV
	 Y0gIBflw5AONo5rtIMPXCu3X91F1k+E66OEtKaiL+ULF0/inoi1Ih53qIr9JAZbNhS
	 +jMtgVZt5qX8mDUf5EMFoO2hkubA/08h+c+pwEavT6zbnLFhGjuRruUlph+fhgbG92
	 nBGE+fXDdsIKxILbf61ePBOduYB0D6PfEYnwi96wAL16Ohnd7KVvyAFdZU8NPwPbmZ
	 LE8Z+8w8P7h92Pl3H7fbWwkt4toHbNqIS7hsLhC4rW5ZJLhBBllb2s3+VZUo1wDZ3v
	 TcOHNDgDtJs0g==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-57659868b8-gtrjk (szn-email-smtpd/2.0.82) with ESMTPA
	id 211559bf-2787-4ddd-8474-ea7f5f505cf2;
	Wed, 09 Sep 2026 00:28:30 +0200
From: Radek Podgorny <radek@podgorny.cz>
Date: Wed, 09 Sep 2026 00:28:29 +0200
Message-ID: <178890650942.186465.6960417770020253183@podgorny.cz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
    Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
    linux-bluetooth@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: put the peer's on-air address on air when we cannot resolve
In-Reply-To: <CABBYNZ+5zV8xzhHZKTUQYT4tLHaZAO7iiKOEsKuT8aA+YNLjPQ@mail.gmail.com>
References: <20260908012048.3681904-2-radek@podgorny.cz> <20260908012048.3681904-4-radek@podgorny.cz> <CABBYNZ+nWb0m=qMvxADM2HvuLhopxG7L+io2JTmGXQM51YOYhA@mail.gmail.com> <178890003160.100543.8134592214245196581@podgorny.cz> <CABBYNZ+5zV8xzhHZKTUQYT4tLHaZAO7iiKOEsKuT8aA+YNLjPQ@mail.gmail.com>

Hi Luiz,

On Tue, Sep 8, 2026 at 10:59 PM Luiz Augusto von Dentz wrote:

> > One cost worth naming: with the RPA in conn->dst from creation,
> > hci_conn_params_lookup() in hci_le_create_conn_sync() misses the
> > identity-keyed conn params [...]
>
> That probably worth fixing, but yes it can be done on top.

Ack, I will send that separately. For the record it is only the lookup in
hci_le_create_conn_sync(): the other conn->dst-keyed lookups run on an
established link, by which point le_conn_complete_evt() has already put the
identity address back, so they never see an RPA.

> But if it advertises using the identity, we should connect using the
> identity as well; there's no reason to use the stale RPA if the peer
> somehow disabled its privacy.

You are right, and my apologies for missing it: v2 as sent does not just
leave that corner unhandled, it makes it worse than what it replaced. I had
the freshness window fixed in my head as the answer to the stale RPA, so
when the timestamp went away I dismissed the case along with it instead of
looking at what the case actually needed. It needed invalidation, which the
timestamp was only approximating badly.

Concretely: nothing ever clears irk->rpa, and v2 removes the conversion in
__hci_conn_add() that was papering over that. The peer advertises its
identity, hci_connect_le() swaps the dead RPA back in, and every attempt
from then on is dialled at an address the peer has abandoned - a permanent
failure where the code v2 replaces would have connected.

So v3 adds the missing half of the cache maintenance ahead of the address
change. hci_find_irk_by_rpa() already refreshes irk->rpa when a report
resolves; nothing invalidates it when the peer stops using RPAs. In
process_adv_report(), in the else branch of the block you quoted first time
round:

  irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
  if (irk) {
          bdaddr = &irk->bdaddr;
          bdaddr_type = irk->addr_type;
  } else {
          irk = hci_find_irk_by_addr(hdev, bdaddr, bdaddr_type);
          if (irk)
                  bacpy(&irk->rpa, BDADDR_ANY);
  }

hci_find_irk_by_addr() matches only public and static random addresses, so
an unresolved RPA belonging to some other device cannot reach it. The cache
then means "the last address the peer was seen on is an RPA", which is what
the swap in hci_connect_le() has always assumed it meant.

That patch comes first in the series, so no commit in between leaves the
tree dialling a stale RPA. I did not tag it Fixes:: with __hci_conn_add()
still converting, the stale address is only reachable today through the
reuse branch of hci_connect_le(), and a stable backport on its own does not
seem warranted.

The address selection itself is unchanged from v2.

v3 follows.

Radek
