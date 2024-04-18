Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930D7D08A
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428054; cv=none; b=XBQ+ewdgv5JeORNDg6iWe1aRL6KtxX7QK0WjB3jcxvCM9zjpStSs6DjVTVoJf+aq1Ccu+uOJSHjzUXDDreX5/W5W3cxTfxncEKxuiY1Ly3fiAetYGAkR7vhvemIauhihfIn963xkzyZOEComw7ziChIBA1YJIStJpTfTQ5/W0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428054; c=relaxed/simple;
	bh=rABg72g5xbyuX4BifkPkfpKTNXGiudrvaARSUX9/g1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAm0MLOt2M8/RF63gAsbIdXX0g8GZpdcKxRlIR2sq5AZBpjNLImmXcFJpyabFqH+OY/KX8xMfaWIoXCbK/1ywhvnKDsvu4odRUHV85RTzkNcDiiGjcCmKaXONRpDAL3n8mXiFmSPpBTG4UVI9zrseDQ0XwGfBdCOFrtAeKokrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3k/tS76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3k/tS76"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FF8FC113CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713428053;
	bh=rABg72g5xbyuX4BifkPkfpKTNXGiudrvaARSUX9/g1M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G3k/tS76Tz7ArGXgAjh9cFN7dnqtEhOQaUgfUqGDn7JCa3eCaAhLbaRJJkDj0u+wm
	 Obq8yeN/lxER6S9BZtTiGw1KaQmkhuFTPEeVRGaoRqDgQ2fnZb5BzAyt74nu9R8io5
	 TFRRzl2W0d2I5IMB+dmHa2G/ykF1cXAnMJvNfcfj0eZtokONaLI9yPrlm+oLdUWGHr
	 IFH7Ll7N8xiTB2XSHz7ibJSoWnh0VHufNCjrBBkjm3zmabrm36o+0yswH2tgqwwuU2
	 2EPUGQeDqEa3XCoIyEn73cPGlULYybMjdIb52lEHdxcL9/Z6Nz9Td/OVyT1caYGDwR
	 ly1QR3CAZIjqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5D539C433DE; Thu, 18 Apr 2024 08:14:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218726] qca6390 bluetooth fails after disabling/re-enabling
 bluetooth
Date: Thu, 18 Apr 2024 08:14:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wt@penguintechs.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218726-62941-0FWL9qxgGF@https.bugzilla.kernel.org/>
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

--- Comment #40 from Wren Turkal (wt@penguintechs.org) ---
I know this is a total newb question. How do I add the footer properly for =
the
purposes of the log? Do you handle it or is there something I need to do?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
