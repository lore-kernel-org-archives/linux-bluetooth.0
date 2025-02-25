Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61F18DB17
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500754; cv=none; b=TttCLDq1AS6k64TCqiueQJylLGRm5EgaBO0ChVxMw2LC1KrT584BEdXXqgDrR2VQ5E3N1AwR8YCeNAoVKL/++G4fAHnivogTyVuDotsKhly8PXVeCd1UYZ+q/zF/FhTjFAJUzQURXzTGYn8igrSiotB2ZWZjhBuuLSRL46KCtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500754; c=relaxed/simple;
	bh=xyN9BhwaP6U8EA55VtFeF0NMwDFmXBazx7FjxV4e6Ac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kv6lS9Y9QXqO+QH5o7YD7hPaFv4xwAtzU9lKR4IqSW2soNTOP2W+i5UeOdVLdwJWEOjOTafBPrVNKB3DUWh/Pwk/PNEX4JP2CYxaF5+C5wl7dqliUBfRlXGHS0fbVZjSoumNJpm0LiijjLdYSgQDm5BOwJ+5uANfq6sXAED/Ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIy90sR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIy90sR8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0AD5C4CEE6
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 16:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500753;
	bh=xyN9BhwaP6U8EA55VtFeF0NMwDFmXBazx7FjxV4e6Ac=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AIy90sR8/5hvLDgNjSXM8aBgrhqKV/EPdbqjU7gjeJjuJn6UUuRAYN5YcJvbMQEFu
	 R33F4/sdB4FUpRfjnVSGcB47saAUbc6vkpWfxmnNbVvOmdTU6lMU+aNoSFjYMsgcUV
	 vDaHAaCSqo/nZZdN4Az9FprjHzN/Zk5pg4PatlNoGFS5P7Rn5+VFhTCyXoo4CTaNuB
	 /zq4BhYZOsaTLZu61mdQbuQFhTcwL5adi5CeRtDEWKmvuTFqrVlto/pxP5LA+euOQb
	 zK9Km5fuXhDwJ4MVRIMqZkbIZzmdlF3RfuxWEWjlq2YwXb660JUh9nA48UaeQYy5pR
	 Fxh2g2pO2sx0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CFFE0C41615; Tue, 25 Feb 2025 16:25:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219812] Bluetooth: hci0: Invalid LTK for MAC_ADDRESS
Date: Tue, 25 Feb 2025 16:25:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219812-62941-iPhw8TKyD9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219812-62941@https.bugzilla.kernel.org/>
References: <bug-219812-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219812

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
I'm running fully updated Fedora 41 and Linux 6.13.4. Hopefully this will be
fixed in later stable releases.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
