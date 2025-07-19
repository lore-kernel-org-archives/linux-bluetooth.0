Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7B33086
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752922579; cv=none; b=Fl+KwgIhn95/NGFqZkIHXHOLx+8hLFjZ8EEWU4zF34frZm85e2zMXBMeYbR7akKi4320uwzZzhZgNn3xQnd5BJK0PId3lOLkF8kK/QDiz8mh6oa+XjogB2jWG6pfsSwvVXLmTwce/XVyxQ38wyUT1fMtaBDvhwxpviemV7sm+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752922579; c=relaxed/simple;
	bh=2gX8qm9WkyWPQqOO1XKN0YJAM1hhxuFRz/tp1xVoMkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tbj4eZ7v3CqBcmmkk1rb9vo8V52L5VD93uWsyNNz7dmHrO2qNWF49aCQz1mDYU5siM1wud4/HPkDFrwu9E9xJ+/OsDJOi8iruVqVKkzEyVicWTWGWLqNtdf6xHFq2ahC+OefncMpr60qnlT2HULUV2rrgJpYhsD83h8NHxYYFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A00+SX8i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A00+SX8i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78732C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752922578;
	bh=2gX8qm9WkyWPQqOO1XKN0YJAM1hhxuFRz/tp1xVoMkk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A00+SX8iV4HHmYuYHPOogOQDv5Cx8CiF8sHw4gHtG4QLCEnwpAN5fcE2I3KE+ln7m
	 NbEizng9lWl+n/Y8ocDgkHGFHn//30ofZA55JT6BrVwyBJhXRwY4vQCEbP1g7QH8yz
	 gfnr707PBWz4YlGHe1xePYZKi3HXc/hRVereBbNTIDV+dAGQn1B/HNoAuHZFGx/C9B
	 oXviGF9Qvf0mrEoep/rC692UGuvx98KukxVenC3V1EAmMR+66SEI75ukLbYit5XKx2
	 3EGl119cv5J7kNsoRSag8cksEDzrJKOU8XxdMlOa2Z4FYyU0e43otBrlvM+xo9HuVr
	 +75YfcHPnnP6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 69B48C41616; Sat, 19 Jul 2025 10:56:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220341] Bluetooth crashes about 30-40 minutes after I connect
 my headphones:  "Bluetooth: hci0: Hardware error 0x0a"
Date: Sat, 19 Jul 2025 10:56:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220341-62941-OTdxT3qUTA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220341-62941@https.bugzilla.kernel.org/>
References: <bug-220341-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220341

--- Comment #16 from Martin Hignett (martin@hignett.net) ---
I tried the OpenSuSE LTS kernel (6.12.36) and my laptop failed to boot
completely. It printed out this a few times before hanging:

[    T1] ACPIL \: Can't tag data mode

As far as I can tell, no dmesg log was created at all.

I fear the best I might hope for with bisect is finding out which kernel fi=
xed
that rather than anything related to this Bluetooth bug...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
