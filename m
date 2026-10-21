Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792547814;
	b=A8hpICvV/xFDkkekFnzPdxExKqyJZFytDy22cyxfdfMbKPrsBArZwT+qNnuFAPOcBukc
	 DfBDjpawWqVg4DNgwQ9N5q1yq7voutym2+elE4d8YGdYXjCIrVrFF3W1FvxVF973avdUE
	 hXBPFbJW1cQvC2XioE1n2xZEyHbDi9PMF2CS4Hh8w4mcx2QfFVv73fDAlFNqC4AbgGG88
	 OJnGe2GP+5Gc65S2C8bwPZ2y+dAv5wEDKl96lpi24gBNVtoDLqgKMwPuuBriTE0RP/ogj
	 /lkRzdIPJ/DDRwGNiqn+5bBFE+Sip1uTBMg7T1z1V7xirI5dx/U0GcTFo5mj2KffJhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547814;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=d9sqJzVsLmXiqXaRXie/Ya+Nct+pOpzeG/XjyQaRJWA=;
	b=eNl16XiMLHnoYAPo0RkFlIxeYe7ur+miYmpW2ShmizeLl3kQwUwP0VnookK8ZwuxtCmw
	 G/v6G+IWkEmou3mKVn3afHIQoM9cExdTX7784Y84JJfAu+ls6WYBfFjrfdet3r6NChEC/
	 YBVRWxmlqDX1v4Iuzi8f4cPbfiby6xryLLBmMKk9094EQDtC1c45imftIUYR/NBsRVI0M
	 If+2XTZYP+lpPfqWtrA5Dz5H9UzePz81WGQQ+XbHX9zy9kqsx2ciPLfDw2alHfwySKkhq
	 AXl4yGa/phJwtEc9Rf6vKf2uXYdtp4rex7P4sYWIF3aP8zLIJ0FGdxcwm7S1MbrKIJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MoCwSJJw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF334606A335
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Wed, 21 Oct 2026 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MoCwSJJw
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C025771
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792547813; cv=none; b=nQrjG3nsNpr8BYpNIuSPNDQA58NbYBUvpc8WAMtITKFxFE1lMtd+aBriNTP5a2YNPefj+N8X3aBldmpcLESSKLSH1Gk5A/lPivubsdoyaNFe5EnWvh/AdnQmymYTEDvitVF0cDWmVECAWZS0SGt9AZ985WUS3k56sKxMtXK21kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792547813; c=relaxed/simple;
	bh=n5fiHwnOGp2rD6vpmvvggKAZY7LaX9SXMkbIym8gNTw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GPJRPZ/pgtbgZaPoPG4yw36x5Qv7cXPA5xGQiebShSHlPmZRGVO9WLZY9K1eDR8JG08pLQmrVTc5l6rZV12Z0vrEB7iv/vgtlSZBy9FruHeRX9/KZhNlUM3fhFrgLZ9pJNT7Ro7vPTiwebGAnVwWrFikMdBwSpjruSfVL9p5xyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoCwSJJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FFC2C2BCFD
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 01:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792547813;
	bh=n5fiHwnOGp2rD6vpmvvggKAZY7LaX9SXMkbIym8gNTw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MoCwSJJw5gumet2KGVZ+QGy+N4If05yBEn5nq1mvme5EU5xNUdPF5LR9bxihtkvdZ
	 wMni07l5PZu5mb7ZXAhQhl/WpvCMNeSxBAUowXFlbSoXxnShEPCBgcjEjFjZ+vyKxW
	 P79pcccyLshVtwNhu6kUGRkwqacKGtr4PSlcJ8h/j4VFbDl0SMJlNi2lTwjRyHPPk/
	 P8hFNLUn/O9aI9zBkAQmTmoubcRmAgiC0k/debhuAB1AE12uHXh+zj49smR5PJxqX0
	 vUpwFFobyZeZ6SI8qt0vv2qM541IBV7RXv7/+yBNVNMLLebphzEjABhOAJiRLFsNbY
	 BP55gqaq8qtUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8DF1CC3279F; Wed, 21 Oct 2026 01:56:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222164] MT7902 Bluetooth: firmware coredump after ~10h uptime,
 then "subsys reset fail" and permanent USB disconnect
Date: Wed, 21 Oct 2026 01:56:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hongweifei@cyue.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222164-62941-2O7XldSSWu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222164-62941@https.bugzilla.kernel.org/>
References: <bug-222164-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222164

--- Comment #2 from hongweifei@cyue.net ---
Created attachment 311209
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311209&action=3Dedit
System info: kernel/bluez/firmware versions, hardware IDs, loaded modules,
crash timing

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
