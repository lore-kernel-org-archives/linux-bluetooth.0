Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83113CFB7
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934767; cv=none; b=bNITx2pMDuKDwr4W0ur4sQ8FsMJrKoukE8bl5E4dFhzY+hs4uPq26LeQqcA2lihEYDnhFDc/cP6nuzzF0pePEoOHubqOFbf9M9HrLf8mtZr59LSGqnnkUmsk90QdRiwo3PqAV/1RB+9cU2ZmzXBHaxAkIHNKNEtEl7BS8ZKqebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934767; c=relaxed/simple;
	bh=Mt69NOlIfFda6C5hpfjMSXJ78ndUlyKPAGL+cAxRHDM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWMIPqjuAg0y3bzRKeUFSSirqIgfukb0FJBNm9O+if1QTZ9Es1pH+qkU6UPpQeHIu/JlovOWTK/yIWyBAmdWfV2/R39FYgxmOkgVsqDEJI167M0zhB1EuIsp357i8rJ1zf27f2VISKAAfvvp3TCyGF9qMjzWrzixZP4dYKFq4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AazLWaiF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AazLWaiF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18AA4C113CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934767;
	bh=Mt69NOlIfFda6C5hpfjMSXJ78ndUlyKPAGL+cAxRHDM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AazLWaiFZAdElKoN9SydN3h/wS7HrnwI6zTbYK039dmocyx5LfdSI5IexJJTYH4lk
	 VKmpUPgUhfHlq32xs4PVJr8bASTelNPnwSliwxGFgLTua7FkaazGFlOFZsVWPjNUm9
	 cgeMZ91uDPKUWjqsESh1FVnIWs+e9tXcHqlI7LRCp+tw5JnDD0dkSbK+J1obdTFWji
	 zKqNikNvelFVzchWPlv52kVyj7YHm/czJrecHXHH+Zk8ZxshS+5uJpfbhvezT3H2/G
	 bQos1UBYkAw+ps0fNjVGpVRzvSrddJ5qYPaAVai3+zMMUeK2Nzg4Je1syoOeHwTEww
	 6KIB7NbNZ5BBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0EF5AC433DE; Fri, 12 Apr 2024 15:12:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218717] Lots of oopses from btintel
Date: Fri, 12 Apr 2024 15:12:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version cf_regression
Message-ID: <bug-218717-62941-clKAnCQZvG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218717-62941@https.bugzilla.kernel.org/>
References: <bug-218717-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218717

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.8.2
         Regression|No                          |Yes

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Actually they are from 6.8.2.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
