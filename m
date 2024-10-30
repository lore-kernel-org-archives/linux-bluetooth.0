Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930E1E411D
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295626; cv=none; b=cAdRRWk0PHAkmDEXQL/A65D4HM15jqmMMKPDD0wBLHzK8jqXBY4wW7/4nZh6GvJRe9OcmtmkRKabDe3nrxxB9Ddof9dbQb6tT4l5CDoTO9MWiye8I3ZEg5l5Qs6j8rrCR6rn9BWDffE4SLiTFIfE9FtpH82V9hEkfa3/rG4rtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295626; c=relaxed/simple;
	bh=Pa1B3KigOvx7bjynTJGkV86AgerR97Thkz1q+Pn41yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sdfefFueTiyVy7pzDufJ1iKbWMUqh7Kk+H5SaU+TcJ4Fy1Wo1ZvTrkMnLGLHO+6dAeuyxsdgsbQgN5h1XMPLolrlrB2CC1KtBYUeUo3qdH44rzhmE5zgw1ZJ6hoeeHwEWYETQIJDiuqdIpqVE9fe3MuS87Ywk5HsvLXAyKj9awA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA1wZtey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA1wZtey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C2C4CEE3;
	Wed, 30 Oct 2024 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730295625;
	bh=Pa1B3KigOvx7bjynTJGkV86AgerR97Thkz1q+Pn41yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vA1wZteyMJwVywUfDDNdAv+LjuBmpvYngakWTkTiWzyOFxc3oON4kErTea/XmcedY
	 FKjw6RCmKd+ICopWIM5QmQiinFAf2MvBbJRQiVn/ukILD0jz4cb9vOZuGG3IXeRRfK
	 FxHP4PetcaKoF6sIDbH7AyFKcgBvzosMKSfRPYA1ZZUAhapXH7mpOR83Em9Th9PZBP
	 yJQx7H4oxd5tlf0FdrgGJb031dfriXfuWz/pKDeMVG3L6vHsvZivRdAbws3Rvpczzy
	 v0+nLE16spECywtf0oivybQQjz3S1bL0AbU0HyJuvMi1MdLIunV/babV+FlkF0e8gq
	 W/z7bR0ouaLpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6CF380AC22;
	Wed, 30 Oct 2024 13:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/3] gdbus: Add g_dbus_pending_property_get_sender
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173029563349.1342841.4710371445634998970.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 13:40:33 +0000
References: <20241029204132.586663-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20241029204132.586663-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Oct 2024 21:41:30 +0100 you wrote:
> This function allows to retrieve D-Bus message sender name in a property
> setter callback. Message sender name might be required to limit write
> access to authorized clients only.
> ---
>  gdbus/gdbus.h  |  1 +
>  gdbus/object.c | 33 +++++++++++++++++++++++++--------
>  2 files changed, 26 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/3] gdbus: Add g_dbus_pending_property_get_sender
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0cd34b181587
  - [BlueZ,v3,2/3] transport: Allow to set A2DP transport delay property
    (no matching commit)
  - [BlueZ,v3,3/3] doc/media: Document policy for setting transport delay
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e2e439156ae5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


