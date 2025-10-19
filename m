Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D51FBEA2
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Oct 2025 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760851340; cv=none; b=Ljjvt3MTT0AALKes9NX2FuXxfgYrnyKOzn6tnPmvw4LSpug5TVDAENaMOnfqe5yQPKT+IPVnMTVIxfIWEAzQeVpYrKlAG535iYOCU38xDvuWwwajdwm7PmSltV6BOnqGNThprPCNSeD9B+1IfATHOH4Xr46wWxSt00zNcTqC1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760851340; c=relaxed/simple;
	bh=LM0K8y1rVLktN34/fEFDbxwxAR0iiOE8zRjZ6btIbYg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f1nV5kmGrM/4haAgu+f85liVwj0jqe/5EGBIiTfsm3csvJ4Qpmz9oqrh+eDEUG2rsC/Ktu2SxIuWx/Junkj3ypUvZKmEMPNURp3j7dFPOwPxr7XEIrlcxl+tZ3Rvr2ve9pW1DQ8gzzhpr78q7cKGS8K2cKGIqx9LZ61sIqTZVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve0rzgHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve0rzgHo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65562C4CEE7
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Oct 2025 05:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760851339;
	bh=LM0K8y1rVLktN34/fEFDbxwxAR0iiOE8zRjZ6btIbYg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ve0rzgHoEsx8roN05Wfmgzzb4WzZeNx5F7njQfjB1VvW5yLZopxKSLaGxgmWYuciw
	 bz0pjTbBPyEtElrVb9v11ZRxBcxOB8B+BNM3bFRwwassjOdctCRoTsF1ao4jGT0gWJ
	 32/EU6vwiSO9kQM47nVH1pd7kZWroBLSAbRIU1dZnK6JHztNgMfy/1wnz+n7MRKNbr
	 do1gy1J0LEsAnyl8wUmhwq6WvBh1zZA0hhGhG8cnKZZBvgV+IoHTXZddUoVkDtZuB4
	 sEBniWYEV335CLnH7QbAaN6DRzUo2SfS37CM5W1NlBn4V50QAZHUVR/yzdB1LGcAsK
	 lw3p4jrQljMFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5A191C4160E; Sun, 19 Oct 2025 05:22:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220538] iwlwifi: BE200 can not install on ubuntu 22.04 (kernel
 6.15.5)
Date: Sun, 19 Oct 2025 05:22:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: network-wireless-intel
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: emmanuel.grumbach@intel.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_network-wireless-intel@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status component assigned_to
Message-ID: <bug-220538-62941-Ua7t1V0XOZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220538-62941@https.bugzilla.kernel.org/>
References: <bug-220538-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220538

Emmanuel Grumbach (emmanuel.grumbach@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
          Component|Bluetooth                   |network-wireless-intel
           Assignee|linux-bluetooth@vger.kernel |drivers_network-wireless-in
                   |.org                        |tel@kernel-bugs.kernel.org

--- Comment #1 from Emmanuel Grumbach (emmanuel.grumbach@intel.com) ---
Please attach the full kernel log.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
