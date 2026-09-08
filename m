Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9C5A9870
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895275; cv=none; b=SjhpJ4XNZD2jeE4BvO2tOhSLSLXV/ZeIh0WVTOCT2GOXi/3hvfHs5oGeybtYrFxkRIiBUarOrjDeyJZahhME713N3wpugzP20aD08BC0Qye6SbCYQS38Z49Awc4ePDIIPIQADFla3GwmUkuc1/1+voVg6t0UmODoYtd4n6uiXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895275; c=relaxed/simple;
	bh=sTb5tUHmrERUINg2ULTSeBOfHpT/25HgFxxhJ+mg15A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fU/5bCIRUKo0wiCrIQqxOEZ9Ndna/EYRKT9HiACgT7snN2sXIY9z1It2ajIYIh2JwelWnxJWBZsKisTInpsm3Ymc62IA3ZNlzMLazsN2qWIFh779WLnlMIhaT1tVi205ZmauuoGRtZMhz4xnds+oP/2aBVFJCTUR2SKLalX/XqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjB2wDpd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjB2wDpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0981F00A3D;
	Tue,  8 Sep 2026 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895269;
	bh=PSp4pa5+lnAPxFQt7Mg60BSVkFsaGVXl2MBeV5PdVWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NjB2wDpdnvxudfMcWk9lQ2X+nVoKZj8zCp760ZFHKuFENOJUU6bvej6qOt5QnrpNi
	 feZYGA5PKWFOtYdQmuI2z6203zuU7GTNAqs6USKrnd18b3QyIgwwjrfIqkV1TMSCr1
	 Lu1MemFO+7cRLmyMjRddVtI1KqlssEd23HtwF2ldE54mi0I6opq2KyWrUymXMEWDm6
	 0VDqWcRju2mlUc47DqpDnfTDnA93rsBNI237BkOEWyZFvH+ycDUssPiPBP1s5iIIG5
	 lFjT+ivwqsaz9iAwUByxg+F6+kfMcr7NZNdcDrCh/oOat5oDDe60DMs1xHAmiR+LTK
	 I8pesQly/LIAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A21380820D;
	Tue,  8 Sep 2026 19:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/5] avrcp: Fix out-of-bounds parsing of
 ListPlayerAttributes response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178889520813.3704993.10488710039351775103.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 19:20:08 +0000
References: <20260901175315.1348621-1-luiz.dentz@gmail.com>
In-Reply-To: <20260901175315.1348621-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Sep 2026 13:53:11 -0400 you wrote:
> From: Bastien Nocera <hadess@hadess.net>
> 
> In profiles/audio/avrcp.c, avrcp_list_player_attributes_rsp() parsed the
> response using hand-computed offsets into the operands buffer, without
> accounting for the fact that operand_count spans the 7 byte AVRCP header
> as well as the parameters:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/5] avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2cd903e3af0b
  - [BlueZ,v1,2/5] avrcp: Fix out-of-bounds read parsing attribute lists
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f53221015a2
  - [BlueZ,v1,3/5] avrcp: Use util_iov helpers to parse responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c156a406db2
  - [BlueZ,v1,4/5] avrcp: Move response parsers to avrcp-parse.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b707ded72e25
  - [BlueZ,v1,5/5] unit/test-avrcp: Add robustness tests for response parsing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92305dc06ab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


