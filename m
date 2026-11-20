Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795135106;
	b=jFDoxtPbLUK909Mh9buXr0sIL9vz4ITeTRmvLzA7nydsiGYONKnKNqmYQpgq0Hk9rdaz
	 o30ZAKzldi7nwlvHe/9O9Rlo6tY87kZlHmv25PRi4s1cJhigNnDwfOXq4dmXYNJXJWOsA
	 nmHU4wzoSj+mxBdB1O9aKeetLXdzLGc5fvwkLyOqVpJ2Y4tgcRVEzlaM6rmL4qvDw0lwm
	 WG4MEFjGF2noWo1Iklq7ypVYec299rhK7x5xNeQ7gVvDl9xJuc4OAOFztM+Ytwv78EEd+
	 GmFtPAgF6NWZ9Hul6eRzQQo/83DMvXIa15g2cuCAGCruNix4faEqrqpKj6IvbNyE5Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135106;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=bPRzOxNbh7WcoIQ0EL9T10ZyWFmrezhVFNDlRHrtdEM=;
	b=zjV1zGxK6PoOsSQTiWBf7bhkJFIIIML8xFSZ4egMRpFM1vU9+O8ZS6FNrgO3kLTdsw6H
	 vGJbZpRmYu6eIx8Esr3sp8DdAu1m7AteaLJ/UdU6tODUriVbyl7OzN/6CehWc7EcnzUSE
	 JJFRtGVFcRUOslkrefOC8oTRSTLkvMGZXwo1aUCf20z7DTCfxhSCxKs6T9JuTqDG4Lc8/
	 4XU0WOH8wvK3TOUKPLf3e33UiCo5qnZ5xQSb5SDPaqiJ+P4FS4aCfHpCexsgrBZbePX3W
	 NiEGdxAHMMRDqUCeCpqJ3xb+aHYd8sRn9sVzyTPRwnVpeR8t4XIaEWCEm/pVIx6sU2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A70Ak8jN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01739606A32A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A70Ak8jN
Received: by smtp.kernel.org (Postfix) with ESMTPS id 773A61F000CF
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 00:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795135105;
	bh=bPRzOxNbh7WcoIQ0EL9T10ZyWFmrezhVFNDlRHrtdEM=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=A70Ak8jNJVwFz7Oz+bUy8r6Uuuvg3c/TjMNFjLC4APL1u2BDvDe/NCAMmM86LS1uM
	 uqvZpjV3eHrDB0pB0Bp39tJ067qnOTt+Z0QVRPyybdD0NuJd5djMOS4D0EoF0kHvjN
	 8NDeXG2mqm7j4sKK4EedWRnOxJpGdEqNluCn/PpJdk9D3EBnS2ImKAODFye/PYpY6f
	 YaXMnj3pviLs/hFK7vpw88c8NsA9fPW9NzPVr/lqApZm8Qifn0reyNTx0kPHQlfCyK
	 SCGdL4XF+jbE5h8loDJMF+hQyPori85qYMrvBRar/iYvewEH/Pwhj80ZKuihMdez/o
	 PzvBxpSyW0VVQ==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id 74075240040C; Fri, 20 Nov 2026 00:38:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219387] Bluetooth: hci0: Reading supported features failed
 (-16)
Date: Fri, 20 Nov 2026 00:38:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hex@freenixos.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219387-62941-uqz7aYU48G@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219387-62941@https.bugzilla.kernel.org/>
References: <bug-219387-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219387

--- Comment #15 from Hex Lindqvist (hex@freenixos.com) ---
A fix is now in bluetooth-next and should reach mainline in 7.5:

b05fb50e255a ("Bluetooth: btintel: Don't log unsupported debug features as =
an
error")
https://git.kernel.org/bluetooth/bluetooth-next/c/b05fb50e255a

The two lines are now only logged with dynamic debug. Tested on an Intel 82=
65
(8087:0a2b).

--=20
You are receiving this mail because:
You are the assignee for the bug.=
