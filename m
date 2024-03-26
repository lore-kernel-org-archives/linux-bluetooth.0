Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AC13D25C
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482638; cv=none; b=D61CYU4g+lrUxn9LURquw+i3w2TXTUiXQEnF07CZJhfzX/TcMnBXAHJokIml7tijqAGVEHrmKLYQEGo+2rgAiNIWY41S8/pu0v0U2tc5Zn0EawXG3mqW+jj+kkrnwHt8mdb76ovUvVlvPanqZ3T6hgEOQvCHFf/vFkRnjfXnOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482638; c=relaxed/simple;
	bh=cTBLyIjQ4CssK1la7/mUTnd3Bp/kCDEsv9p4m7uJTB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XNVLFeFHEGzsobSW/p7NLz+UyH7cbhXpO1u32s1RNfEJJPZILyjOVIFyQRShYsen1fN5bMDLa2rs5SwJydYA0+5H9uSFEP5zYg3Xv8QaLkh5/42b/KI/GrFiw0xSJHBUuUVZhgNxN5W84MldTVYkfaMfNv1RdOzCm09L9oQ56kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8Boq3B4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8Boq3B4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C524C43390;
	Tue, 26 Mar 2024 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482637;
	bh=cTBLyIjQ4CssK1la7/mUTnd3Bp/kCDEsv9p4m7uJTB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A8Boq3B44P4Uf+BfdEnS71zsVcUmpl0tdWAvuPxnYdHA6Q/ytXA19mY4u1+ANNzyt
	 YFMYtd9F2V97GlEEjnsFYPFKovdB6rN3W/UA4xIZMdlGjiCkRjywXAo8ISML+Hg3pE
	 RcV5T9umu3nhChcU9T0tu5PNpi7vnyYP/G7EIL+D6Ben2pQCsELHQqGeD+n7wiRXMt
	 rTTNDA1CiWHY4x1IuqfA5d3r1ql+pPGYQl8r+QsyN2KwRHnx+aS/foLaIBXCkpZH/U
	 3rSYzP132tc+sezQcLoDxQGNOOHMojXlD846G5yU5mBVLDZijTGdDC5fepANDOwO8z
	 rkvIKY42T9dHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AFDFD2D0E9;
	Tue, 26 Mar 2024 19:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not checking error on
 hci_cmd_sync_cancel_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171148263736.22204.6662439741909879492.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 19:50:37 +0000
References: <20240326164317.1460864-1-luiz.dentz@gmail.com>
In-Reply-To: <20240326164317.1460864-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Mar 2024 12:43:17 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_cmd_sync_cancel_sync shall check the error passed to it since it
> will be propagated using req_result which is __u32 it needs to be
> properly set to a positive value if it was passed as negative othertise
> IS_ERR will not trigger as -(errno) would be converted to a positive
> value.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/e9c62fdc7f3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


