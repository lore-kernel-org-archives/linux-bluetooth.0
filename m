Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89693A3E76
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940451; cv=none; b=XtRuj/XTvD2Rs1X9e6M/twTJ2F+onj47+3jlboizTNL6ZCalZZgy1alPZ3V+ywYhyT+g4olbY6rtKVpCI0geSjJIZxzGcUKNPdebFt+14GPwrAmd/OAP2qlMksGW4WENTBWUjdB7e8AUwX/rlmRxWqjekEYGVSX1w7L+0FNk43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940451; c=relaxed/simple;
	bh=RtSoHGmGqKvPceI7gCWG+uqEj514W6/pPRu3LkkJq44=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D1EmXXGBWWClmGOAAt3O/U3xtYbgaT77veGg2XtSUo3d889yreDaB+D073GohLcaDVb/pn7asxhKBU0FxzxrVEu/gSfptFXgblHD4N9Yaa4B3ahaXsll7xWRdHIUsFwLjM15QslwivzlUzv7y+6zzKbUlIO7vYNOMMtPsk7RuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc9ObD4h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc9ObD4h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59561C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782940451;
	bh=RtSoHGmGqKvPceI7gCWG+uqEj514W6/pPRu3LkkJq44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nc9ObD4hO75BgO8v+KV94WsQ/9ZThWC/2gDkBZDdBc2Jg/Tl4biNJxM3iImW+CVsZ
	 tlZYThtji3oCNg7FbK7vONcayBmFf1I2miHb31i/ESsFIbuPZxmY9qP9RGzvFdgDaw
	 DMEjWCb90ov7SoxGtZAjdGqBFy3opSAGIPsfwuzGw3HQN+qHfwWbQGcH/vOHcl/dby
	 +6vUK5ID1GYuvOdyv9pg1Qythyaipw5bWDoLDls2oWVJMKp5zxt314q8VD2P2c5eGr
	 az9iAhf+C2XyyUM0yjC8Sr4TsW7jNXqsCPveFy60oR3OIeSSyt8rw2c6/S05bP6ut0
	 iUEZPqTP4dzDw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 47BBCC41614; Wed,  1 Jul 2026 21:14:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 21:14:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robhogan@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220564-62941-dzsHoJW5ah@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #16 from Rob Hogan (robhogan@gmail.com) ---
Created attachment 310410
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310410&action=3Dedit
dmesg output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
