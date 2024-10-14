Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAD142623
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894637; cv=none; b=dBlLxkaEqymqzdZQ0ZAH5i73Csm9ka3DcVm7H/xJv2TS8TXtYV3JiHC7fAlKhiXadbBsbVwyoXgXlMbD0njpevNme7DCwJ/V+Yn2Hz/fc4VgodoKKiCVmQ1Yd19oM6T6/AroBA8BmVOogCI3gS8PPWPyn98xwPeiwNQygsQKYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894637; c=relaxed/simple;
	bh=Vojh/h4Tw66LtWt6d3NOM9yEB0C5uO1In/wXiJjq9UU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBBEL+FJUmYP0ymbKdGsXApboQLJW3Qg3FS5QpebI/kOB0LxL+hHqNbkUzGMoRCP5AX/Pd4LaEGNeZDhjxP/yBjTo7ecYGowhWhTA5IlWO0OVwH0DH8Pd6pIjKlAO5Os5lsfeRv60BBsCTueyc5YKL/SMQ5zhAqxmlwXJ081RHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSFxa0pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSFxa0pf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E318C4CECE
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728894637;
	bh=Vojh/h4Tw66LtWt6d3NOM9yEB0C5uO1In/wXiJjq9UU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VSFxa0pfHDC7pUsF/TaCXcyvaHeKa1s901XMqIyAsyoU6HmSASuZ7GejLqTwdc7cc
	 HtZoIS5d8JV5i82oM1nK/TeTLCPfkF8/T0iKJpenIeuoAT2pJw7LFGCxSAaHYXeDz9
	 BsYHxTHKcPeO65e0L7Mql8XxijuqnV5VttnhEbaSky000w9evWghwF8j/buUBUI8rk
	 pczUs3yAjOU8+f4BISdMHd++xZFkp5x3Z/osFabwEZleG53QC0vAkNu8NrXNdn/SgW
	 VM3+QJZnZuUpzeY6lh+9WKRaJRhzSrQf6S5QWpct9Y98OnIh0/fNSXvrpf2GOfWz/7
	 Jijz6yI3uJtJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 24767C53BC2; Mon, 14 Oct 2024 08:30:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219385] BT mouse can not be found and/or connected in 6.12-rc3
Date: Mon, 14 Oct 2024 08:30:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219385-62941-A0LuROcb0y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219385-62941@https.bugzilla.kernel.org/>
References: <bug-219385-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219385

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de,
                   |                            |regressions@leemhuis.info

--- Comment #1 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Mark, thank you for the report. There are two more reports on the list with=
 the
same findings as you:

1.  Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't fail exte=
rnal
suspend requests")
2.  Commit 610712298b11 ("btusb: Don't fail external suspend requests") bre=
aks
BT upon resume on my laptop

I think, the plan is to revert the commit.


[1]:
https://lore.kernel.org/linux-bluetooth/020c69d7-ad86-44d3-a508-22ff949ee7e=
c@gmail.com/T/#t
[2]:
https://lore.kernel.org/linux-bluetooth/a34d2761-dad4-4ae7-8787-6bbf0553831=
8@panix.com/T/#t

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
