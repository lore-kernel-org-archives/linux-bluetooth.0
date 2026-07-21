Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731E471431;
	Tue, 21 Jul 2026 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662863; cv=none; b=qWpgm0pcvT7bk6cvPn5vfy6FC3q6QonFerXb6SADMMHQo5NxdsYPyYxeYTZbOLGBDiiRt868KWwKnNrNINIaWJQFcPqBREt0gYIjqgZ0DmJ+KuZShH1TRx3IM9nwrSUSeZdtEWRjhmOjdDPvB1mTQmr+g1/no1XV1u/+53Xc2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662863; c=relaxed/simple;
	bh=YJSzTOV4ZUHcqilYCcj/XfS3GMS78b0JUj9HsJTQDVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=snMsbE+76yD3vqyHwNpQHLssMFX1CYWhaVeFAF62pIl7sxyrM7cQx6PtYipeqZuGDAs62oTubfPIotLWLYyhuagXsT8DYlgcvf7WiAGB6MHg//BsyihWHLqNN9zAMdSv5W3wfI7haayM+9LhoAFPfnFDImWboEL8b6xWI0+BV2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyE1jsYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyE1jsYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EC21F00A3A;
	Tue, 21 Jul 2026 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662862;
	bh=mEMPgqAfAM3y0oa78tar4ibH7YPhJZl1EqgfuYrjqoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eyE1jsYlMy5YRT9LeFGrjvFk8ZOszb68tD2KSVHFVHjVPX+AjVId0e9kY5Bult6VX
	 yBAK2msHeOrHzkPlGweFsj+XamfdvY94nLTK7b4qreuEkxYEgTiSM7upNu2XMZju/h
	 ff42XsG1wBS+07E8UDZ2uhp9zMTYbE6wR5NJcQxY/qJpWqScw5Kpyw3tSwwXDVReH6
	 PJNyW2R0h3R4wCPIOUYqKJ6BZd49Dx51M/sGY1Qy/fQrqctljF11p9g7aRUJbRrLZs
	 xxZChjSoQWeY+KaeNltFDBgmv92N3gKCwvIzXs7jA/LBGq+jWg4SEo7PRb0w9O7qP5
	 nV+fPeCi6ZOpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B7739253FD;
	Tue, 21 Jul 2026 19:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: clear iso_data always when detaching conn
 from hcon
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178466283139.1001510.13531091802205452302.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:40:31 +0000
References: 
 <f3d8d52dcb2a5464393623a56369ea244c144460.1784559155.git.pav@iki.fi>
In-Reply-To: 
 <f3d8d52dcb2a5464393623a56369ea244c144460.1784559155.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, iulia.tanasescu@nxp.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jul 2026 17:53:33 +0300 you wrote:
> When setting conn->hcon = NULL, also conn->hcon->iso_data = NULL is
> necessary, otherwise later iso_conn_free() will UAF.
> 
> Fix clearing of iso_data in iso_sock_disconn()
> 
> Fixes KASAN: slab-use-after-free in iso_conn_hold_unless_zero on
> iso_sock_release() followed by hci_abort_conn_sync().
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: clear iso_data always when detaching conn from hcon
    https://git.kernel.org/bluetooth/bluetooth-next/c/e824c0bbe0ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


