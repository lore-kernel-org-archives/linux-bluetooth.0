Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F22BEC2D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377221; cv=none; b=R7p6mkQgfBvTMu1YOzEK8E+pRfp79MS3zjFQ7BgsS1+PL+Zg+ZaSzBX+VB42PMCFzDzyKx48UG9gHyehMIAMLuLPpFFXQN9+ACzIv8k9rhQ3fj7zc3xd1qnrS5GMobZb/lEkJqUhPc/jocsjap8o6aW5diq8TPnOx1PQYj/OOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377221; c=relaxed/simple;
	bh=xN592BRmhMa89b2Dbzq9kvuGT3puWHFnU4mLnuJFJAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZSGKP3ykhR8ykTf7fZaH9TOfqp4jthpZgM4QRa7NJ5Sk7uM4s2UopzGnXhU5kjMdxE9OZWcKERXeJHHHyOoSzH4ODnIfdO0vcL1jpwVfo2SRS4NM9jaBslzbEC3rBqxIr64KtTQYPOA+1X+RlkaASFP5yGayu7xm6F9DzUihKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEubL8LH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEubL8LH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE66C4CEE7;
	Mon, 13 Oct 2025 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377221;
	bh=xN592BRmhMa89b2Dbzq9kvuGT3puWHFnU4mLnuJFJAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FEubL8LHOdFLqOV3vEA/wJlxRaxJBvXlYLE0GvkzXRTyGjSpuyxCKPqVH3i1GBB7E
	 Lsy6uZL7ZubBi2oJZ38jApcvg5d8POIKJPlf+7OxEM3lzSzkEvTyVdHDu4npCa7YQh
	 +YKm+D4KklgzM1tMYXkgyMLTSA+GtvlG58gLRhv93KOl5xuLBmpt8Av0PBH0KsXBbZ
	 O/BiFJL0SFXUAJeN98TBSJ3ZrPtUHEg6X5Lym8BsEmDX7sa+6nxDPn1soeD8vj7KFU
	 kL3Qhq24MskGEaOlEE+xsgvQqr4vPEiZFhpBYEoReJ6ECZ2bV37sUCYor3DoewFFff
	 sBxCpesvGgkRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34828380A956;
	Mon, 13 Oct 2025 17:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Add 6lowpan-tester
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176037720704.3150041.6926741718800601678.git-patchwork-notify@kernel.org>
Date: Mon, 13 Oct 2025 17:40:07 +0000
References: <cover.1759702519.git.pav@iki.fi>
In-Reply-To: <cover.1759702519.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Oct 2025 01:17:38 +0300 you wrote:
> Make a basic tester for the net/bluetooth/6lowpan.c implementation.
> 
> This module doesn't look like it's much used and locking around
> l2cap_chan / hci_conn there looks suspicious, so probably some tests are
> useful.
> 
> Here just simple connection / disconnection and packet RX tests are
> added.  Some issues appear to be there:
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] bthost: handle L2CAP_DISCONN_RSP and remove l2cap_conns
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=05f3aab743f0
  - [BlueZ,2/4] bthost: handle L2CAP_FLOW_CONTROL_CREDIT_IND
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e17f888c840
  - [BlueZ,3/4] tools: add 6lowpan-tester
    (no matching commit)
  - [BlueZ,4/4] doc: enable 6lowpan in tester.config and explain in test-runner.rst
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


