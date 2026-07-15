Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B63EB818
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117547; cv=none; b=AjXEtx3/o83yQa9GHLuHO6eEMhxDA/QtuYLVwDQkQcw26ewEPxIhHezGQJuTWKUrE7KtI1iCiR7cdf4GNRee8fIYdjGH80UYWqEQKmpWyB+8yINP2YICB5vNZ+LQ9uyMFQOo25oQT4oh+zoAELaxyooSOzzGzYgjkw/Vs71B2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117547; c=relaxed/simple;
	bh=N6zOzSy66iZDfriXbzy9hx+AKwhZJMkkQjAwNjccNW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aNsMfOr7LNQDLSwTPYrPg63x7XiKM7VAaHr8MdIyh2uKvoK4qj/EdINjnKjwiItitSUxS6WiPvKHVk/5ycmeZQZrGAq9aBWN5M68xSaPWmado9J+n+VUx1ob/Tw40Ty/D6CvavVDSOARQF0nDfpFyfmsobTj7htkYCbQ8GsQ2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk4orGQu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk4orGQu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45D32C2BCB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784117547;
	bh=N6zOzSy66iZDfriXbzy9hx+AKwhZJMkkQjAwNjccNW0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Uk4orGQuq75/trqQm2SN6AVk4FTUb9a78bHP3HOt81kozQoSh/Rto2Ji+i7p84tam
	 0Fwy3iGn5zvdaJsco7YeDSElEHM0aZPCTCW/2xV4APVEc4KkaMkPp54SJktRNGQVUI
	 FMUZuiuKqncS83g3rbPSeiFElCL5ge7KkzRzku6fRgJAeHKmcbT2XfX75CHOZFOsH+
	 vJXK3Q/gfCu0vpXjhxkMxlz+U4qHz+VNbeVWnfSJBMcI2l0X1BbhUxfdJQyTrJC+xh
	 UxbRslmLseYwc6aWeMKU2MmdFL6r6D++pLcnHDxMs72nB8t1plGwBylWTYdohRmvAJ
	 YSTaDOTrudVmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 225FDC3279F; Wed, 15 Jul 2026 12:12:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221754] RTL8852BE Bluetooth (0bda:b853) fails to init: Opcode
 0xfcf0 failed: -16, hci0 never registers with mgmt (BD Address
 00:00:00:00:00:00)
Date: Wed, 15 Jul 2026 12:12:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: serge.brun@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221754-62941-XFNhxrWWLG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221754-62941@https.bugzilla.kernel.org/>
References: <bug-221754-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221754

--- Comment #1 from serge.brun@gmail.com ---
Created attachment 310453
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310453&action=3Dedit
rtl8852be-bluetooth-bug-report.md

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
