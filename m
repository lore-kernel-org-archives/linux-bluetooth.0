Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE147DD78
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847246; cv=none; b=K5n3lTcmII3CgXc9o2rB3U1Gol7ltEQEENFTXWmbsTJszOWlYPNBxBOellbRkPw6LVj4I8yfSitpNPsPjZPyPPjuCWl7A4L68Yo9+PnI+oxLMTaG72tbmNYXq7tWK6EenG794YO6OQcBevrETPksURCeXaKCHcarDUX4/WG+n2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847246; c=relaxed/simple;
	bh=eTdZgcz8T/N3lUpT2AcpFWDqK9tCTqzR/z2oBWw90vM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIehx1PhRHFnX5RHR2OD9MVD0FRene6gRBwwkwlYF0CWjQYzKF1csMTSp66l+wrJuHNu6+zG9YG1G88/6HnWD83/IRBsrvhJOvZ2jKhCJNHIRE0OIhaJmVqw6GtX9UQt4Nf4zPXf+ZKkO7jn5H8fjZeUn75AnzdbaY4myS6WTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaKJKSKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaKJKSKj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4C66C2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778847245;
	bh=eTdZgcz8T/N3lUpT2AcpFWDqK9tCTqzR/z2oBWw90vM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KaKJKSKjBMzjD0CP97eTNTOD59VYjyPOniGWSxtOY6j8YJpbZ3PEdPq5ZVPz3+iqe
	 IrIAkybhdTqWcWBl3zdIrtOLv6r6BxzkPn/FRR4G9wimntmaGMxaxFzPeXPLfRbA8e
	 HroDEUQgFJeNh4tmLruS1NjQUktlCTZQPUA5QmA48PfI095/5MV+IuJgDPIBSPeb0B
	 HH05hTdMLBxQ2c/mZHx4KRuO5YzVB65roXJQEN7aBrzGKIb/inS9B0JW2f982hyfSz
	 40xsYsUmbMXWjarKSKWaPlIuAenSfWOsOyETwPJ7WEmV9duQSFoY9gJNJcV7xj6iNl
	 /RrKVkaVUaG2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA382C4160E; Fri, 15 May 2026 12:14:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221524] Intel 8265 Bluetooth regression (BLE hearing aid
 unusable) in kernel 6.12 vs 6.1
Date: Fri, 15 May 2026 12:14:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: t.darcin10@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-221524-62941-C9l466Q6Ia@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221524-62941@https.bugzilla.kernel.org/>
References: <bug-221524-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221524

Darek (t.darcin10@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Intel 8265 Bluetooth        |Intel 8265 Bluetooth
                   |(8087:0a2b) BLE             |regression (BLE hearing aid
                   |connectivity regression     |unusable) in kernel 6.12 vs
                   |observed after kernel       |6.1
                   |upgrade.                    |

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
