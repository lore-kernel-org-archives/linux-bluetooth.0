Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C010A0E
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038858; cv=none; b=eH43sApZ/Q92M5YVStgC0CgnT7IIyrq64kvUP5Wtlxuv67tWX87kjPcR6+715wsef57ris+djgX9IbHew3RBwBLVMX/xbP46MSja4KrGO11ugXzFgPH+uIi82KSZCyeZgRUw8du62JSCqFioFMaEosVUectxaisVb5fORUTIQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038858; c=relaxed/simple;
	bh=5SPUjlrogpjyp3X7Q8S29uZkfYqagSRYM766U0zmNME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VuKXMAol3penaAQ4DBkWv+jXHW0aZcYiSYVCjDPD+JaGpXWRdU5tlhHNXW3aGAZlPmh66ej5oZuUSl0/WNaBUTfferATu/WKgw100U7gxrcHMz9rPoiU3k3k3DMapUsvr4s9gGNZYZxFOcgiTCrGqFvik/5oDY0FtouZLDN152g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l02VmeY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l02VmeY3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 540B9C4CED0
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 00:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729038858;
	bh=5SPUjlrogpjyp3X7Q8S29uZkfYqagSRYM766U0zmNME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l02VmeY3LWlRxHsshPGw2nUc54yc3XwnyXiSyyUQ4shRw9ULl2zEDQLrDOSoMYMdK
	 ppSE8eI3Cm8OhKIXX+3/ExuSsOLrK7nxmAwEtG4tO0zGKyejAkgkjoiE8jkAX/N9CS
	 nnfJ+1gIxoCJRXiL0wke0vGxQIE9iL4CogLThSBEZvUGoXKJ/N/GViAuWm92GOgC9Y
	 zMK7g4z0IjhyyMVQX+g44ZLL3w5eAGl4/9DM9uv/yd4w+L0Fn0rfFSQM0tcJ4kQhSO
	 7tLrU33tnYdlG96VVS9qtV/SpQHhNKEqN5N5QHq6U1hQ5jooYvnL6m7a40VCH6fDn8
	 v/tTBu3WiGetw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37FE2C53BCA; Wed, 16 Oct 2024 00:34:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219365] USB bluetooth dongle stop working after upgrade from
 6.11.1 to 6.11.2
Date: Wed, 16 Oct 2024 00:34:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilson@adilson.net.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219365-62941-9iiNVtA0qW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219365-62941@https.bugzilla.kernel.org/>
References: <bug-219365-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

--- Comment #11 from Adilson Dantas (adilson@adilson.net.br) ---
(In reply to Luiz Von Dentz from comment #10)
> https://patchwork.kernel.org/project/bluetooth/patch/20241015153719.49738=
8-1-
> luiz.dentz@gmail.com/

I tested this patch with 6.11.3 and it worked with my BT dongle.

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
