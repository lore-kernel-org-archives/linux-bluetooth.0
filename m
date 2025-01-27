Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEF77F11
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990610; cv=none; b=DcU9qxZITOU7Begx2LQ54voClfkQL04CHpb+x3F2RKRGwLILU3mWS3s+7RUVJVMSHsNQecWGjRzo3cipgpJ2rXHGxTdo8r1jtPN1G0lpmuIpuixAK9q94We7RzM2kDa0vxEq6r1YcfgsLRrMbAwsjqeepenRl1HsJmCBGDhhYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990610; c=relaxed/simple;
	bh=UObvwyz7CYP5ro9l5YEq+iGDDoIogmuIZtVHNA8ITe4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZIqn5AkBf/fko2fVXyLtMt0qKwr+6KhAOkVZvZzBpeDJQmXcaAHZbuv9X9gQMvRrsn6e8Ld/MlLaxc/rcwQ+9IaSW45v4gjNbUbyjJgG1sNA+Wo3Friry+NeIoWeT+61bVHBDLJr1OnSyxXUaIsIWJ6nXbIRLCMJWtuKVtTfNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys+qpUFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys+qpUFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED667C4CED2;
	Mon, 27 Jan 2025 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737990610;
	bh=UObvwyz7CYP5ro9l5YEq+iGDDoIogmuIZtVHNA8ITe4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ys+qpUFf+omdzZoXyuMgO3UZOPB8yeBXua+ok2jBS+WHHKVEEefp1ZKMp208WGaWI
	 Q23fNus1yB6Te25yzcmOItf47um6xYsF+ItreNR3YA5+6HI16KjoVC3MM8TP5QtNR9
	 kFi8C/lk9+NM8ZC/LkBmx4EcHtnRoG8XGnv2HUllibrWaFwIfdg4ZtfFNFucfi6n7X
	 6szufg7qoVtKn5118v9inWfOiSpa8VuGuIii4gzzH3JaosDQQ1ibp4Old+WU1AWdca
	 mwJSNm6YC317srvOHjNsXAbufZrccH8f1Z7Kw/s1SyJOAKkM06JrQ8HL652qxARXih
	 /QN1/mBauvEdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC7B380AA63;
	Mon, 27 Jan 2025 15:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt-db: fix crash on bad attribute index
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173799063523.3128680.16274968694858512912.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 15:10:35 +0000
References: <efe1351374fceccbe4f1392fddab0d75e128a510.1737886528.git.pav@iki.fi>
In-Reply-To: <efe1351374fceccbe4f1392fddab0d75e128a510.1737886528.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 26 Jan 2025 12:22:44 +0200 you wrote:
> In gatt_db_attribute_get_value(), avoid NULL pointer deref if attribute
> or db is in unexpected state and attrib at index-1 is missing.
> 
> Fixes btmon -r crash, on a packet capture obtained with btmon -w after
> clearing BlueZ attributes & cache for the device:
> 
> ==208213==ERROR: AddressSanitizer: SEGV on unknown address 0x00000000000c
> ==208213==The signal is caused by a READ memory access.
> ==208213==Hint: address points to the zero page.
>     #0 0x5af4a6 in bt_uuid_to_uuid128 lib/uuid.c:65
>     #1 0x5afd54 in bt_uuid_cmp lib/uuid.c:118
>     #2 0x5d0dd2 in gatt_db_attribute_get_value src/shared/gatt-db.c:1663
>     #3 0x56aeab in print_value monitor/att.c:158
>     #4 0x56b80f in print_attribute monitor/att.c:207
>     #5 0x5982f7 in print_handle monitor/att.c:4417
>     #6 0x59b1b8 in print_write monitor/att.c:4598
>     #7 0x59b796 in att_write_req monitor/att.c:4627
>     #8 0x59e91e in att_packet monitor/att.c:4918
>     #9 0x4f4847 in l2cap_frame monitor/l2cap.c:2567
>     #10 0x4f6022 in l2cap_packet monitor/l2cap.c:2708
>     #11 0x4a48f6 in packet_hci_acldata monitor/packet.c:12606
>     #12 0x43952a in packet_monitor monitor/packet.c:4247
>     #13 0x4170c9 in control_reader monitor/control.c:1517
>     #14 0x402f76 in main monitor/main.c:277
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/gatt-db: fix crash on bad attribute index
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9f11c1817c56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


