Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106B2F290E
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211413; cv=none; b=PbNAUSUvaLWWvzz1fp79jLs/CdgdRGXcWqagH0dWsHv+Nj8/CMkZ/vkgPyFfA4im7xHLUXP5v7A5rI7F7mNq/qA2K7GOIRN/M/c0dZ7AcfD0qv/vCSmLr7j94EwtwL5gG1F6SMolWsnbBO045gjO5nmjwLhlvpbOsGzJdHFGKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211413; c=relaxed/simple;
	bh=gzRPUGaSgoeS19Tcj0uwd2kPFGuKaKnmyqmXzF7FNcE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCC6p4n0tWKGlhI0pTb2wpl3IkNuideGRht88VH6vM6O2bcWO5GdyggR1UwDp0SZZKgPIgF7AQFdLPCvLr1+TEeS6jbCtS+Ljx7mhPFquWdFrvNdFDDIfA5Zmyda+0YGYDpD3q12f9WVYtzTAiJD+/5j59zF4R2lC3UbaSeoAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5lqvb+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5lqvb+/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ABA4C2BCB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211411;
	bh=gzRPUGaSgoeS19Tcj0uwd2kPFGuKaKnmyqmXzF7FNcE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O5lqvb+/XecT6g8VDF+ba6xdrpHHql/V4vCpaBEmDwNpXE8m1IxZjC2Klp/vz1S0q
	 XaxSufZsLZRsP7FKuLJFBB85ghgpNOQATsU1jgAoBk/dqYEamE7NZGTTBQ1k3rQh1M
	 qCBwlCIm+Q/B+5I+YoZvbZ1U7qFfDkX6iwunwnoZxmq7Efa+Ufh3JxxGyYQk/KHAnF
	 xE66/r5WRiHrCZKSnmb4+BU3TJ2FePkc/8abbCv5a0lPipyvOwkL63JFui6Qi02lLB
	 etFaDSIFPGqxcz3mfvaijCz6BHagr46HqqMWdihLnfEzYXL3zza2MPx60kpu/1ZbPg
	 SotBf5Uy5shjw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 41205C433E1; Tue, 19 May 2026 17:23:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjE1NTFdIGJ0bXRrOiBNVDc5MjEgKFVTQiBJRCAwZThk?=
 =?UTF-8?B?OmUwMjApIEJsdWV0b290aCBicm9rZW4gc2luY2UgNy4wLjcg4oCUIGZpeCBj?=
 =?UTF-8?B?b21taXQgZm9yIDA0ODk6ZTBlMiBkb2VzIG5vdCBjb3ZlciB0aGlzIFBJRA==?=
Date: Tue, 19 May 2026 17:23:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: gagnieux.virgil@proton.me
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221551-62941-9pKILdtvc0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221551-62941@https.bugzilla.kernel.org/>
References: <bug-221551-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221551

Virgil GAGNIEUX (gagnieux.virgil@proton.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
