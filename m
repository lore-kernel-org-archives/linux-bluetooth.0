Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A112AAF2
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540512; cv=none; b=eayLU9ozxU3XY1zsPE0uI31PwVJqWDknCzs7hnbb/M61uP0ZeSoaIVMFRARBLjzwg77W0EJOPKangzCjf6NM1nqdavjn60jZIWkG+RFWOi0Jn5wBe/zKd2LIj5gdnT9S2qprLCIxS1ofgPVYHZmCxo3q7VO2gXIJh1bt0FIVjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540512; c=relaxed/simple;
	bh=aXOH0PZpjleape/WaedvkD/fkWOvtobDP3Wq9mfnRMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+E2Rn1r4nQnYHHesHae+PMeZTOE5YGG8isDkYXFL/kQZXzWIFK64GEd+Igt3DqzSPf+cXOHxGRuZVZJWrcNHWctXmELiB2yB4Hm2ThrmSDDCwqhUe1UC67hZMrDOBsEvqWoM7PLWQ5yftnD1ql1a4O4Agt8RC9vj71NmV8vxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvFts6FF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvFts6FF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33697C4AF0C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716540512;
	bh=aXOH0PZpjleape/WaedvkD/fkWOvtobDP3Wq9mfnRMM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PvFts6FF7enpmGM5H/SxqQniZXRCpc4yaRDTJK1U/z9eimHvNLqjyvaiXNETcyarT
	 umJWjvGA1aDkyCXf7TdA5uywdFo+EPifJLnlLro/FIW+tq3tq6xFPpXIE3L+BEvVyX
	 /Oov43h//hM6DlLuuBk75JDlPUxndWYBNNf9B+6lI6jT5R6zZIZJUpKdncyvVBmS28
	 QSytDZTtYo3QVacv4hI7hrta0MlhWPEher4z8o2/G9sdebwgwsgu2xKIqmHIjLVhf1
	 8mpWltzL+xHKbOSMzIPj9K+xdtRmTk6vETRX1MnsiY/74/GtHp6uZpYQPR/MzxrCHW
	 kLVSbQfR29aGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 268E0C53B73; Fri, 24 May 2024 08:48:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218880] HCI_EVT Packet 'Flush Occurred' Misalignment
Date: Fri, 24 May 2024 08:48:31 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuxuanhu@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218880-62941-TRxKZzlpc7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218880-62941@https.bugzilla.kernel.org/>
References: <bug-218880-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218880

--- Comment #2 from Yuxuan Hu (yuxuanhu@buaa.edu.cn) ---
Created attachment 306329
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306329&action=3Dedit
TShark pcap file

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
