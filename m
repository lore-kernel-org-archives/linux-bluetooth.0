Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843722A1A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502206; cv=none; b=atGS6NfEXc2kNHHbqptaCBwAcSoMB7YeET8sICq+7O4gKI4ELK7LIG4egvCOalivrWiIkD2OblwQYgJDwARAcHCHGRU1k+CKFNvraIO7F6uA1JZdg2gGYO1a3l3L3N2WpPNxLAudDNIjgviFPM18q+eKtn1vq9kd5KnTlp+ovnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502206; c=relaxed/simple;
	bh=ajZ56rS90onStK2bNEt/47fEyEuMTE0DB48Zzrg2+ng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZwNPSjY0wQC4b9ZA7/gDlbFC8W/cMX+EbUb7A/mE6f2AUpmFLfV0IXhSvYdaxWvjgtVpo/Hlxl9FYfrr7JMidQIqgVCD1a8qX3Wi2othoc91vnUzwWpsEI93IcyXJr5otOVrTMyrwJ9d5v0mIBmzVyd53Pr0m2sx5dv/+PWm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXZQOp5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXZQOp5u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3F71C4CEDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742502206;
	bh=ajZ56rS90onStK2bNEt/47fEyEuMTE0DB48Zzrg2+ng=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qXZQOp5ui5a/D2t8PXe1ALoPTNd29ClqODA5lFw+nEDUjfmGZLvufhdCFmOgbysYG
	 MpJD1VhR9po4NNjl7dXqYY2T4quTyDRXSOtnu3CuijumgVLxSrIxmjXjXHa2RMYhjM
	 VmO1GsUpVhucQ2Ze+YsSo3lRDIl9Vgvd8CRlRIFqGSPPIgmo+c1CdXvX/leA4RUSE4
	 NQsSzt+2x0ykQzMHLXIitzp8XtHHCoOawcZ6nsTQWeXhiPClCxTok/xky5Na2BO/5q
	 vVuECoelwXj4fDfMUYWahaXobDM+vu/RTfAjCVAV6wSqhOeVYiOIIF3vklcZfCGgaE
	 +AyRhuQk33p7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E49E0C433E1; Thu, 20 Mar 2025 20:23:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219898] BLE - Intel AX211 fails to Pair on first attempt but
 succeeds on second attempt (utilizing software-controlled bluez API via Dbus)
Date: Thu, 20 Mar 2025 20:23:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miller.hunterc@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219898-62941-q09O2RrBf3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219898-62941@https.bugzilla.kernel.org/>
References: <bug-219898-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219898

--- Comment #6 from Hunter M (miller.hunterc@gmail.com) ---
Created attachment 307873
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307873&action=3Dedit
Successful Pair Attempt Air Sniffer log

Air sniffer successful pair attempt (second Pair() attempt via Dbus API).

When pairing succeeds, Master sends LL_ENC_REQ after Slave receives Pairing
DHKey Check (see successful pair attempt No. 67 and No. 70).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
