Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE32063CB
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427200; cv=none; b=Gn4KMCWVLs/dJ3hngbg8PwVOaG3D/k810VSlE5OmQ+al3TGWkh243yFwHpGY+yExznp+z3r84ozyDg4i5DxMLJMV+1SO0aMFXh0DH+0AJd6+qjRCig6iILKIRrmVpbWnSM/YevWWzB2ztfJfogVXGdik8ypCR1DFujmIV3p0jUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427200; c=relaxed/simple;
	bh=Geq22imbzJho6h3hwYxRUrOq4rosQqhPNxUWnw5U8ac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D14PYin8LbrRuKzRn1hR7Wy36Hwhc3G0x6oQuC7SZjoUD//jsvbUNfsBgi2OBDZ7nzjGbyfAUbosiKuxObh3mHOsOiYKkkucvJBXTB7vc6m3cN977KSJzUe9VkmxbB7zy6OqX1rSXyUdKP7s7b3+jvzsJkcnFu1UMuaeSXaOMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awVbs5Ej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awVbs5Ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B872DC4CED6;
	Mon, 24 Feb 2025 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427199;
	bh=Geq22imbzJho6h3hwYxRUrOq4rosQqhPNxUWnw5U8ac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=awVbs5Ejy1YUxBxKhIng3MMhxmg6AzgxLam+OpF1Sy6/TcKKcnlCOs6TpC1A37xaN
	 Qwz1M0bbWQom/lLHa5GVrwtYLmo6kKo5kyXZpTwTBHfiK51YexvF4udAbEY/HQiy92
	 cnx1egIhI86kublNkcKD9Xys59qc6SthnAPCBCyZX7zebBxfO/FN4XXm9lfmSAAd2O
	 UVUmTCQtN44SC5pEaqG5JuVLF8SYjON5Gz9Elie4M2rYADtvomFveyLjdfZtM9r9nJ
	 37/7XRXYCiqfKUAMlKPda35OBIewZnAMV+fA5juvzvsznuFBBZJ6WxCUdzQKaZEgT2
	 hEUbigW3lzALQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB2380CEFC;
	Mon, 24 Feb 2025 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/1] shared/gatt-db: Fix incorrect attribute type 
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174042723126.3590450.3653149369627151708.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 20:00:31 +0000
References: <20250221163139.1705-1-sarveshwar.bajaj@nxp.com>
In-Reply-To: <20250221163139.1705-1-sarveshwar.bajaj@nxp.com>
To: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 vinit.mehta@nxp.com, mahesh.talewad@nxp.com, devyani.godbole@nxp.com,
 iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Feb 2025 22:01:38 +0530 you wrote:
> As part of BLE GATT Fuzzing testcase,if application sends an invalid
> ATT_FIND_BY_TYPE_VALUE_REQ with attribute type as CCC (UUID 0x2902).
> However, this request is not valid for descriptors like CCC, as it is
> specifically intended for discovering primary services with a given UUID.
> When processed in find_by_type(),attempts to access attribute->value
> without checking if attribute or attribute->value is NULL,leading to a
> segmentation fault.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/1] shared/gatt-db: Fix incorrect attribute type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4465c577778d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


