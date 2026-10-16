Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21452FE4F
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165217; cv=none; b=iZZzrGfPIg6z8WmbC/uanj9erqCdov6QMLDcMFQiCNDWp1MuwPpgMjAl0h5ItFomE8AsnySK8zKpmDJOx79agX6xBfDI54r35lXBAxOyecmtmIQLU+5I2tmzkhJs93040p2PzXVsGqDRlQEYc6XGSvv93eOBUoSXwdGuPDUeSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165217; c=relaxed/simple;
	bh=LIZvuSbbg64gKocqYPp3uow2UFw3CCUJMhc31PgY37g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEkUwNLZUWnoAdTnf+lUjs8ga/4BXWeedUmR1OJCQq3DZZfuCgcZ2WZVctNwaGop7hZO8fvNi22cR4rqoofbliNK+eTsgoyoyACa9qmYTL03jgXVAsy/5e6cjRKv6ETk6oqMCl1t+b9o5OQvfaCEXhModCAnfK1Ue0m/L9prgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5Jivk8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5Jivk8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EB01F000C4;
	Fri, 16 Oct 2026 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792165216;
	bh=CsyoLztQ3S8qBOeHwZ/krRNJg2/3/C212NrhEKJiR8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A5Jivk8gWi0bNYVOC470rcQLaIrnh9dMV5c3cz909CC82Be8BgcNoWpejMv9A+CEv
	 Dv0SpS5ilUK6Ghn6Jk6N0363+nxdjozAqqN++vU6qoxR1CVQk2Ypv/lW4/Y3z+faAT
	 9T7mOfLmXi6rFkF0ezK64wKTO316JIdaSPh6E2yKQkAG4e4IRlM+cL9yVOztfY/3r1
	 w5PcISY2Tbd5Y2ENY/IDCyrayEhGkZYuRkcXIzyG9C8uPicruGvUEUS8nSiv85vFuV
	 +Y1awAZ7cvacFVGaVRaWPdxUL2IaEP7talfJ7N4yMA6cP7G7T1wmQPgHc2OFP8xoX6
	 yaiDkKRxoSIFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3D4380A96A;
	Fri, 16 Oct 2026 15:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 0/2] Bluetooth: add hardware rfkill handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179216521476.826981.15138353307358957117.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 15:40:14 +0000
References: <20261016025921.1719986-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20261016025921.1719986-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Oct 2026 08:29:19 +0530 you wrote:
> This series adds hardware rfkill handling for the Intel PCIe transport
> and the Bluetooth-side notification path.
> 
> The resulting flow is:
> 
>   transport hardware event
>     -> hci_rfkill_set_hw_state()
>     -> rfkill hardware state
>     -> hdev->rfkill_block work
>     -> HCI_RFKILLED state and device power handling
> 
> [...]

Here is the summary with links:
  - [v10,1/2] Bluetooth: Add HCI interface for HW rfkill events
    https://git.kernel.org/bluetooth/bluetooth-next/c/09399227b038
  - [v10,2/2] Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow
    https://git.kernel.org/bluetooth/bluetooth-next/c/f600f753cc32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


