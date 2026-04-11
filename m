Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAADBA3D
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911554; cv=none; b=rYqkWVCVr85dDuKQqyg0bBAJbK0uvciJBsOQu9+w4CrZqSmsCR9LcxtFk8inOiiPzJSlQK9SPadCKjR0ffNejoYXqkiFI5u+n5cC1087t0ZVXItd3T9zK08q1QQ2dHW4WuXTpSJZCIzdXHtEaLR1loAW9DSQDmD5b0GjLI30wMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911554; c=relaxed/simple;
	bh=5WLscnCF6w4/KrWtzghYD95iZ3XZU1AY8r/+avdus8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AoV+0+9oSj1Iqq/9TPH4C/0TgiknuDA4iX4CdQmkr7tt6h4qNYCuoBvUn6OBkbGSeOCuvvvJzQp7IN/g8WNa37EOps4JqohOSzM45wKBl1mxnI0i8Aj4MwGZPa+VSBjYhpsDQxMorn6SwbdOPggNnCLWg5Ai8w8hOQLmSzULiDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+syyYWw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+syyYWw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB3A4C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775911553;
	bh=5WLscnCF6w4/KrWtzghYD95iZ3XZU1AY8r/+avdus8k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M+syyYWwRTuLjLG/ez9mQ6bEOm0KG/rzLej6LCDT+zU4RKRU+xqaChuByztsoABhy
	 kTXcTM6Tk/JRwdxfsW5CwubI5lRLuhy6wN7B3knkk1Ym0fur89FY/qdRwhfFJHkNBj
	 wka+1gxVsNm0MpXCrSkZX1o81TQpRzKhJBdYt66nHyvgRqWhOLhuwtBUMzJsPOyyqE
	 cVBD6dLyqnr36iyXCv8Pm676pvl842iMDRXM51Zt7qSwDFduiiSw+zez1AbkJ562yn
	 0uBo98eauHeQ3bRk8ijq2vy9nOGfWn4iXwMkXy21Iub7RFLVG2Bwh553Xxp5y26s6+
	 EMwrgP85bBMoA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C4D60C4160E; Sat, 11 Apr 2026 12:45:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221346] Bluetooth: btintel_pcie (8086:e476) may hang in
 shutdown path (synchronize_irq) during reboot stress test
Date: Sat, 11 Apr 2026 12:45:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangzhigang1996@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221346-62941-epAXA1cSR5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221346-62941@https.bugzilla.kernel.org/>
References: <bug-221346-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221346

--- Comment #2 from Zhang Zhigang (zhangzhigang1996@gmail.com) ---
Created attachment 309857
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309857&action=3Dedit
crash log images

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
