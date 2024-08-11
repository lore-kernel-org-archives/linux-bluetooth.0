Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7188416B750
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Aug 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723400254; cv=none; b=Q+FSxc3qt1pVMP1OXHmGN77Z2gHfEpbokE0SC6x7zYP9BxpmZRT6jHB1pR+2t+bexMssUHqGNs3OTLZD9JQ5CHb+vRszl3YBKUIyQDSzKTiEvSBLY+tNu78CsT8TlhuqV0A+eddhU/NGs9CZyS0gNFHq/1lkynqcCOW2CNyEtsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723400254; c=relaxed/simple;
	bh=i+lTvqxiMRXFw4pW4fXIUgAA4bXjhigtS13EAIn2h9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edQvYrH1s+czxvaVO7oSs0a1UiGozBCfqaqmo9jDbMSRVq524AAiDK+XWipR4BEm5ZVIFhNtDNM4nBiGZelc12iHDDUWqmnsmJQ6jfjMVbMr+nHXSDiGrZ6JtOiGNHrVqg2BGGjSYTJCxXTa9Ju0IUxL4DiivHqla6yyKHpBpeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CdEnF589; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdEnF589"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so4229074a12.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Aug 2024 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723400250; x=1724005050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvbZ+8SyXPbkfWIxq8fFFxIwmoC4vttG1Fog7o3RX+I=;
        b=CdEnF589n0JAAIAH4FERLOqOO51a1AKViW45tAa+pSmCCxJCxAkiT0tjGHDSKw//LC
         9wdaCf9pKzlR+nvEyggzqxq4wt0KbEZfvxqC9ogCaAVaj/SRrTjvFhbRnlX9u02avHAw
         1on6ndsMpiCADolJ9sgSq9CI5UXB0M5CQN/FNmHHofNCGTk5Ar9nb/2WWeTxmR1lHmgT
         dw4AZ777rvsJ2ALtjNdMMCMHZbbkVxt0CipQeYSSyJ2hKLVddQEaTcXv08CNC+HHhpts
         EMYKQUimIy36ASi9FFMpYgKgi99whST1BGvyssVc6G/KBddRZWvUWYwOglqd72viNbmn
         cwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723400250; x=1724005050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvbZ+8SyXPbkfWIxq8fFFxIwmoC4vttG1Fog7o3RX+I=;
        b=mt8gvPIo0vBNDRDaZBiI+PakDFq91D8fLKXI3VGtvjelEDYzyg+In1iMfvkluBklYs
         wX7GshGTesMX2cZqoO40JDGr5w8lP0w2ZbUSKuMJ+NO8bcwVuAQ7c9P5ds3qNNEiqLB3
         APQHNzzuSDKdJ/ldHfgPUFz+Ilf4jo6KeoFS0tHZWiuf67sF41l587NxnOOMrTswf5d1
         v6YlS+iqbtw4CHlvLNv6TCbcOqHYEk/Y1Dqj3c1YhU04gvPliNb4KhVGY5n4dhorwUbd
         c9caQ+BemO/P/q8AXYpj0RrDNjQAUto0ym7m2gP1zLje77cv4wsJGLcutFv7R5doU3+F
         epSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJqdpDylizwoo2DoBAbRcdvifkQDdvrxCuX9uqrwP7KrAfI3UxJ+5LvxFxbFqzvD0ulmgLu2evPRJPhX1N/ECtA16qBsWRIF2wpqsBweqy
X-Gm-Message-State: AOJu0YxNf+J+ew228JuB8oprXxDYXJbGvdlCJMG866nszlpnvQZHTh64
	yWiYawOzenNVuKun93uY+6UL+ceu6Wo5cn0fSTmMulcERWTZntuC9PnezXuYJBs=
X-Google-Smtp-Source: AGHT+IF845o0XSP5n/BwrlmriZw7Zb6P6jQ3BpfatLkLOENLMyaMOLi7UlDJBP7b5+N/eNUzZ5p81w==
X-Received: by 2002:a05:6402:458f:b0:5a1:c40a:3a81 with SMTP id 4fb4d7f45d1cf-5bd0a6603a2mr3481173a12.35.1723400249713;
        Sun, 11 Aug 2024 11:17:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a6032c1sm1610593a12.92.2024.08.11.11.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 11:17:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 11 Aug 2024 20:17:09 +0200
Subject: [PATCH 6/6] ASoC: dt-bindings: serial-midi: reference
 serial-peripheral-props.yaml
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-dt-bindings-serial-peripheral-props-v1-6-1dba258b7492@linaro.org>
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Daniel Kaehn <kaehndan@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=i+lTvqxiMRXFw4pW4fXIUgAA4bXjhigtS13EAIn2h9I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmuQArOhpNatW52wzJpXmws0fDjOokzOoUe8LaC
 lsqDe/iqmyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrkAKwAKCRDBN2bmhouD
 10kpD/9SOhRnOR0/feUFtJ3/1bim82Fw4+7IumOZPA7eiWKJANvWp2lMdImnWInzmSwBhyQreJX
 CcZOcbd29+X1YgRQFNNxf6PkQ444aPBNpCmUggJxXS1hYJZF6HWHMIQtlr3FelO4SHIF4QJdMEh
 exRB43qX03biWL0S+zQcNW9/WOmyfmOqJkzjrW3yohC2VGvgqpMw98+8+wpX4EIE34vvu3Hk9ta
 Dgh9Ho9WU79eqWzdn7C8aawEviq3Hbn7o7SRJX43kVaAy0KHVYOLTrWQQrVd22AVwBxm2JFtEB0
 752kvhWQRzIlOL5PEvcbg0sxnIMtixrhBPw/JZfOrnzdSJ3R5BCn1D5p1GCTPzCjBY+xJBFUDjQ
 SaTdfn+xLdc6HYz1XPQgRyypy5RTUxaqAYe9Nd5dGGgKmm1ihWw5W4W8o/C7Ko3cTAR/GJsBxOI
 PDixnjajQVDH9z6sgoDoifPyYwrLxfvWMhzWjZATVFw7x3f03Z6SIjKq/+6ScEuYaVp6qfMbKpb
 Rgo0ayBhAXShHODYAWm3U8uXrSTWMY+b1EaCNxbxB/ZSk1pmOkbcxl50h7/CfqDMq8Mrv4xMobm
 t3YbsVbWF6YCTxKpBDShzvOXWpp5ULhSQ/Y2dLnrqsQStlcfK/ZVJaPQyinHcyCcJG0LUhlfuxN
 b7/go1JyGYOp9xA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Reference common serial properties schema (for children of UART
controllers) to bring common definition of "current-speed" and
"max-speed" properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This patch should probably go via Rob's Devicetree tree.  It depends on
the serial patch adding serial-peripheral-props.yaml.
---
 Documentation/devicetree/bindings/sound/serial-midi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/serial-midi.yaml b/Documentation/devicetree/bindings/sound/serial-midi.yaml
index f6a807329a5a..3b2f6dd5bffa 100644
--- a/Documentation/devicetree/bindings/sound/serial-midi.yaml
+++ b/Documentation/devicetree/bindings/sound/serial-midi.yaml
@@ -22,6 +22,9 @@ description:
   configure the clocks of the parent serial device so that a requested baud of 38.4 kBaud
   results in the standard MIDI baud rate, and set the 'current-speed' property to 38400 (default)
 
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
 properties:
   compatible:
     const: serial-midi

-- 
2.43.0

