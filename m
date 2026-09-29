Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8D753977C
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694632; cv=none; b=Hj9NbM7ahM90LTBulrH8Yl4axNKH8Zwwb/Lxw9ZjBSG4N/hFCZOg6jc4ttVeVw19JtJIoQ4CFQ7BPRAfNKE6xiANgl6P2XIjSjbzfcsytPYgDaTMUZhsWkBLBCkf4C50gh9Qp1hcPkdZH5q64cG/4ekyuGnmfE9ED1+/hFRBxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694632; c=relaxed/simple;
	bh=SOakISTCjsRw9kZoRiqGWdEuaILUaxtyuKzpOk9fP30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUTH9qbNMNWNNJdwqDknPW4WeWa0HBWxr79jemzh4K0kERHRDeIDXHZ8/yutLbrd+U8qD8IbI8MBKI0PcWUTcj8n8RQUSH2oSutQE89wpX0mtQDKiMvqIpxoROWkDgKFQgmJDKURtrKYxvYe9YzMESl51jpV85IOqojpwI4+FMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqX4xZcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqX4xZcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8018C1F000FF;
	Tue, 29 Sep 2026 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694610;
	bh=vcqgckVrCc/3YHunqWai6wqQES2mgxBjYbZD41f2g0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JqX4xZcHBVz3MtvNzrGn2qU+Li8+JvtDNkDqqIWRBVcTyRoH8Zi4WHWCBeu0ZfyNd
	 OlRpSTb2SYZtBDHNhE45OneMrDL8ZH4Z0S79NqyeQ+Gn63oyRTSbZgTLOgkMwZaRkk
	 gxECEgT89+aSjVFWXFjnLrp6BMMPvk8HUayriQ7ivSlC0lh8eBq0A00o1fNcL0Gu6T
	 Qs4q+MI8eiSwr6+j6zwvCIflYUDqVMcXCYtAU7s9ydbVMyZ9oXq+xE6seQpAnLxnOy
	 dzn02dl8bX7rYoWiga/xsm2BB6eVyayFHY/cXUqtViWB4Z1kAIF29X69TuXsSAX4U1
	 BqI9L+F61Yehw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773DE3927049;
	Tue, 29 Sep 2026 15:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: fix TX descriptor bounds
 check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069460911.983246.4722326207131032001.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:09 +0000
References: <20260929065641.2936267-1-ravindra@intel.com>
In-Reply-To: <20260929065641.2936267-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, kiran.k@intel.com, chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Sep 2026 12:26:41 +0530 you wrote:
> btintel_pcie_prepare_tx() uses tfd_index to access the TFD and data
> buffer arrays before the index is advanced modulo txq->count. An index
> equal to txq->count is one past the end of both arrays, so reject it in
> the bounds check.
> 
> Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
> Signed-off-by: Ravindra <ravindra@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: fix TX descriptor bounds check
    https://git.kernel.org/bluetooth/bluetooth-next/c/baa53af641c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


