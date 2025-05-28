Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099A125DF
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416308; cv=none; b=jZe+seYAy4uYNlGwX6nLvHh3+KHDumkFeIf/KXOHN5U1zdfCRAmn4HD/xI0N2Z1a0Bw9bntF+63OiTovZjiqWWbWrJ6RTBv7KxflbNUogKiMgCEdICvm+IFqJBZQtYT33NjSoEa4OVbyxzgo+gJvkEOH7CdnJ+x2LTpKXIqZzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416308; c=relaxed/simple;
	bh=/7cRzgA6iwNrezdjnK9ktEcuskaqrULeN6yXsMXFZ2Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qyqyFJwlnyhwyAYlIgLcFfKWismMC+gUmhmdm1u7+XXeL6JrufiFu7ISBg3HkhEchrQ3JHwK9BfAp5uYNrsmjABbZPkx889w2UaHWcdogyIy3PfQq/ypVHRDvDRsZ6PzasMqClrwXEOlR9MPvEu8Re3kZhKlhgdCgqpybx2zVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rflFylrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rflFylrE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A514EC4CEE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748416307;
	bh=/7cRzgA6iwNrezdjnK9ktEcuskaqrULeN6yXsMXFZ2Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rflFylrE2uKbDh8pUDcFTmSmXF76A/hvJtAkikb1w8CsFh3/7IQb3JxZYHlUDmfem
	 I1bWjQJEcrps/y66aflFVxX6znUoFLUnkHIOgvaJjmNWaO7OzbM0bJA1wynWk7/DXP
	 oEKKFQ7IrygCIlp8lQfk5dWwQhtOYepsyflrwzhkdOzMNQa4Bl1gnMY9yfb0PQdKcc
	 8vF5aChC0siMrQjAmmJqSIE+5ZHQ6aTiMbbBloJErH0dIloHaJ5JqdbwAsTNnqHmhe
	 z69OBOh75IcDFBnQCqTBCDACizseiKsoERl+zf19g2mu/M5obMcs/76ZyswpGuQ7Iu
	 pPXD+nQplpbdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9B416C4160E; Wed, 28 May 2025 07:11:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 121221] Unable to pair / use Genius Navigator 900 Pro mouse
Date: Wed, 28 May 2025 07:11:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: minthaylanaminthay@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-121221-62941-6MKb0naKys@https.bugzilla.kernel.org/>
In-Reply-To: <bug-121221-62941@https.bugzilla.kernel.org/>
References: <bug-121221-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D121221

robal (minthaylanaminthay@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |minthaylanaminthay@gmail.co
                   |                            |m

--- Comment #9 from robal (minthaylanaminthay@gmail.com) ---
I can't even shutdown anymore if I don't use the -n option. The whole system
basically goes down the drain."

Affected cards:=20

* Belkin F5D8053 N Wireless USB Adapter
* Trendnet USB stick

Fix:

* downgrade to 2.6.29
* or use the v2.1.2.0 drivers from
http://www.ralinktech.com.tw/data/drivers/2009_0521_RT2870_Linux_STA_V2.1.2=
.0.tgz
https://snowrider3d.com

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
