Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4833FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234526; cv=none; b=YmgdU2TU6OlnhS+5DTIhABlVGycdi1de5rwNNpzgiw4t8rBwXF9wzFCj/Hy4Rugj/LadxgQnJ02RUsD9aoL4BamWxFAU+kq3iTUJS2ukwUC0MMYCuEf94mQU+ZXdcYFavt0cAMqx3WKC6wOUuOuqqcY+zotLsieIGLXnKNopLnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234526; c=relaxed/simple;
	bh=4cvb5FA9/AqiDuMPjMLvmCAC5HQUpVtbWlEmcg6dYII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llpi58z7yRI+SMxiycxveM+zpRDiDhloJ2cE1VuwcDtw/AR0U0XsLfdRtALxryi9AxzMuk/GIgN7OUkF7pRUHM+5mljpCcBR+fBkcI0e94r/OIUchWtwbdGziw3qS4AK98XNaNzYVatCOgpw7IlcywjmuTEbCsJZZbJ0zE8UJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlqpICZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlqpICZt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 695EDC113CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 02:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713234525;
	bh=4cvb5FA9/AqiDuMPjMLvmCAC5HQUpVtbWlEmcg6dYII=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hlqpICZtliAqDCZGL/fG9ntSASUnvD9nKjim/5wt0YAis6g7Xox2/jwk8PG2pfBXa
	 6zJwJSkoq0msGr/jSW4VnQr0AMBu+eNtrv0dcwwvaFM9igRzM5Xus/o77Ygh4KRURJ
	 6LlGf3FDfVINaL6fTosdQSrSN3HJGFcEKz6qW44EHoNwu7gdqvX1oKdXBuZ0ZySshT
	 VlDDu4t/KrgnB4aB1v0/J8PYIifayOjfaslPTSDcn32FxIhXUJf0owVKuD1jmEv5i8
	 7eX5Zz8R1diILG1fbE6B9OLW4DlsRt9wycs/rVRDNWPrwYox3J7X0Ij/wTIiBP16i9
	 WQJ/GZCHHicNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E151C433DE; Tue, 16 Apr 2024 02:28:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Tue, 16 Apr 2024 02:28:45 +0000
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
Message-ID: <bug-218726-62941-gkL6lV8Dp5@https.bugzilla.kernel.org/>
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

--- Comment #14 from Zijun Hu (quic_zijuhu@quicinc.com) ---
for issue "Bluetooth does not work after a warm boot.", we need to log of
function
qca_serdev_shutdown(). it is called by the shutdown phase of reboot.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
