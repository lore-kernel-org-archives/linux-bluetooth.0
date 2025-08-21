Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75430EF9B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797397; cv=none; b=XwbMOTtw7GAfbqZ68DTX8Aq6uWEH3Ejwwq66gyCkc9qeBMBS8x1KVIyWtcZbTZocRfbByIFDLeSg4feB8AKouBjJojLly4jEUHQ2cf3PRbY2o+3rDnnRgaklxUo+YSe+J0kB14Kadj93KWS7maVWILj0O9enuaehWgmqgoWWHDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797397; c=relaxed/simple;
	bh=T7GXv4fw+hB+D1eTWd3IOEx1btxKpc6z4Wy1fd8EKt0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XXrTDYJHGFofRDeIx82+e0m14vYd477tOzPCug4qCowBKE6UI7S0jMjlwnlzyaK3zMFe63V5fgNuWBkrBrvn2zpvLg3iBjSgE1giKxGhvJ+oVofvGQYOFFL62/3M7EAbAPZ94EO6nMiBny2fNlKHn3K2NgSNiVm4Ok/mxnoGMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id2z6DeX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id2z6DeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43936C4CEEB;
	Thu, 21 Aug 2025 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797397;
	bh=T7GXv4fw+hB+D1eTWd3IOEx1btxKpc6z4Wy1fd8EKt0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=id2z6DeXCgv2A89YuiCAy0YR3Mr1jChac00WAWM3NFRhu3VRrme3PJeoiz9vlJ1lV
	 Tq9qork9N8CRvLI36kgGJe309JKLGq+HrkxBZ9UmQoaMqWJqE+kvYVEZoSuAiKpq0t
	 JMoJeUYJ9cprEJsOSCV6jS+MUPFW9eHx0fzAqYgbcEj6Uq1oaELOvYPqxePh+fqpoU
	 oH+IsHAIP5qJsoYvQD94MaUjB18XQ5Sk5SXc0IBd8GYDQvEG5hrxGmOKvE/cRw9ebq
	 A7UTBkdP3WSDKvrZ0jzVUp9l5WI38mfnY27vZA5SG+TfeF8mGOE515/vvzC5gfFe5V
	 LlQ55w43lN2ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED9383BF56;
	Thu, 21 Aug 2025 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] profiles/audio: Fix uninitialized
 params.subgroup_data warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175579740650.1124304.11801215010500519797.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 17:30:06 +0000
References: <20250820141552.800720-1-hadess@hadess.net>
In-Reply-To: <20250820141552.800720-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Aug 2025 16:15:44 +0200 you wrote:
> profiles/audio/bass.c:923:2: uninit_use_in_call: Using uninitialized value "params". Field "params.subgroup_data" is uninitialized when calling "util_iov_append".
> ---
>  profiles/audio/bass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/3] profiles/audio: Fix uninitialized params.subgroup_data warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c773fd53c953
  - [BlueZ,2/3] tools/tester: Fix fd leaks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bb14a8b18f94
  - [BlueZ,3/3] input: Fix incorrect destructors being used
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4784f58ff0ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


