Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDA267AF8;
	Fri, 14 Feb 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551564; cv=none; b=aUP1lA3jT40mYuliiBkgeRkBEbeFNusOkMZflM0bvlCQ4HBDjo5xYCOaqVjGTDa0YzK+PTCqDyy/Ay5cWxZ6P1y1Y1kE42o2LP8LdfTB0B01T6v8oa8XtdnwtjF54v5qk/nj/6zMlmMUzV51T9crr8ApBneubfkfwqKp5zCqkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551564; c=relaxed/simple;
	bh=yCxxaLvR4UouW1wbpmBsL5nojd5dCMqZThqzSxI1LRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTwFPsKjF487SomlW/sllzI+SIqJ7WAT+Iw2vQk9kcUsxG4TAj//yiQXmQYW5gT2Ql/S293vkRuAqfEjuC3hdkI5vT1EjaKDOb4EArUtPlVmiF1DT8cqNy3mzJmS5GqMPQsjeZrDdaa5xl2x5PAev53ATOAp7n+HBn0Ba0q9Dvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1JaPcdG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1JaPcdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5187CC4CEE9;
	Fri, 14 Feb 2025 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739551563;
	bh=yCxxaLvR4UouW1wbpmBsL5nojd5dCMqZThqzSxI1LRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1JaPcdGKCf+5qYgIy7U8kI80cmFy8NR+Sm6WgU4QlOi/E60LNRfIwXnQDiCJ2NdW
	 RqSMPHnuaJb9m4+x7r+gRxJjcTA/OPgHsTYYJGZy1HhpqbF5bETwmijH8xng1MpFfg
	 4P5fXLlWGBnO9Lp+dXGF7Fb4XfA/ZMO0594y3Bn+M+Uh+xWWKkf2rnd5hkZo1kDJ3r
	 2LJja+YBYPOW4ynXEK88nAVaWMkIwvTxE8+fJws2MUR7yhwd8rbS/egk3Y2fLzePk+
	 TUvXIyxv/8JsRpm5FO+SL2ieCsFI2LCNc8LW83vDHEkI5ekv2Wdy6Y7GNO8klNRu9p
	 3rmy4qEbh7dlQ==
Date: Fri, 14 Feb 2025 16:45:57 +0000
From: Will Deacon <will@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: syzbot <syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	maz@kernel.org, mark.rutland@arm.com, richard.xnu.clark@gmail.com,
	jiangshanlai@gmail.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [syzbot] [arm?] WARNING in delayed_work_timer_fn
Message-ID: <20250214164556.GA13743@willie-the-truck>
References: <00000000000046efb605fec3def0@google.com>
 <675c28e0.050a0220.17d782.000d.GAE@google.com>
 <20250211111045.GA8885@willie-the-truck>
 <Z6u6MgaJWMpjCn4O@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6u6MgaJWMpjCn4O@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 11, 2025 at 10:59:30AM -1000, Tejun Heo wrote:
> On Tue, Feb 11, 2025 at 11:10:46AM +0000, Will Deacon wrote:
> > Given that this seems to explode a few times a month, I wonder if it's
> > worth adding some instrumentation to e.g. dump the name of the workqueue?
> 
> It's usually most useful to print out the work function when identifying the
> culprit. I'd be happy to take the patch.

Thanks, Tejun. I sent a patch adding some more diagnostics:

https://lore.kernel.org/r/20250214164349.13694-1-will@kernel.org

Will
