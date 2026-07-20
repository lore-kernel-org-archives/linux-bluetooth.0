Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255B42BC33
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556560; cv=pass; b=iGMz7rNU51lH1Cn3C7ii5VJ9dDInD9iebPU0zEnCPAPJUTL+H34L3dj7NjeA0bRE3HRco/tjrrkf+bVHnsCfShzLv0aH5vRLmKak32BoGD6oOm1T/ni8CKFNOqL6S7I/venjJzZWy2+nXUo592oZ1SBKHJbs3KP+VVQywpnMeSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556560; c=relaxed/simple;
	bh=qd8/hFAc25E6jb48eCE2wh92eWpaePh+UbVqhSUI1UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzBjRpTq4P61Bi0QUHfrnYPgFg6XX42jSJPz2g4OUC+zzyI6oLorJ/RReSsu9O2wxEsLuzbVnwE2j/qQ864i+Kwl+kDk62vts9hXrA7Ablrth4Kj6qxVAy+EBzpP915IS7l46QWHoNIyqfAiURXBQawzDw5yjCbf7QapF1S4A8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lhFPJmT8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lhFPJmT8"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4h3j743YRXz4BKKr;
	Mon, 20 Jul 2026 17:09:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784556544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+hgpM/hGdQHfE0tGkN2IERguQSmxZWIxPbGqCtMeGbs=;
	b=lhFPJmT8lnJpDEQLjIaZ8/EP8GMcsZdM1j5aYSsIA/gA4O2Kouo6xBgMh5lNhdpkAiV5GP
	gxyMSC9SlrBEeiFzomsaua6hjidk/NpmFrcMk8uyCJT4m0Bvz2aJ1PhH9XSVMf8IGsDg//
	sea15PtwkLkPQ4LwQvFaWJeJDDElPHORVCKoNBRxma3bGWe4Injd3RA1QZURKinU3drx0A
	cmVVoivX4Pr8/JkEoruUFJKckNtePsHWq+vJIhNDqoo6OHcENj3wJQa6YxR2sR2mm9PNbz
	GEk0Wxyjg5xswdjkcMhI+JIRMOGvvSKmpdPcsblh0wW/WKMt6XOkXoRg2WW6Tw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784556544;
	b=tbqGglZrGRVCL8aepMeYicIqFeXWjxOXdfiQgHXqx8NrwehIHwyt5jFFcW+BoJSw2aQRFn
	GMOozSCZTOaxHLg/CZAvwAlLUWlfiCiSJGYq+ghFcJk6wYqEtXBZbHmAn0uersM8S6oRSD
	DU40OyFToqP7CElAKXTd6imsde9gUvEY/0aRsXq3MuCXTH0TtnbW19f4oTpo8XnjbxhCES
	4Brcs8KkfEO+MtonK50DGybvaffxRrXrI2KWv6D3qG/SDW0G6CeGjaF32IVtuya0oDq0eB
	2u1WE7jbM2ZmUPyMjBCa2Q5OZzElWUroLZdt0F5sx4/aW18LXIXxXLysq7/Iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784556544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+hgpM/hGdQHfE0tGkN2IERguQSmxZWIxPbGqCtMeGbs=;
	b=WDQHb1HvJntpC6mk3riDfmk6W2EVYg0O+MnuLR7pMbRB5bYqVh4z0QKiTgj2dhVPNCuxnU
	MAoJkpr4cP04n70gZk8dlIYT5puOudw82fk/j/kN8oGpeXYxnRmDnruaaVb0HopWXLtpU4
	MF+ryIAc7Vz7BJt82d56S1+SQgi+lXRLuOzQnTSbv2VTJet8czbr8qsgSKdhuUzMDuEf7r
	tH3tZMPuS4E+x6ZNOzSK3j4VwJMbZQAm8Y5KqC2yQp9iFvqC5+MrWD9V0fWHgSQLjH+BjE
	R5JFuYKz3oWHwUJNNJUPeKFhMscz/uadfJcAfREk5cDXT3Wqoj+dqPfuYEEFvw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] test-runner: use virtio for the default kernel console
Date: Mon, 20 Jul 2026 17:09:01 +0300
Message-ID: <e71384747c71a2fa0db585acdb727f324161d1b8.1784554811.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Serial as console is slow when commands produce large amounts of output,
e.g. for the -d debug option of the testers.

Use virtio console=hvc0 as the console, requiring
CONFIG_VIRTIO_CONSOLE=y which is already in tester config.

For capturing the early boot messages, retain the qemu serial, kernel
will switch to hvc0 during boot when the HVC driver initializes.

For: time tools/test-runner -k ../../linux -- tools/sco-tester -d
Before: real 0m32,094s, After: real 0m8,967s
---
 tools/test-runner.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0e3bfb8b7..4617afc63 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -238,6 +238,8 @@ static char *const qemu_argv[] = {
 	"-device", "virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root",
 	"-chardev", "stdio,id=con,mux=on",
 	"-serial", "chardev:con",
+	"-device", "virtio-serial",
+	"-device", "virtconsole,chardev=con,name=console.0",
 	NULL
 };
 
@@ -291,7 +293,7 @@ static void start_qemu(void)
 	}
 
 	snprintf(cmdline, sizeof(cmdline),
-				"console=ttyS0,115200n8 earlyprintk=serial "
+				"console=hvc0 earlyprintk=serial "
 				"no_hash_pointers=1 rootfstype=9p "
 				"rootflags=trans=virtio,version=9p2000.u "
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
@@ -330,11 +332,6 @@ static void start_qemu(void)
 	argv[pos++] = "-append";
 	argv[pos++] = (char *) cmdline;
 
-	if (num_devs) {
-		argv[pos++] = "-device";
-		argv[pos++] = "virtio-serial";
-	}
-
 	for (i = 0; i < num_devs; i++) {
 		char *chrdev, *serdev;
 
@@ -915,7 +912,7 @@ static void run_command(char *cmdname, char *home)
 	}
 
 	if (num_devs) {
-		const char *node = "/dev/hvc0";
+		const char *node = "/dev/hvc1";
 		unsigned int basic_flags, extra_flags;
 
 		printf("Attaching BR/EDR controller to %s\n", node);
-- 
2.55.0

