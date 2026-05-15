Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273F3D332C
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833488; cv=none; b=JPprv6LG45CyHEMoxSB5hQRckKArH87MpFLtvEm3L3xRdTtkannprvjk3ohLOJSNTVILy9hXoyqLWgcj0KKWb3Jzu3gGZxWHTNI2le+qKvLE1lLbkuSmQxAaDE7iTnKli83fOLnVl7xuc7JE1yhiz5AVEzVuYig3yNHDaGIpQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833488; c=relaxed/simple;
	bh=VsOmjGMK9hj5sU/rQHgVhq6LC8AI69Jm5MYQSZO/tuc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYiEGGZdu38E9V0al0HXPDsO2mtU/NROi3DqbTJll8T5mSMQdeZV8pF7/GjZLNOc5M75fRXB01RnQVQT0Au5mfGBuybRIWh/SEiRsB9pZKj+dqbLm8TqoG1CpTkQLA75inWXbSEY8fkioN3Q26PBqQL0LUqubcbnTrqTJxbr+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq5P5idu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq5P5idu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFF0CC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778833487;
	bh=VsOmjGMK9hj5sU/rQHgVhq6LC8AI69Jm5MYQSZO/tuc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Iq5P5idu7DOLtNrVAv9PTyZ4TeXx88USTS3P1sQfuvYeLzEid2VTHnGlc+eiynTeG
	 6kuUIZ2Qq6ecjrUk9+bRGCmC10XBKoc3vqKvfXUnVBnl5WkPZfQHCwmYhc00oXrbTG
	 r1yq8bjGKAjP4qno6C45btXl1QRH46nGqhQ0vCQntz60EPBbjmb8xqZBpP9jdNmJWN
	 aHkUNUWMNq9+H441cLJi/paYKg8UT7g6rcx/0qf7WKYzA8qf714fT4JlVFr1SvYzVm
	 7bsjWrE/8wElYjh/JCFz4OQMfSbbdPqXTxK0Wbn0mDsPTLnNPrJYsX2EyJ/0Yhoh0y
	 guZycKZcerErg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CF85DC4160E; Fri, 15 May 2026 08:24:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Fri, 15 May 2026 08:24:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abuson2@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221521-62941-Bvp6SoIKSq@https.bugzilla.kernel.org/>
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

Piotr Be=C5=9Bka (abuson2@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |abuson2@gmail.com

--- Comment #2 from Piotr Be=C5=9Bka (abuson2@gmail.com) ---
I can confirm the same regression on a MediaTek MT7925 PCIe Wi-Fi/Bluetooth
combo adapter.

Working:

* Linux 7.0.6-200.fc44.x86_64

Broken:

* Linux 7.0.7-200.fc44.x86_64

Firmware is unchanged between both tests:

* linux-firmware-20260410-1.fc44.noarch
* mt7xxx-firmware-20260410-1.fc44.noarch

Symptoms match this report:

* Wi-Fi works
* bluetoothd starts
* rfkill shows hci0, not blocked
* bluetoothctl reports: No default controller available

dmesg:
Bluetooth: hci0: Failed to send wmt func ctrl (-22)


Booting back into 7.0.6 immediately restores Bluetooth. A full power cut do=
es
not fix Bluetooth on 7.0.7.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
