Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795278522;
	b=0Zc5X6K0QTZoZ40ySyUat29owKwKVmwANfOUGa4HI4fTBnPj4R+J2/G5RrBMgGvJUPNe
	 IGi426E66UoHX6Ua2qvWb9Rg6W5ymuPNVqiWOkkacTLpzu/mYHo45XQ9EkIPIYvEb4JHf
	 MKUGmQLFZycTzDIWwCqNU0YXwFfQu1+eOppxnJlumZstZK7CqBi3o3IAE3islUj8DjHNo
	 I3O32rhcCYtxr8c9OYOhTH/oV+0fAU9P79d1MxxtzMX5tQyNASzxFQDqaVa0s/KMUEj2k
	 EHAVk9SYg5+1k8dDDALvi7a54cc4U84ymz5KIgJRnoOK9Fr0dBZh37bE2SsdHlQzrFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278522;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=HSQnfTZc5AemTN8bG0Qn2JFF5ZSwKB3i4dj2lPL1OeA=;
	b=uyg0rpkYTuRO/cl1Y1RcIaOevxWp5Zxr8KanyAluIW20QmzYEXgw9TXPMee7lqDE+N5t
	 sPOv/k68MwKeaYRENpchR/PWuP4skOaXuBojwgmT859mZlG2kBaYtC9nX97G1qnotUioE
	 0bBD7sywI5mdW9XNLuV0NrK4zVENJgCVaPI3Zy9Xe4r9Kko6FLluGHEuvIyObYWWZ5TWO
	 82yYOe3Qf1BVSn+a2pfQoQ5V0lG8NF+uRis94MNPPQXINyb/LyxLm+4vXu1wd0tpqCjnq
	 P+E+YA/ou2MfmrP2WL0jTE2Bfw2VjCe6L6LnLOT/EK/UrlX3+dKdXfOHYYbL8Uqp3Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwoB+kCb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4A606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwoB+kCb
Received: by smtp.kernel.org (Postfix) with ESMTPS id B54E41F000C6
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795278521;
	bh=HSQnfTZc5AemTN8bG0Qn2JFF5ZSwKB3i4dj2lPL1OeA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=iwoB+kCb15XwfjzySD1NAHqDFu8HDdQuSMzrAA6OtHZo1tQ6PF9dHp+XJrvzEghFj
	 iS92bQbH0+wk2jNGCd1dvVxtX2u2aPXMLaMJ1V9D9qClA7FIYw1oFiwg9F+i8yatSd
	 GjoqW+snnXBcXW/sfoRLC4wk6XRBmCoFgpWFDoENYaYjMjVFn8Al4VVpcjbjCnGym+
	 gvvoTfRC4laFnyjRarBtHd8d7OrqjHAgAn1qQkHgcHC04gALbhS/mmmFNR80k7ylLk
	 bqQl2aTzsF5GXNP4UZaf9KkUBjRqPABwPjcpQEGKiODmHvBZ8zkiU+4WnrYKj57ss9
	 IkZo3tFIaQpzg==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id AC656240040E; Sat, 21 Nov 2026 16:28:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222310] [Intel Panther Lake][btintel_pcie] Bluetooth A2DP
 playback stalls; HCI packet completion warnings
Date: Sat, 21 Nov 2026 16:28:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222310-62941-qQ6l1JlvKp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222310-62941@https.bugzilla.kernel.org/>
References: <bug-222310-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222310

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
rmmod btintel_pcie btintel; followed by modprobe'ing them one by one doesn't
help either.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
