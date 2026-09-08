Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BE4349BE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895275; cv=none; b=FWpgXWXglCByyb3AoD6nQ0VO4TKpiCgsJ9sVzpU21KhXe+igxMhvjx7YqAdADbvN0l6rctCySHoJUI5VaaEJ+Adv39No7CbnGgFEkE7BG9hZKywhhlm7FvVac4Vpj2frxjzGPB+GsRkX0waj9BqXHlJKor+O7MEr43EYwb7FNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895275; c=relaxed/simple;
	bh=9M6ADM1OgUIlS4+Yd5gdrdaWUTe+2UCgtULUPDaLen0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XQ6E58BT/qSkzcXStJzX4VSoZkytd+s1yUfVblo1zJ4HZcwkKc1gBMXJbbAAr+9HsVYNBamk/9knm+rKq6yYrQqxzVI64HYXK51YIeD8xBoCDpyhV9gchp2biQVi0KncgfgDKRzC49Pjzlu1O7hYVFLt7C+ajW2+/fzbluODbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyUen/Q/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyUen/Q/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529B31F00A3A;
	Tue,  8 Sep 2026 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895268;
	bh=Agj+w7EWpcUk5lIwHwAknZ7cAbzxiz8MwI/S8nCOiGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oyUen/Q/iN3J+LkZRl3pYNsY5la2K+rd4b1e/WgxRqgaeNzNx6Zus5mMwe2XVdmJS
	 rhItQ/Grq6K9MFs3qbC0oEGuWG5nssZwk/nTnd1WqF/kabJO63Q/kYT2VnpRAgwrrP
	 K2HXFjI522D0m4hkbfRfXk6gnxNPDZRgPN3VooYXaZ0tz/Y+P+B474tAzzVmWn+S7x
	 OYP9cDfmXF9/g3FYNzgD11oM8UbdexO3xMHjMGEXmSb9kmJ5ZEeB1sTCNEw6ASn9Co
	 68OTeUTx1L0JrZWmSozd0bPLQS3aRNyOoNX+/zHECQung0ug6OLazyx34JGH1dWORk
	 NK7wbNfVOk1GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19843380820D;
	Tue,  8 Sep 2026 19:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/2] client/cs: fix crash in reference ranging
 provider
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178889520689.3704993.715155796199185527.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 19:20:06 +0000
References: <20260903101635.3370149-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260903101635.3370149-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 15:46:33 +0530 you wrote:
> `start <dev_addr> 30` followed by `register_provider /` segfaults
> bluetoothctl on the first ProcedureData signal: cs_ranging_obj_create()
> exported each device's RangingProvider1 object as a direct child of
> "/", the one path with real gdbus object data (its ObjectManager), and
> gdbus/object.c's invalidate_parent_data() dereferences a NULL parent
> in that case.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] client: avoid registering ranging objects as direct children of "/"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ee67b09a565
  - [BlueZ,v1,2/2] doc: note RangingProvider1 objects are nested in bluetoothctl-cs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1d413a73f4ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


