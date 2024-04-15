Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F33839E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169291; cv=none; b=FiFEZ6Jrfqt+8fM3BifK5sGiVss+aLw9UH/eYxewkw5gFYr959s1gBVcoh/peRy0kS8RC/L1zdz9Gwvnz0r9sf+qabaJd7WjfdCP5MZCLyXXxa/yqHohostUMIxuZ8HxKKR7ngK7BnqA81DGBmrQXSEq27W4IPymZSQeZaesNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169291; c=relaxed/simple;
	bh=EPsZZBrWGPswXWPF7GRczRKJBgRSjZnpMbwIRI5jBPk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SpSZz9GS675zU7/749vm3uyjkgJ8iCXzVS/1/a7TzN4HuPDv1fdhQxU3o+Mr4D6JCgj5U8WnMw3/zCUC/HFHh07hIPOdLIiHkKaHwjBZOD5OBqH1KlmM//EKCnVg51fl0qVhO2dHtioDOY+vodXQjO/Hm5aHQvidL82/Bw49NHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onlNMvEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onlNMvEb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48002C113CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 08:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713169290;
	bh=EPsZZBrWGPswXWPF7GRczRKJBgRSjZnpMbwIRI5jBPk=;
	h=From:To:Subject:Date:From;
	b=onlNMvEbaXDwp8GVV+9gbk26DfoBjRGYmQdCTEN622oQPjkbOOZQGw38+z4cCwUxu
	 YRINUhR7ijSz0BxRnntP2MiDb3Fhgg7N1sLuKgDW/DmyK0RISoL4MSthvladXhzdSz
	 wuaWsa6JO68WWE8jYWOJcNREMyB3yDAvZ4gTq4I3AnO5dLEJvVHxkBoR+4DAr4rjmT
	 4l/P+64Vx2pGQ/dgmaGX+eSpDV8E1MxJJcyppgP6VIU2aCcnHAnqPzxrNx4dUNmdD5
	 J3C6jubt9PfTatGXEnwcP2X1FCForfjW4fcHgz3hJZNZTQyr7v2c3D479C7NEijRPd
	 TwOLGCBXM7HjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 38016C433DE; Mon, 15 Apr 2024 08:21:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] New: qca6390 bluetooth fails after
 disabling/re-enabling bluetooth
Date: Mon, 15 Apr 2024 08:21:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-218726-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218726

            Bug ID: 218726
           Summary: qca6390 bluetooth fails after disabling/re-enabling
                    bluetooth
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.9.0-rc4
          Hardware: IA-64
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: wt@penguintechs.org
        Regression: No

I have a Dell XPS 13 9310 laptop. This laptop has a QCA6390 bluetooth devic=
e.
The device works on a cold boot. However, it fails whenever disabling and
re-enabling bluetooth (e.g. by cycling bluetooth in the GNOME UI).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
