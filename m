Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F202641CA;
	Tue, 11 Feb 2025 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307572; cv=none; b=pAFG/9b7lSw/PsSwsj7VjutkrknzZycYknw/sBrp3lDhYLJAN2ZNBMCmXiMRqb0FgzaS8N39im+3TA4/28ImJhUZhpYGTzs1nkZD26OCforK+Qe2blfF1p34zUwTrxel1bf8c4UIoxgzQukdVcQB7o0Zu6KLv3oCwFfRpJUlTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307572; c=relaxed/simple;
	bh=h66F2MARKJ0K3tXXMQGR25Duc5c7sPuk3UNDeq/Ou5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfoTo8Ilrr5uaI9nUEBCaZakfvnaGS79pXF0g+0dfTiQb9JUFnTcyeAuFkPMApaiL4y6eWffbbz8CQIWz20YDK6jpiU4+XnDACNRZXkzKt1WzHNNcJfoyiJ9t29r+orm2CKEUb0W+PrrJR03+fJnKaF/1I34ZwOT8o+ayYs1OZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFSP9mMd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFSP9mMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273FBC4CEDD;
	Tue, 11 Feb 2025 20:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739307571;
	bh=h66F2MARKJ0K3tXXMQGR25Duc5c7sPuk3UNDeq/Ou5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFSP9mMdHCC0Y2sUcYf7y1ZEvCSndcc/DPH40qQQQTnxRICFJRta5wkMSrPg0/in8
	 SndLBNisIGQWlGC+hqEOA40YYSHmfbDKDiVW5a4y17C7krN7UAhaNtcG+/bfVZaQKW
	 r5tKxpq6p8IqRlLSdtJ9mjElyKEmXUWpXgW35sWJB1vO33vtU7SHpn1ohk/Lo2kFmo
	 coGmYguJUtd3bKrZ9abgURH+h0Etism6tpMrvS5VmNd9tBf3LHisTvkJe0jr7vn6Jr
	 wYcF+RML4QYk+098THoOYc6N5Ug7LoX+De/iYLSezd7F3DCn4QPhZaC7caNCzp16Sw
	 imdKM+NgKx0pw==
Date: Tue, 11 Feb 2025 10:59:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	maz@kernel.org, mark.rutland@arm.com, richard.xnu.clark@gmail.com,
	jiangshanlai@gmail.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [syzbot] [arm?] WARNING in delayed_work_timer_fn
Message-ID: <Z6u6MgaJWMpjCn4O@slm.duckdns.org>
References: <00000000000046efb605fec3def0@google.com>
 <675c28e0.050a0220.17d782.000d.GAE@google.com>
 <20250211111045.GA8885@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211111045.GA8885@willie-the-truck>

On Tue, Feb 11, 2025 at 11:10:46AM +0000, Will Deacon wrote:
> Given that this seems to explode a few times a month, I wonder if it's
> worth adding some instrumentation to e.g. dump the name of the workqueue?

It's usually most useful to print out the work function when identifying the
culprit. I'd be happy to take the patch.

Thanks.

-- 
tejun
