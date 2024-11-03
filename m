Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3422582
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Nov 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730642689; cv=none; b=Nz3bbJ31kBmlQkQxqkQYxjcWe9lehtriaFXmmuiKVIIGSbfVt+2C0+yPIuqQa55A2zYW2XSYRAGu6CsmWt6exxsWN5HHT0RCDyIzt7S5koiSym5tRqpHpIZrbaAe+MeQNeo527Qz+6yQi/zQtPbYfGDy8Qk/8BRpe65JH0PIYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730642689; c=relaxed/simple;
	bh=NmGbpuNgTaakn2yCUfsQEONPbdqoeTjpayaZyW7hTP4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IwbRHH++VNA9VjcsiFQlb6bNizWyJHM2lequwkn7TX6EokZbTONNo+wLd4bDrCjEf9v51fk9+q5B94Tc2+9SqOVPhO3JduImlowccGZZzCdXh2Y8GK+CCuICq1CEdohSSrU4Wnk7DAESma1Q1J7D3sz+NEgFCQ7IYg/iBuRg52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P68S88CY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P68S88CY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C385C4CED4
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 Nov 2024 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730642688;
	bh=NmGbpuNgTaakn2yCUfsQEONPbdqoeTjpayaZyW7hTP4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P68S88CYFCKROVQlOnK93pVsSZrs21V1PD2wnqeM5NMK2FN/Ly79446TUyO3P2NaC
	 vWnP3gisX7XVDOcEyvnTRQ+T5nH1iVvJv7qyhLKLkHe4R9w+K1Q2q0kOiRSTLQ5682
	 PQPZL4jikhgAOpfOF1qrynmph5XNfT4j8n4cP2VQtLYQE86ExbXOkwFfHRAikImK/+
	 varVAa0z1swwHEUmEcgHasfMpcCES2fvJW1nLNuhd3Sb1acCrpuCOwhyIeZGUNaCU8
	 XOfbLqGriHAtnwH3ycqjrQYhHnn1NgJ0GFgS20mcdvYaDJLfjtcn4Q92gpuIFRzzrm
	 7kPlIosrLbQ+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8FE37C53BC9; Sun,  3 Nov 2024 14:04:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Sun, 03 Nov 2024 14:04:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-JnvKNIl90M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #5 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
On the Dell XPS 13 9370, Linux also logs this error, but Bluetooth still wo=
rks.

Does Bluetooth work for you? Can you pair and connect to a device?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
