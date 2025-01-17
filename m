Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230219B5B1
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137333; cv=none; b=QthK7MpHsqbm9qPqgG/bD238vxRpMkNTzvXHomYFD63OAEhBz09/NxdlwkEdYojpXKapOGRryXB8ToPP4HQwP8oOcu4zaD7LwvU9Hb9oP8sN1164K+QwTPVveEZHwQo/6y0l42ufaL5VWNGEmEDeOrCRMVl4Kj7S2xgVV4PDEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137333; c=relaxed/simple;
	bh=p8iOap8zPn5QBRRJAIA+Diw8q1LRyqupL+cFi8WiXUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4DJ0PxNrQVlotP5ZFt5N80tIlt9lwAlpjJd8wJt/C9k7ByL3/88FVAoo5GrXSJYEe3HW3ZtLA1/bKdUGjXkpUrRMYnGnBFsDgCJ+ii6Fi8JtbUCIx8e9c3qakq5703YKEIQc9Lwm2N0Fa5ST4nWnuoACS6NCzHDMqwUxFnqYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=WkHlEAvw; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=fzRYvDgb; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=wftw7E4p; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="WkHlEAvw";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="fzRYvDgb";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="wftw7E4p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=cTjKWmnT2K2YYaKz3L1Z+ig3yjJ59rg6JmWK+PyWsts=;
	t=1737137330;x=1737227330; 
	b=WkHlEAvwGhywZckPkOMbBYkcJFiQVArADGRjTKDiK68nVrJABrbBdNTU5QToDtexFJ93k9fSMc0IIYLUhEPA88XgDmOKuQXvOVAHdm25rbq/j/COwRDty3tGV9AbtBHhl2OJ/17wuVKSh+xEKF9nZlqOPMoZMHyPDigBsaJ5IPIaz5YVPUQxqPkD8cVeX6s4RWkIZeQklgAUpriDjHXSCtefgRI/FrW4ISyDO87NXc4xj5RyFCMjclws0DdBcX/sOLiD44z928/a+1sdJrJ/bjjUIgummdrgsISAQOPg+Kk9DA4mvmh5x3l0I44eUO+fwpc6i3m6r5CWLIcR9mGaQw==;
Received: from [10.113.156.13] (port=50430 helo=send288.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1tYqlv-009XKZ-0t
	for linux-bluetooth@vger.kernel.org; Fri, 17 Jan 2025 21:08:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=cTjKWmnT2K2YYaKz3L1Z+ig3yjJ59rg6JmWK+PyWsts=; t=1737137323; x=1737227323; 
	b=fzRYvDgb/PnIFyqCZNqjPO6d/NcebtrXGhjyQQEZ+4Ykv3cSh5cZP8DkGEWX4I3HTHohwmFZEGe
	K3OllK1RfnstwXfwDMQV4JciWvqm2/UUBJNDp5yJ7mOcsLRBA0rBu9KwvYirGfutwEf6lxlMStcTW
	HKX5nBL6x04WDrAdA7GtYK38DarBPhh9/MEgiDT+h5k4L5aVOQQgv5mbA4acqvo+r7/668KzjJ0az
	AMZoXo4mQsEf/52/ydqulCaX88bTcBUJvr0iXM5ekh848/OYwC8PLcwuzvoOUJazhXUShpfrvdI4P
	gF70q0xDtneqtHhDOjkFtCs/tfHeC3TI15zQ==;
Received: from [10.113.31.164] (port=52236 helo=send220.i.mail.ru)
	by exim-fallback-55f48b6675-f8f7z with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1tYqlm-00000000Pwc-2pbe
	for linux-bluetooth@vger.kernel.org; Fri, 17 Jan 2025 21:08:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=cTjKWmnT2K2YYaKz3L1Z+ig3yjJ59rg6JmWK+PyWsts=; t=1737137314; x=1737227314; 
	b=wftw7E4pSMO9HxAT+F+FIi9740p9KUsNMoFYccUSJ/6Pl6w6lhKiSjjRtB6tSXtprRP2N4M6ac4
	QfOHT7hHpee5BMR2gVekEYhNA7yTGxOOVVEnqpejZbJZoOgTUHOdlYQ4MEPwX3lBJ2rE5yWWryK0v
	eFqlQqGJ09Sw8kAOjKW1R3R0KNmTS92VanCsCRt80ZUHhfkiLLv9CayhqZ1W4K+JnCf7tUxtyQuLQ
	Tq54GCJahB3I0TP74F8r5fWasB6mZ/SaGQQoTiXpIlPWEVOGHF6ZT/rgrg5hYm1p7svsZ8ffL+52F
	MCKx/c4UZr8RMI7uF2NBI4PaKEHy6vvPiPSA==;
Received: by exim-smtp-6758d5575c-cjkqz with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1tYqle-00000000Kqh-2PzX; Fri, 17 Jan 2025 21:08:26 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: linux-bluetooth@vger.kernel.org
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: [PATCH BlueZ] shared/shell: add proper line clean to bt_shell_printf
Date: Fri, 17 Jan 2025 23:06:11 +0500
Message-ID: <20250117180611.14869-1-hitechshell@mail.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F92BE5667526BA91DB058AA908F74F18DD3029687DE63693182A05F538085040176DA923CF62C8753DE06ABAFEAF67052323D17CAF8DF22DA955C7343EF8955195F83A364D46ACBB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CA8E915ACC910FBDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CD8995A08F41566CEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C90036BB6B2C9762B95F9C9C0D0F3C70CB863821DD6C5BEDBC31DF9E95F17B0083B26EA987F6312C9ECB28585415E75ADA92CC0D3CB04F14752D2E47CDBA5A96583C09775C1D3CA48CFED8438A78DFE0A9E117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE77FFCE1C639F4728C9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE752F7DE0B01B7D88DD32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED629923F8577A6DFFEA7CA130F49D908D5024CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269176DF2183F8FC7C0D75EB778CE7D8A0C68655334FD4449CB33AC447995A7AD186D8C47C27EEC5E9FD5E8D9A59859A8B6EC8B63A8A94DDF1E089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5F5FA73486B61B62E5002B1117B3ED6960C4C9B67C136431E886DC9BC01168B20823CB91A9FED034534781492E4B8EEADEF0AF71940E62277C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFF2D86CCF3113FE61405950B64E60C56494563BC18524CCED170D09ABF08BCC9A2DF5FAC740BFE7CD8239A89FD99B187528C9430C0E338588214E9C5D1211E9FBB3386D30C4F613E2111DC66A97D0BFE2913E6812662D5F2AA6729FCA2018FD0220873D81B8D7664624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWtbQUE8gyFz2wyqos6jkGQ==
X-Mailru-Sender: 7219FA8B682B638D72A16E3FD9953F6317E7CF0FA865E05B7A7607D3AD3E355E10C79C63003797A5DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E321808EBFEFE579B5B131811C2E9C309C97F73D70E14C15049FFFDB7839CE9ED5E581D7620AC4EB1A7F62E7EC3621F8515618464F639D725D623832E91A78B74B8ACD64BFFA8767
X-7FA49CB5: 0D63561A33F958A556A70E9205059A0B5002B1117B3ED696BA1412AAE8AAF819E409568A2FDEBC0902ED4CEA229C1FA827C277FBC8AE2E8BA767AF59AE04DACF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSq9RJUSWxbjabRFuIOw5Q1i
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E321808EBFEFE579B5B131811C2E9C30265E0C284DC06AE8049FFFDB7839CE9ED5E581D7620AC4EBC239D44EE3EA5B4E453E46A1937546F3F550BC2F89CC81FF
X-7FA49CB5: 0D63561A33F958A5D3F31E940074A13D72D04F2221DC734572AC3E2D8B9F09F7CACD7DF95DA8FC8BD5E8D9A59859A8B682CEB350B80293D5
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSqw0pZiC6kS8NyqHyU9iLcO
X-Mailru-MI: 20000000000000800
X-Mras: Ok

---
 src/shared/shell.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index aa6c16c8c..837152525 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -719,6 +719,7 @@ void bt_shell_printf(const char *fmt, ...)
 		saved_line = rl_copy_text(0, rl_end);
 		if (!data.saved_prompt)
 			rl_save_prompt();
+		rl_clear_visible_line();
 		rl_reset_line_state();
 	}
 
-- 
2.45.2

