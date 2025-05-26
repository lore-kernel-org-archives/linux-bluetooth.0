Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6181FC8
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748265397; cv=none; b=gWqoqpihZFxN541Nvz3d7XNjmlZbLKhsL8wzMHBUZZsPAisoxFLwheoIFl4gVUj8Epp+p+U1GVpq/FYhGbv2gaez3rwN+4Vp1qp6LYVIAQKX/6qYQ+XhS8TYBVSt6xbCPex/eaRH8SKkStXZSfWH56mrEg1jnnQqdmugaK7FX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748265397; c=relaxed/simple;
	bh=2HIpfB4FINqSnaJhzyxciDjoxVg/KlZfS9/mw3ZwWgA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=MjtTCIOqTwr91H6ewBgHgkA9AEmz32j19snv/Zv8+JB6++7XfKBbQy/8ibevlJT5N4HzZhnVVuJfZRP+srpkm5rToZh3RTh4DPtb7i1L9swPu+JSTl033tggptLHOh5C+rcPaHDrtpWSgiyQ0+eCWuYSSfdn37D8yBtddDEyIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=AHEqPgLk; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="AHEqPgLk"
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:832b:0:640:fda5:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 9436D6113E;
	Mon, 26 May 2025 16:16:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VGTRfvGLneA0-S8uCgG0n;
	Mon, 26 May 2025 16:16:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1748265392; bh=cVqHOhUhs4uPu+FcM3hJbxzI7N2DyCzgJ/muJ431BGo=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=AHEqPgLkmySp3WSPRljbGlen3+7xV4/zGEyARadwwenqOYwihy/L4k+I+jmnzt6gG
	 YjB4kwST57X+pgQ4bdLX14KdVYYYC7fYEennYCQMOB1K2K1BcNW4J9uNTNnx+hXeT/
	 zYUmDWfrcG6cM4Vld4B/cQt7CAOVcwHOvPZMjzqA=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <6e929029-71c4-488d-b97c-3af7aa12b42c@yandex.ru>
Date: Mon, 26 May 2025 16:16:31 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <CABBYNZLJGwmPSe9Me+OLpr8WLGOenRrwJt_JxVmWfPO_X1YWJg@mail.gmail.com>
 <20250520144935.595774-1-dmantipov@yandex.ru>
 <CABBYNZ+i56pg+Rs=mu8HvJ1LC+aeyDAt7=pYJ3ksNOrehj0ZUQ@mail.gmail.com>
 <624a7fcd-1e25-4cd9-9e6b-b2315905bb2e@yandex.ru>
 <CABBYNZ+nu69A5GN=VTH-jB-0mVjNihMFT=hHQmDiNrZXnEVwEw@mail.gmail.com>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: [PATCH RFC] Bluetooth: use RCU-protected list to process mgmt
 commands
In-Reply-To: <CABBYNZ+nu69A5GN=VTH-jB-0mVjNihMFT=hHQmDiNrZXnEVwEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 7:03 PM, Luiz Augusto von Dentz wrote:

> Afaik that is no different to hci_chan_create/hci_chan_del, and other
> versions, which don't seem to have any problems with and they have
> been around for quite a while 

Maybe it's just because the related paths wasn't tried hard enough
by syzkaller or something else?

> I assume that is because of the usage of synchronize_rcu.

IIUC synchronize_rcu() is used to wait for ongoing RCU read-side critical
sections to complete, which is pretty enough for lock-free cooperation
with _the only_ write-side critical section. But for the case with
'mgmt_pending', it's possible to have more than one concurrent writers
running from the very different contexts, including invocations of
'mgmt_pending_remove()' from callbacks scheduled via 'cmd_sync_work'
by using 'hci_cmd_sync_submit()'. Note calls to 'mgmt_pending_add()'
are always issued under 'lock' of 'struct hci_dev', but this is not
true for the aforementioned calls to 'mgmt_pending_remove()'.

As of time this writing, syzbot has spotted at least three crashes
caused by an unsynchronized updates of 'mgmt_pending':

https://syzkaller.appspot.com/bug?extid=feb0dc579bbe30a13190
https://syzkaller.appspot.com/bug?extid=0a7039d5d9986ff4ecec
https://syzkaller.appspot.com/bug?extid=cc0cc52e7f43dc9e6df1

and https://syzkaller.appspot.com/text?tag=Patch&x=17561df4580000
is known to (hopefully) fix all of them, also keeping the changes
relatively small and simple.

Dmitry

