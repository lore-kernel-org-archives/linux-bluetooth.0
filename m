Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ABC54758
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320799; cv=none; b=q1O+Deg43zg7WVjmOKADoGnnArNHRlp3rmnEtkfVeGUa35ByacRJUyfNUBPVxVmqYzJhSytxJEYmDqoZx98rLhz/9HrAkOBSiGarBqS135Bd8U7zZaD82kEs6lOYgwRqJS4+KHTxjEVDWE1XSw3m6Z7yIsT7k9Y5X2J/qUtBUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320799; c=relaxed/simple;
	bh=ktslDhB1n1GpmFpR2mISFnmfT0AD9w9/B/9Gvx32o4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jm7tTPvBZuhbiM5dQd+0rJQ2iWG3z26iDjQ9lzYiC3lxV3Huu/ugpnH/v0rc9udn8PdxW+tAnABndMSBuJi0CU5umcAmbpa6oNN7POxxWGCeO6ye4mv8XgJxptFBvBdlDzrgPDwhYSNnVzXMoOC8o6ve6Av/EhXwIMLSh2K6jlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjjTQQx3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjjTQQx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79835C4CEDD;
	Tue, 18 Mar 2025 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320798;
	bh=ktslDhB1n1GpmFpR2mISFnmfT0AD9w9/B/9Gvx32o4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bjjTQQx3i+QQtbDGx7ThSshJORqCumjBVTLCe7gaB9KkJAG0RwFLpFMHwgZL8jjbQ
	 zmoJ6PGZsXIFJwMTqVFiz4ny0WNjVy+LYTsiCsBMd3K3GAi7Fo7qhA0V0k5W2Epgyu
	 uFA6kEe6WM1v7J4TQFDyJVR1pCouq2sRwwxgLY64VwjRs+Tb9IqL50ReQtWFSK3ocv
	 IP7jg5FgG5uCGuq1RBPg/UixBPkK/pLQLaphYh+4Nz1VuYrD78Alr9ec5PT+9OBLJW
	 MSsG8KSAgru4wvBZ7XS3O247eqqOfeaabop/gjbAy0FkJMfD0N22JySZXvXMz4nQFy
	 E8ivu3sHDrClA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8A380DBE8;
	Tue, 18 Mar 2025 18:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] Fix crash in dbus caused by Unicode characters
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174232083401.406856.11032850769125698268.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 18:00:34 +0000
References: <20250318131431.124750-1-r.smirnov@omp.ru>
In-Reply-To: <20250318131431.124750-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Mar 2025 16:14:28 +0300 you wrote:
> A crash was found during fuzzing testing:
> 
> dbus[5324]: arguments to dbus_message_iter_append_basic() were
> incorrect, assertion "_dbus_check_is_valid_utf8 (*string_p)"
> failed in file .../dbus-message.c line 2765.
> 
> Fix it with additional checks.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/util: implement argsisutf8()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0205edbd29fc
  - [BlueZ,2/3] client: replace validate_input() with argsisutf8()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb1dd2bc1c4b
  - [BlueZ,3/3] shared/shell: add check to shell_exec()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1edffc22a343

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


