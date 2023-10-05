Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3EE92718
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 17:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjJERLi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjJERKb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 13:10:31 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A368C10C2
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 09:57:39 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S1d5q4vjlz49Q75;
        Thu,  5 Oct 2023 19:57:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1696525055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRRoQQjouR8y6abpELysX96Gj52Q0fJl5KEgK2nXJ+k=;
        b=uCgRwX2RpKws2FiV05cjB+2sImx8Ymazi5uZ1waadjCmc7MG54ru11uy3DUbpkTnYiUejQ
        CGetv8Hq43Cxz3/m0vNbIz0n9POTHxdPcOLMyaVRA7t4PA3fPQg1HJCZ+Ggz5epYzp2ZY3
        bMFm10MyQczxXMHt4tkolEgYfNAykae3nzWTrcoes51VDY29gOzLT+j+MOV1CNGev7zZ1C
        4/4Sn2femttwwCc28RRETDB0NwzkRaxQK2/PSdHIOt23B/T+aLR6nJ6hjUoOKpFHxNdI2h
        Ob3pfTUYi9sA+bepzqJsu0RVp0dBC1UxhviL8jeWdeW0OIChw/BzQOmznTQNWw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1696525055; a=rsa-sha256;
        cv=none;
        b=Y+zY+DrRvGNntQUFckOPgdR3CwePKs1O7oHIburezIEClxxD9520ebNlqdHVP8pa7mxHQY
        AuEsR4XW1enQNJ2QjpfEAqbrZlyjay0Gs0BLBHeywNVx+7FdkQ5Uz+JxUeVOQskx7r2U4A
        zwO0OBPe0FVppqbyLD1J2B9J7JoldMiMbkgW9pQpq3HCXjI/FijmkbxW7VbelRUHilSQzv
        p7nb3n3co2lrxi6SDtqmT3iwZ5r5DafCpry8T9r91Pq1SNErhavxYw47kZHaLQ/dPDxahP
        TbLrNdI4WpwzbDL+v9tyKfDYLpAfUPEynRfGflTmz9/yCRv+8oXloJw6PnZrew==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1696525055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RRRoQQjouR8y6abpELysX96Gj52Q0fJl5KEgK2nXJ+k=;
        b=B24PSk1p6gIW51VFHRIACV8Mj+olAI1dNRPFZ5q7ZlPcsO0QDM2JerxCB95O0BjsnU75M2
        /6Z2lOynUcwCEA/wGuq0t2F4kUnaQUFWNNmjHTpgfcGYr5K6imh7jwxueEEt0bH6Gynp1F
        ziuNnyKHcDH2XzCC1PMRGvkHcE0+xSsQxNHAVuvTav03Tvt41+c+8Oa8slrW2UUfyw0YUg
        iPcTUB3ktou6ZxV7jqjfGO1f3QY9k0t6M23nGFsFElg68oE8KZfRxVlQyZrRiiliQfTawW
        of0LtpT451RyCPgs0K/VdsuLRiaYwkDN7/fCACFik0dvPEJHTYZYJCvtTeY4Qw==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] doc: mark battery APIs non-experimental
Date:   Thu,  5 Oct 2023 19:57:33 +0300
Message-ID: <50971f883abca31aa6a043086ef4d4f3201d7f4e.1696524938.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ceaf8aa40e0967b01b86008b16a26bbb111a2cf6.1696524938.git.pav@iki.fi>
References: <ceaf8aa40e0967b01b86008b16a26bbb111a2cf6.1696524938.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove experimental status also from documentation.
---
 doc/battery-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
index 9a6b4fd39..c03d64fc6 100644
--- a/doc/battery-api.txt
+++ b/doc/battery-api.txt
@@ -13,7 +13,7 @@ Properties	byte Percentage [readonly]
 
 			The percentage of battery left as an unsigned 8-bit integer.
 
-		string Source [readonly, optional, experimental]
+		string Source [readonly, optional]
 
 			Describes where the battery information comes from
 			This property is informational only and may be useful
@@ -36,7 +36,7 @@ BlueZ will stop monitoring these exposed and removed objects after
 UnregisterBatteryProvider is called for that provider ID.
 
 Service		org.bluez
-Interface	org.bluez.BatteryProviderManager1 [experimental]
+Interface	org.bluez.BatteryProviderManager1
 Object path	/org/bluez/{hci0,hci1,...}
 
 Methods		void RegisterBatteryProvider(object provider)
@@ -56,7 +56,7 @@ Battery Provider hierarchy
 ==========================
 
 Service		<client D-Bus address>
-Interface	org.bluez.BatteryProvider1 [experimental]
+Interface	org.bluez.BatteryProvider1
 Object path	{provider_root}/{unique battery object path}
 
 Properties	Objects provided on this interface contain the same properties
-- 
2.41.0

