Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA32E1C4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597804; cv=none; b=JHq1yxRUZC8X486Ud3g5xjzmAnkD3aEL2iSQ63c5pYmbGzh15mNOgXTFTxrwvKUieKMErcheMJZsksvcUioGCyma++ykH4EyiXgsPkgxz01J9tOJAKPH5+S8HvgfELTNfmoxzpkRB1PK6SnoRlpB5Z/FH8cj25juSP2KkH2ohvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597804; c=relaxed/simple;
	bh=F9oC/FU1z1mskoQPIZAUm+mjZK+nyoPjWN63uMInARE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aAGnUVd/N7u/4Fcay5jNP6OMJxI+ZjSZNF+3+bloawjho/7vxzyPeN6RFg61HD6nqqQJ8sDl5092Jf0OE0OcAbxF/2lPmKK0awrTuke6gYRRDQ2/oVLArtYPGiSiCP7CHz7UAI0KgnX2UHKrHdkz5k8engRybRrB7pI+uXcEh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0KKcR3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0KKcR3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A461F00893;
	Thu,  4 Jun 2026 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780597803;
	bh=dtShf/sYqyhiuesqZvUedzK3WnO+OBXhLP67ONWFbTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=o0KKcR3jezxh5ZyPB211wLYB6MttY3Rc5NGg1zv3qwRyYIZEygnlBqF2SqUqutlWx
	 u37daXJ/RglV/alJKOJ0/Jd0xI7b9494NQoK63rWR5yYBeXaTxZgCUDzP30+m0jRy1
	 q4ZAEEqKqM3xUXfN2mOFebMjvqmN/B99fnpnuVy7+vWFUpQvmtc/PtlWUBFiYlLH7V
	 nhPfa8zoA96nC5CaVjTaW4QES6c+qVC5t8eAxkKESwTfPE+Vc4ZlTmllX1bwWQ+148
	 RXXp3+5/UfolKNmreR5xCjiSiXcc/bLX3WjDQVz0QdKXxJMfzEV/xL3r/A5cqBDBRn
	 vglPR8XC4JFNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8405A3930A14;
	Thu,  4 Jun 2026 18:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] adapter: Fix using case sensitive strncmp for
 pattern match addresses
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178059780440.2972338.7011698971696114731.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 18:30:04 +0000
References: <20260604171933.129638-1-luiz.dentz@gmail.com>
In-Reply-To: <20260604171933.129638-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 13:19:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When matching discovery filter pattern with addresses shall be
> considered case insensitive since its binary format that can be
> printed using either upper or lower case for the range a-f/A-F.
> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] adapter: Fix using case sensitive strncmp for pattern match addresses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6bc42d69661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


