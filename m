Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00D2F7EF2
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871522; cv=none; b=ahi9UC1ZIn5urCDO7IdwIDERJ8ZhLTqp4ebNXOLu9y9oyA2SGTALHByaplVEhn/Vx7zdOnj2s9GQ365/4qFGi3SlcKG0h+Bu3zIZPCBtDzRx/Ri3Zc2G0a8MtHSYU9lhM5AR5WUdlrXBWN2M/328+Pftu/GWUaQy+WMTzo5LURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871522; c=relaxed/simple;
	bh=AbOd0GHtfhp37bWyQsKvPJq+LzlKKbKyAxaPBKKOQTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z44QjpZR7gMixnTnk23qCZylPM0e81m81Cj6yegCBcHMp80DndKfslD1fg+w9jFSYy5E6wkC0aIYKVcxlAA2npXopwnLyK1OUPcALSQJkmUdIB6Fa/XwqKD/neEq9Y6Tm+pKZVhWAjT+RQOVP5XHRanqFVkMgJTfAJlczfufGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuPGFUzI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuPGFUzI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1FADC2BCC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778871521;
	bh=AbOd0GHtfhp37bWyQsKvPJq+LzlKKbKyAxaPBKKOQTI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GuPGFUzI4Yr2auVEBZlQ1ZmH0J5ZSDSx5aw2pbvYGPoiATfaDzz2+vnjJbh5KTfi4
	 Pgb6G+w/3NiMprVEIaCkrZBvWNlwHuJ6xenvWKoTKY+tTmJPnywIbc4pCEAfrM8N67
	 gCImiDNW4x+VY7t/RsAgtuvjDgM4z8z7JiPOLSvO4DzWUjg6xOGJ9YyRsSA4ZDMjZd
	 A5MExwGsftbklBD2nSIKsKZNmuxKZYgqgFCqXztIUzoGe5p4dBZlDQUbidaLg/d7wo
	 AAjyClZiWhUCa8TMmbPckLqAct7/QrE3J4/Ju588MqWTiIbKTlk16VuEcfdzLFsZCz
	 jlEFcOazquNBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 939A1C4160E; Fri, 15 May 2026 18:58:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 18:58:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erpumper@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221521-62941-WU59URZLex@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

--- Comment #7 from erpumper@gmail.com ---
Hello I say kernel 7.1 rc error panel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
