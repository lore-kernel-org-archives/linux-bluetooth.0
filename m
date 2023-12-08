Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g0T4xKQw"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001F31732
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 01:10:33 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so2301256e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702026632; x=1702631432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12BmaJuhbEbncP7+ftMTLuwVOUi9eU3Yjw6BIudZUgw=;
        b=g0T4xKQwuY/YlPHarRAPgYZlqMl+vNy2vzQmd0TjjyCRW3vOWM6PYBqAYIpnY75m47
         PLzhwABk8Gus5HZV4JV+l4aB957/j/13L3oJTDFq2oI6APF5OtlROJTdR6Dc9/qhhNQJ
         FKKNotPAdHUAgNebeRMyTH7XzNqhI+rKymtVGyxu/l6mnzvu3rXDBiCW7/uwbzS9AcGD
         GbTp3OnwAj34PQNxtzaYH0O6fgnMqC6TghzXBULSye6xHHB1j9mtRg6mPHYnYiU0se4h
         0Ff6tjDtv8KA2M3WI/cYG4ZzgHwWfOgQUSOcgVwQq66NpRl04XYcFo8XfnQ6n27ZQBAs
         ZjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026632; x=1702631432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12BmaJuhbEbncP7+ftMTLuwVOUi9eU3Yjw6BIudZUgw=;
        b=vnBOapjSNKh1Zfm4ZlVcuYyoa+8Zy43nRSI2Av0fJIeWXzxB0MOq5DJo1HNEpjdbA0
         4N34ISynuqtGlfgkh9+odW8BHhrBfdmqju6WkyJdpjuwvrJTR01ZUaCIXPhUeIDWulzS
         tvFNstIB4INXfZspb1B6rgCY9L3NxHebEEhslz6vLLPvIHEHK1Oz6Vn7ZPtwM3iD2g73
         Oaq8HbisssWEUksBpS4ZlBlmH1fUJxXymM3wnRjvBxhFCjxzEuymkujLIHWJ3dPvIDvC
         5POyXpYulxAOF3KGFKT3+M1tBQyNkdYgVRbTPOfm00ylDazZXGERLgV2pCs2D9JiyE5m
         3Rsw==
X-Gm-Message-State: AOJu0YydKMFcqEfVkJh0qgOl0q4JH3e2bDN6l8Zl4lSKclhUAeyguhhe
	Jlk0YgFfFqn7L9i8+yCAUMJuew==
X-Google-Smtp-Source: AGHT+IEuAvHPJ6MPE6Pyhi39JMfaPxgtraeVoZbvofdAwVPfKIYoAMgYX+RB88hkBR3//GVeQ8tsTA==
X-Received: by 2002:ac2:5316:0:b0:50b:efe8:f5e8 with SMTP id c22-20020ac25316000000b0050befe8f5e8mr2266675lfh.88.1702026632109;
        Fri, 08 Dec 2023 01:10:32 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm1572705wrt.22.2023.12.08.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:10:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 0/3] Bluetooth: power-on QCA6390 correctly
Date: Fri,  8 Dec 2023 10:09:33 +0100
Message-Id: <20231208090936.27769-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Resending with all maintainers in CC.

Patch 1 is just a typo fix as we're already touching this bindings. The
second patch adds more regulator definitions and enforces them for the
QCA6390 model. The final patch enables the power sequence for the BT
module of QCA6390 in the hci_qca driver.

v1 -> v2:
- squashed the two bluetooth patches into one
- changed the naming convention for the RFA regulators to follow the
  existing ones
- added dt-bindings patches

Bartosz Golaszewski (3):
  dt-bindings: net: bluetooth: qualcomm: fix a typo
  dt-bindings: net: bluetooth: qualcomm: add regulators for QCA6390
  Bluetooth: qca: run the power-on/off sequence for QCA6390 too

 .../net/bluetooth/qualcomm-bluetooth.yaml     | 26 ++++++++++++++++++-
 drivers/bluetooth/hci_qca.c                   | 14 +++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.40.1

