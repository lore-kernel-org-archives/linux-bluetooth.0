Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4431D516A
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456225; cv=none; b=SHUP2kpQueIndJ5vMp+dov81otruRlPe5XIp9XveK0YSTMVDTLPDBTwcte4V66rOet4F2I/PnQHjf0hFeLwt0x6zL8szkbhYw16nT5QIZvsxlV/V9YjS+//MoN6opPlwCIcRAzh9kO+q8ISB+PrJ47hRaDrhvT8ZkNZls3H06Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456225; c=relaxed/simple;
	bh=mITTeI+bc0L5+UywrvtHnC5Kv0gdsngT2umj0mn2+nM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isxXBJa4y6shbBVp441qf7hzGWFwM1i+bvONn/4lW5orwQFSYv0MAYfnmtB6WpXMFm1ikCdGX+H5zrn7JqB7y7GUxAsk7NLbk98l446sSH5MGhFArpuMXU8BzlRrjoyviYIvnXqeNuv7XGOe/Eg/AF+LGtI97H+tBwwpH8f8vig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWbizNnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWbizNnM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3444C4CEED
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751456224;
	bh=mITTeI+bc0L5+UywrvtHnC5Kv0gdsngT2umj0mn2+nM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EWbizNnMySwK7uSNlI0esrgOKyuUSZXXvSjc8aZGKF/AmzeRdZaNv67LKzZYUiTUs
	 QdwqyBo+W7YVTckx7ZJaK9q6itde7mEGr+v+jqCqAfmOSuAxDaHH3ZSFg8TrON707f
	 RgXCza59GasJMzl22hdoE//SPmA0H29xfqTx+DPLwKihlnfTS6CzHPrvwSxexxntpV
	 Zyc00J7W6Sannbdlla2C0elFiI+KupzIHMxd2ZVpdv2YZtmXT+UWql8hnRfcTTfEYH
	 X166mcGL3sv++sCoQxfBrbzBkXjNfogz6dKYrJ5tSEvg+vOk3h/fmiVQ4WwwdKbKH5
	 HEpTCRbkoCyAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9D428C3279F; Wed,  2 Jul 2025 11:37:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date: Wed, 02 Jul 2025 11:37:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: galcian79@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-z5a866SMvp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

Fulvio Magni (galcian79@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |galcian79@gmail.com

--- Comment #281 from Fulvio Magni (galcian79@gmail.com) ---
My device started to behave incorrectly since Linux 6.13 and my DS4 control=
ler
lagged randomly. With every kernel major version bump the situation kept
getting worse, now being unusable on 6.15. Reversing to 6.12 fixed the issu=
e.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
