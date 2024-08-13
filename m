Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D01A071B
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564234; cv=none; b=Fcxr9rEB8uOZu5zO63Md/I5XEo3h2foh6rY94OkJNs5+/cyVVWxZa5YXe88+ZGHR/3qABRBZimU13l4bDqt0iTLYNE1cuFjMOJFEUR4vTGvahZKUeNFmRkkyrjOV1ZFFQHenpLfh7ckDfkixeYGXYFhc8wOMXtwzwNHpUa86+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564234; c=relaxed/simple;
	bh=Tuulk4DWW8K/ZOAS63bUEa5rowtVpe/LfyyU3AWxBtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k4t6fnfkIFs2K7D4rbP5SPOs/qOa6qRXDOfYWh2Rm26g2IFwTmqs9KXp8qV3LqOCdm/vwiNxYiuXoU0jc1zUa08I43p6Vosu8qGqMaoNxvwib9Mhu1UNEkHjKJEhZlYh6kds6/WC+FzxxLFvVZJD7KnZsfegQWg+Cbk9ePfcsqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au733dyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au733dyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210E6C4AF11;
	Tue, 13 Aug 2024 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564234;
	bh=Tuulk4DWW8K/ZOAS63bUEa5rowtVpe/LfyyU3AWxBtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Au733dyGZ7/Teexzeik1ODNHiK+QzxnacUi7gfGyW9HTVb2KEMiCAnyfqh7Ge93cM
	 6Yqh1W7P5SGWg/utyYWtKtAYqAjadNLptjEsaTTEWCmW14xhKSmd0332cR354TlDHE
	 NCuvT5SIhAcvvcbLJjEJALlrs6L6uJlfGzoSVY3MN10mhOeGIVgg2xfWaK04bZza9t
	 KCe7od7FSbOrYwqO77ueACL/TOO5I2Z9W7P0orVwlhbZoz4bhSITU+HhjYOtzMVF6r
	 fojY9cUWPLXkSq7YcbDXTlIXguwB9ifBg3ju05t1pMvQIwN6lz9hJrUXFfcGFCfJIT
	 CwskC+RRCMFkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7153D3823327;
	Tue, 13 Aug 2024 15:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] tools/rctest: add NULL checks to main()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172356423323.1679641.951558882403566649.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 15:50:33 +0000
References: <20240715084701.42478-1-r.smirnov@omp.ru>
In-Reply-To: <20240715084701.42478-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Jul 2024 11:47:01 +0300 you wrote:
> It is necessary to prevent dereferencing of a NULL pointer.
> 
> Found with the SVACE static analysis tool.
> ---
>  tools/rctest.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] tools/rctest: add NULL checks to main()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b752f760da47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


