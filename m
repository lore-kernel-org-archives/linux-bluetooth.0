Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792668225;
	b=iaDE0KJ1rChGRb4L2CqU57ZoVuxRHngOb19W0pfr3mThGUzmQGOBiVHczoMWCAVMYOAZ
	 Zwrxog3jXW9yQi/TFWrrGM7afdRm7UowSGX3yaWGrW1RhTiGlLeHsa5jix+lZcJxfjKj0
	 v7RTsZ9z6MoUlheUupJjmET20dXJCrSSM7wQ10AtwhKQMF39eDi6LWVa/tAENJdTdmL8K
	 nNE8RAGz41pNrbZ7wAoDqDf27WwVZmkgZVspeEN/JXHYR6Porvd1gUhlrpJYas7ssNNza
	 ND3giac2Z+VXIsbVhmzXqLs/3ZZgmwOxHw89bGshRe9wKpdGktSaTFBSh0EZ8uVEn+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668225;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=mRa1M5yIWp+M7Z3Wyq4vgjcK8kUQNjW5NZ3igmh7XRQ=;
	b=wqDt7UmjkpeI0gezdNF2RZeE1vWNW2n4pvW8WlxAgyMiDrYfIgwRR6I7mQTz1oxsfWBi
	 YC/8UMNetbqYEaVpgRkMkA6yf7DejHxqOvhC6DbR5Q/iRVFxTLbPKde0Xkm0OwptHLunR
	 VbQkfpFi+xnLprnEn3TN7jBuKi7o26COPQ8uqUdhEu+MqJ+tQ2HXe8jOYieYPtzMI6i5J
	 2GO0IgyesssaflTtxH90QTHvawmG0bj6sczQtHJMw6NcDCWd0B4Deoj9ozgOF+Idiv1LK
	 HplKbChbQeDUbmxMTQWpUpWKGjNDe/sCjdS2V3xn/QCsZjKAOrWspeRBKaJFtvL/WMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=By7XHBP9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8302606A319
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Thu, 22 Oct 2026 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=By7XHBP9
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8EC25771
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792668225; cv=none; b=li2dHr12zZFIwun9Eu3pcJRpMOh0FP/pbqUgUWOaxky2sH214q95nYXn+OcdtAFM341AltdygHq6sT6wY6dYrPRvafbspz1Dioai25ZRS0vRswxgYWXSQ1yRiA4EF5g8eCvcZs4zUgmJSCckFWK47YeS48cxY6ndUtLLHLc0xL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792668225; c=relaxed/simple;
	bh=6Av4dWcuNy0dn5oHKVwGLy4mI7JZ8yu4pNBQEIb1c6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6pKzdPRbmG2uRRoTzODGB3kxtQOhV4QX4yWHJl4j/2Qlene3wAiQc6HSeNsXzJPuO3A3Md07qGtFiHpGrBPisbk+9jH8kFm3fjrStJ9K3eDJnuHARKl3oOO96/AvQW7iQdKjNes2rHqtN1z7ns784TS2IgzfdeD9F96CEQMOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By7XHBP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF836C2BCFD
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792668225;
	bh=6Av4dWcuNy0dn5oHKVwGLy4mI7JZ8yu4pNBQEIb1c6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=By7XHBP9Mx6sn5x4YlTICvNZVc8BnJXhNfuMJ387qmhFjoINoXLepp+/wdffNl+Ms
	 zI2A3Hk++rDlym65csdPjkzFS34EWx2+z+JU/Zow2gYqzdJKVKClotVmEJGLvm83cl
	 I98RdQojEl0nm26AZBJ6CbCwz9NWasTLWNuZ62VggQCidWFFRs+PJApXgB+657Er9E
	 ZKO4DPjtGY0Rc2fPa6uLW7IUAdKGag4zWhxRKHmRv2rWoKmsEn3rEuUIdsBZ5rdVwl
	 97C6sU9NxRQsIV4KHeLHQjkJnZHKeM2d6hq8vISNRgxHzE8FaeX9PjaEkrDJjfGxL6
	 /Dh3EW3Zdqocg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C6BC5C41614; Thu, 22 Oct 2026 11:23:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222177] Bluetooth AX201 device does not work on Debian 13 on
 Kernel 6.12.114, works on 6.12.113
Date: Thu, 22 Oct 2026 11:23:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ghidoliemanuele@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222177-62941-ILqMnm6ET2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222177-62941@https.bugzilla.kernel.org/>
References: <bug-222177-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222177

--- Comment #1 from ghidoliemanuele@gmail.com ---
On 10/21/26 17:34, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D222177
>=20
>             Bug ID: 222177
>            Summary: Bluetooth AX201 device does not work on Debian 13 on
>                     Kernel 6.12.114, works on 6.12.113
>            Product: Drivers
>            Version: 2.5
>           Hardware: Intel
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Bluetooth
>           Assignee: linux-bluetooth@vger.kernel.org
>           Reporter: kalamlacki@gmail.com
>         Regression: No
>=20
> After compiling Kernel 6.12.114 bluetooth device is not working in blueman
> app
> on Debian 13, it works correctly on Kernel 6.12.113.
>=20
> My adapter is:
>=20
> 00:14.3 Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)
> Bus 001 Device 004: ID 8087:0026 Intel Corp. AX201 Bluetooth
>=20

The regression is caused by a missing backport: 6.12.114 picked up "Bluetoo=
th:
L2CAP: convert to getsockopt_iter" but not its prerequisite "net: call
getsockopt_iter if available" (upstream 5bd0dec150f5), so getsockopt() on
L2CAP sockets fails with EOPNOTSUPP and bluetoothd cannot register the adap=
ter.
See
https://lore.kernel.org/stable/20261022111535.528099-1-ghidoliemanuele@gmai=
l.com/.

If someone can test it, a Tested-by in reply to the patch would help.

Emanuele

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
