Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E5427FB3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130839; cv=none; b=UG8/de6H5VgFnraAVgUZ+QdEErE5YK18sKlgH+l9MiY7CTid5u2uy9xIl8OKK4F/K3doFGy5p0J3/mGGXYQ6qmEeBIyw5LWV5o/JJLYEkch6DYBIXit+HJlkfGkWmqwar1Mi43V+hvqRPowGe8xRZZ7KOMlWFuKtrZprSu+Jmgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130839; c=relaxed/simple;
	bh=xqVZpSeWDEJOXOdLGycsggrVnZLJpaa+5/GxEEUFjgU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XZ98fKG3WtOt08woeS4Cnh2onuZCmFJEdLb491nknMfOZLRk5eHTXFIw8uZmvPT/i9x38Jl63MlRCKS+tMPFnuy7nxf4F9tTrVPZMIoJp+c2HtxN4q8NprzLLQLXLFPPPAHhQQANKg50wfg6u3q8WYcnTKPmjWocQqstdrzXUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0AC91F481
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:13:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] test-runner: "-a" option also stands for "--all"
Date: Wed, 19 Aug 2026 11:13:45 +0200
Message-ID: <20260819091347.1204005-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTG18iyAMEIQjh4veXWtQlH0Odvj9ozjZBJUum9zgChOm20FdzK9SMBkyMCI1MwSB8ZsrMDyzAQn7VFNEJnNGAty5q0MJq/QBw0KRNd8QCLUTrz46Ux4vyqEazuazvhw/BmaLZHCkEoTi3Ixz6bEQrXrhpaPtwJNxyOLlNGqv5TltXTHRWRkM3XMseRY/7rWBbULvKlr0OmYsB33fOEWg8SCw+ZCdUj7Ow2XqxC5xhCi/4fyCqR69aPWzcUp/dX92TYxGrzazYt8i7tsm2e5XvN62PwbZkNVhT62c1zU+qFv472FbcED9TdtqZ0qlwVRiNRevVQAjuz+F9DG3nfAx/ekNiA5mDiq34A0AEMkXcmdNgZZf77zHJCDCxEy1iav+CzB/aEjeu8SK0LKIK3rOS3knP6cddGCwz0Z4/D/guPmYjvPzlkQ/BEOHZvLyCU5KxV+pDxA8Qr7aCEOPiyLhd14nxUFKRGv2WXPoihtIqJ0bwoGyp+0Pu2b0yyy8BQPKm+bF9cFgZiDFAruEKY4wd+qR3eWKK1z/BHGEccBeePIdCrbvJbO8j5hRinvvquRb78kDj8GEniK1HdXizYoP2ipQ44SkDgWCdfeunR0cVKCH6fSs4uY28Cu36f7zmZr5/eJVVpJKxAh1U8iMCAH6kqJyXWn4TOGW8PpKIWkwJ43jA
X-GND-State: clean

In the options for most command-line tools, -a stands for --all, and so
it does for test-runner. Add --all to the option description before
--auto as it's a more common option.
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0e3bfb8b71ec..9fecea4e7486 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1216,7 +1216,7 @@ static void usage(void)
 		"Usage:\n");
 	printf("\ttest-runner [options] [--] <command> [args]\n");
 	printf("Options:\n"
-		"\t-a, --auto             Find tests and run them\n"
+		"\t-a, --all,--auto       Find tests and run them\n"
 		"\t-b, --dbus             Start D-Bus system daemon\n"
 		"\t-s, --dbus-session     Start D-Bus session daemon\n"
 		"\t-d, --daemon           Start bluetoothd\n"
-- 
2.55.0

