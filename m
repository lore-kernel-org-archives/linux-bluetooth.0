Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AB4400
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jul 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428776; cv=none; b=ZSfcJxhlHTwiTQxLwhchNyatUYQNH9aGf2GM4fsXGQAguLzLNFc8kGAwh60wdCyal7o9uz8fftEHFF/edfV+lQZhpXu/66eQSbzATmKyLbAi+A3GvalF1SWVQt766s6j5R1FngEq3CUYZlhT5DYzqNbW55xKIE7I3hJqg4arQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428776; c=relaxed/simple;
	bh=1gNCwovGs2E53rzY/RgigibvQeTn98gWBcT3t+cqE8U=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VYU/5N5s625sddsMs3GNZ0hwDfkJFVL5p8r3hNkAYp1KZE1AuoqZdLWIYdmeG3byVUEs8L9YMgxPts3o/DwL7I68QRcfjBia34vE3zrcnifTVBVd9ilu6854b+jytF22joPo2AFL4HIY4Oci8+brNPlImTPCB/oQUVkPfPTkf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=u+GojvZN; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="u+GojvZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1752428759; x=1752687959;
	bh=S5o0CVD7/ECG4oMQfQVu8Xy//Upsnv3Qf6m5zwGpsIA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=u+GojvZNIrsBGL4rfKpWL0lEi8YYAcz9KmchkrEKzAfFwDruwotKhLP74bIbSNLC1
	 +Wc50ufWszMUcXFPTz5drEgXdG1cjJPmtpVwXZ2ohq+NvChTUkfaUadX2Sq4vxWw9f
	 qrqdWsr8H0YGbdm47bvLoNB6zsOUt3xfpxKK3vwSMBcUItw4Io6ZAlDkN9XAdfU+mH
	 K7QJYzXDAr348atdow9Xp4EAewAgOQi5jrv677ar0plqFEL9ejeZtBQA9vOuwO1GLd
	 CA7Po2yYoqVv1VBKWfcLwGE0CcAM5A1APdP7VTHdqVVZ3bgADT10S/f7Yez5Stkl68
	 e29uKRkgovDOg==
Date: Sun, 13 Jul 2025 17:45:55 +0000
To: linux-bluetooth@vger.kernel.org
From: Antonio Rische <nt8r@protonmail.com>
Cc: Antonio Rische <nt8r@protonmail.com>
Subject: [PATCH BlueZ] obexd: clear pointers in `phonebook_exit`
Message-ID: <20250713174550.2041002-1-nt8r@protonmail.com>
Feedback-ID: 21706885:user:proton
X-Pm-Message-ID: ff355a3fbc2ca7918aeee6b6eaf0baf2c0161479
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This fixes a double-free which segfaults when dbus connection is lost:

    #0  g_type_check_instance_is_fundamentally_a (type_instance=3Dtype_inst=
ance@entry=3D0xffffb55201d0, fundamental_type=3Dfundamental_type@entry=3D0x=
50 [GObject]) at ../gobject/gtype.c:3918
    #1  0x0000ffffb52712c0 in g_object_unref (_object=3D0xffffb55201d0) at =
../gobject/gobject.c:4350
    #2  0x0000aaaac63f4798 in phonebook_exit ()
    #3  0x0000aaaac63f83a4 in plugin_cleanup ()
    #4  0x0000aaaac63e0ae8 in main ()
---
 obexd/plugins/phonebook-ebook.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-eboo=
k.c
index d772edca0..45db504bd 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -661,7 +661,7 @@ int phonebook_init(void)
=20
 void phonebook_exit(void)
 {
-=09g_object_unref(book_client);
-=09g_object_unref(address_book);
-=09g_object_unref(registry);
+=09g_clear_object(&book_client);
+=09g_clear_object(&address_book);
+=09g_clear_object(&registry);
 }
--=20
2.50.1


