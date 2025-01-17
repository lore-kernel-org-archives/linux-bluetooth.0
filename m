Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239125A63C
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140019; cv=none; b=NC2dIuxdKiYv7yaObflHp2q7hxY7RQ8w7crN7/WJZmGhFVtqdmzaNuSpWU7rTm6epuEgVx9MP2wh/QnoPfp4bdvdXDs1EA43pkoiey8t1gnyKl1y85U5zhSMt0CcZpxX3K597wtbXYadv6rlTIAt7LukgHi3flWKWQaNoe6jbSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140019; c=relaxed/simple;
	bh=2ImhPY8N1P409emTS7giUuQFOiO6WQwOJZ/bREPYMjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvfI5cKrc5deg4t1T58K4AQj8t8K34vtChPsZblWj06cTEe2+KZHJccopkDPRTJQ00w7kJfOvm/OfCzQEJiVNoqO10ibEq/VoD55t32m80g6zTIBnBsk3GqPil6WUllM7bv2/hBpGeDRgvdqOUCKlC1EwfUl5UEvS/PfjJVq068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=zHJelnrD; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=ehpuL3R4; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=fxPc1NGo; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="zHJelnrD";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="ehpuL3R4";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="fxPc1NGo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=2ImhPY8N1P409emTS7giUuQFOiO6WQwOJZ/bREPYMjg=;
	t=1737140015;x=1737230015; 
	b=zHJelnrDBgoA+ocZOfp0awive+kZ6dljaZJ/z7wHUPSCUEaqtAd036xwX7d6sNM3OXgHEMd7vbqVjn8WALqfPgfOmj80FvU1D2zQy9cYig+sN0eM9kqNOKe9XbWt6RzcqwNdM7rrlrfHow8qoraXjSz/CJWE+FHsaT05qf2e79HUBc8jGpkeC5LxhE9JnKONrWe62UkdBNOOkY9MoO3qiQlC92behtX67oLomFshB3JS0MtZs8jWM4m7H5knwLwc2EOKDTQRv8YXL4oiUu9tnKxYsUt6pp8HQH/nhRUCjOQW2zRB+hauUihAsgAzxdjP1aeWf89xIWZt0j0TJ+E0KA==;
Received: from [10.113.196.133] (port=54536 helo=send55.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1tYrTI-00AAyH-7V
	for linux-bluetooth@vger.kernel.org; Fri, 17 Jan 2025 21:53:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=2ImhPY8N1P409emTS7giUuQFOiO6WQwOJZ/bREPYMjg=; t=1737140012; x=1737230012; 
	b=ehpuL3R4RAg5grJS5Q3Z4JEnUyjnmw5wrb+Fq8AC6Lf4S+U9RATSXhTzZa4DV7AR2k5Z6gXWQOb
	M8JVk9UX6OVL6+HUjWbo+JhebSN6C6hZIb5Ue0zfKwYkBt+xbFQ0RLA9rZBIC2rF/8S6EAXmNydy6
	pvTXZoyBCxxLokKOuB/XFvr6LZHUyXIKQnhvowbF0Xhg3CJm20ZfKHL1KuQ+EIlfsA7UI7qjrBcXO
	NgrLaOm9zMg9awqjJ1mGZmYrKhBzUOfmH5M7J7Yi99hzE+YKHLY4OvbS2VysaAVKId4UDU3eX+Ui9
	c8EFSruLoMjvr0ZD9lDBiKdgBdATec5PTezw==;
Received: from [10.113.53.52] (port=51798 helo=send127.i.mail.ru)
	by exim-fallback-55f48b6675-znffc with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1tYrT9-00000000G3X-3omz
	for linux-bluetooth@vger.kernel.org; Fri, 17 Jan 2025 21:53:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=2ImhPY8N1P409emTS7giUuQFOiO6WQwOJZ/bREPYMjg=; t=1737140003; x=1737230003; 
	b=fxPc1NGo7qhj1Y3/kU4xFx9Jbtk5byqM9mKBjYwXqIeJ5AKhccDXHmMrG0rLRxygJCBUDVXlpi3
	qyZMweQKmXEdcu4XzZa4uZxQY+6dqRG3Qpd+4RUE87RNl+B9MnVeVpaWuomIzDlgx6IR4Sun7OfxJ
	XsW7PrN1yTjNesIVzQAhTMJnbApjIELZPGg63EJnHDAIjvCXbqoNCFHxPtqL5HemFXtlnmy0MUBH6
	l4mxzg/UUnZBBdQ8UWFb0mRrvN1cyEvw4rxYcLxL/TRvajY1ft1O9qZNFyLF2tgJ9RNcRGf9h4F2J
	nFsGO/bCPkDKS4MKMpJBWGM11rpCiXr+j4uw==;
Received: by exim-smtp-6758d5575c-cjkqz with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1tYrT1-000000002KV-1lYs; Fri, 17 Jan 2025 21:53:15 +0300
Date: Fri, 17 Jan 2025 23:51:02 +0500
From: Denis Burkov <hitechshell@mail.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] shared/shell: add proper line clean to
 bt_shell_printf
Message-ID: <hau5k6onzla7yzhygzoz64dga5wzhnwwebxtaxrxfndeowezzy@k3wfz3vi2tpy>
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
In-Reply-To: <CABBYNZLK4hAmUXp-yZVDXUJ6M8_faDYPN2i6kccdbvc945f0fA@mail.gmail.com>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F92BE5667526BA91771AC702472B402285C611E5AAF235A4182A05F5380850405510752860C21F7A3DE06ABAFEAF670585DB2E7C8784BB04349EF95A134DB3DD19AD13A5913A5F63
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9D6DADD6B53929DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637EEA194BB48C104EF8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8695D5F30218F14E4D1F293AA401F2E95419C0C34BA2E1F9320879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C06030C3405640F6718941B15DA834481FA18204E546F3947CB861051D4BA689FCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063767B9C6E70FBE8DD8389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006379E66999697786A0FD81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7582D06489A00BB5AEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE76631511D42670FFE2EB15956EA79C166176DF2183F8FC7C0E4A630A5B664A4FF725E5C173C3A84C308899E12ACF764CD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-B7AD71C0: F8D540627A99B4FB7DB86BB5CA128351461DD7A0A9FF8BE1E8F7B195E1C978311F160DC9883BA6C1BC778C3F84A8D0C8
X-C1DE0DAB: 0D63561A33F958A5CB81FDC6FE886CEA5002B1117B3ED696D52C55FF59DA1CB8B91D2EB2DEE3878C823CB91A9FED034534781492E4B8EEAD85CCBA673D36D1A4BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC71106E36FF2641B7B8424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D349320586B19AD2C72277B600982697474799975A28512BFA5D8BED55C22050708F8670BBA59969F731D7E09C32AA3244C8C1B4AD46F32A84777DD89D51EBB7742CB6E72052DABEABEEA455F16B58544A2557BDE0DD54B3590B8B5179048F486F0F8ED7FEBB3D2F69ABF0F826D30A442AE37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWtbQUE8gyFw4RZw4FkpBvw==
X-Mailru-Sender: 7219FA8B682B638D72A16E3FD9953F6302980B8DB596F077B4F4BF0E7EF3B544D48A73EB96638A38DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E321808EBFEFE579B5B131811C2E9C30BA4E4D1D460E1F5A049FFFDB7839CE9ED5E581D7620AC4EB77D8AD260FAE1322F9B9F81CC9E09631D42D680C63CEBA458FF39D4549A2E417
X-7FA49CB5: 0D63561A33F958A506A1F34022DADE665002B1117B3ED69665D3D3E5B51F781A4E82D2634811542802ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSo17Yhm31sDTbRFuIOw5Q1i
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E321808EBFEFE579B5B131811C2E9C30720BC3AD2A41786C049FFFDB7839CE9ED5E581D7620AC4EBAD8B01D3C9F89961C6A5670B6F786E644228B720314808CC
X-7FA49CB5: 0D63561A33F958A551964473BCC4BF1FDE5FE24F511079F39FE18F7CC0E9CBECCACD7DF95DA8FC8BD5E8D9A59859A8B68E6A4215806F4BA1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSoKNdUUzT8mQgyxHfUpwjuv
X-Mailru-MI: 20000000000000800
X-Mras: Ok

Issue was reporduced on:
PostmarketOS (gnome-terminal)
Archlinux (konsole, alacritty)
Gentoo (simple terminal, alacritty)

(this list is not complete - only those systems/terminals that I had
quick access to)
