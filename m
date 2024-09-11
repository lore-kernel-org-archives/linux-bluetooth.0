Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43624B26
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022251; cv=none; b=r9qiLyCLFBBgCg74wGuDxm/gJ6zjJgXteOHApkq/8WTTEAaySDR2SxZJOSUlCZeMFMRmr9k4z/u896EzIJGNID6qKjV7HXUxaQovrlizYEpyBp6+Ky7+FLXgGaWho8kwkeFf3xbrGMljOXr0/xA0rpFmiERL3Z+mZjY2WOxW56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022251; c=relaxed/simple;
	bh=rke1Pey4GAmHXbUH9kYCvnd/hVXAyGYhM3+5juHSaZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3xWedAst7b+BWXGG/fXZRddA882rS7y2ZFOmYbK4TvW5UjzrYk6oHNvoljmjOkYyIH9foN5ZQGqwdytP6s6flHyhyPT/O4IITNqepUKCu7HCU6l7ynOT4T9yq8izDVJ4dArwiZQs8X8GR8hXorPR+g7CErYOhpj+dFT8sbVEsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY7chD+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY7chD+o"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E3B5C4CED0
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 02:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726022248;
	bh=rke1Pey4GAmHXbUH9kYCvnd/hVXAyGYhM3+5juHSaZU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YY7chD+oeYZ1AZT8kRDbZRkIDjxErnM3l09estCwLebBgwpZuCsFgrI90OvB58FRd
	 3wKbtxEGuRvnh5gCQmPEJssuCsmR/VyvhX4sx4ILAGUY+KIghjV7KvrLKJt1UX2tl/
	 0lIsFKDfWFEU6UakI3B3f/fQsD/+6IGX85XrCcsVT7m7cN7+o97Mt/Fr87r6Qi9ptg
	 SF0jR6g1D2yJE82RB4mmPcG5Z/77IpjjR8k9hVkhItVW9tAI7mKnM65dpYN8CsAy39
	 EEIm+X1jDoKjjpjCs7i/XpvowN+gDVMAhv8MctNjsADchCBoCNNe0/zVwk9VfVrhcO
	 nuNfd/suhzLIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46882C53BBF; Wed, 11 Sep 2024 02:37:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date: Wed, 11 Sep 2024 02:37:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexknoptech@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217023-62941-RxGWmayH3P@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

alexknoptech@protonmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alexknoptech@protonmail.com

--- Comment #11 from alexknoptech@protonmail.com ---
Seeing the same error with Intel AX211 on kernel 6.10.8:

[   15.392496] Bluetooth: hci0: Malformed MSFT vendor event: 0x02



System:
  Host: fedora Kernel: 6.10.8-200.fc40.x86_64 arch: x86_64 bits: 64
    compiler: gcc v: 2.41-37.fc40 clocksource: tsc
  Console: pty pts/1 wm: gnome-shell DM: GDM v: 46.2 Distro: Fedora Linux
    40 (Workstation Edition)
Machine:
  Type: Laptop System: Razer product: Blade 15 (2022) - RZ09-0421 v: 8.04
    serial: BY2222M73501760 Chassis: type: 10 serial: N/A
  Mobo: Razer model: CH580 v: 4 serial: N/A part-nu: RZ09-0421EED3
    uuid: 66376534-3534-6236-3161-656334366230 UEFI: Razer v: 2.06
    date: 11/01/2023
Bluetooth:
  Device-1: Intel AX211 Bluetooth driver: btusb v: 0.8 type: USB rev: 2.0
    speed: 12 Mb/s lanes: 1 bus-ID: 1-10:4 chip-ID: 8087:0033 class-ID: e001
  Report: btmgmt ID: hci0 rfk-id: 0 state: up address: 4C:44:5B:81:97:E0
    bt-v: 5.3 lmp-v: 12 class-ID: 6c010c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
