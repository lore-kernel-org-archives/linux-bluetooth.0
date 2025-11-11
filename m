Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4130E0F6
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876695; cv=none; b=YPghA7GZONAZBQdg/5G6cBMI63bcay8lF3TKiYKwDgWzF1YQVb5AlXo9niTI+5Tgm5H93Z+4OMZuJBJftPVUekd2wcDDiV3uk/u1ZuCoOQURy3VAyAx3sBvg3J+gQlwdCXhgmoCw9Dv+q/4qKorHSiKVQLieOFrhLvH7l64bRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876695; c=relaxed/simple;
	bh=VLXijM+9GDZ3LbedFPG0feJXTZVcR7lKm2IMDsNjkyA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDCs3OeHWX6IEOYa/peG0yeAj0ebm5Dj8mZZEaUjBAbR8ms+vPv2BJv1KoM7cIGAQhTl77ejccZlF8ysLBpbfmvJc0s3C4slDlxjIlveO59AwKKtAL9PgFyLe8r7KKfZHwtd3MRQGE6uNhchViq/a96ve5DuouQuuc3n9KNbr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=IeKjcKtX; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="IeKjcKtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762876678; x=1763135878;
	bh=VLXijM+9GDZ3LbedFPG0feJXTZVcR7lKm2IMDsNjkyA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IeKjcKtXU/2elM4tDy13mu6pAOo6kmpOUEixnvoU3W+9SkEAe7wrTqqZbNItbSFkY
	 C92t1jKDHCU7akXoigTVcM/PXxTBfFbDvFQP6Q0pmhXIopWdDnSKTvFFRDSDESYRAS
	 0xAmCX3KyItKkYcboxooB7WPQKMiIGJfWaUmWbMvIiQyslIapgvb/ox0vCPfXEMzbB
	 lNjSwECvYzC21af8CUf4foqAKjISnqg4n0vqdMZCZ5efgGkaI9wpPSv15Qh2OPjZSS
	 EFz58ip7Q5o5PNWSUN+QjyjPhdiVb9xNMvJ3X4m9oS4cK+VoYB02e1eRTgayVqaOmt
	 uitlDemn7Zp+g==
Date: Tue, 11 Nov 2025 15:57:54 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: Alfred Wingate <parona@protonmail.com>
Cc: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH v2 BlueZ 1/3] build: use AM_DISTCHECK_CONFIGURE_FLAGS
Message-ID: <20251111155644.11675-2-parona@protonmail.com>
In-Reply-To: <20251111155644.11675-1-parona@protonmail.com>
References: <20251111155644.11675-1-parona@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: b557e250ba37c8289ff58db6147e822f3ab30f5d
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Alfred Wingate <parona@protonmail.com>

DISTCHECK_CONFIGURE_FLAGS is meant for users to be set on the command
line.

https://www.gnu.org/software//automake/manual/html_node/DISTCHECK_005fCONFI=
GURE_005fFLAGS.html

Signed-off-by: Alfred Wingate <parona@protonmail.com>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 94f625db4..708e2ff14 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -744,7 +744,7 @@ endif
 EXTRA_DIST +=3D $(manual_pages) $(patsubst %.1,%.rst, \
 =09=09=09=09$(patsubst %.8,%.rst,$(manual_pages)))
=20
-DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles --enable-library \
+AM_DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles --enable-library \
 =09=09=09=09=09=09--enable-health \
 =09=09=09=09=09=09--enable-midi \
 =09=09=09=09=09=09--enable-manpages \
--=20
2.51.2


