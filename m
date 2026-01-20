Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADED3F23A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952397; cv=none; b=q4OvP0FkBOhl5xrrnTMZaRt87nuldQq63JYMOkAN5I2WKMm2jlryd2bHIyxU5iEnQhjxAOcZCGwxdZwyFI6u/kp96+u6oOhdRGZ9bXYKXFtLz/7INFjNPf9vqZrb6cbk0H/o6HQpGLftW4l7Ws2y+NBp0LjCayFy+7bNa4PWFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952397; c=relaxed/simple;
	bh=o6kqWZpsuOWJ8oITOBlra4FraiJjDA22SyjXMeZSHHU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtrXqvft6MuqBqOLGayTR5OIp6gUDNVcVPV3SoFU5UZubpoJZQNRWvb4KTxsKv5GQhQmCBp5QLrpDC4tpgCEpK/gtxIhDKwhIegx+9tWRdHpUtMJsIYVNFPjE6SGkZmIvfA85t819J697kC7AFv3yVpXGBN8Veq161tYqWrJnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpHmSFAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpHmSFAy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDE8BC16AAE
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768952396;
	bh=o6kqWZpsuOWJ8oITOBlra4FraiJjDA22SyjXMeZSHHU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NpHmSFAyfpkLFwW5TQEV5xVBFllCot431ffHbVYXdfWZuq/1W+jhnq10DX4uHbyrO
	 pr1oVaJsJKUTOISygEDpd8foWvuBPzSBR1JCR+1tyFbJe00MRSzDPPzHCAmt3TTSEk
	 OJA9v3QWTdoTSI8eJ3kazRiuu4vTKD6tg0gSDvHIGr34RUw0tw4leB+QsjwEfsr2pm
	 oHqqPne42NytXL2tUZYq5/mBkoMrgf2ejlM5FQSVWGRT+2S655HxMA2CfeUNe5in/s
	 tWyk3ZysN9IGWJjjtvLDAHi3fZ43S9pIZ6xLoAvmIuoooxY4ZImoepVdPNL0vVxxvE
	 P7S8O/D3wHtMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B66F5C41614; Tue, 20 Jan 2026 23:39:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220986] MediaTek MT7902 Bluetooth adapter (USB 13d3:3596) -
 missing kernel support for hardware variant 0x7902
Date: Tue, 20 Jan 2026 23:39:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aamolodc@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-220986-62941-LYghMuOMZB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220986-62941@https.bugzilla.kernel.org/>
References: <bug-220986-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220986

Alex (aamolodc@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|MediaTek MT7925 Bluetooth   |MediaTek MT7902 Bluetooth
                   |adapter (USB 13d3:3596)     |adapter (USB 13d3:3596) -
                   |fails to initialize -       |missing kernel support for
                   |reports as unsupported      |hardware variant 0x7902
                   |hardware variant 0x7902     |

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
