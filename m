Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F17347D
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943230; cv=none; b=BaPCgtycjpfeIG0q8ujHivFgAuT3imqWPoDd2PcqYNWsxMEwHSLh2JuUHUAfINM2OwMp7U0ynVp65ULG9mHDszXjim5YjmlER1Zb/fwYdR787gYDA/9sC92OaIup2QB2FAm+Tx8xkMLUthTIyEdub9oiiMGFzsi1PV+sATqjoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943230; c=relaxed/simple;
	bh=Z0mX+tDdHae4Ufxh/VkLoATwrunaNKEF2Sm6BPoKz8s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxpCM/DjUMnjvIV0uqLU30q2NL/V3hDdyo7f11n+2CW8uQEnvo78SkSJkAnclsPwYwJEFkaS7JLlFmXwrHDYi19yyifAuJ2JSII9lN1Fi7xeqPrAxoeIN9tHdlK9EfUrV2tfzgDXL2QG0if7mF1TXBE3o3/mLrZHXfAbzUSYraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFXf0xbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFXf0xbv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90EC8C4AF0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721943230;
	bh=Z0mX+tDdHae4Ufxh/VkLoATwrunaNKEF2Sm6BPoKz8s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VFXf0xbv5yncxzdBNxgxWmiRbsCU/wyx+1DYJWRikKtWgHXePG3Mmb1BxuWWv9PpV
	 GzNgNmEhIvx5XBgoofoDQs/r3sR1useF62rD7llGPHffKTFr6ZE098cUvyASjznNHh
	 +a2EVnj9wYLe0XnskO1wYovkX+R7KssH2Sx5rckbcGFC1MqZhMDwpNX+39xHt8ZEkC
	 Wh5dNlApRcpwgt3u210863UpMiFdeGR78wJPlmXfgCiuw4HqA1W5EADERjXQF4ylU8
	 zE2+LdKpUu8PRv3LO/NtNOW5Nz4wihD50OOX6N15ZU3pQZI3SS19AttaNNxS0c3wIH
	 S7aMTL6SHBGhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80AC3C53BB7; Thu, 25 Jul 2024 21:33:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219088] bluetooth scanning doesn't work in 6.10.0
Date: Thu, 25 Jul 2024 21:33:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219088-62941-jGThUN384z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219088-62941@https.bugzilla.kernel.org/>
References: <bug-219088-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219088

--- Comment #13 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Eugene Shalygin from comment #12)
> How can I learn why is that?

Are you sure you are issuing any command? Or you are using some UI that per=
haps
thinks it is scanning for some reason?

Anyway if you try bluetoothctl> scan on that should trigger the command abo=
ve.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
