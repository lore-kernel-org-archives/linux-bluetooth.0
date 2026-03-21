Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6529ACC5
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089565; cv=none; b=ADe1299GeIz4fx/vL4heqMA6BLY3ftGR+3nGvrkSxHlFA83yTkY4J29kXu3xsqhG2WcjPKejhg4/nSFoOdEKcsQSPGKgsLgGiuGYb7pX6Yu9fJtERVLJcZP/3ZOGU66w5jlDfm0aOlRjKdxcuQbI8Ema3ulCxgLq55odheuVnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089565; c=relaxed/simple;
	bh=JZoL2mB9ZeDRTKEWAAau2+XSqpW/dWmevRg5Xn60py0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgVPQ/MoszVPbwC5N8+FNnWnCpx5i+22Lw3W7QV53AyFmedg9/AANI2Ft+Ff3rmtvPmmYrOTTDFUGRv+hhbPHDjh8ZVWGhZMtVCqMI5s4MHxLWwTC5RcNur+mGTpYhm2TTxQptnnylzwXDcFNaALrxb1Gf/iStwYiuvPL4L2t0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxcuTxhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxcuTxhm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54D67C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774089565;
	bh=JZoL2mB9ZeDRTKEWAAau2+XSqpW/dWmevRg5Xn60py0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZxcuTxhmkniiR+DThExqQkeAclvGRFoOezq+3reeCWSGZtTk2shXDaYD4GSYGZMUd
	 HHWpE/d2QkJeod2+UlV0FgYcAtlG7kPkkuYY7ewxzQOYueiZKlQ0Ugf5df72K3adri
	 CmgWWYuxS3qfECSFwBlrcihysXdfAq1Q54EWcPeY0N86KFoI+EWeawhfs+SpLZInDT
	 Ko7AldEQK3vwQnczUt307iIm7HHDQI90PD/6rNW8OWAJbcEqxZ2wWEXeZhOSGVPL4Y
	 CKEKSRURtNTAQ72drXMqQijj8w0EboX5E8kP3dFLlpxMUa5wVxlpf/gRkfBvlXk6Lh
	 XKiwqzS5cdu8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4E98BC41614; Sat, 21 Mar 2026 10:39:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220061] [REGRESSION, BISECTED] Multiple Bluetooth devices
 cannot be paired under Linux 6.14.4
Date: Sat, 21 Mar 2026 10:39:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220061-62941-kNQxOM7U6O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220061-62941@https.bugzilla.kernel.org/>
References: <bug-220061-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220061

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
