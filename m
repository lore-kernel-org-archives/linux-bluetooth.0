Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535618;
	b=V27MIpFo4Jpo4YOfkcv22xPFoTeg9FQPccyXuKXNPeHR4v1bLXYb5P1NdpboPzePAfJY
	 zq2A7Xkp2fypwRqas0Cisp23KXenDWTFYY86qUJs+OV8UeuzM1S+Vh4SblZhwDvHqI8vh
	 w6sFVBcnRxcZbDKOa2Ky7+MrX3RGbrsfQcUyCwg2UTvGxKde1n6m9QKL3YHGFt47Dr6QB
	 y9nJdaiVcngHjjrFgp2D8glLc8j9IDLhHnXs2Y9mFFFlZkYryHtIV6SbjBtYC9xjvFTJT
	 E5PGjwge+TrIq6O/quAoSrWp7Kqn5NkXBo/unPFI2gcu/ePQJlPHRBM6H8jK8vMQgNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535618;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=dKGmhE3EGMWo2/OnOcb+JkK9VU3oqaMygTogl84oBsw=;
	b=AR+nu2Fv39v4u92UqyLeLfF+cwbAbwM7Zs1CaCnWQUQtWIIaOESEosmXLKHbJxvm47tQ
	 WeimJSxbCRRjTSVxQoqpb5FfI3Qy3AS6JWJj0HjP0R70t+FT+8/OV9KqxMv6pxwTR9vdz
	 qPoxdfzd6SHS2lJ16+Kb/fSM/KVBwZhcQSCUG5yAGIk0zUKPCUw7UBQNN6FXQSlIcUKU5
	 zCJjf0L3ZcETr1NS/nPbbqlP/9OO45JKtErBy5nMBG3sW9DI1ElfiCXIGkreo+qq9wb0v
	 7dBP0QQV//cagEdygiogYZmlPDjvn/KgGBHxzOYIFBPrCLYOg9NK03cTG2YmnSsfDJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83C606A691
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A83C606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E23BA3F5B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 10/14] build: Only build gdbus library if there is a user
Date: Tue, 24 Nov 2026 16:50:41 +0100
Message-ID: <20261124155319.1752879-11-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
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
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGkBQPJBgyPp3EQcm81e1o6okEqvhg68CbVpV7cswzi9J34puYBUcRJblDMvhLWDqHk0B4IQEOuTrP0jemR+UlnuQBF6s+RQBIrWF2me6rXh4X0IfiZxsBBo+5ja+bxgJ1w3dPYvN60ahlXEBHvwwxXhfROQqxR8oh7NaBuAdTnR99qN9ElNArhTI5/fEBObzxTBYDDRV90DTrZYWVQrlqYQtDFdCVW5Q86cZ8Z7EYd8vUecONBX0RUZTpzr+cvizy+EUgnBDezhvgi7gaTx+eiUjngG2Cw9BthUGRuc7RRbx74AqH5NLJBGm64XpJK6j+rQiyyg19+JNOPFsqhIjMFtQXrr5Yr8kONCtzlZ2CkmjAgiuwGz18ih5goHUvS+/AumhE2QJb+Hf/QaFnFHn6RaRy/HIvjpu8xw0mACOLCZNbpveomAZ2313CcLoSzW4ku3M/EHBiY09OufZiHQ6YV/1uU+Ve6yj1et1MqMIjA0ByYCYtHIkR6EMWOo6aKNRzSfdOdj364p3c6SA2oGD8cg1ya30GjZ86Je8QSf9lTUN6IN11nak6RcnFDYcHlZW6QuMmMwpUgRF7gR+gXiaLAAWbo2daAlyQdwy7eReAFJc8rB4vhvTiaRQ3B++Pczbu9TKyjEESt7R0w7Ft7YSFervrb35xv6go8xKxQMQ1QSg
X-GND-State: clean

---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d3cd76c1032b..01582a0b5969 100644
--- a/meson.build
+++ b/meson.build
@@ -270,7 +270,9 @@ configure_file(
 )
 
 subdir('lib')
-subdir('gdbus')
+if not get_option('tools').disabled() or get_option('client').enabled() or get_option('obex').enabled() or not get_option('tests').disabled() or not get_option('daemon').disabled()
+  subdir('gdbus')
+endif
 subdir('btio')
 subdir('plugins')
 if get_option('daemon').enabled()
-- 
2.56.0

