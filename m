Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51E272801
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767205930; cv=none; b=YpTWSxVdNTxkj5RGBblUB8Zhebh6Q84Pv9IaPcF0WIkN5xlo2wzr58ZcBSE5lkdmiaZ4sgDBdms/6l/F1FaFWSsXxe6zfw+qKayPn4XnpjEzmUuX1Taj7oMxHvHRBNzWK+/zRgej+wM/zW5t05TPuO9BoS1xnNcep2ZdyhsSdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767205930; c=relaxed/simple;
	bh=ICNxWxjfCcUQ8KquTSF6WwSmFYBmfs7fs0R0prYHezM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWvhm1zM3YzgbKH1thgsg4aaDql7sryDrbHr8uCzFKWdHuWngyCd5htRusFnS4AZBKRYJkDdIJl7zFTcCAzzWCZ/fZix+6fRlI1lHW5vVZex/vkbGd7f6ITcEcoy1RB2DQiPDuW4oCvmgnGO/nu5LCjYGxsFCejNxgImvpK85iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC1o7fXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC1o7fXp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD8DBC16AAE
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767205929;
	bh=ICNxWxjfCcUQ8KquTSF6WwSmFYBmfs7fs0R0prYHezM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RC1o7fXpD6sETZDKoqpi4qeBjOJpRV7hsRwrNm2x1Qj4ukD/+vgPF8dZ0rMoF1q00
	 cc5oPMnlr74Zz/M/EeNIVX0WQNecnxcwHHCuE/odIHzEOlZnVc4l1pz8+Fg/z6UUsr
	 cEzHF839K7ecnkFzvrW0Uk8eC+IP34rVtf11lXQ8KAF5CwIF0Ku++Ty+2ftjNodmDa
	 Rgi1G8HRUwBDhh7WbUfN3lyRUGDsQfz2eRfucEGTjdakRKZdNr1nBrNhe7zm0vtKVO
	 bage+bVIbQZjN129VDmMpEJYiyL0MdwzEU3lPOJOvlamTkRLbTldPTqhPHwGDPXCog
	 m9M2+Z4KCcuAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C78E4C433E1; Wed, 31 Dec 2025 18:32:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220922] btusb: Add USB ID 0x13d3:0x3625 for MediaTek MT7922
Date: Wed, 31 Dec 2025 18:32:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220922-62941-xRRe2SKIQM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220922-62941@https.bugzilla.kernel.org/>
References: <bug-220922-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220922

jeremy (jeremy53561@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jeremy53561@gmail.com

--- Comment #1 from jeremy (jeremy53561@gmail.com) ---
May want to include results for

sudo cat /sys/kernel/debug/usb/devices| awk '/3625/' RS=3D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
