Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225162F90E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499329; cv=none; b=X/aIPdspllijWttCOQf3fPDQY65YAm4hKapl1N4sbCwgdLUiNYVzhpP/esNV/01hBBuCIpldIQsWclwa6jSrjAheTTVSf5ZmyBo7t6TfTIB6b6jkqUNehz9KuU2AY2WlfdeRn2X2VFOhRANAmcPdBJoDOuED9aqCudovfB3Bp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499329; c=relaxed/simple;
	bh=2DXRAxdJHAKxfr3TF9L+BXgBYXIUfjOLqAUAz+Sea1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zfd/yjNXi1uRUaiVWT4pEh016W6x/2gs9kvmzeyKTPpL8LJhHWhUOhFmyPSR1ORGh/hQBo9mp0SWUd5kPdH6uxGed0ST9WOKz7Gkvdd30TdxehvhDK2X0v4e13ncME/HdOOMrlI0rxhyPF5UR9bNcFs3es60MSlSQV2wvupkHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09AB83EBDA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:35:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 3/3] mesh: Fix const qualifier dropping when using strchr()
Date: Mon, 11 May 2026 13:35:07 +0200
Message-ID: <20260511113511.1217887-3-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511113511.1217887-1-hadess@hadess.net>
References: <20260511113511.1217887-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEmeJFxZdEJ6MEKEBnx4R7zUTU3WB0Nrjd2shr/6yJhMwgp4Rm7j7kZ+R38IgpgPE/d1EjFusRsaGrp6r4c/x61y5UdmQqlWvmi3wMg2gTL0DmKzPZd5iJe1Ly5GIW1Gr7eTpHPd/I+sxI4Dx7RZ52nbUiiVSaD9A72Mrl6OL6pGGu+1eT4CQEteEYjRKFalPRXrwVLuv15T5GymD35/+CLss0ytkqdtTYBO0PkFaG0ED8dJR0aKy2JqezLbSWqg9GOD8ygn4oTjM5/Xic73wdWCl9jLbRNbLjQeco+q09uA5lGLi5RsoL0s29335M75A6a+qAZHX4/KpznfIqmpqvfBKKFJfFxBkvEMYJKppDVO7y3MjQmJfEgCtweDDzXZZCL/AwUpY93qTwsJnscG59aSdjEJTMyOvCQ74doyaquMrz9TJwOndM7v3FAcpevr5qLORehdHvlMd20sGKKKQ07oQqBIAHYsqHwlsItvDxeeF3To3hQ5SAgB3LPU0eVn2eG9MsIN4wOPOtAJZkTQIKV7+0+tpTnV5dIn++diG2TO6IoGNTb1JQGIdEhIHcXCbQw5kHoFgxejuQfJ6OSTA+XqIrfBfV+dTP7S1QJMqQw7zr00bych8Bz1ohfl+10Nfz6mHLRRweCredGfL7bzMkI6ryIO8ORyeLv2juroKESBg

strchr() with a const string returns a const string, we don't change
that string or "next", so make both const and get rid of the warning.

mesh/util.c: In function ‘create_dir’:
mesh/util.c:108:14: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  108 |         prev = strchr(dir_name, '/');
      |              ^
---
 mesh/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/util.c b/mesh/util.c
index 348401ae5582..a21882a2d9f0 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -95,7 +95,8 @@ size_t hex2str(const uint8_t *in, size_t in_len, char *out, size_t out_len)
 int create_dir(const char *dir_name)
 {
 	struct stat st;
-	char dir[PATH_MAX + 1], *prev, *next;
+	const char *prev, *next;
+	char dir[PATH_MAX + 1];
 	int err;
 
 	err = stat(dir_name, &st);
-- 
2.54.0

