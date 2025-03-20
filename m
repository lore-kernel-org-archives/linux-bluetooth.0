Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BAB1DDA39
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503289; cv=none; b=W2GnzrumMXdgXVWVueD2J2gjLB4GF69IoiAdrcDWy7uZcOAxvGr38/dd9TCro3OZ5zrAU7Ke6Htmwb18grzc8NZxxYhtKwiz7NwjlcM4IByzzia+F3bGrcdB/HJAIAByIzqn66QUzfjLYc9PRj755owibCv8nFY1L0YbZAZppx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503289; c=relaxed/simple;
	bh=42ABpmiHQxeIQyyhvpCChnUZUDul4N2SMxtP3gJ3vCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKQYW3tsupO3PgVfzrCHseEOQNPbI74dtjYD6O1p9eat2ajEiRP3QAzyLVWPDCk9YS4PSMqDp+ZMIWXwjOr+ytLrqwv/+OFbP5UOS9GEt5q4pjlw0K5Ni31Y356KivPuktGPCAxS3ReVdlexBmeDtPCXumI0Gew2eXnt8NX9YxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkFZgntz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkFZgntz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B21B5C4CEDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 20:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742503288;
	bh=42ABpmiHQxeIQyyhvpCChnUZUDul4N2SMxtP3gJ3vCI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EkFZgntznKyxBJbyhHLUjlGC6utiA4AJOuZxKRlxn2bkst8pjjCa+I3yeb7k8r8B+
	 OGl3WOuAKvVo1PKAPt+E+NRXqqrth9ZE6okPrXU3/uCe7udFleD7XwDGxX6XwfN9fx
	 9A05F4YC7ukiepz43hH6MJwJyscuFs4LDhg/apPzJBYnkwdqXqOjp7Q67GXM9D7fph
	 lWF7KrvvRvZfJBPAZ3jHUPPb/0DP6ksfKqO4aiap2wRdv80dkZfyF6IyYlK1Rytpys
	 NA51cvSKYKY0Zybr5V5TDx530Xz6ymIfa316COiTUeU9hmdsbr1dz4SrutGy73QH2r
	 7RN42k17icFyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A8A31C41612; Thu, 20 Mar 2025 20:41:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt
Date: Thu, 20 Mar 2025 20:41:28 +0000
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
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-219898-62941-weT6sCP5u8@https.bugzilla.kernel.org/>
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

Hunter M (miller.hunterc@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|BLE - Intel AX211 fails to  |BLE - Intel AX211 fails to
                   |Pair on first attempt but   |Pair on first attempt but
                   |succeeds on second attempt  |succeeds on second attempt
                   |(utilizing                  |
                   |software-controlled bluez   |
                   |API via Dbus)               |

--- Comment #7 from Hunter M (miller.hunterc@gmail.com) ---
(Apologies for the multiple comments, I should have added this at the start=
).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
