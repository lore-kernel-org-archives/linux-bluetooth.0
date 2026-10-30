Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395786;
	b=O+/ogOPC+raSWaJ19k/9EDaMzd5E2giy4W0dhW/SWlmcNr0BEOdY63Cx55h7o90tyzP2
	 iqdpOQwGnrbSDeENIHKXjB7eZ8CSdCfDfGacJ1r6Hq+vXw8SKWdBn1eOfzT9uypyGyPwB
	 FU4zg95jkQBbwjmafHhBEcz2WxSej257BYmnUkGjhoH0+vXN4QAGDfu0HOnslkOVjTaWn
	 Chxx/NlBXJzqBlnOOlYtb9Duqjp96ILeoenN93teNVznZWFXD1pGjMCbYOUn9/nsgDg9K
	 grziVMxRmys9VwRGlDP+6Glir57muJ7xGUgc5wKMbFuxboOh3ygeROT2/HI/QHD2gAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GoNTkqst7oggjvkjJNtqv78A2GIJ3OmAHMk3cwWqm50=;
	b=FaYSw4FBP6XwVdjJ3SnbQ20YqQbdNqER2RWeCModfEQn8vrIRehCdrSvd9DM1kYipiAh
	 j/kAOyd16lFgSQfbmUEFJZJS9nj4c8OQW+dBG3TGpZ3Jv+VZx7UWl7/l1rv3NBcQ0dJK1
	 b5n0UXzlo4MJHsreIZ6322hiACv3RQQC/5Dje6du41DVQENOsGMT/Ox+yIo/NpdaKdx6F
	 D47l88e5JT4FvV2oDWYBJe95RG3AwLeaRJcpwSpLzWmKlRZLH9SgZeePG8NQHRgxu6Ika
	 ZS9mfWrSzzzUDWi5bSWw7sqrSN37PRGo8GffHnrq+fFUpVQ+ol2p9HfEhwWQWYVuGdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFotXGzu;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122C606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2122C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xFotXGzu
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9851592ada1so322571241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395785; x=1794000585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GoNTkqst7oggjvkjJNtqv78A2GIJ3OmAHMk3cwWqm50=;
        b=xFotXGzuy7o3759/7tNruCyyaotw8UyEfiNR3dMgzrNCud4KtkJIW2xvxYej4U56mi
         PbSO42nISm1qlpMh621iyzVyJIdHnAO56rrhTGNUSY9K+nxYEEc+tBuxuJDH08Vme3WK
         FFN+UuGhdWzzzdqZdpI60QAVebC9tijBp5ipS35/cr1nI40FI4HvpiYboS9ukXj8exGT
         JAamg9l88jzTCQO3RbyxubRFPANU6kw71jJQ7sWHtXh6f8rpWb8m5MZAskwMxY9CnmFO
         lhYlSlvdGdN7WSoyRRy+2AEPikvxTQLtNYxUfxnoToW3hvxQdICSCw2tyQzfSv3/1lrW
         Qdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395785; x=1794000585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GoNTkqst7oggjvkjJNtqv78A2GIJ3OmAHMk3cwWqm50=;
        b=HV4D4WYw/mWErR6JADrTMjTHb19D9MbQ4TvxotKpm+tUHO6VYsG2gegDheyXrsB4+c
         6Hbf9WZuUbsPWQPvyVH4xt+bf8lc110UFfgtvq6AT2rHljXwVKnJty4TZ3bamzV50EDw
         4Z7j3yVC/5nvNaIYzmkacaRemke4bq36mbt4Np9Iz8NN07hLS03++iOkJVRMomcDXowM
         6FhhIO8o5i/mFTc7qvVDsjhENIFA8j+NKIO4jfkCGN46vWuq8qVaiHNwS1c6djF7rVH5
         VuNGz9v0oNg5grkRvCyfiMTjHY1ketqSUMWwq6lmZdv3/fXb/+w2Li/ObjsSjJPUP9/U
         dQFw==
X-Gm-Message-State: AFq9FYIzJ4CLuazfrJ6HraH2siYWw3wTyPEsGPlIIo2cN9MlIJ6DqY5G
	0AewEp+bJ3eibsqZk5zc4smiKRExQwz0+8G2r0yRZpTrL/a0uLkohisChKWT8g==
X-Gm-Gg: AYBFou3EHBYeoPo0iH6Lpwq4Yh9FX8MTNdW+VxHqWyQQWhidrEy0DEkx0D0m4Kdej7m
	VAZwwG7I25+H0GCH8cnWx7IAcs7kMsRoRrhkcQqJJEjVWjuD8MyFFCoiTwx5E53zRA2xqsAs71P
	qdwjzNTlIJdp1qjwZYX3g/WWyNGj9Kg/wAoQyscECxFCW4rCE8+nljgFDxkquNJNUJxf6pASVCx
	x9iVljEPNSBElTH4VmuQgFXPShpG46o85YIcLfUAsjwIiQysyQva1LYuROiUScflz/+fpUTfSAN
	1ZeAXgClna1WXD5cLIbSOZBe49j0hf02/dJni+CmTQFJ6K78AwrceLFwmgjRcx1AOUqZ0JDzm5E
	9iikDJwsLar/TBp6q8etzccci95rHmzsfvdgq+Vudo0VgRDViWfpyllM/iYqGCxkvTlm9Sqcw8s
	O+p18oeDTjPLyKxpPs7vS9b8Shfrl4G/qhXOksCp0Pvi/VQJ6tc9NrYgDq/4ngFP9lzuAqEDBUe
	D6K9jJTAbD/Z0mMnHC+sqvHHYbhAAZAnBLtvOt7VSEA2KHcoFTJ4tRNC7x4RTyMd56gwvR4qXSN
	mwbln9FT1Fqxmw4HzihGG29lA9vvbYE4omf/4dk/32QpVmeTtdM3mMiXoiGSkKDdjZkXS4hlsMY
	knG5/Yt13akKvdzjJ63qCl8VJc1Z6qMvwK+0hlrE5E4QnYXEKHOHIyuK4xyRjIj8+y95ulfyC7z
	Ps8qp0rtPkbIGzZutdHhekjhp9
X-Received: by 2002:a05:6102:c49:b0:7cc:33c9:b3d2 with SMTP id ada2fe7eead31-7d0726825bfmr1779760137.25.1793395785128;
        Fri, 30 Oct 2026 14:29:45 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/10] tools/test-runner: Unbind virtio devices before powering off UML
Date: Fri, 30 Oct 2026 17:29:31 -0400
Message-ID: <20261030212940.753771-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

User Mode Linux unregisters its virtio driver when powering off, in
atomic context, where removing devices that sleep, like virtio_bt in
hci_unregister_dev(), triggers scheduling while atomic bugs and, with
lock debugging enabled, an endless loop of warnings.

Unbind the virtio-uml devices before powering off, so they are removed
in process context.

Fixes: a7e9a42a791a ("tools/test-runner: Add User Mode Linux support")
Assisted-by: Claude:claude-opus-5-5
---
 tools/test-runner.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index b4947f113607..0bca31a46351 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -232,6 +232,39 @@ static bool is_uml_guest(void)
 	return uml;
 }
 
+#define VIRTIO_UML_DRIVER "/sys/bus/platform/drivers/virtio-uml"
+
+/* User Mode Linux unbinds its virtio devices when powering off, in atomic
+ * context where their drivers cannot sleep, so unbind them before.
+ */
+static void uml_unbind_virtio(void)
+{
+	struct dirent *d;
+	DIR *dir;
+	int fd;
+
+	dir = opendir(VIRTIO_UML_DRIVER);
+	if (!dir)
+		return;
+
+	fd = open(VIRTIO_UML_DRIVER "/unbind", O_WRONLY | O_CLOEXEC);
+	if (fd < 0) {
+		closedir(dir);
+		return;
+	}
+
+	while ((d = readdir(dir))) {
+		if (strncmp(d->d_name, "virtio-uml.", 11))
+			continue;
+
+		if (write(fd, d->d_name, strlen(d->d_name)) < 0)
+			perror("Failed to unbind virtio device");
+	}
+
+	close(fd);
+	closedir(dir);
+}
+
 static bool find_kernel(const char *root, char path[PATH_MAX])
 {
 	struct stat st;
@@ -2213,7 +2246,11 @@ int main(int argc, char *argv[])
 
 		sync();
 		/* Rebooting User Mode Linux starts it again */
-		reboot(is_uml_guest() ? RB_POWER_OFF : RB_AUTOBOOT);
+		if (is_uml_guest()) {
+			uml_unbind_virtio();
+			reboot(RB_POWER_OFF);
+		} else
+			reboot(RB_AUTOBOOT);
 		return EXIT_SUCCESS;
 	}
 
-- 
2.56.0

