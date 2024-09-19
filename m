Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E13B1B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765832; cv=none; b=Np9R/JbC4nB7RjDd/CrCxCGiThTq0/txhh4nXvWv20bQyX6BF8KlLrAspiTKC1Pls58no6RPQBWJhWTclwTT+L1NIj5fNm/9ZuPNcf/IMZ17IkLQVQqNfjG0vfHh+zEVojNG3CfvgxlTcJkEbfc/5ht5svaD+OBUAxUextdHSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765832; c=relaxed/simple;
	bh=UdngwJhGMEKkam72GDcl3h9vAsSa2PgceGExcKlfGHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vo7ulDeUyXrv2Xebs0hEefMTTUAlHf59pMwFYZ0VwSlk2sufmu9wnS0DJuppeLbssMtNVewc1YATAGSp3Po5L3dPmr7gkZmHeWHLga8oEIGUXVbeaBmeEhsA2GFTlEgXpauV6y7izyI8tPcDoNRQ63136rYeJPMUKIulcRgVLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVgAvNeD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVgAvNeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9244DC4CEC4;
	Thu, 19 Sep 2024 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765830;
	bh=UdngwJhGMEKkam72GDcl3h9vAsSa2PgceGExcKlfGHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iVgAvNeDTed16Haji6JP1aoNcOjWDCjWPrd+A7QHRCBtPixbGAyBWcAh5+DcDSjoh
	 PbofIbTDHXfTOPHV8VdKbHLa8XJ/WBmVzrsjVMpEQZ3YH7YNOm34BVfcWkdrCPwW81
	 5jC1nJlxYgPW5ZCDZyC1Zq7FsLZ1ZT88lRi6RtWaDsH5ZCVnkd1KJObC29biRbXkgB
	 kgGJBXDRcqYawk2TMgVfnqrLMEyqTtcqo3DBShUxkFuuubaxVjAwWSeZT1wBrYDKXI
	 fE3dKoSA6eyN3cbFj9JVC0A6HFOrn8u68HW57sLui1V6YRsiQ7VzQlyKtHVFNcm7UP
	 /U787iTpDtLcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEAB63809A80;
	Thu, 19 Sep 2024 17:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] org.bluez.Device1: Add GetServiceRecords method to
 get a device's SDP records.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676583224.1626973.17300467053285086244.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:10:32 +0000
References: <20240907213301.14000-1-vibhavp@gmail.com>
In-Reply-To: <20240907213301.14000-1-vibhavp@gmail.com>
To: Vibhav Pant <vibhavp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  8 Sep 2024 03:02:59 +0530 you wrote:
> This series adds an experimental DBus API to get BR/EDR service records for
> devices. The method will be used to implement a part of the Windows
> Bluetooth API in Wine, which allows accessing a device's service records.
> The documentation clarifies that the method is only meant for compatibility
> purposes, and purposefully returns raw SDP records to discourage general
> applications from using the API.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] device: Add method GetServiceRecords
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95eb34ee2ee2
  - [BlueZ,2/2] org.bluez.Device: Add documentation for GetServiceRecords()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=44a1930479b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


