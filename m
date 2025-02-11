Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274D26BD8C
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286622; cv=none; b=aJXrdpjgwaaj9BcXIGsQ1tzaq3MT4p4Y1X5GZSTzl2cfB1h75mY5n0y7iJQ8uID0LvSZSP1+LGOdoZS1pE1jvPZ7vJLitXVz9MIhoUW5ho86chPsAyULe/Kwj56Ig/nhNQlyQp6oeOClL7KkZ+BU06CrHamQ0rc23CDKCKcV8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286622; c=relaxed/simple;
	bh=xTioKLwkqiTYo78adTptznX1BK3x303q3SvodfnBVB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SFrvEYuEgLh6ueSnpkZrmjmxftqtyrpbYYA/nz0ruv+sQUocWj5TZI+l0l9WKXUv1PN8fEbryHxChYjzoZpl+o17Dw7MjQGkipMpFVo1iw0EEM6fbAJAga3qUNOcUG3WtmWsrTY5KBm/31ti3YewtULRkWgc8ke947osIhxv79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuR7A8so; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuR7A8so"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83BB3C4CEE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739286621;
	bh=xTioKLwkqiTYo78adTptznX1BK3x303q3SvodfnBVB0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IuR7A8soIg0ebaD/dceJEQJUucWQ/m1GBUzv0sXIDe6Ufq5l+s9iMebETcVmwQOv5
	 rYRe1j974TddoKl1LK5TK/EBH46RYyJySgCfwlOc/dUFwDHIWKGKoqTB+bNokJ+/FN
	 c/Rn1NT57yov+snHhsuZKh3oFTjQlubCbeKAjmD8PSVrMy69RsVOXQScmyLgJ+27p1
	 8xPdZepYIpCShLICGEL8mZFVgVvrNUTu2w5iPi7Kt0X6vjhaDgpraRZhWo8EI5Zqw+
	 XtOS1GraX068aqytiVfNYMEj2dw/8FEXL5lNd/9E/xSMgzqfzoQSwGPUAMaPODkH0D
	 qfDI0s6kEwiyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7C8D7C41606; Tue, 11 Feb 2025 15:10:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date: Tue, 11 Feb 2025 15:10:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anhollander516@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217023-62941-saY2Fi3Nuo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

--- Comment #14 from Avraham Hollander (anhollander516@gmail.com) ---
I'm also not seeing the error anymore on 6.13.2. Though it's not clear from=
 the
changelog what fixed it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
