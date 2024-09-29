Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E58F6D
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727619933; cv=none; b=jsGeIG5LnBYYBVKY9rvJgd2lpfMZ/iw9H3Ohhw0JIqpLdybErlYghbncCttz91QLwqkKtp0HTpmvDV6OprMHmxj6l4tPBqxnnn6SK2b46oncPdNQ8FiZ9IcC04TTgwX7UTvmgJZKitbqU9KAqtbqZewdIN09SBMsoN26OMTjrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727619933; c=relaxed/simple;
	bh=9n9YI0Aij47p+YujWrCETsCkH/WdkSo4rmWhJupsQPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmVj9rGDceH0NrEHWHcGeAzWInt7wi762q130H4G4LM0rIYUIMNxYW5sEYj0CHPH2aMobT6jPhG/pXeVayIrmULCNAoH7Xo+KXAjO3HkCFGDmeVfNAF9YPKPCK2tiZn7L/ptp8mCYDEYhGsPoo9ExMFw49sPxXSQmto7Ezq8+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb1zPw2m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb1zPw2m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48AE5C4CEC5
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727619932;
	bh=9n9YI0Aij47p+YujWrCETsCkH/WdkSo4rmWhJupsQPA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cb1zPw2m/SpV5QH5sI+Sl90E/EjdOIk9SrzWaKo3XyUd/9Lxb8WBtV1hYRyVJYAM+
	 WQDMp7yx9nBrbuuLnrvoaWwelCoD9+zxsigdDXtGrkZOUyO6/ivom75eXvN1ufiLOd
	 /HlKhEEQMPAMW25Y8U8hegzxRAds0sIB45M9/O5doWfFqqi5SJfbX4a+ytU0Rn7jNQ
	 D82w/fqLvLR8ER326nzUQlV58/YE9CeMLUuE8ImkzKX/yP8bMjQqhR6ozG4rjm0BTQ
	 +poa7W+ElLsyC2xI4toSnY8XL0mmfVjE3vIhEygQoquXjTyhyIOScN2FEh8KVkdVJW
	 qC1c24nVps6/A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3FFADC53BBF; Sun, 29 Sep 2024 14:25:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219333] Bluetooth: hci0: Failed to claim iso interface
Date: Sun, 29 Sep 2024 14:25:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219333-62941-x7SJV0Rnmb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219333-62941@https.bugzilla.kernel.org/>
References: <bug-219333-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219333

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
