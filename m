Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AA1E532;
	Fri, 28 Jun 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598994; cv=none; b=LyvsFVGRvkhNLqo7A4D4jMuvqGydAFL51FqkUTxAypeWTuOsaMqALgYgsDKhkaQ9bzxPsvm4yiKkcHV4NZ3EsoawOeTL+JjQPw6WNmjizHsbeWV8YAiZGRS84q6+adtcR5qgZwRSiLDbAJIv+x6wiS+2SHU+RlSU1faZ2u2TY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598994; c=relaxed/simple;
	bh=cb+WMxhhWTVOUFDmRnkqtfo3qZmA4hA8QTbiIA68f5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=awyPwvmUTNa4dgkIh8iTIwWAFsgoxtkMqgVeV94gcRBZwkJetjvibT7ndcDC2oIxb+BXQokumBszaoAa1X8YgWzkknQ1GOg4F6zqHHe4LlWrkUCSAU9PZXjZT7xlMkIK8s/r8GrlgfIuzYg2mTYI7K0SwoU3eKTAKxzpTOSU01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcxSceGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcxSceGu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A3F3C32786;
	Fri, 28 Jun 2024 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719598994;
	bh=cb+WMxhhWTVOUFDmRnkqtfo3qZmA4hA8QTbiIA68f5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AcxSceGu7L5XdsxF1/H+vDN69Np0bgoLh3iRplpaBdQA2NlqvJtVbwCUQxPlE3/k3
	 xlS9kRtssxDu4rkXRWZ9cSW1BrHJ5RiILa2b5Wff8OKw4TbByHcYXn65TdtaYYaMe/
	 07kpwp3oq2C9KMTDUxFY73wssKY9P54E5rSF+NbZZgd/epB04Wu3q6rPv+pRLWbrhO
	 6/MNNpq60pnpDa3CBKhmDkErtRLXVKRlQ39VPGmkgV5Ltce2xtAI2pLXszArMtCfnT
	 ODq1dogkS2+OaIelCgynZhW00Ap/rcAfKNXo+oDz82EjrqYIDieHRsuZdPvkVb0AO/
	 Xy2xPts8PggPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC5E7C4332E;
	Fri, 28 Jun 2024 18:23:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] USB: class: cdc-wdm: Fix CPU lockup caused by excessive log
 messages
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171959899396.26186.528799806468905607.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 18:23:13 +0000
References: <29855215-52f5-4385-b058-91f42c2bee18@rowland.harvard.edu>
In-Reply-To: <29855215-52f5-4385-b058-91f42c2bee18@rowland.harvard.edu>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org,
 syzbot+1b2abad17596ad03dcff@syzkaller.appspotmail.com,
 syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Thu, 13 Jun 2024 21:30:43 -0400 you wrote:
> The syzbot fuzzer found that the interrupt-URB completion callback in
> the cdc-wdm driver was taking too long, and the driver's immediate
> resubmission of interrupt URBs with -EPROTO status combined with the
> dummy-hcd emulation to cause a CPU lockup:
> 
> 
> cdc_wdm 1-1:1.0: nonzero urb status received: -71
> cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
> watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [syz-executor782:6625]
> CPU#0 Utilization every 4s during lockup:
> 	#1:  98% system,	  0% softirq,	  3% hardirq,	  0% idle
> 	#2:  98% system,	  0% softirq,	  3% hardirq,	  0% idle
> 	#3:  98% system,	  0% softirq,	  3% hardirq,	  0% idle
> 	#4:  98% system,	  0% softirq,	  3% hardirq,	  0% idle
> 	#5:  98% system,	  1% softirq,	  3% hardirq,	  0% idle
> Modules linked in:
> irq event stamp: 73096
> hardirqs last  enabled at (73095): [<ffff80008037bc00>] console_emit_next_record kernel/printk/printk.c:2935 [inline]
> hardirqs last  enabled at (73095): [<ffff80008037bc00>] console_flush_all+0x650/0xb74 kernel/printk/printk.c:2994
> hardirqs last disabled at (73096): [<ffff80008af10b00>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
> hardirqs last disabled at (73096): [<ffff80008af10b00>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
> softirqs last  enabled at (73048): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]
> softirqs last  enabled at (73048): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582
> softirqs last disabled at (73043): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
> CPU: 0 PID: 6625 Comm: syz-executor782 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> 
> [...]

Here is the summary with links:
  - USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
    https://git.kernel.org/bluetooth/bluetooth-next/c/22f008128625

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


