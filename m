Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F01BC58
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338425; cv=none; b=BcqJFo3IBIyR+tLc8ZK+LsaJyHA7UnCkkz3+wXnIfRpS2uus6vukLcaT5tBCEeeuUe5/F/IH5k8lmMnJRj4m41jT1uD4oby8E1Ou5ZovPauNofFMHNiSqoDwhxrrhPZIFGv4p4G/uncrmntIxQmC4bcu77mgp8X+3sSXq3w5GZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338425; c=relaxed/simple;
	bh=4jiSW92+Bb9q7+7376i2nMtCBynV8Gk6cLiR0XpSFVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QrcpL9xTCufb2wyYcrRgr6hrarh/6HIIt2j7U+5hZKVGqei+Xulh8DBZbyO7S1TaWGhefWVXXwmKT3pH+S1c8/Ir9yXi9xKNIHG537TjojvT0j3NdD3zHWiy4OyYctgSMNh+BIfe20AZdMkNlIbJI7DOuRBl9ZUPKCdIXUPUgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjtphGQR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjtphGQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3C6C4CECF;
	Mon, 11 Nov 2024 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338424;
	bh=4jiSW92+Bb9q7+7376i2nMtCBynV8Gk6cLiR0XpSFVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jjtphGQRWCmCes2J9r36/yH67F1sFjtyFc7Zhmi7KNHeMtIvMpzh8s167CFVZqhfl
	 9zee3aZIFu6zXDLJaHQcoGzqPeyU5VMv98efPgmeJprECvVP19PLI7D6m4XdLDhnJZ
	 ZHmBVf8twnqerXg7vS79a4YuVApcrFQz5XY+LQM5aiNMtFPa3nsc3CRqDXgucAnpdp
	 62Nzg5mwmd7+WWTFYISo+WQRd4QItq8qESGSHY9jZMrowS3Ue4iEjQUWvk7Yt+rGJy
	 y7EFdOQrIDSXNbRhxQhBvsWe/zAXfX2r1eLC2co7iwfQK/riqpOxaepYQv4VRp0YAZ
	 hGcQtoFNDG8DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1CC3809A80;
	Mon, 11 Nov 2024 15:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Add Newmissedcalls tag in PBAP GET response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173133843480.4067431.6612368228241780036.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 15:20:34 +0000
References: <20241111125518.2039073-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241111125518.2039073-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Nov 2024 18:25:18 +0530 you wrote:
> This fix is required for passing below PTS testcases:
> 
> 1. PBAP/PSE/PBD/BV-05-C
> 2. PBAP/PSE/PBD/BV-17-C
> 3. PBAP/PSE/PBB/BV-11-C
> 
> Even if the new missed calls value is zero, send it in GET response.
> As per the PBAP spec, it is mandatory to include Newmissedcalls
> tag in response incase of object name is 'mch.vcf' or 'cch.vcf'.
> It will be better to include it in all GET response.
> 
> [...]

Here is the summary with links:
  - [v1] obex: Add Newmissedcalls tag in PBAP GET response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=639fb80032cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


