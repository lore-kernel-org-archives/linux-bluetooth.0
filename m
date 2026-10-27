Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122833;
	b=ZSRu5QyMoaRbqwa6GZj8y2mhgejFMKFyzdBxi8ItNNWEfgDMIIUe7dAPSsAdt3G3TuTy
	 7soCcTc7mAiFWfH6nC5igeQ6ar2OaFjaBcPRDoi7lnOKCxPSCEqskHrcrxY6cgwZO4pqT
	 sq8gQHpkv1Lx4jq1PU0MRi/pQKX/LPTSRvZKEDU/sXldkN8hWBTX8oVdLj7BIJRR9wpnZ
	 MEr9Y0My9nFUaGmBHjhft5nO3hBRP8SCp2r6zfFcdD5w1xjCsjSDVBaRh39wNaVWHgN0Z
	 GVyKkFNd41v9qDPL3FZ/mtnaVe0aipvS896cUGZ+Jqh9jXKry4iUxBrFpFxJDXmCjfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122833;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=Xot4+0oM7iiX+wH+71b/sudsCrxOmffIQGNVw+btxqI=;
	b=dO4adIUJ0ve5XsboBrHJQsL8zp/tY5kiuevcdNgI0gWuSEjkDQT98HyoExnxMC2+YMrG
	 lyeX9gBGR4dj87J8YJE8F5EMEOxM8Xw27uk65Ei3/MQNVXHlBtEx2ZY3mS0PnHUUcnff3
	 PHf1p4H7zjAJvZi3zbLZ27tR5ZFHk7Ih7FiutOOmGUsGroGgwL4/O6hf+rD1Rwel7a1im
	 dmqiaUTbrMtAJ8AR9w7aKvwk3ThuHXuQTX2HxBiusIw+OpGIqXQN802evxYMHzbIMBiq1
	 I1g9PaoSwIC3aaavP8wQe+3n8d7i0q9NDzz4rlNzU9iUW0BdiYbF8/6OTgO+CnL7u9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="XcYviF/O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEA606A32D
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Tue, 27 Oct 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XcYviF/O
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD506513C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1793122833; cv=none; b=HtHgJcAH5MKm6Sjl2NgzUoH/Ywsa6yCj07isCZ5CSRDz0OB1Yix2M6rzZF1wCyBvo8P0b7maLCapGgg+jZs/TSxsoCGI2qGdhdknn4Ti9etgoiZrUtbiKR0jTA5MlyrMyOTvptCVCfOgDhpQ/HmXilfnH6154Ye4OGjrH9a7B2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1793122833; c=relaxed/simple;
	bh=vzbQLiz8pDmEd+h5c1Am+nkXun+nUcdiMDANgC6zXOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fek1Y51t03yY/7vGq9wZiwi0jIpte8GinnWegI7nPBmTXjq9zcQO8ctrqM++y9MX82VQYd7IsBzJiJjy2FNVCr3FPPbFPop96iCIWyFx6nwTzWbpyufeNwAQeWnzbJDwWHq8uaman06i6dnCr3+LHoEAle/D2VHNO8pQ6i6a3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcYviF/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64E52C2BCFC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1793122832;
	bh=vzbQLiz8pDmEd+h5c1Am+nkXun+nUcdiMDANgC6zXOE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XcYviF/OzNbP74gTlANPk28Z0yRaUip6OZv+ZgfyRNuezeGRNHb9tqtIId8fxOHG/
	 giUc5UGF1eqQEsDgxd91Fny11/nVRgnKCqCGD2RAZLLy+Q7iHvh9jczk1+tkxSGzsG
	 HInNY1dXp3WTbyy8k4FJVkM8QjnXc5dniUuIzZJuxCqPKbuojkjWi0Vph2T0j7rUc1
	 nzWPnUkaCII6YqN9r29/NgXQyw+DZfTdPpiOBnBm6+Om/7j+RXXinGebjWMfv1wKbn
	 uvA2xCQP/sTPB44SPCAxXm28KSQ1SaUGqek4pTLiJvg1/iyUo5YRyz4MJt3Bo4YDJ2
	 L/qzn29L5SZsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37530C41612; Tue, 27 Oct 2026 17:40:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222204] Intel AX210 (8087:0032): A2DP audio stalls because the
 controller stops reporting HCI Number Of Completed Packets, while the ACL
 link stays up
Date: Tue, 27 Oct 2026 17:40:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: danoomsys@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-222204-62941-MAxNpYvcjc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222204-62941@https.bugzilla.kernel.org/>
References: <bug-222204-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222204

Daniele Cianci (danoomsys@proton.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |7.3.0-4-cachyos

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
