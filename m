Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD6270EDE
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688199; cv=none; b=DHRJSUXscVr8NHiIkpGG/p7DoO3Oq730u/kqKQSM31qwo108/Z2IXEF7ua8j3gJXO+i31koacZdLK5qMgyCtelbC/nSyESGg5tSU0HA6bO6/cPWfVo5hZ9RevCDm5BHa3gmPG/om0+o5OFLBey8Js/AbGME/6kdxvzicxDU3VHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688199; c=relaxed/simple;
	bh=owD93efJSOHgysb/7fiQGFcVppNEmSLa0aASk/eoN/E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iIDsS6BKlJkoGNdJ9LMTY30YizsGo7ZxcRYTvvMd3yxdxCEqoC5w9vVmYgTKNPrR7XigoI58tLTOq/WDFez296B/yfw9b8YAYghC+7sBnHIgi4Eq8+vgRJfbYeN4q+2GyzT8IxODSQCjOzuVtETyZxjc2SCZPdMshV81Dzp4GC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9ri38M9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9ri38M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF600C4CEDD;
	Thu, 27 Feb 2025 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740688199;
	bh=owD93efJSOHgysb/7fiQGFcVppNEmSLa0aASk/eoN/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9ri38M9LD2ZhUVmzgujzG/V/9bza4GcBff29kOnIEbwnsnXMdPhaObpKZV29hLT3
	 wTGkfpjH30GjVCKQHRLhff9LnIuSOpN0qhcWnOj4I0A6GafcIJbZBZmjJxhkOuzbmI
	 VsMWDtHl/7ei3Mq7f5JXp3Qp3jRkO6t2PNEGwQyClSB2KP2EMU9+IsTq0PEGJat+qT
	 +dbnJm78R6NnhzmLBkXRBkJnTbDC6odMhv/4mT1gHLswAxY6UpgFvGof5Dsh4xnBOO
	 sjFtfY8jOoaSXKg/HDhcq7k66CzefYr79o1ceMqwzQxqUJZ3lJEoN+w1XElbkhydri
	 fez3BcI9tHLDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7B380AACB;
	Thu, 27 Feb 2025 20:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] oeg.bluez.Adapter: Fix DuplicateData default value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174068823098.1556213.17109899955004429051.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 20:30:30 +0000
References: <20250227182832.3228513-1-luiz.dentz@gmail.com>
In-Reply-To: <20250227182832.3228513-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Feb 2025 13:28:32 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The default is false not true.
> 
> Fixes: https://github.com/bluez/bluez/issues/1113
> ---
>  doc/org.bluez.Adapter.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] oeg.bluez.Adapter: Fix DuplicateData default value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f901b537716

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


