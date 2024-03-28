Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F34024219
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592019; cv=none; b=MiKfx0vVozRYTXN6wxyH9JYeam1dEGL1xYh8z+QPJGJSvYpq2VBo2sCcGdK/Zo8qsj+KN3G9kP+yKrNFBtL4SPrM8wVIjucmBrBBoL1Giq0UbxfE/y7fMikqwjrJn0zSYKjvIjFPLoj2ybIUDWvE52361k31saiPzqEXT6m2xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592019; c=relaxed/simple;
	bh=W/Z7aag4XBkUobTesk+LyX2NjoEpOaPwxNDTWstN6dg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gpt1RG77qUl5MIWbKki5tszIceJBXQz3UzGxVD6Izy8zlF2d8+VtpOr98E7Hkwt74KwoOhJjhDqYU4GF9ziYYZN0jdrMUsTAlLsXICBaFWaiSXBoZ/42Chb7oyt8S1Xbm9hFRuA5YTvqJzpdg2nrYWlC00ufsndb2jwCQa1t5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUQa4d0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUQa4d0P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6C0FC433C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 02:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711592018;
	bh=W/Z7aag4XBkUobTesk+LyX2NjoEpOaPwxNDTWstN6dg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LUQa4d0PmZ+wjLo13/u50CUFHygvV/TGJsuL8mLjwNphXpguoy+OEvSNarPs24yQd
	 MK5MdbycbSYyyy98jC7EgT3Rnlnqw4259VdZ9ppkaTql0o53i/NAEZMOoh6GjbnSpP
	 vcaFkNWgSaj+oi6MIkQoYZXaqpWwnt3E0m25RdEF8S+N9ui4bys30WnFaVJUz+jYz8
	 IXXmEs2VkKrmwcHiNRUPP/TBDf9rxodiQXcDF/XKLZx+EVQszI+QyEVDSqUoA6cwLp
	 Qc6QJBtPRFDJ2K/oT0PRqGDkGxfXgC7qX8cFy3pSQX/Fs2ONii0jeMjqz0ZeoH2u0z
	 iuKQYYmOeq1aA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E0585C4332E; Thu, 28 Mar 2024 02:13:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 02:13:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jb.1234abcd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218651-62941-7InJaLmmIy@https.bugzilla.kernel.org/>
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

--- Comment #2 from jb (jb.1234abcd@gmail.com) ---
Created attachment 306051
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306051&action=3Dedit
lsmod

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
