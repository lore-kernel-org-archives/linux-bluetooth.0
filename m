Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE918E25
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209093; cv=none; b=LjMJzrxR7TqRjh9ng2Dp1qww4G0R3jXeSEF+JZZx6IaZPpShnGdXFELCu4+5kDjpHEoayhI+vfU9mH5Bgpyeqnau4Vs+cMemr4X5SfESs5msEw6ny3a5rLjoqV00TM1gxQgUTuHin2N2JOg7ZG9ZAV+OusRDfz58ihZ++Lh5C7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209093; c=relaxed/simple;
	bh=rVFEGwGZ7GIyrM5uUd4x6Z0NECg6gJ0Uhqzbs9rUItQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncPhfa3vD0E5MLbmCj8GjJJBMKbbgqY3ujMbrnr/PdHHAlzrl/JGOjAy6uFhDr7m8C/AkWPCt625u+n5+asT6C1h7oLWR/zBhXLWji/5XVVCLxTUuVEZEL+JqY6sc+a6TixjGTXQ5MbypgLxnGE3+dSaUM6GmwULq/xqEERV9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuC9HFRx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuC9HFRx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D799C43330
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 05:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712209093;
	bh=rVFEGwGZ7GIyrM5uUd4x6Z0NECg6gJ0Uhqzbs9rUItQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nuC9HFRxLn4phot8k8eA66m28xVn8r9u4F69nN9ygDNNTQd7cmofzr66yndX6NMYk
	 UxRNubdrRrIyfnULigfLj4SASM1ja3JQopQU9ppxUqIKhUprQqeKds2LliHWfuJhbF
	 gKPNtruVoDmR5d3Km92KUsJC50HrD7W9sOlqgGN5N6+dBuhL9/uCk2aXcwKfMWl5XX
	 EAHLW9NCqeiViGpforNDVTXFN79n5q9pVugntK5uMmdOB05SNFiyXSmT2PNx4PNkBK
	 YIoztBNAB1cWWqKVWljKcKD07Js7V4aSacPp2hi7auQRGQcngBnqM+Tlcn9mhU30m5
	 Wiz4ymvsI93WA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5A712C53BD3; Thu,  4 Apr 2024 05:38:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218651] kernel 6.8.2 - Bluetooth bug/dump at boot
Date: Thu, 04 Apr 2024 05:38:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ferdi@sttc-nlp.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218651-62941-dsxW02DCG8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218651-62941@https.bugzilla.kernel.org/>
References: <bug-218651-62941@https.bugzilla.kernel.org/>
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

--- Comment #23 from Ferdi Scholten (ferdi@sttc-nlp.nl) ---
I can confirm this as fixed in 6.8.3 and 6.7.12

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
