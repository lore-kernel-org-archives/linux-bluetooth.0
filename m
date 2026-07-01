Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FC265623
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914802; cv=none; b=GBReYxiR+mQtTC8vO+Y/10F0Q+LegbMfJIPlwN+CCVKMq7IVGMli5Tfg7wIQunijVDiNt54u3h4ZdB/lt0f06WOP47+tfR6/fIS118YFp93KUBovgWO+Azm0eiugjUxhraXvDLyEDoyYQ2opWKlCmtEAfMjFOhAEzkmpb1VKmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914802; c=relaxed/simple;
	bh=FDxTb+YYql/Ou+jJ7c2p6RiKARW3uhd4mINX1GHctqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYHotlfKfvRfXZ28j6LZQPi2A794ZfIDHfGyqOgCIrlKeRRQ/7jrJ1Elxe2Y1EYcnmMNDSa3lGCf4MG5eJeGVfoWh2XkE+o24u+MeVqYKinPVuNIe2vDUHU08VTcKO4o6gT4eBItyK8cB11icuvaxEA4PUtN6qIStPeRTMLA+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF+1wnSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF+1wnSE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95DB9C2BCC7
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782914801;
	bh=FDxTb+YYql/Ou+jJ7c2p6RiKARW3uhd4mINX1GHctqY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BF+1wnSEZTyB/Vvh1/d4aJV7NKE1WbF0kVsHZ6ogTP3/ybSLa/MS3KhmjyRg8LyB8
	 wyxRuMIfhu7fr2hhmYhou5GtqTpy9CpunNdktshz9qJQX2Mh7ERnoEH8PDjPik59GQ
	 peluSZI4/qXOTuIxF/IsZaknthPDT/phNvydy2SLNcLERWSCaFcVZoF/5eqqgP2qvN
	 Ge6CLdjvWhiPEViBw+d9tDZAdhKtn4LkQK4jrMkuL/2ADXtNAfsz4PZr29Ibolx7VL
	 ktuK5d57vy2aYnE3j+Hy2bllobHebgwxKNiN5UdB2VW9/2sUGdnuFzsw5zFn9gOGZr
	 ds/ZefO5fQzHw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8410DC53BC7; Wed,  1 Jul 2026 14:06:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220564] hci0: ACL packet for unknown connection handle 3837 and
 sound interruption
Date: Wed, 01 Jul 2026 14:06:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220564-62941-tGAKon7lTM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220564-62941@https.bugzilla.kernel.org/>
References: <bug-220564-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220564

--- Comment #12 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
https://bugzilla.mozilla.org/show_bug.cgi?id=3D2048220(In reply to Rob Hoga=
n from
comment #9)
> I also have this issue. Error appears every few minutes and the bluetooth
> speaker disconnects and reconnects.

@Rob, might this be a different problem? It be great if you create a new is=
sue
with output of `dmesg` and btmon trace attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
