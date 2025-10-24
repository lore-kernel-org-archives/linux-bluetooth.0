Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34226CE3C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337828; cv=none; b=jPz8j8DGbl6ktnpKNntz7D/RUtZp8uODJPhdvBoMeDimHUpBmdM3/arcDqd4d3tfK3uB35uNTETdqMO2JIIFkzY2IWRStkklRViWt708Ah5LADxLtlfQsI3Cvmy4tyIeXwaOuQHEqVRQdOj3YRH+MJ+g9/V3++af7qpQx/SlE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337828; c=relaxed/simple;
	bh=2lzvZ3xZDHkZsEgyItmioihUl0Ja7G9KmUj4+P/oUD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XcOQDix9pqfjWBvQjJOB+eP2Pji1vakVuH9FALNAio+d+w7BcjDpMQGfWDDtWAEnQIqiVfBGSDPIK8OR3voUscC0b0Z4jCfLF2jMpMSQsP9u0AdbAwpxq9KOd6iT0wruc+31j2OuOoEW0lqmrjXDMExvD9vVLMwEUlOwABecshI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeBxy98j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeBxy98j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEB3C4CEF7;
	Fri, 24 Oct 2025 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761337828;
	bh=2lzvZ3xZDHkZsEgyItmioihUl0Ja7G9KmUj4+P/oUD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FeBxy98jWwHNVlN0SKGmNB5BihPgKCOpdp3O2cHSu2G6TBKqezWV0cFoCgcbj4+WZ
	 sWbWSgghk0AaaHQJXh187QOmjs9iSg98MdLlJbiEscs7zffqmxIdr2lhlz7J1SbnDH
	 cm8HmnlXmHOl853m3ZVHouXt0CDTsA1rPBCtdwlyoxXCmVcsWSvIQ4VNZo3Rt7+enE
	 OiCKquJbItRfA2vxfFMY7cyIBuoN9m2Pt8pJDTOqAR39NDowjOlK7I/ePJm9UZUuQF
	 H+1efNSSyzFu13BGBZfdUajTScDFX0aiaZl1TWipOvi0wy4OXjo2+OyniZAc0IT2Yr
	 YtkD/QJR9B7fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E01380AA4F;
	Fri, 24 Oct 2025 20:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 01/13] bass: Only attach client if initiator
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176133780774.4052182.3184282346368820547.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 20:30:07 +0000
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Oct 2025 17:00:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes calling to bt_bass_attach conditional to being the initiator
> of the connection, otherwise both device may act as both roles which is
> not recommended.
> ---
>  profiles/audio/bass.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,01/13] bass: Only attach client if initiator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=43aed48c30da
  - [BlueZ,v1,02/13] device: Add initial support for setting DEVICE_FLAG_PAST
    (no matching commit)
  - [BlueZ,v1,03/13] bass: Add support for setting DEVICE_FLAG_PAST
    (no matching commit)
  - [BlueZ,v1,04/13] MediaAssistant: Add Device option to Push
    (no matching commit)
  - [BlueZ,v1,05/13] shared/bap: Add bt_bap_get_db
    (no matching commit)
  - [BlueZ,v1,06/13] shared/bap: Fix no calling attach callback on bt_bap_attach_broadcast
    (no matching commit)
  - [BlueZ,v1,07/13] shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams
    (no matching commit)
  - [BlueZ,v1,08/13] gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter
    (no matching commit)
  - [BlueZ,v1,09/13] bass: Implement Device option for Push
    (no matching commit)
  - [BlueZ,v1,10/13] client/assistant: Handle assistant.push to own broadcasts
    (no matching commit)
  - [BlueZ,v1,11/13] client/assistant: Detect if object already contains a valid BCode
    (no matching commit)
  - [BlueZ,v1,12/13] client: Add script that setup a broadcast source with 2 BIS
    (no matching commit)
  - [BlueZ,v1,13/13] client: Add script for testing Broadcast Delegator
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


