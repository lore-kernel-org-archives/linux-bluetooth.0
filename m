Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105B1C9DDB
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568247; cv=none; b=ZoiKPf9J5Lo+jLH/eqQohhS0ygzKIOhCVkHEcn4WTsdMEg8mQIakoLfV5CRKXT7kb0iDhqOvaRxw43RKvWckytxHr/r41lo25vKfDwa7UgFcmd+RMhQlwDk5l/qUgyzbRyL8NVwGXn/hh8Kk+V72dbW6ff2XH7lzPNEYHSPDQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568247; c=relaxed/simple;
	bh=f/bFqIqvULgsTEZXozGoriPFERUUwWtc0QG8WIsOOqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV0Vusfr5ucCZgqy6cIb5wmVMryf7zJ3VJ1jN+yPtgXH63JpgJxiDoe/p/LlCeowgHR5VDQZLHQvGJGki+ZXU9pRkzQNbvP5PugEDASSU5Unnvb5uDQozk/Dxm5n9+70rCOAcSox/icFXC20VwT8wiZs90oZB0a+3XX+Lx4UjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=TUJlkZPP; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="TUJlkZPP"
Received: from fpc (unknown [10.10.165.23])
	by mail.ispras.ru (Postfix) with ESMTPSA id 81C6C40B27B0;
	Thu, 10 Oct 2024 13:50:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 81C6C40B27B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1728568234;
	bh=29Wqn/jqsbRQSKMLd71gfDaUXjtFFRIipdI9OodAKAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUJlkZPP36d5jNhwkRVZq1ftcmx7QzjRHPArNSvTyFakaDoem612W8TTyo91JBW4x
	 agSPEJCLMqhmTrZYjj4UkCEWVLLWc9waXDU5tl44vpKOPUgBXCiU6WkrTh9xqHvcsN
	 jXJz7lTgYvWoY1jqchRVtJ5F7RmGJtDEE8V5MZks=
Date: Thu, 10 Oct 2024 16:50:30 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com,
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] Bluetooth: do not send mgmt commands to
 device which is going to close
Message-ID: <20241010-7492e13ad493a1459bf2f8bd-pchelkin@ispras.ru>
References: <20241007074538.109613-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007074538.109613-1-dmantipov@yandex.ru>

Hi Dmitry,

On Mon, 07. Oct 10:45, Dmitry Antipov wrote:
> Syzbot has observed the following race between 'hci_dev_close()' and
> 'hci_cmd_sync_work()':
> 
> T0:                             T1:
> 
> ...
> -> sock_ioctl()
>  -> sock_do_ioctl()
>   -> hci_dev_close()
>    -> hci_dev_close_sync()
>     -> __mgmt_power_off()        ...
>      -> mgmt_pending_foreach()   -> process_scheduled_works()
>       -> settings_rsp()           -> hci_cmd_sync_work()
>        -> kfree()                  -> set_powered_sync()

I guess commit f53e1c9c726d ("Bluetooth: MGMT: Fix possible crash on mgmt_index_removed") [1]
is supposed to fix the observed race. Is there something missing?

[1]: https://git.kernel.org/torvalds/c/f53e1c9c726d83092167f2226f32bd3b73f26c21

> Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf

Btw, `Fixes` tag is really desirable if you are fixing bugs in kernel, like
KASAN splats and others.

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
