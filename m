Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E73515D4
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930462; cv=none; b=dDr1A6H+ErUea8V5CvIl/v9cBxEzjgsuTAbqmAQ9+JA6gmI531V7IOT9rU0RIvtwleIvZP9mwYv4lZj6qqZRvlJ3QbpWmwfuBQ9VDYeRP1H7Rqx9/DQ1ZrTuG4iVixaGgxuH7pxP2Mm/NWc0YzG21HdURfztzXYNU1Mf96WQGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930462; c=relaxed/simple;
	bh=gtej5XXN2TDNpJJXWGwSHBMf5wv6wtrAg5TVPqUu9qg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FJMaBn7XVbBXlwgqHGET54cHT1V9nMrutCu6aBp1gzs6wnl2buXVnygiNOA8V/qenJZ/b03/Z17FixN2gqw44XPDVXBiB64QqnXrKPjAAnwzSmja0/0u3gZrhxfcoQRiwhl6YHBEgJ8/WAkHk2cGQJoh2FIWKHt1OXUfa6J105Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+Hlch3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+Hlch3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE621F000E9;
	Fri, 28 Aug 2026 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787930459;
	bh=4B/mzpLw+hNYisDWqoaRKHAq4m81O+pws9snzX2aHEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h+Hlch3I6GFD7dA0ofWVP6XN+gt5XRB+b1lXB0KvmhKB9HqpLy7G3UFNstAuVnNpM
	 6hvVvsX4E+PMT2CtLA7T8nHUvS41NHbQo1aNeI3zrEi7ZjL784xnRFWVqpAT1+RFbq
	 ITFGGuDhQGvYhLN1T0g7KhUX8s9pX559klJrk/921J4XZu9uWE7mEqw5B2wUJoF9+H
	 UTh+WAt4OmfiP1r8fuveSTR2KsmyBE9z4KGe7ButVSK6qV9NAAI7v/gSgGKvTPQVh6
	 VS5Bc+Gvl48C+dUOupugunOnn1wcZ9L3wBnAxCAEMylfu9KKpFBJz7FMuhBw7dG6de
	 +7wu1jUeJdIoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A94380AA4C;
	Fri, 28 Aug 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ, v2 0/2] SECURITY: Add top-level security doc
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178793040464.2650225.12054190440172218509.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 15:20:04 +0000
References: <20260826132610.1021538-1-hadess@hadess.net>
In-Reply-To: <20260826132610.1021538-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 26 Aug 2026 15:19:04 +0200 you wrote:
> With reviews from Marco Benatto, Senior Product Security Engineer
> at Red Hat.
> 
> Changes since v1:
> - Added mention of issues that can only happen using vHCI, and not
>   real Bluetooth adapters
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] SECURITY: Add top-level security doc
    (no matching commit)
  - [BlueZ,v2,2/2] doc: Remove obsolete security-bugs.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e8141342284b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


