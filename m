Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9715B57D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536632; cv=none; b=bk0P8lLLID/mQAlQtknHYXiFSVegWqFj8EGw/4mU9gTFvJFLeJbW/V3p+IW+cAwNGJU8TrUSCbM4obMGtFaC67dNp8gY5Mc3LksyB14ZnfVBQoIBmI/1BHnv/dZK38MWOjwwxHaota5PPjvku6hGIPclMfUEjEdRzESpf/O3NWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536632; c=relaxed/simple;
	bh=cF+urcaYyzcegfpbA1RY+mRpG5QxSeV9JOuREJTnKts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XR64pvRHLamQlLvEhka2QQ6FOtjjj6AAdX5H8MQowOR3lYm9nWW9j5eMumZvC366bob9Endypt9Y6HASfJTZZD/TI3oP8t46jKCcUeMZpOcU4YUZmz4wggehRbd+DQEY4u0pVkslxB4fvWSHjiT08Z48fiRoi8K20Xp8e1kVPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ9PA3mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ9PA3mk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3086C32786;
	Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720536631;
	bh=cF+urcaYyzcegfpbA1RY+mRpG5QxSeV9JOuREJTnKts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JQ9PA3mk7ULYyV7ZBTiHmQz1JfIMcub3rxdcuOkzp6fMNUm8W5ZhbxLmt+wtHtVSj
	 7mOXpIcfQx/74AxC7AzwHUzQfLtyTX6HLL1Yw9V7Gi51AAUBn0bqMAWtiVHQ+MYtEC
	 YMxZcx/v55g7gJYYAvCEzjoHPdNVUN2o1jjrPpFjfF9c+Acm7nPGLOGVJsQaK8pI5n
	 nuqVse+L4EwX3XCpzYxk8OgMIuxJoZ1oBa0RsxIn6Fnvl1RiDxPyxNIx5ZScPMrFNO
	 Sm277dygIZVFKWwMeFvCSwJMsj5VYOUbam1UTYKL2u7cvYbDsv+9rxmVySjiyXwFdG
	 fyCQOiBEn09Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93A17C4332D;
	Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Add Cypress support for bdaddr
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172053663159.10405.10122710292582684536.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 14:50:31 +0000
References: <20240704101123.51164-1-antoniovazquezblanco@gmail.com>
In-Reply-To: <20240704101123.51164-1-antoniovazquezblanco@gmail.com>
To: =?utf-8?q?Antonio_V=C3=A1zquez_Blanco_=3Cantoniovazquezblanco=40gmail=2Ecom?=@ci.codeaurora.org,
	=?utf-8?q?=3E?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jul 2024 12:11:22 +0200 you wrote:
> Cypress Bluetooth controllers seem to either use Broadcom chipsets or
> to be based on Broadcom designs and share many of their vendor commands
> with Broadcom chipsets.
> 
> Particularly, the patch has been tested on a CYW920819EVB-02 board.
> 
> Antonio Vázquez Blanco (1):
>   bdaddr: Add cypress manufacturer support
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bdaddr: Add cypress manufacturer support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=34aca9a4fbcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


