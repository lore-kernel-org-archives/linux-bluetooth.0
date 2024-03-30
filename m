Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C917D2
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711763441; cv=none; b=dyP6xcApq0pZQNI9zRVbSxN/+ylkkTlz0O5rw9I+dqa//drWR21PjFBouq0NJieOtYI40f2bO9NoaqYwr6d7LIfcr1jB98Ucg1oKak9NpKCHpk801dglxiz3quOWr2hETn8PWcfS38lUCRjuIdzTs3uy+RvDFrPHxPisDUeDwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711763441; c=relaxed/simple;
	bh=snjC0yer45gvNWcy5zN0GOkGg0I4HRPfH9xxXyd8nJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMlcG+Kf05VRWFIk4SnzoEs38szCIqxo8TnImaqQksEi719PZkI1mQCOFPBD1JAGLyI4Voqs4YrbzH8F+EyOVrG9tvBHuPtw37mhqBR41kUhu0y0fE/5QzRDAdO/Pbyh5UTyWN1T/6xAr5FXCOUfP83excqS3qv706SaH+DbKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NId9zOpP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NId9zOpP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CA97C43390
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Mar 2024 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711763441;
	bh=snjC0yer45gvNWcy5zN0GOkGg0I4HRPfH9xxXyd8nJA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NId9zOpP/eDoM/SsBcQ+uoaMmfKkZwxj6Hw+LPLPBoTgdqSJheAIEIbudwsivu9M7
	 99mO0pQ5ZUOl9F12BEh1SKuL0QR0uaOkjCCYupyrlL9YUZDYxCtNF7yEZ8TVfKKgqA
	 FxykRE9o0vZ3UN4UIdejgXmJgoat8A6KeghGQIsAFR/O34TkeAU4qNvzxnUjEBqZpB
	 uEmSpHZy9lkm+ckN7E7j4eDgRzycqxMUZzjaPYiDWeB+ojim/HDQiVKMlTVI6pT8p2
	 4tt/Zm0LWOCVdUrYQADsS+4c5KFYjC4xTF0fu3H9gatYGb38ZQznQ98HH5GuHINYby
	 Da5nNRwHZxsgQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 65014C53BD1; Sat, 30 Mar 2024 01:50:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Sat, 30 Mar 2024 01:50:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: sugaraddicted@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-hrRnu3Pa6p@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

--- Comment #11 from sugaraddicted@gmail.com ---
$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [03a22b591c5443ba269e8570c6fef411251fe1b8] Linux 6.8.2
git bisect bad 03a22b591c5443ba269e8570c6fef411251fe1b8
# status: waiting for good commit(s), bad commit known
# good: [8a8b2a057ed9684704792b5d4b333616769002c2] Linux 6.8.1
git bisect good 8a8b2a057ed9684704792b5d4b333616769002c2
# bad: [da2d94af7ba950b33ce7dfd326894460c5536988] drm: Don't treat 0 as -1 =
in
drm_fixp2int_ceil
git bisect bad da2d94af7ba950b33ce7dfd326894460c5536988
# good: [116cc80f47b29edcba609ad92be1ad83d1cedcd0] arm64: dts: qcom: sm6115:
drop pipe clock selection
git bisect good 116cc80f47b29edcba609ad92be1ad83d1cedcd0
# good: [57662cd437c052595711bc733574e6895e074ee5] gpiolib: Pass consumer
device through to core in devm_fwnode_gpiod_get_index()
git bisect good 57662cd437c052595711bc733574e6895e074ee5
# bad: [b08bd8f02a24e2b82fece5ac51dc1c3d9aa6c404] Bluetooth: btusb: Fix mem=
ory
leak
git bisect bad b08bd8f02a24e2b82fece5ac51dc1c3d9aa6c404
# good: [4a09d0236854360d0c33fec01d3c7d9703cca570] PCI: Make
pci_dev_is_disconnected() helper public for other drivers
git bisect good 4a09d0236854360d0c33fec01d3c7d9703cca570
# good: [da0de50013c160f76b0d4c1869be25875f48015b] Bluetooth: mgmt: Remove
leftover queuing of power_off work
git bisect good da0de50013c160f76b0d4c1869be25875f48015b
# bad: [b53e5ef62fe9853648b4478bd6cb3aba970a6f1f] Bluetooth: hci_core: Canc=
el
request on command timeout
git bisect bad b53e5ef62fe9853648b4478bd6cb3aba970a6f1f
# good: [54db3630deff566224de6cfb0767d2d398e68ed5] Bluetooth: Remove BT_HS
git bisect good 54db3630deff566224de6cfb0767d2d398e68ed5
# good: [d8c7785e8104359f139cdfa99e2511575c4d4823] Bluetooth: hci_qca: don't
use IS_ERR_OR_NULL() with gpiod_get_optional()
git bisect good d8c7785e8104359f139cdfa99e2511575c4d4823
# first bad commit: [b53e5ef62fe9853648b4478bd6cb3aba970a6f1f] Bluetooth:
hci_core: Cancel request on command timeout

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
