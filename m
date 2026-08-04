Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E47080D;
	Tue,  4 Aug 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841810; cv=none; b=DIeviFmNx5cWQTSiEB0AJYpWAGth8gzCtzFAGYD6QkusiGtnsnbfwCxLiB2xus13ugHqX/klo26ud7eBXdPE1vQwng3pWW0C38/NdxhzpYu1CoOxt1jDDtFFeIm8UgM+P7lRP+98CmFS6Zae/Vqgk0n6r2nIzhWap45ZD/wqdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841810; c=relaxed/simple;
	bh=ef7cl9NmMhJzS93n8zytx8dseW0vG0QLZ6VGyBH6Zds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oldN4htwQjibOZSZq1k9g7RS6Hn0l+4iiSHpVCCn0xVf1pG6t6MFk/tYkkNGpY8vlCGWlYJyT6zv2KT+m6FHE5IoTf6i7x8j01tFHEEeLTVhH92k5k0VemLa881vSaMFroKKLQif45hWnoL9eBLVi4e5eSyqHLg3+ezNaJT7KsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.228] (p57bd9ff3.dip0.t-ipconnect.de [87.189.159.243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5D27A4C2C37F03;
	Tue, 04 Aug 2026 13:03:00 +0200 (CEST)
Message-ID: <952fa44b-9ab0-4398-849a-0b5f94047646@molgen.mpg.de>
Date: Tue, 4 Aug 2026 13:02:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: clear remote wake on idle Intel ACPI
 paths
To: Sean Rhodes <sean@starlabs.systems>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Sean,


Thank you for your patch.

Am 04.08.26 um 12:13 schrieb Sean Rhodes:
> Commit 6953217d9f44 ("usb: core: allow ACPI-managed hard-wired

I am unable to find this commit in Linus’ master or bluetooth-next [1].

> ports to power off") allows internal USB devices on ACPI-managed
> hard-wired ports to use the existing runtime power-off path. For Intel
> combined USB Bluetooth controllers, btusb still keeps runtime remote wake
> enabled for as long as the adapter is open, which prevents the USB PM
> core from dropping the last child reference and powering the port off
> while idle.
> 
> Only keep runtime remote wake enabled while the controller is expected to
> signal activity on its own: initialization, outstanding HCI commands,
> established links, discovery, LE scan, LE advertising, BR/EDR page or
> inquiry scan, diagnostic modes, DUT mode, quality reports, or Intel
> devcoredump collection. When those are idle, clear needs_remote_wakeup so
> autosuspend can power-manage the port and a later host-initiated command
> can resume the device again.

Please add a paragraph how you tested this, and how others can test this.

As the diffstat is over 900 lines of code, could you add a paragraph 
giving an implementation overview?

> Signed-off-by: Sean Rhodes <sean@starlabs.systems>

Add a Fixes: tag?

> ---
>   drivers/bluetooth/btusb.c         | 917 +++++++++++++++++++++++++++++-
>   include/net/bluetooth/bluetooth.h |   1 +
>   include/net/bluetooth/hci.h       |   4 +
>   net/bluetooth/hci_debugfs.c       |  20 +-
>   net/bluetooth/hci_sock.c          |   5 +
>   net/bluetooth/hci_sync.c          |   2 +
>   net/bluetooth/mgmt.c              |  15 +-
>   7 files changed, 940 insertions(+), 24 deletions(-)

[…]

Note, that gemini/gemini-3.1-pro-preview commented on some things [1].


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=6953217d9f44
[2]: 
https://sashiko.dev/#/patchset/48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean%40starlabs.systems
