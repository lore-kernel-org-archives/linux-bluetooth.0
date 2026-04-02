Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB640DFA7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088177; cv=none; b=KD0DH4hT9xqtoTQAP7pgPxEWtWHW1009MznyKuHWzesJlAFprGvN9VSqzZ9O7CqSNstm1rASbeB20s+ADRIuZu3RQNXKqbkoNVKNSndytsAP7WWZxiqQj/6RjjtcRCtc4fM9FqVHse2z4jbyCVkp1C1vbG1X+dSfLvyTlWKgUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088177; c=relaxed/simple;
	bh=RPoxVjHd92eT+ZRk5SSrX/DzzAhAoZkgwWXEncybCiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtaOTtd5AOMPJZdueS2i6K6mvHAJi5BNZlEBnUZDi0pMTMsUJufwt+Rlq8xy9G2NmonI9bP2oiCcuJU+OkT21+lpGhwuOu+689jgXNZmCqGSFCtWwTOqsScmwoKfLf1IBedfmR2rrTSJIYOmO7H2lBEHT5KbxxWqcY3MMLknXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZZ0q+Xz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZZ0q+Xz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38141C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775088177;
	bh=RPoxVjHd92eT+ZRk5SSrX/DzzAhAoZkgwWXEncybCiI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AZZ0q+XzjsRySKSNqqIAAp0hOE3uS9BxMWNFcsSN3njcZc7ZQ/Q7WxQpvom0GqT7W
	 jKjMW+nYF1vNPQ4BGlMpvGkdYCXd2eiNtGQ0zpif80nLVzjjf6fjyWJXC57RXXKbs/
	 fR6iauJ3gobIiOfRCgXEP1mIozagkhkmrH6WP1w1pzvZlLo+dwAr0Q3DFsx7fqII0w
	 ZqNTYej/F6AIvWbvwHnm4AaS8sVav1Kkrdr1DhHe2X/d4PINeCrp2AWdtjspDftWsE
	 tOuvf/1r9EweJhrdS5E5EsDtmGXagpKLNp+6H/DN6BQG07p/KoLMhPhR+YmCjJzSAp
	 4QvBlO6G9jG5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 284E6C433E1; Thu,  2 Apr 2026 00:02:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221309] [REGRESSION] rtl8822cu: BLE disconnects with firmware
 0x0673_0EDC
Date: Thu, 02 Apr 2026 00:02:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: i+kernel.org@schimpf.link
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-221309-62941-WRBhvyBZre@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221309-62941@https.bugzilla.kernel.org/>
References: <bug-221309-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221309

i+kernel.org@schimpf.link changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|rtl8822cu: BLE disconnects  |[REGRESSION] rtl8822cu: BLE
                   |with firmware 0x0673_0EDC   |disconnects with firmware
                   |regression                  |0x0673_0EDC

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
