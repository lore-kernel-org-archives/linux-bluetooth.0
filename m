Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430563E8C7D
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665870; cv=none; b=uS7Uwk2YET2+6+glmxrBlnlgQGmC70msdDmyRHTn8qiqWsjEJsnpjqEd34zV2qb9jrmPMUKz8HnjvE9Hkb+bo3VNfWZ7A/rIar7Dv/VMGAEb7XDLSbVAPbDk+exFwWggejAl9AqCCRz3EU4LtiEGK962IJoRxDTZlE+xWKfTZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665870; c=relaxed/simple;
	bh=hbvKqKhUp7vySoE8HMf7bvGUAYENCL1GhaIFW0zmkJQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uq/6fR0saXvgjMHxDisUxrcu8r57A34ydFJOFqvNhJ+6HU740ot4oImgy/1afCC5J0IIKLxQeP6BA5Q5VKwqEP6RaVhlbd7MdGm6LW2dlzr5oqYalyJtxqKtBh9yYOQ6KPhDBPstjKZESA/W2Z1EdsAp1FJIgirQ3siZTiVlLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHbSYmb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHbSYmb8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B4DAC2BCB7
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778665869;
	bh=hbvKqKhUp7vySoE8HMf7bvGUAYENCL1GhaIFW0zmkJQ=;
	h=From:To:Subject:Date:From;
	b=PHbSYmb8HdpZMSsDjaLN3EMb5KP99dzqOD6bhjbEXAGFAy93XwJl89G5gT8WUlhQ0
	 4qXyNpc5/nOSqQ/2TmD2ki/X2x0xD7U0voduUwMKn2x8i0dERIwYOj+DR2u1p0ZxQk
	 JPUfvCUNOl1G39lVNx3CBcYqy3B8aA8yPs2IQwVOXQicxU5SfE71MrXrHblwQV7hAJ
	 14pO3zZx5Km3EcJI5tHYwk1qnzAPAlWaJMtWUtzdMlS7SKcfGAYPrQvyYy2WUYtL11
	 Bs94NtIIX2sAWvGF4tAX/1YLRk0jRqkhXl2Dt+fj096b7CzaxS3zF203S1TP6ZZJdN
	 aMVE8jrk/v9jQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 694CFC4160E; Wed, 13 May 2026 09:51:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221511] New: MT7925  7.1 rc does not work, but it works in
 kernel 7.0
Date: Wed, 13 May 2026 09:51:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: erpumper@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221511-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221511

            Bug ID: 221511
           Summary: MT7925  7.1 rc does not work, but it works in kernel
                    7.0
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: erpumper@gmail.com
        Regression: No

7.1 rc does not work, but it works in kernel 7.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
