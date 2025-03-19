Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F71CAA86
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396184; cv=none; b=GDqvFSU6b6r3gcbfsS6yMi/6nbFoeU952dAK30wr3trJngzK4lkZa40Ht6m0cq2acQ/ZhqBZiMzJP+k7r/rlotUY6biN+j/4CYxYKbJIMI+D9wTToqLFnGmdrJOX5cRttb475x7paJvBm4wHtYVsgWh85XamKTjKnj2CDeHTdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396184; c=relaxed/simple;
	bh=XeRzBgQKq5MYfmEYv1+63DG9oJH1AlqPnUlCne0S1NU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+/QiwBwFUSD48b6rHzj7+LTF1JzUFO2nOpWfgP8Mgd5kRcF57bI+wr/G3M6xPdkiH0XvzXPs43F1aO4aDMCuetbu4xW77tt/pRxKSWiLSibg/u1MRuDcXHGHR6cmUplhqoLv14pvcOhuLIn5rDvniZNvw+gNJ3mUvZPp+1S/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsLrc0jI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsLrc0jI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 701F0C4CEE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742396183;
	bh=XeRzBgQKq5MYfmEYv1+63DG9oJH1AlqPnUlCne0S1NU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LsLrc0jIjKT146KJudW1rY2VP4CnjFalXrD4BbeLcbjq5irjDRuvWNDmLkFx7P88Q
	 fDxfffJ5xY0voAk2mBPpwRnX+aJjx3oFF+gROJqx13oQjXo8e9YhL/Tf16eKONaG1a
	 HGWPfO4556nFv+PQgHR0LhvAAvni8Hh0MhraIxVZUV/5jy9BaTO4xehFz9Wtj4XGmA
	 4Jkb8NuoDAfpSzzpZShP3PIsQ54zsgTjgBJq1unc/arQYMHJPQAKY+GS5AV3suFIJz
	 jdCrcGh2lRTcXeTM5LROPkfYnokN1+SBvDEXkITZHTpOVhefG65asSkR2X8tdcnzSu
	 plR93/WclySPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 69B39C4160E; Wed, 19 Mar 2025 14:56:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt (utilizing software-controlled bluez API via Dbus)
Date: Wed, 19 Mar 2025 14:56:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219898-62941-hZJ2EW7CeJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219898-62941@https.bugzilla.kernel.org/>
References: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

--- Comment #3 from Hunter M (miller.hunterc@gmail.com) ---
Created attachment 307863
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307863&action=3Dedit
Syslog when using Bluetoothctl

Syslog attached when using Bluetoothctl. Shows that
new_long_term_key_callback() is hit on first Pair attempt.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
