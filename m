Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE3193
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=mIB8Rm3IMc92H//8kItCUbt2eoaEaaO+t6YiHMiI/tnb0aBOYIdwpBauSmyWvDpIxu1Mh4A49rYhnY3JduaQpzNyxrW0HmOYGVPIYNalHXLw0z6ziyTnVe6jxCzUdi2S9ZQD/uEvQwamdy/p08IoZ5lvUhamYWXPI+a4MkCDAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=F/HbVo4A4RjQZ+vKiPn5ElqvSWqMFTAmzzmaMvmbiz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEIL0LTxRnibgZcZY4BY2TIuaNJxK/G3jx41syuf0r9KGbqoAupZNA7EycP8kIiL6s2AA0HLUkmfiI9d6R7Yerm6ChVtK2a5A8Z+TZjt47ZNGoxSE+YQuYqRrS5xFfFzyZxQ1xuiRzq70fDLiYqmP1SM3WH+pUqc9r0b4SXoSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv2UYyvQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv2UYyvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 230E9C433C7;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=F/HbVo4A4RjQZ+vKiPn5ElqvSWqMFTAmzzmaMvmbiz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Sv2UYyvQz/nf0WtlQzINAoyW8/q+HHTxUSOotCUVoAVe216KofhA/nq/lH6N9c3WX
	 dGWN4YLGzag3/ggh2praBez1CYs+/0gKV97CfuaHF/CLrWZHzsHrdR6cCQrLeSoBYx
	 DQI0AG0/hatImfpKzUyp05xWK7SMFxwzMhLNQwC0uu/gr9r78SnRaLJThgLUKDWXIu
	 BqcQb3oXD2GkeHBhLork3zOgTMDbq8/UFea3LVfYlpGKD1rUrGKpzcRqwbIrEs8z5L
	 NSIZszvoT4ZzAUrcqqXQ00BYBOXB+g3HQq+DJQlwofGgVERpQFgxr6ifWTlG5meKVO
	 aLRf++bwgh0KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C05BC47E49;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Thu, 25 Jan 2024 00:07:26 +0000
Subject: [PATCH BlueZ v3 1/8] configure, README: introduce
 --enable-external-plugins
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rm-ext-plugins-v3-1-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=2129;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=e1EdDSyciHHAaX9NsOJkW3suqFVoEXcg0Cnn7chU+j0=;
 b=ArEUScUswXs1Jus2LYZ/6mJV+xYFIIB+RTKcI7RvIw8Q5PeY08L3U/7Lzzq1xAX4tniFMSytA
 YdLYfnQ56IODVG764Q5VTO6lO0PZpJkS3B61zbIdLO6bLMhugXhDuhF
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

As the README chunk says, disabled by default, since they rely on
internal API/ABI and can break at any point.

Instead everyone affected should work and upstream their plugin into the
bluez project.
---
 README       | 13 +++++++++++++
 configure.ac | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/README b/README
index 7de7045a8..6c0777046 100644
--- a/README
+++ b/README
@@ -249,6 +249,19 @@ For a working system, certain configuration options need to be enabled:
 		systems. The behavior of the deprecated tools may be unstable
 		or simply don't work anymore.
 
+	--enable-external-plugins
+
+		Enable support for external plugins
+
+		By default external plugins for bluetoothd and obexd are not
+		supported and thus disabled.
+
+		External plugins require access to internal, undocumented and
+		unversioned API in said daemons. As such they can break at any
+		time. If you have such plugins, enable this option and work
+		actively with the community to make said plugin part of the
+		upstream bluez project.
+
 	--enable-nfc
 
 		This option enable NFC pairing support.
diff --git a/configure.ac b/configure.ac
index cab5da581..5e353a1d6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -364,6 +364,16 @@ AC_ARG_ENABLE(deprecated, AS_HELP_STRING([--enable-deprecated],
 					[enable_deprecated=${enableval}])
 AM_CONDITIONAL(DEPRECATED, test "${enable_deprecated}" = "yes")
 
+AC_ARG_ENABLE(external-plugsin, AS_HELP_STRING([--enable-external-plugins],
+			[enable support for external plugins]),
+					[enable_external_plugins=${enableval}])
+AM_CONDITIONAL(EXTERNAL_PLUGINS, test "${enable_external_plugins}" = "yes")
+if (test "${enable_external_plugins}" = "yes"); then
+	AC_DEFINE(EXTERNAL_PLUGINS, 1, [Define if external plugin support is required])
+else
+	AC_DEFINE(EXTERNAL_PLUGINS, 0, [Define if external plugin support is required])
+fi
+
 AC_ARG_ENABLE(sixaxis, AS_HELP_STRING([--enable-sixaxis],
 		[enable sixaxis plugin]), [enable_sixaxis=${enableval}])
 AM_CONDITIONAL(SIXAXIS, test "${enable_sixaxis}" = "yes" &&

-- 
2.43.0

