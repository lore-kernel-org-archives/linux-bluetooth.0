Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D018D
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591813; cv=none; b=UgkH9NoqGwOaWqQm+PULuU+9uVPd3yAUGh+Jhv3EfokprXJEvcZH+3gAFxbG8Gu9YzAgax/j3lsZ5TyaQ9Hw1AXIO8VE3wG8VrbTvC/D0Bs2NUk7L/fF0BuZUmPMCrwKrlhaf0H+Hq7IsMR3uQGycLlsSDqUnUubLz8gqNplN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591813; c=relaxed/simple;
	bh=74v2m086rqXqUfdgb3Rz1zgkYWJ4vkdW4G9jSzKDeyk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BFjDN7hzCiJfzlSaDAda2VZ/LcE4IYZeGRVJxLcoKTjbF0s1yapa7Eo31mYmXzhIcIHtXXj7Cb+HifucvRGPpHLmDFqj9yVOE8uo4Sabh4iGQCbk7XVPjohPIFEEEb1gCm5bZNIi5HnmcQAT0NHgisuMKCTOhZtScN6V0c3JtkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHjwGZ3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHjwGZ3b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 934FDC433F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711591812;
	bh=74v2m086rqXqUfdgb3Rz1zgkYWJ4vkdW4G9jSzKDeyk=;
	h=From:To:Subject:Date:From;
	b=eHjwGZ3bYsfXVqpEDvlHULcB/76FpayVXbF42WEPuDcEv0tiq95jVvDYhH8E6UhGZ
	 uNoPUQ33BQHGdQgA/IKnikVX8SyZ08hu/Nk4j/FP5j3vxGnfO0ktv8hTZQUVUd2Ag6
	 6VbPxxf/iyz/m2bESmgYOWg4e9xBhmRTTDVX+VuntzJwIgtHPwOsBVh+FucUUZd68H
	 V+YHeiYUykHVF5Rg454RmZQmKQe5uxIF51b0JpaRDpKuqEvRpClUAkG/tQwaNe4Blp
	 AiGFYAoTp7cDPL4AHFzidmwEBCacBJYZ09r8d3V0Tor6R6Fs/exMajTAhEvBsQAxtq
	 ZGANwPpGwpoZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 77B1DC4332E; Thu, 28 Mar 2024 02:10:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] New: kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 28 Mar 2024 02:10:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jb.1234abcd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-218651-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218651

            Bug ID: 218651
           Summary: kernel 6.8.2 - Bluetooth bug/dump at boot
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jb.1234abcd@gmail.com
        Regression: No

Created attachment 306049
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306049&action=3Dedit
journalctl

kernel: BUG: kernel NULL pointer dereference
Also lsusb display related dumps.
See: attachments.

Maybe related ?
https://lore.kernel.org/all/20240314084412.1127-1-johan%2Blinaro@kernel.org/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
