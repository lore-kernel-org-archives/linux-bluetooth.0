Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E33A6B8E;
	Mon, 11 May 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507251; cv=none; b=Uj9QPOWFia3W5k0DV6aT5AFApFRTH4tN0Dws34MCWdECDroY3SQ0Au3bRyOK3DaWO+HihcNuHfEuj3wNWImwMQzikrTK3C2cPEQ8/UPxP/+SiSwdrOZOW0c8FixVH2QigU03tlCKsRjSaeeA/7ddl/zq72esN6JRsCmdkpIsKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507251; c=relaxed/simple;
	bh=tLEp70UHG/EuCtRgDahvTDvSVaeMSKrr5gp+ozE1qW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrRAaJ9pJZT85lptuBWRfPuNrdQRkFGVgl8JClV+Jozzs/ofRWLbvdLxwnOYTbb3lGs2isDUFquIiu77bAagQlk+z/KdDsoJizEEyQxt8YdfhXdTkEk/mB6C6G9Hq67s4zTOnbO/+zXJdBFic0GFgH813TkU8eiWTLmdJj4WZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1dT215E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1dT215E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F12C2BCB0;
	Mon, 11 May 2026 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507250;
	bh=tLEp70UHG/EuCtRgDahvTDvSVaeMSKrr5gp+ozE1qW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1dT215Eo1W/iomsuPqD/B4aeP3cPbUVynPZPTZO3/3aHSKkzOBx9TZLq7cXhnchL
	 Cw6V1i3ubK4zwonDCjV91jJoXY1q8e1FrEebMyrZKfGzbqOkwVrIqxyNYoPpBHYZ4Z
	 YI3EahzXHL6E/wQLxw/JNUgeQrUK7mmiu/T03CfJJfdAClAk+fwjKaaFISo5bfXSWZ
	 r5HoIMImqRKTVQDV6aDQGnkOmsvHF2HJRjISoqYCx1OBBg9Hfx74mnydsJLgsipzjf
	 JNB1XOgdNtWiLYjbRyuZNMam+ziA5JxKN/jM4C96uuD2oUycYzdXMpUEYoS3w9VWih
	 7vful3DVMisXA==
Date: Mon, 11 May 2026 06:47:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 6/7] selftests: net: getsockopt_iter: cover SCO
 BT_CODEC conversion
Message-ID: <20260511064729.11c507b1@kernel.org>
In-Reply-To: <20260511-getsock_three-v1-6-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
	<20260511-getsock_three-v1-6-1461fa8786ab@debian.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 03:41:51 -0700 Breno Leitao wrote:
>  tools/testing/selftests/net/getsockopt_iter.c | 65 +++++++++++++++++++++++++++

please don't add Bluetooth tests under net/ (or at least they must
cleanly XFAIL if Bluetooth is not enabled). Also Bluetooth has its
own tree so not net-next in the subject.
