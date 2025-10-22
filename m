Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A934B1AD;
	Wed, 22 Oct 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141033; cv=none; b=sVRQekfvqjcDlmKfvtzkNSnkKgD6agDNmi/8Ltpyjt3lBPdlVN9yNLTT5PpyA0D75gSyPBUjl1fejLxg+pvfonJFTMaV5iyMN5CmzomOidDLhu98UXkp549v1K5lXR5mAmJNZ5lFyfk4saXd9IPSKSCn6HXc3Of5J04g63osn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141033; c=relaxed/simple;
	bh=4bqIxQwaYwiGicJXcXxKfKTqZFmjRYMc8Clxky5cxcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hja8QR4bmaaIc7Vbzx4z/0xXo2DV4eWG3e3s2SzyPyz836v2gEj3wL+d631ltczRNy6m+rHMwmo+L/6TZoKFOzeU/Qx4rRr6OTY7i/z7z4OAFQ/7pNuGXCUM61V4mlHVLV+/spT2N7EPenFvnXoM93BtrKRzLonvkMnlenfNVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK+HT6xq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK+HT6xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658C3C4CEE7;
	Wed, 22 Oct 2025 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141032;
	bh=4bqIxQwaYwiGicJXcXxKfKTqZFmjRYMc8Clxky5cxcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PK+HT6xqI/oVLZAk6t66sKLs08HHqVELEU+iFdbPOtLDLM6bo2ljgtegQPaUxv4e/
	 hD4EXuU9Dm+BmBcKdzskHrvc5kYVmu8Mk9JSlYZsyy0H7oLgadOsnKhC99u3b7+O43
	 a2HHPV38hlWvyYKSQ+Qu+KW2/TCEqqsPKD2aFzjp63cYDx/20wUWNbsgnBn53dyogA
	 n2AFtbvS4LPt7iiv6Puph/tM4Xl/EF8J3NzwLw2yoE4Y0b2+NlAfy2HqS4MaP6BDVg
	 ex/00O9+R5r0xBheGRF7fqqdpv0aLJ3aZKY13dgRKPCnXjFRoWbJPxn+uuGz9zV5ux
	 BNpR7CJBeYgeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD033A78A5D;
	Wed, 22 Oct 2025 13:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: Reclassify Qualcomm WCN6855
 debug
 packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176114101324.1909224.4267593158133917211.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 13:50:13 +0000
References: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
In-Reply-To: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
To: Pascal Giard <evilynux@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pascal.giard@etsmtl.ca

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Oct 2025 11:33:15 -0400 you wrote:
> Some Qualcomm Bluetooth controllers, e.g., QCNFA765 with WCN6855
> chip, send debug packets as ACL frames with header 0x2EDC.
> The kernel misinterprets these as malformed ACL packets, causing
> repeated errors:
> 
>   Bluetooth: hci0: ACL packet for unknown connection handle 3804
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: btusb: Reclassify Qualcomm WCN6855 debug packets
    https://git.kernel.org/bluetooth/bluetooth-next/c/dc74e6550388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


