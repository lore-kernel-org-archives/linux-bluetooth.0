Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423F2E8B71
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766591008; cv=none; b=f/NNPlpy8IgA7t0vDTl/oDYzSzoDl52711gavgeTZrMX6Ct7VkXPRw7SkQqxlsfVYNjFNlw7FLNZMjJXHw5DTzrWfRqcU4Q1/9ukZIaV62Fyp9Ha7qujeL7y9HkK+tVBuxAfw/SHraO351QPmvtkP83BSiB2XvwwA9kFnfmyWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766591008; c=relaxed/simple;
	bh=J+iTuJgrHNeT/I3r8R90USafJ9GBGlYgl6vp46JR/hI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkZJhQHHFQgCuw2VW22QrdGi9HZAOmRlujzcWmLa9bm4hNxLu06wT8T+xXH3cFHyNhTqPcisqklx0V3+z8b9S6AfPp0uomS4JbyxSpLrVSqVfjVNbgsp6+9hyUkh0WVDQyim7s59PBZj7xcZMNBBJvARUTcdDSKBCT+CysWsg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHk2C6EZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHk2C6EZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10872C4CEFB
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766591006;
	bh=J+iTuJgrHNeT/I3r8R90USafJ9GBGlYgl6vp46JR/hI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GHk2C6EZK9K5i0JAc2QZfFiID8C2xRx8Y+B9EbBG1Ri+wiZ9HJucsyteOXGIKWlni
	 9jP09pUTw7DJ4ORjZo8kJ3BgJK9/8uQfnxKJbz1t52b+2OfOieAb9EqgwIb0fCO1RW
	 WTFJax7Guns7tDv7J8I8yh2uVrv1UV2hUm9KVZ7L0eC42ErgejgFTpumyI9STCjtGo
	 7e/x6SYZE8sIvsrE6bgeqhFa+rnf9A5becZDadm9xX1aiD/XHy2pLg4gCruFqbO+24
	 9Iwhc4YjNi7lUuzgLipUSQbzsN1pYr0kZTV01XYknyz8kON77rMRfhtwVqqfVXJ2Pb
	 1ju9DFuvKLCLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F2406C433E1; Wed, 24 Dec 2025 15:43:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date: Wed, 24 Dec 2025 15:43:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jay+bko@jp-hosting.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-ZUstykSBb6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #37 from James Addison (inactive 20240903) (jay+bko@jp-hosting.=
net) ---
I'm encountering these firmware upload failure messages again with a 6.17.12
kernel (Debian testing/forky 6.17.12+deb14-amd64).

Noting comment 24: this does seem to occur from both cold boot and followin=
g a
reboot (warm boot).

The hardware I'm using is the same as previously mentioned, and is a
wifi+bluetooth controller: Intel Corporation Wireless 8260 [8086:24f3]

Cold boot:
```
[Wed Dec 24 15:30:57 2025] Bluetooth: hci0: Found device firmware:
intel/ibt-11-5.sfi
[Wed Dec 24 15:30:57 2025] Bluetooth: hci0: sending frame failed (-19)
[Wed Dec 24 15:30:57 2025] Bluetooth: hci0: Failed to send firmware data (-=
19)
[Wed Dec 24 15:31:07 2025] Bluetooth: hci0: FW download error recovery fail=
ed
(-110)
[Wed Dec 24 15:31:17 2025] Bluetooth: hci0: Reading supported features fail=
ed
(-110)
[Wed Dec 24 15:31:17 2025] Bluetooth: hci0: Error reading debug features
```

Warm boot:
```
[Wed Dec 24 15:32:55 2025] Bluetooth: hci0: Found device firmware:
intel/ibt-11-5.sfi
[Wed Dec 24 15:32:56 2025] Bluetooth: hci0: Failed to send firmware data (-=
19)
[Wed Dec 24 15:32:56 2025] Bluetooth: hci0: sending frame failed (-19)
[Wed Dec 24 15:32:56 2025] Bluetooth: hci0: FW download error recovery fail=
ed
(-19)
[Wed Dec 24 15:32:56 2025] Bluetooth: hci0: sending frame failed (-19)
[Wed Dec 24 15:32:56 2025] Bluetooth: hci0: Reading supported features fail=
ed
(-108)
[Wed Dec 24 15:32:56 2025] Bluetooth: hci0: Error reading debug features
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
