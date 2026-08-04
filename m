Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247633D505
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843211; cv=none; b=LQ2qCXCdTiCqFd0gS8FeTAE9vNOryb/VMIvsoi8cCgXKUMxjaQroH6DxGv+ylQWrWyOXPnBQJcROdZ446muPeg0KbfzGgcGI41yC0qI32unWhWjcs+q6fcqkdsNoEodqG1BAdWqwp6oECRna0hHFYaAWjyAPUL82jSSnzN1SfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843211; c=relaxed/simple;
	bh=BToAoFt7svTxvNN1Aiv5DCCGZgR/tG90FwZadIQKvY8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vn9H12Ssz6O5UlLuPAEwTsdgDwJD+iiJXsU+c/wyvc+kQ+uUa7PmTaa9C9U4TnKLoN9Aec/2uVEoteWH8atArcq++GsGpYd1dj76z0AqrTrxsqSivwotAKB2KawLdoZixVUgovzcBvIBTAgDdHuv9j3brD+xuSfruL6HXtCpJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Jvp34A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Jvp34A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7357C2BCF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785843210;
	bh=BToAoFt7svTxvNN1Aiv5DCCGZgR/tG90FwZadIQKvY8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g6Jvp34AY+DtgYX1dxzY1LV/KU09Q4yB4QkgyTx+5gv0g5EYPpYjkqpxGOcZQuUTv
	 AMm7YjBQEjl9Tp6lgLd/VzeWSDwIhorNpSHtM2GsdCV+QT81Xaok3uDr8dk6KLvtMC
	 EJDy3tktorC+EktHKmAiEq2kT/pWqfXfDw8n++YyNiG7d84Ifvo2WSH5uOLyLdJPO2
	 NHcNcO0bPq1f3524ZIjqZFJg12LhZALM3F8dlIYgOoqzyfpv6zfqPv9CNp+QM08UZy
	 Rg+t/P1YWtfDzIvuHoqNaDZ9veSXB3mWoEWeGcX1Rjh4xyKaCDJrlgNXOlVWmcTWPa
	 yFiFZ4MlLkY9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B8512C53BBF; Tue,  4 Aug 2026 11:33:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Tue, 04 Aug 2026 11:33:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221754-62941-I5BrY8DWEw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

--- Comment #5 from jeremy (jeremy53561@gmail.com) ---
Might want to try
https://github.com/mihaits/rtl8852bd-bt-linux/blob/main/README.md

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
