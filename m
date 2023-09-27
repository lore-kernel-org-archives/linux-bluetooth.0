Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0D9E7F14F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjI0VyE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VyD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:54:03 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614EAF
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:02 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3512f905f6cso28704995ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851641; x=1696456441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOmbSCSuxl/iBoDJgSbUBLhFhdtVyCAjbkktwlieTt8=;
        b=CEyWEotAFtiLJkZ9nbF191rPap+7rFPV9hMTnsbXvLU/MX8z8ZJFlLLOsg3DUow5pU
         WIQcDD5jGQHMGm0brw0J0n1nybdsBCXbaCxfQiEjcZr8N5uA/RU6KiD4eG0kxiFFL0s7
         RySfkku3ksSQopDQ6oN5DqRcg+P03LtMbSnPssV7SSInZc75YqRYl0kWEn2Wl+t+yJ9I
         pZHLASJdYPEgHkEBrnLhuM+cSDD9rS0Z5RmiDljvtfqtia/c54BjzNibma8nqnK26DQN
         Uzup99UnTVmhNKTcBYj8tBvnFb83HzxoKqbdw0vyZbZMCxa5zXoYi83vHh8g0E4SfFXm
         DwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851641; x=1696456441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOmbSCSuxl/iBoDJgSbUBLhFhdtVyCAjbkktwlieTt8=;
        b=Rjo9FT99CUpgsyDVQtR0e/IrbyB+4cHV7rLIzOw5rIgtKvgtdjpzjhdFQ4XZEt+WIA
         EAEMM37nhULOhb+A619y17Bzm8fr54CY7dJw1HSSZud4vuOasn8A7rp67meBOZaCPrS+
         /xhP4HekWf2jvF4c88W4hIXkE5KuKfRtkGdVQgm5CSbLpqKgmLmyW/wCyouJqNNSpain
         Ex2z+ngHurriAir3uriGFe+cfHjfFgTPfaj6JL3CFRdaorbswlvlqenJRKsZt7yFmhyJ
         7CqN/FrriXMBKM5zuipUxxFw3x3hkLx7V61tT373erZMs+rwB5He9CKDZSivniZbiPWI
         zFEA==
X-Gm-Message-State: AOJu0YybRZWyfhGKsWygca/CYeXQQs3vRSpywzuldUkTLqIUflp7TwjN
        VJ3MHUHexqTEAnLivcHMppL+QolYHaqa6ShQ
X-Google-Smtp-Source: AGHT+IF5pkNgmNiAAuzxmgWLKVbWWAJu5OR1ZTPbmpRPUJQyahYFxgu9HS5sLiyPd5nVXS7SLvHn2A==
X-Received: by 2002:a05:6e02:13f0:b0:34f:6837:6ab7 with SMTP id w16-20020a056e0213f000b0034f68376ab7mr3167020ilj.16.1695851640695;
        Wed, 27 Sep 2023 14:54:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.53.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:53:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 03/12] client: Make transport.show to print QoS configuration
Date:   Wed, 27 Sep 2023 14:53:45 -0700
Message-ID: <20230927215354.1874835-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes transport.show to print QoS configuration since it is now a
single property:

transport.show <transport>
Transport /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0/fd1
	UUID: 00002bcb-0000-1000-8000-00805f9b34fb
	Codec: 0x06 (6)
	Configuration:
  02 01 03 02 02 01 03 04 28 00                    ........(.
	Device: /org/bluez/hci0/dev_00_AA_01_01_00_03
	State: idle
	Endpoint: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_sink0
	QoS Key: CIG
	QoS Value: 0x00 (0)
	QoS Key: CIS
	QoS Value: 0x00 (0)
	QoS Key: Framing
	QoS Value: 0x00 (0)
	QoS Key: PresentationDelay
	QoS Value: 0x00009c40 (40000)
	QoS Key: Interval
	QoS Value: 0x00002710 (10000)
	QoS Key: Latency
	QoS Value: 0x000a (10)
	QoS Key: SDU
	QoS Value: 0x0028 (40)
	QoS Key: PHY
	QoS Value: 0x02 (2)
	QoS Key: Retransmissions
	QoS Value: 0x02 (2)
	Location: 0x00000003 (3)
	Links: /org/bluez/hci0/dev_00_AA_01_01_00_03/pac_source0/fd0
---
 client/player.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index fdc27c281ed8..d72ad6a5da01 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3799,11 +3799,7 @@ static void cmd_show_transport(int argc, char *argv[])
 	print_property(proxy, "Volume");
 	print_property(proxy, "Endpoint");
 
-	print_property(proxy, "Interval");
-	print_property(proxy, "Framing");
-	print_property(proxy, "SDU");
-	print_property(proxy, "Retransmissions");
-	print_property(proxy, "Latency");
+	print_property(proxy, "QoS");
 	print_property(proxy, "Location");
 	print_property(proxy, "Metadata");
 	print_property(proxy, "Links");
-- 
2.41.0

