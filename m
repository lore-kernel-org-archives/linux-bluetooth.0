Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6E3112C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790953; cv=none; b=ZOEuxDdCPQsQBBaEdWXJtK8/ZdCXHGx1YuBH4IhLDP+TBhREbE0g11roMWlialR5SZvK1+sjg0ZdfHCLidPbCGp6xhjcU/3uN3Bi6/jlwBfVck+RLxNoPVRUzGO3yCI9qlW8+3dwz1iHqbDgDC0uH6IWUSUB+yk0kFJ2SQys7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790953; c=relaxed/simple;
	bh=QbHn3stp5gFuQSPvOGv1w8p37kWUW05Nrl2tLc095YI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkd1fbZsb3cO52RIQU/LC9gGimExphWjoezLxa0AtUh5pCFw7sivVXBkhUKsYxoQyDp3ZCa/EvzY2bjpH6B2Vzy3AAhEAUo7s8n/KZki1xDb/aNLJpnpowp4beHzlZCXXZo7/suZFnyM/8W6uAjdQyiBfpLkBhJmpiksAloJSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5dvTlPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5dvTlPY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDBE3C4CEEB
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790951;
	bh=QbHn3stp5gFuQSPvOGv1w8p37kWUW05Nrl2tLc095YI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u5dvTlPYAA/Qejrxiu4b2tT4SZ7ku+Ddsv8jIS1J3LMJCqJTCissZXMjw43C07FMP
	 nvLfi7MRqw37div+svfYgmSL/9NPEsQW17CaTfBxDGenLoH8wo+XUlQhejo9UiAMRB
	 aNdoIpYQhD7f+wijhxiPYyd8ZacrNvD9bKpWTK0488NYOD6uM26+bPYwDKqcfN+19F
	 77GFm62L7FV9XIcqU5wpTfgAs/EmhZUSl5T/e9bZ5aSZI0Ti1CivcFX9S2aDS3WjGb
	 YA9HcmeLEFVT3waW45EYPqVT3g5a6HOsSDNeG8cEIjhanGVYyENFKK1sKyVQLHCDc2
	 NThUhZZw2kHiQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D660AC53BC5; Thu, 21 Aug 2025 15:42:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220481] kernel BUG in __slab_free during btintel/ACPI DSM reset
 on AX211 during hci_power_on
Date: Thu, 21 Aug 2025 15:42:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: emmanuel.grumbach@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to
Message-ID: <bug-220481-62941-Nl6wbfF3wA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220481-62941@https.bugzilla.kernel.org/>
References: <bug-220481-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220481

Emmanuel Grumbach (emmanuel.grumbach@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|network-wireless-intel      |Bluetooth
           Assignee|drivers_network-wireless-in |linux-bluetooth@vger.kernel
                   |tel@kernel-bugs.kernel.org  |.org

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
