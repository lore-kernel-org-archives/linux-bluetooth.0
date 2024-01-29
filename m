Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C266B40
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=qWooKvu9bqQF64hothf/ktMp+c4t4Y42jQx8UDy1TzyLOTmdtW77rVgW0D0LTTfRPoaS03wTDi5Dvbu0Ni1jAwMzuotV18W5NYmvaBAvFXGUdUG7cLJlus2Tc06iCBz/BiBCi6g/uMkDorI57iBRYVPONgrHBtzGVirJ7TsxnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=T41AqRzZ9anzy8KgZAVF0U4kwCqsFRwAQlKY9yqeluE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZ/YhtJUdUsmhStKA1KeTkR1zTbESSiRBfllfXBlGxbNTEJ0vXGruAGpGte0rVPrg5+Q6gS2rZL5/7kVM7zpfrO9XqacjitRlyYdIaQc8oyTGsjRfqdIoRX78pQCv2Ko5WzOw5/g3IaOFxg6xBe1vO6hXe/njiKQKF4WctgMWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoXbC1v8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoXbC1v8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1071C433C7;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539456;
	bh=T41AqRzZ9anzy8KgZAVF0U4kwCqsFRwAQlKY9yqeluE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HoXbC1v80x9bs4MgtcoQrj0Z6zMsG2BpDpX7gwWSSCy9WhhCOin2R7ddkw03BkSVU
	 jxvwL2yUiBQQNBoMovqypxaQvVGuq2TgzVCUKiDo5XcZ6OO7274niLwPROPu5qtWbM
	 cVj4++wNZl9DDnUmtJLYCZDRDr9polqV5DBeFE1FT+cJ+lG0lHzeDAbn+x+fY/2OfV
	 JwaBkIOWTToeFx3Pr6VgYpvYBn3EVQp5QaWRX53IHYTfTVegUnu2kIRCUC1mEDAyUI
	 bf94F2NPKHN15urjT5TpY3974OZrlxTbvbJtiZZQbeMxqSYEJeH9AB36XkCrI5NwX4
	 G0kOVG0iaM2ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5581C47DDF;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:15 +0000
Subject: [PATCH BlueZ v4 1/8] configure, README: introduce
 --enable-external-plugins
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-1-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=2129;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=TURnkD96L8lhhZthFxY3kbYoSxFEDANByCVJaEdcrOg=;
 b=OfKLp3lmunDbO7SjD7ptcG7Qsp0A7Ef092N5KC4EjC4bBBcdkUFQCFyaIcEUTotTlBf02WBHn
 7UV3hCvEGk6CYNaD3JY5SPTRt1b06qFnO4HHESYYrIJybQz3D97ktHG
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
index b4d362494..5eb7ee0e0 100644
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

