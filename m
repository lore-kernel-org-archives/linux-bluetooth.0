Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722717464;
	Fri,  7 Mar 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307164; cv=none; b=JTloT51ZgunLJ3gcjes5jQKokj+smZ6nei/+OSPqqrDjiEt1Jh/6dNZrpeif85OSRq+0ZLUBEef1BqjYQqr6hgESNgJyPt+cy1/cURwqRhYTsgNslxOY4nsI/hvUoyvbOZyArLtBvR5TLqA9yAWTko/eqL5ivhxDnVtQlAPiSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307164; c=relaxed/simple;
	bh=eBsDNEUWdffyGJJ47jDOZ2DY6q3Bcjg6RjIoTLAUQiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdYbFGujxya3i8JSOU60GvQZ3Kq1/Dgk4APd4bjfZApZjlrbMJkDcG/0bEhB3Vl484MTzGx/pfBslzqwdlkhR23UvpRLHxl8ToJLJ9SVVk0aRcPTzkOhMBalQcVuf061hld3CxhRvTG6ZScJ5wnsSMCz6/Bq3CJHxFQl/exMF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATGdgcI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATGdgcI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D00C4CEE0;
	Fri,  7 Mar 2025 00:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741307163;
	bh=eBsDNEUWdffyGJJ47jDOZ2DY6q3Bcjg6RjIoTLAUQiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATGdgcI5svBZKvg/rCQ8JSOVcUyHHj1NwT0rFobnPoZS4kXvqEYVJ9Z6iTTmbhkyt
	 rPXRa9gm4wZapxFKwookb0PiYZrtdcJAtJJXBHCpyPf+zwsy98dwQf85pY40Vpheco
	 rtfwfDPKYLBhMI2qsZwlcB1sBI7lxcMVnraNZXZPnF+UdaRGbomYp8jtIrQaP7jJrS
	 Wydk583jedDKc5uwXBvGEfMoNi63U+fuaYjWRi9v1kR6mERrrjzIxrb+S2sDphNoVb
	 ERg6s7qavu+3OB43L1ryt1XCqQJ1F8a/YoVDN8hJKEW9YAsixBi2KR46co0WqAmkmg
	 lzDG0ca42u/TA==
Date: Fri, 7 Mar 2025 00:25:38 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: syzbot <syzbot+e9abaabc441d3dd18735@syzkaller.appspotmail.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect_cfm
Message-ID: <20250307002538.GA302609@google.com>
References: <6761bbbd.050a0220.29fcd0.0075.GAE@google.com>
 <67ca3c79.050a0220.15b4b9.0072.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ca3c79.050a0220.15b4b9.0072.GAE@google.com>

On Thu, Mar 06, 2025 at 04:23:21PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f66d6acccbc0 Merge tag 'x86_urgent_for_v6.12' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1666b2e8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ca2f08f822652bd0
> dashboard link: https://syzkaller.appspot.com/bug?extid=e9abaabc441d3dd18735
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Maybe this will stop the spam:

#syz invalid
