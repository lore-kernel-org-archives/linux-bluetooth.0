Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B725A62F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142061; cv=none; b=GWsMWyjf4OqfY1hHLWyKjCn3jn1gTBlqjuCC+50uoVr/o09Ii+Y4OGt2+aY0wxzlXFNWUvlvNPv7VIXzoOnPHsBSrUYdmlUGUPdVz4OMGeBGagJDfqGkZlNiiNCK62/cnKTeYCF5DEzlTnM/tuNbArqmMTkRhBhYtxWw63IXuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142061; c=relaxed/simple;
	bh=Ymas41G9AUQM/3md0dB8ILMIv520vkq2KGRUUufRruI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoWZJ/ZwEMXo+3E3i6ZRV58ZMSaXO9Pg1dXkrdq6usvxrEBWVueSE915qBD/3rPkThInTd57dNVytvsLis8vkAyEfoPq0jqNWy/SP1rOEh8iKE9kqPpdoYdvBPv8xh+p3mURiWWuwG9ZDzOXrI9EnHkTysVM6iu4zWv62HefFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=lUIkzahV; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=sqcaqaoV; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=CmJ1hZmo; arc=none smtp.client-ip=79.137.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="lUIkzahV";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="sqcaqaoV";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="CmJ1hZmo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Ymas41G9AUQM/3md0dB8ILMIv520vkq2KGRUUufRruI=;
	t=1737142057;x=1737232057; 
	b=lUIkzahVMuJyunJjSzcunlLGwwa2zX9lIbuQLj6JSUA7cOl/dFaiZF1jOyQrUGEDZeOAhfVfG/0B0EET0ECOjkfzIeEPjSv/LVe0DJxcDFYoweyPl/shy75b4Z0N6ePvRT0yCWY2PlR0Ouc0ZQOWIZZYF/Y1qEPWbP5vQ858v2VFMHIFb+PkivxVD0kCRqEO/ul8KkO5AfqzSVm3dNt/mdt2GihJ4PoegvmAkJSJKqpJRhtsWds2jtyTobuTW+qrQ2zk+ch2b4lEnBTwhI+3Jh2/Dkj+ITZdMtkwjUCrh0jvsYmq/oCk/+vBF4zvmi/C3GxXRPt5Fi6+qTh8rf3xbA==;
Received: from [10.113.252.125] (port=55478 helo=send239.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1tYqwT-001KXd-QL
	for linux-bluetooth@vger.kernel.org; Fri, 17 Jan 2025 21:19:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=Ymas41G9AUQM/3md0dB8ILMIv520vkq2KGRUUufRruI=; t=1737137977; x=1737227977; 
	b=sqcaqaoVAHAxyUqbuQMpQRnS9HuU7hXhlDUAg7X3CSwH6uaEKER3xwsVmRniGc47GAl+u5yBVVf
	+cfwQvWOjCPTwWyB7fhicyZIYBE5dNEeunMhu9ihL8KmCCKNU/EuJ5e8Iz/GpXxQsa1wTNpu00yiM
	ENlayfIXCxiFN/Yk+AJPuK+Etu6co0L61tcx99onLPlagLVTWxUkXrCRz9YWaJpK7xrwCI+pfHmxg
	dVL59eUIA+Et+YMIAPBz3wZeD/D1K/kugWY16dHb61ec12qFxzqCXpcRPzMWipsoRrqHJbCE6/7ar
	wTrLTMdO/Su97lLafc+xVVi7UizOyg0D6o+A==;
Received: from [10.113.61.27] (port=43362 helo=send106.i.mail.ru)
	by exim-fallback-55f48b6675-spn75 with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1tYqwL-000000001yf-1R71
	for linux-bluetooth@vger.kernel.org; Fri, 17 Jan 2025 21:19:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Ymas41G9AUQM/3md0dB8ILMIv520vkq2KGRUUufRruI=; t=1737137969; x=1737227969; 
	b=CmJ1hZmokOF4F48Oc2rZ91kNa7746uT0GCZFz6OsefgWPfyv7HekgqGczgiHxKBTM8DMgfPU6S+
	EM4qOnQff6usCzD5aANAZwxjngUQ7SRS5buuS6wFEsWCOsN1gaILLMAi41mcpD3nJNZiKv1hdgiQU
	gxr2A6iA6w9Bpswz3NLsH5NHg8wjq+okng0F5vPaKTy6FIi4smc55JSaiMQZ4LUd10wEqlmDIznRT
	F4aMd9DvPAOzH9bxFAotyx8fHUkSkkawtZ+ks8S7Z2Z+cb1E1XHDEDHqRuWj0Bc12/JDoZ0/OKdqM
	gL22jn0xq4FYf0WB9GhsdbVGl2L96gq8r/7g==;
Received: by exim-smtp-6758d5575c-g2tp8 with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1tYqwC-000000008wC-27zj; Fri, 17 Jan 2025 21:19:20 +0300
Date: Fri, 17 Jan 2025 23:17:07 +0500
From: Denis Burkov <hitechshell@mail.ru>
To: linux-bluetooth@vger.kernel.org
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: Re: [PATCH BlueZ] shared/shell: add proper line clean to
 bt_shell_printf
Message-ID: <jjjs76es4fmqn4mrvo2u5hwjwvrg5nqi4xczh5rmr73pqzfrk6@m236ffom7olo>
References: <20250117180611.14869-1-hitechshell@mail.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117180611.14869-1-hitechshell@mail.ru>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F92BE5667526BA91E9F58B327A747C8346DFDDD45EE0D99E182A05F538085040C43F47A63428F1ED3DE06ABAFEAF6705C37DF09158E22B51A955C7343EF89551DE81258B7D5E2227
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BF6702EC5472AA0FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637040380BD28C1B15C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8818068BBA4A79AD489D5074AA622005776FCD2144A08941220879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F7900637F3E38EE449E3E2AE389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D2DCF9CF1F528DBCF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C1B3F1E879BC1E2F1BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B61E7D461CEF46D5073AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FCF1175FABE1C0F9B6E2021AF6380DFAD18AA50765F7900637F09814068C508CC822CA9DD8327EE4931C1080093C09B8365705F49E3A860CEDC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A59BE7E5DE4C55A3F35002B1117B3ED696385E734DBBE67A09108A05421C070DB8823CB91A9FED034534781492E4B8EEAD69BF13FED57427F1BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3454E98140CCACB5B3629796C2CF4167A02DF39A04C776757F46C56E40C29C94FF2F751139C303B5EF1D7E09C32AA3244C309506BFF8927DA177DD89D51EBB77429EDA331B464AAF02EA455F16B58544A2E30DDF7C44BCB90DB8B5179048F486F0F8ED7FEBB3D2F69ABF0F826D30A442AE37E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWtbQUE8gyFwJo38aqui/PQ==
X-Mailru-Sender: 7219FA8B682B638D72A16E3FD9953F635D999836DCA614E367744F1CEDD0CF3F4753C85A0B364B32DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E321808EBFEFE579B5B131811C2E9C30BA4E4D1D460E1F5A049FFFDB7839CE9ED5E581D7620AC4EBACE62DF9C0DD901B26ABD077F9082D60FB8ED4A9343E79D893E7A0542FC327DD
X-7FA49CB5: 0D63561A33F958A5AA5C202C57A778745002B1117B3ED6962F9F548F9364EBD73E359E1F9564EB4B02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpdsWEEWWYWWTqYQ0PEDyTA
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4E321808EBFEFE579B5B131811C2E9C30FFAA9B46F1D56B4C049FFFDB7839CE9ED5E581D7620AC4EB777D6865313A48243CB72750B23DDC8326198D05A65908B4
X-7FA49CB5: 0D63561A33F958A54543C52088F2DD9EB3F086E263CAEC0DCB382660EECF292BCACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSqf5aW7er5knZzUdJfQ/bjz
X-Mailru-MI: 20000000000000800
X-Mras: Ok

in some terminals (or all?) the line is not cleared before a new one is output
(for example, if you turn on scanning and then try to write something to the terminal,
the output will be mixed - you will get something like this

[JBL T450BT]# h[NEW] Device ****
[JBL T450BT]# he[NEW] Device ****
[JBL T450BT]# hell[NEW] Device ****
[JBL T450BT]# hello[NEW] Device ****
[JBL T450BT]# hello[NEW] Device ****

where "Device ****" is the line that was actually fed to bt_shell_printf
