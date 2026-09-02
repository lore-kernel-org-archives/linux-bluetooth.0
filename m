Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA13EC812;
	Wed,  2 Sep 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338340; cv=none; b=AkziPatJ4ktbQe2ucetkLkkzympdBVn5U2EwagFns8Jdk6jdtDCX6wl963PdWEcoNWaIMC6DAuTgoGWCCaCzd7K73BcFqmCPnWyGlt8fUaOv1gXixmQJMFUfqQ7oV3XMVwyUAb5K0vjfNBvA1TtZ/Oz7ETzc9Y/GK1PgjqR7D+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338340; c=relaxed/simple;
	bh=WfxBg7Bf+HiTB6ngMWEXZD7Yr7SeHQb+UIJiTi0yjnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i82AMTQRR9DdQlr/QNXdeEwzehvVlsBqk71x1pte4soWRZfbFjpyNPQektFIZKjGucWN3E34FKdQGSIk49VRCUk1OSDXAEgugDJ3/WsWbzqcRRg70cJuXrlQbebozDnKfKo/fAaRDgMRZem26BFljjSqRrvwm19vcmu39q1ImVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.42] (unknown [185.238.219.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 776B34C2C37D64;
	Wed, 02 Sep 2026 10:38:27 +0200 (CEST)
Message-ID: <369afb50-3582-483b-89ea-f9b1a7259a4f@molgen.mpg.de>
Date: Wed, 2 Sep 2026 10:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix stale cache in set_dxstate
 fallback check
To: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
 <20260901203818.112189-2-vladimirkondratyev2@gmail.com>
 <d633b7ee-0afa-4fa1-8340-3d7616f429d2@molgen.mpg.de>
 <20260902072417.30260-1-lsa.uz@pm.me>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260902072417.30260-1-lsa.uz@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Sergey,


Thank you for your immediate response.

Am 02.09.26 um 09:24 schrieb Sergey Lebedev:

> Two of your three points I can answer from the hardware, since the
> Tested-by on this patch is mine.
> 
>> Can you reproduce this on real hardware?
> 
> Yes. Surface Pro 11 (Intel, Lunar Lake), Intel BE201, 8086:a876 rev 10.
> It first appeared in ordinary use, not in a test:
> 
>    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0
>    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1
>    Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2
>    btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend returns -16
>    PM: Some devices failed to suspend, or early wake event detected
> 
> One device returning -EBUSY aborts the whole system suspend, so the
> machine does not sleep at all.
> 
> I have to be honest about the rate rather than useful: it failed on 2 of
> the 3 suspends I attempted before installing a workaround, and later, on
> a newer kernel with the workaround removed, it succeeded 7 times out of 7
> with no btintel_pcie change in between. So the spontaneous failure is not
> something I can produce on demand.
> 
> What I could do was exercise the exact path deterministically. I built
> the driver out of tree with one debug-only parameter that returns from
> btintel_pcie_msix_gp0_handler() before the boot_stage_cache refresh, and
> only while alive_intr_ctxt is BTINTEL_PCIE_D0. That leaves the cache
> stale and gp0_received false — precisely the state a genuinely missed
> alive interrupt leaves behind — while the controller still reaches D3.
> 
> Without the patch, that reproduces the production failure exactly: three
> timeouts, -EBUSY, suspend aborted. With the patch and nothing else
> changed: one timeout, the re-read observes D3, set_dxstate() returns 0,
> and the system suspends and resumes normally.
> 
> Full method and logs are in my earlier message on this thread,
> Message-ID <20260830151550.44687-1-lsa.uz@pm.me>.

It’d be great if the thread could be referenced via Link: tag, and also 
the problem summarized in the commit message including the log messages.

>> To me it sounds strange, that a register name *boot stage* should
>> change after the boot. ;-)
> 
> It is a fair reaction to the name, but the register genuinely carries
> live power state. From the driver's own header:
> 
>    #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY  (BIT(24))
> 
> and both helpers test that one bit and nothing else:
> 
>    static bool btintel_pcie_in_d3(struct btintel_pcie_data *data)
>    {
>        return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY;
>    }
> 
>    static bool btintel_pcie_in_d0(struct btintel_pcie_data *data)
>    {
>        return !(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY);
>    }
> 
> So bit 24 is updated by the controller on every D-state transition, long
> after boot. The name describes the register's original purpose rather
> than everything Intel later put in it. btintel_pcie_resume() already
> re-reads it for exactly this reason, which is what makes the patch's
> change consistent rather than novel.

Maybe a comment could be added above the macro definition.

> The re-flow is Vladimir's call and I have no opinion on it. If a v3 comes
> out of this, I still have the hardware and the test fixture and will
> re-run both halves against it.

Awesome.

Also note, gemini/gemini-3.1-pro-preview found the same issue in a 
different review [1].


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260902042840.2432862-1-ravindra%40intel.com
