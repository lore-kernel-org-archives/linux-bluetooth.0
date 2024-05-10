Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC81635CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332705; cv=none; b=HSR0cwqVkM5UPhFvuPb1etv1B0wkvJFx8NmQqEgUcm5LK6QEIATqPZnM4hunpWLv/B5ZKRnZz/yz5u+kv3FHDnqckpSQazxxXyhRud2ByCwJako9zVajt9hwAY1PrTRUvgbgXHStiH/cHveGPOlSFnNOmxvTATHTqpZfHfW8Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332705; c=relaxed/simple;
	bh=TmByswNQKHOXRhWykun5laQ2PUPsFpZeRBbgJLQuE2w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHM4BLMeNV8TJPz3ZLx/LvTcZlSVsmhZP3kr+s1sx1YSgQIw2Eh3QWfo1eKwoAjr4WmqEUbjkmyJBR6nJPMig33fLKwTGIaON4wNQJ2r+Gh+Vk698qFtSJRp3kd5l90bz1rCJJZpmObsrCZqP3p0qxrQesXAM9wLEHbizaR8m/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F01211BF20B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 03/14] client/gatt: Don't pass negative fd on error
Date: Fri, 10 May 2024 11:11:01 +0200
Message-ID: <20240510091814.3172988-4-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: NEGATIVE_RETURNS (CWE-394): [#def33]
bluez-5.75/client/gatt.c:973:2: negative_return_fn: Function "io_get_fd(io)" returns a negative number.
bluez-5.75/client/gatt.c:973:2: negative_returns: "io_get_fd(io)" is passed to a parameter that cannot be negative.
971|	msg.msg_iovlen = iovlen;
972|
973|->	ret = sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
974|	if (ret < 0) {
975|		ret = -errno;

Error: NEGATIVE_RETURNS (CWE-394): [#def34]
bluez-5.75/client/gatt.c:1049:2: negative_return_fn: Function "io_get_fd(io)" returns a negative number.
bluez-5.75/client/gatt.c:1049:2: assign: Assigning: "fd" = "io_get_fd(io)".
bluez-5.75/client/gatt.c:1062:2: negative_returns: "fd" is passed to a parameter that cannot be negative.
1060|		msg.msg_iovlen = 1;
1061|
1062|->		bytes_read = recvmsg(fd, &msg, MSG_DONTWAIT);
1063|		if (bytes_read < 0) {
1064|			bt_shell_printf("recvmsg: %s", strerror(errno));
---
 client/gatt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/client/gatt.c b/client/gatt.c
index 3aaa7a9361b9..6c7603985172 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -966,11 +966,15 @@ static int sock_send(struct io *io, struct iovec *iov, size_t iovlen)
 	struct msghdr msg;
 	int ret;
 
+	ret = io_get_fd(io);
+	if (ret < 0)
+		return ret;
+
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_iov = iov;
 	msg.msg_iovlen = iovlen;
 
-	ret = sendmsg(io_get_fd(io), &msg, MSG_NOSIGNAL);
+	ret = sendmsg(ret, &msg, MSG_NOSIGNAL);
 	if (ret < 0) {
 		ret = -errno;
 		bt_shell_printf("sendmsg: %s", strerror(-ret));
@@ -1052,6 +1056,11 @@ static bool sock_read(struct io *io, void *user_data)
 	if (io != notify_io.io && !chrc)
 		return true;
 
+	if (fd < 0) {
+		bt_shell_printf("recvmsg: %s", strerror(-fd));
+		return false;
+	}
+
 	iov.iov_base = buf;
 	iov.iov_len = sizeof(buf);
 
-- 
2.44.0

