Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA32320B
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737076; cv=none; b=OYOyBgHmWaf2x5E/j0IpXEWv32mV2n/sFmf2uXHjtb3IKA7Y2TC0uAn5xdwUNpGjMWU1cNxx06/ul8G2lKEHH1IeQZAJLBVNdJeQT9I+TPXfdnPhpJZxdeCvJEGZSUa0pRNdKCcXqROJQksyIqrDwZVEeT3bU33ep+IY046rhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737076; c=relaxed/simple;
	bh=3xZIYUg1ksnG7JCY33FqaUegJO8aqsJH8004V9FCLoY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qIhaBEsuENToSWsQi74RpHc4AaZUv72bVmVVF1f5GO+i3zkNY5yxx/aIE5Esa1ABwBjGZ4FoP/QxiYUzL6WV+TBPJOmPh021n4HgfzBgnDbtSNmlSntqFClu+Phc8ls28kCUfULEPzGTMa85tEg26kbsjTmAt1Hf7ny3v9ps4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPQVvQtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPQVvQtI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B53C43399
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711737075;
	bh=3xZIYUg1ksnG7JCY33FqaUegJO8aqsJH8004V9FCLoY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QPQVvQtICjwi6lkPK+u1QEnKPqWIMHmRGmuXntjqKzJShPHDcjw5Mowoyn4wqPI07
	 VLy/6E3ze3blK2I7T8ULnIKwKg/dnVhxrAFG+YJBivxHY1qSsZTJsEt/kw9eUE9XdD
	 pcRk3bBpjUd86xbwyp79ugFUgjxwB5RzCYX8+GZUBW13O5fhtJXOSo9g2Uv45rKU9m
	 N9Np68n7YXr+iYB7Ot1n5vXq5hzKcR9QTqXzL+/NJoj1jvhuUfhEiM4nyB6z9LNG3B
	 U/qFPny7lnoIn3w52RN11pT5L//0ZNRJaYJFp/dYqiNeWIZDPoCsCVOE4n3qdIww/D
	 J9ns1aMpXIrVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E0AB7C53BD7; Fri, 29 Mar 2024 18:31:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218416] hci0: command 0xfc05 tx timeout in kernel 6.7.1
Date: Fri, 29 Mar 2024 18:31:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dustin@falgout.us
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218416-62941-Npd8m4rV4L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218416-62941@https.bugzilla.kernel.org/>
References: <bug-218416-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218416

--- Comment #11 from Dustin (dustin@falgout.us) ---
(In reply to Gurenko Alex from comment #10)
> (In reply to Olivier Delierre from comment #9)
> > Had the same issue. Somehow, after a long power-off and turning on agai=
n,
> > Bluetooth managed to show up and the message was gone. Using an AX200 as
> > well.
> >=20
> > Currently using kernel 6.8.2
>=20
> Wow, indeed, after upgrade powered off my desktop, flipped the PSU switch
> for a few minutes and it worked on boot. This is very weird behavior.

Sadly, its short lived. Mine stopped working again after the first resume f=
rom
suspend that occurred after the cold boot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
