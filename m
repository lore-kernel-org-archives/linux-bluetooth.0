Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84696AB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233937; cv=none; b=IKXBAS8h5stoNpRd6jHoGKNSS1yOcLf3elJuLDcjoZUifb6vzplbnYJbDu0YRURPaSXH1kMk1Y6FSz5WA8PA3b/ADeMF23y9Co3sVG7y5jA/HWGpunJKdsB+8hSh81wVgPyNQOsslIOntI5t9JhR4+89aCsmR3TvlIooAwh4dT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233937; c=relaxed/simple;
	bh=p/Bwk6dFnafsoxZimkWx56W3kXjvEEX5PQGl9TTLl9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3p5RmokCBBHGeRvx4yfs5zwqrpfkthPGb6SBEVSH3YcXl6UwoAxPqWsQQVPB1dYeZsJ4uZ++7vARzkQgPZy/68r6M2ZQGrxfssTirXEuiFieo6c6oBdLQbQznO08907alFRtQ9jNJc8agQ3N72S5CCVsn8YfA9JDOu+Rm9B69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8zlpDun; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8zlpDun"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C45DC113CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 02:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713233937;
	bh=p/Bwk6dFnafsoxZimkWx56W3kXjvEEX5PQGl9TTLl9w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z8zlpDunbSFz+gDRcCRQgfG8sAv1nsMS7RKzXOUsMoyk5HrYzad25oLuCvia1Knoa
	 h2SJBiQqzmxdovoW9Ir5m0SU0k6MFTSHV43ZmQO9FSIVydwnpE6y3dtkIcJ/8QAVD+
	 01rvJ2GOL70x256eex80NIlGIBD36xELVygjsYOZKDh5OAaGk4smp4cO4UUq8KgEuY
	 Tr8wPNvqttH2spwPmXuaIwiOHj044uH2V2q1SUgn0UsH+xKl7e6v6ch1sYSYO9JQ4w
	 Asb8vdPuWTq/LUhMG2Ik2PHRkufEopDJ3ENTKlS8NKwSTCxTR4dIpP4g06MAqViveA
	 SM1GVHRgj4Saw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3BB0EC433E2; Tue, 16 Apr 2024 02:18:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 02:18:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: quic_zijuhu@quicinc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-OIsa7pbYxq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218726-62941@https.bugzilla.kernel.org/>
References: <bug-218726-62941@https.bugzilla.kernel.org/>
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

--- Comment #13 from Zijun Hu (quic_zijuhu@quicinc.com) ---
you maybe apply below two changes over the tip of bluetooth-next tree, i sh=
ould
have not conflict, then test by following the steps shared

// it have no change compared with the orignial patch
https://patchwork.kernel.org/project/bluetooth/patch/1713095825-4954-2-git-=
send-email-quic_zijuhu@quicinc.com/

// it has contained the change reverting commit 56d074d26c58  compared with=
 the
origninal patch
https://patchwork.kernel.org/project/bluetooth/patch/1713175927-13093-1-git=
-send-email-quic_zijuhu@quicinc.com/


you maybe firstly apply above two changes, then perform a power off then po=
wer
on.
then test disable/enable or warm reboot.

please share logs if any cases are not working fine.

thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
