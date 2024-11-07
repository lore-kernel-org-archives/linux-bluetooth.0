Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784292185B3
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013094; cv=none; b=AfjmeVcJpmBNa8AF6qbgEEz8YQOAFzxBFv8mGvF0CnNeb6Yi7pWlGfaTB36voLAa+kqpxJ9+HkDKoRA0j3bDK4anmXSDh1N1OcMMMAFr2n/bk99GDiLJQZwdN3VXFg1AGXNxXD3f4uat5xrX9zI+/VmgN2So0XQAssVcarX7hho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013094; c=relaxed/simple;
	bh=FSc2JXxstClhqf9OXpAuIV8HPK2ckNNrIfxO5AulBB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4j8gd+dTv5D55Zq1gaBFHTTmzZkPrePcWEhnz2cXXltNyk69+CKqs32iPiyrAEJc1ute//kM9lkDE9N/yR3wIArBI/l64ESWAV57uYom/nhmyn9jH7mOKjEeo88gEPHXUqPTpfFIp0flGjN7eGAIIt5nkfMmZUkM4tmxwKt5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuitYLjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuitYLjr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 121F8C4CECE
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731013094;
	bh=FSc2JXxstClhqf9OXpAuIV8HPK2ckNNrIfxO5AulBB0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AuitYLjrB8BL95QO6JpKlIfQ9Hmy9rpsl7LOiWbAAvgnRKaW4DrQkZWt0gM4buvnB
	 s/3YcG1HjTJWDywP8BAn1rjTg2XOekpNwrve5LBZTajiWdrw8ttZG5s5chvusDiEvM
	 FUi/gN8ifEntw1yGASw6B31sBRM5rXE5im712LgPZ5GIyaP7QYm8+74EmMY6+hEYgE
	 lt0tFMMk0Vt/6m34P0XvoIH5/97ZBXgTBU+woafndNyNNwDo63E42CMlK0Fn2TDFSm
	 WwKkFU+sa4anhL5MXe+Y0qVGDsu25dj//HwBR+fINDhdewkE1kPuW/ZRBmcT9JM1ht
	 fgC1taOxlIgNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 063D0C53BC7; Thu,  7 Nov 2024 20:58:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219458] bluetooth connection fails after L2CAP: Fix uaf in
 l2cap_connect patch
Date: Thu, 07 Nov 2024 20:58:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghibo@mageia.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219458-62941-DgovrS2ETp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219458-62941@https.bugzilla.kernel.org/>
References: <bug-219458-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219458

--- Comment #4 from Giuseppe Ghib=C3=B2 (ghibo@mageia.org) ---
btmon output added. As you can see in the working case the behaviour diverg=
es
from packet #16 (in the first case, working) and after packet #94 in the "n=
ot
working" case, both calls ACL Data RX with L2CAP: Information Request:, but=
 in
the working case it's followed by HCI Event: Read Remote... and other comma=
nds,
while in the not working case it's immediately followed by "MGMT Event: Dev=
ice
Connected", like if something was truncated.

[working]
> ACL Data RX: Handle 256 flags 0x02 dlen 10              #16 [hci0] 413.70=
0565
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Read Remote Extended Featu.. (0x23) plen 13  #17 [hci0] 413.70=
0588


[not working]
> ACL Data RX: Handle 256 flags 0x02 dlen 10               #94 [hci0] 20.20=
5711
      L2CAP: Information Request (0x0a) ident 7 len 2
        Type: Extended features supported (0x0002)
@ MGMT Event: Device Connected (0x000b) plen 13       {0x0001} [hci0] 20.20=
5764
        BR/EDR Address: AA:BB:CC:DD:EE:FF (Company)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
