Received: from send288.i.mail.ru (send288.i.mail.ru [95.163.59.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37712166F3D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138457; cv=none; b=gA/TrnzvNOn8VidPcYX18ANzrHIEhx6OPtjsz0mq5TRvWzpciRwUzGShXWIkXlnEI3+8tCiLL3er9t5yHxCxU+jf2nzqQ0lzP0LV3rLIYyQMrjIqMcbijOPrHRI4IzbhvWwSiDq+t+kEPz4E2gUOCSCNDVf2bSDdyx3ZcRMUNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138457; c=relaxed/simple;
	bh=fe5O1zuxzy5em28pufCQzth7ZkvmYs5vMrKpUwLeiFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKrW7NpvSjDgqQ6LeXPso27Kh0yi4EDKffQf9SAmAdPE0+9TeTpXIz8BJP+k//FzU5j9TNt5PTr1nXbNx0FvZSjBPTx3yYHrP6dfv84IshdZzSxTylwkihIMae2dLIwx1swAkbj9ssk2gwTVtOt/SK5dWKaq0dSjMzt38o9I5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=QmkeWk3L; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=TAePP9h+; arc=none smtp.client-ip=95.163.59.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="QmkeWk3L";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="TAePP9h+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=Mfs+/Bjq3qalVgzQf3qcTV9eu3COEjBS+5J70KdCdZg=; t=1737138453; x=1737228453; 
	b=QmkeWk3LFJxlhiVsT4Mr46Ou9Ak2MTSOcaA+fRR33s6G0Ast2Gtx4lR1T8P9i+sSGNGxc4Dio0c
	0XSvg9kEmumMCuNQ7bx7tjzOJqvVVAHtNvEmaQ4lt63xP38bAvyybsfht3ADwGKa78RQahf8/R95Q
	PsdaHLefapmRZJ0vB9ppRG0HI6SNn1LXt/svKp9HbLHCoiNITAa97fPhFDKvl1o15GJEt7mWLIR8b
	nJ1N012G0hUAuhzG3vN3sVp0b2x8nrWhrPFnEFz9LtdJ9QZf61Whyw8h7UsT5XsMHSr+8U9wBOE64
	SwvPHZt+CYDgT+oUljM2OSh1fsZSmauAafwQ==;
Received: from [10.113.142.48] (port=52786 helo=send57.i.mail.ru)
	by exim-fallback-55f48b6675-qd9zc with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1tYr46-000000007ha-3Cu2
	for linux-bluetooth@vger.kernel.org; Fri, 17 Jan 2025 21:27:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Mfs+/Bjq3qalVgzQf3qcTV9eu3COEjBS+5J70KdCdZg=; t=1737138450; x=1737228450; 
	b=TAePP9h+peyk2KZ3EG54ta5FXcXQyA8dzOrDuW6VlGUHh9ntMrNtFAkOC0YRHc0NaTZOdMuicse
	Hdx8QKXD+hyBKywr4/PYlk8eVy9HdgUn4KAJWbzVtMrj+ecrllvVondw6PHGVomxjxuVcpPcQtr3E
	o6VotKw1b91JzcMXGfhjyfJZDyC948aAf3oxhapCPUn2duFkFSs9a8EAo5rtm8L9b65aLPk8wcZVM
	KMSjRjr3XMQm6pnM1EScPRM0PB9OQYG2D+jYZ4BoH3GoqYY8iw++d5RdeCHuWV9MNnHjrana2NluO
	UqrEb8er/Q6YJlrQiZP3x/1IAckG1u+VPsFA==;
Received: by exim-smtp-6758d5575c-cqk4c with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1tYr3y-000000002I7-1XyV; Fri, 17 Jan 2025 21:27:22 +0300
Date: Fri, 17 Jan 2025 23:25:09 +0500
From: Denis Burkov <hitechshell@mail.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] shared/shell: add proper line clean to
 bt_shell_printf
Message-ID: <3aawgbxiytnne7qpbx3pmcsrwsnnetm7aznn6fjxygboui55il@62zkwgjqnmpw>
References: <20250117180611.14869-1-hitechshell@mail.ru>
 <CABBYNZLK4hAmUXp-yZVDXUJ6M8_faDYPN2i6kccdbvc945f0fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLK4hAmUXp-yZVDXUJ6M8_faDYPN2i6kccdbvc945f0fA@mail.gmail.com>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9F92BE5667526BA91E395D7587768BB3AAAAB6B6460CC5D35182A05F538085040B5B83C71B15609E23DE06ABAFEAF6705FD30066D1CE69D8ACFFF059546F94A01115177133B14DDE9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FCFCB92DA8654BB0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063764345650F0BBEB0B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D850E6E47FBC4EC2223E933ED8B512B146920081AA8502838520879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0B27420F9988F54058941B15DA834481FA18204E546F3947CD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F924B32C592EA89F389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637A3640AA7557C1107D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE788447B539030F878EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C381C471718626405235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A569D2FCF6602DC1755002B1117B3ED6968F3E3B1FDAB9B9D65B6221DB6D7A72AD823CB91A9FED034534781492E4B8EEADA2D5570B22232E1EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D346E67BC984B8ABCB5769C9033EB7DE606E8F37DF638B4F98AA7C988E835427F9545AA70EB5DF0E78A1D7E09C32AA3244C89BD8B751F85CC9D77DD89D51EBB77429E558B41E7A8845CEA455F16B58544A2E30DDF7C44BCB90DB8B5179048F486F0F8ED7FEBB3D2F69ABF0F826D30A442AE37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWtbQUE8gyFzjhA2/5RAbBg==
X-Mailru-Sender: 7219FA8B682B638D72A16E3FD9953F63A8FA772DD64F6EBC670A377E8A0BFD00F9248E00AD136191DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4E321808EBFEFE579B5B131811C2E9C301A1561FB40BF213E049FFFDB7839CE9ED5E581D7620AC4EB30E786A5533DD27CDAA97B8DC78E0D1202524F04F559E7E1C4A21D9B223F9646
X-7FA49CB5: 0D63561A33F958A51D58CCE65FD2F90D5002B1117B3ED696D3A0C743B0C5660CB99A9B79129B760402ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSoLFDCXEUyEibJdENjvzQK2
X-Mailru-MI: 20000000000000800
X-Mras: Ok

On Fri, Jan 17, 2025 at 01:17:31PM -0500, Luiz Augusto von Dentz wrote:
> Hi Denis,
> 
> On Fri, Jan 17, 2025 at 1:08 PM Denis Burkov <hitechshell@mail.ru> wrote:
> 
> We normally expect some description of why this change is required,
> for instance what is the output with and without your changes here,
> are there artifacts if we don't use rl_clear_visible_line?

in some terminals (or all?) the line is not cleared before a new one is output
(for example, if you turn on scanning and then try to write something to the terminal,
the output will be mixed - you will get something like this

[JBL T450BT]# h[NEW] Device ****
[JBL T450BT]# he[NEW] Device ****
[JBL T450BT]# hell[NEW] Device ****
[JBL T450BT]# hello[NEW] Device ****
[JBL T450BT]# hello[NEW] Device ****

where "Device ****" is the line that was actually fed to bt_shell_printf

this was reproduced at least on simple terminal and alacritty (on gentoo)
