Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156748;
	b=IIbeLvFYAPxMBmFx+IvE8KauIMiXl2t/K3YHW4bAiPp3KutQZVtBkDFyrYr9i5Qf6CrG
	 TUpixrvBdOKJPoQx8sBOPoWVR9DGQGXfquVOmXHn4GlLpVFKNN9gDDki88Avwx3+sq+5K
	 BmCWH+aF8DdH2jo65Zag8USKubMavlM4sI4m5dVT8va26vh74cXX2eZnrxdBzLHKAd2F8
	 opc7FP+XowE89upS00TE/YUQHzOU+DGW/vz9QwQE9X+QmrP5VIvQtNqt5344tGSFb6mDy
	 dwoEKpdu1UNoVkWdKEJ1pBjB/an3Fe9xK6Fxzu912x3fJummTK6ljUFsbY7hHJup3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zOfNEWZO6xNHYpFVSEMGJORJZchuusLPTn8ganHRSGc=;
	b=AVYg/KHSZPdwqcGAU3C1uToztxLEzXXdKTisPdyAPjg46haLAeMZBD/poJ0VcCEWFDRt
	 p1lZSbnnX64+IgeUGmXChEFHt7YDR84HL+sywQBvIJZH4PYzKsel/wsvWfMS6Z32fyloQ
	 6q+00D7A8hAK9pgg4PSO6vhEew+tmJG/PLq3Urg1fyeebOP38iR0hWsraP3dWf1GYT+eb
	 fAmD6Jd/ZDy0M7TBUq+oQ0K0Qs2osCzLdVlC29nCefytuyYzFCnw1P4Mklww43EopEppi
	 i0sekHHi0P6W0l52Jz2Fe8R4SyMr0VszLWcXT1oXjfbYIEyZr1avZlcfMY4xqbemZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=02rWgMsa;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFB606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5EFB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=02rWgMsa
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a3ac4ac65bso9179f8f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156745; x=1795761545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOfNEWZO6xNHYpFVSEMGJORJZchuusLPTn8ganHRSGc=;
        b=02rWgMsa3byoROnlDoaeeUUHSVQYaRpmiNQUG10MTxgl6Cv3/aeNNP9lR791r5Hs1L
         1IoNLb0mwoAVF5C/by/sCUNJ2YSWUO8sXaF0HWAklgfGIgSPGJex9tZk8ILeMunjyIum
         qmtLOgVWErgiC9o+YZpxctYEJoy43Q/bKU+nQ1hus0Utpdjnh3823PqiCEe+jCjfRtlZ
         bJMMV9D/VcROhcFJgkFquTRTggr8wbnK3Upre67Hn7r+Qob4Tg5/LQzqJpxuOMDgKbEy
         hFZ+Jdrw1Qir1IucKJc1HAxzLIppNO0oRs3RwOFIoDFUIHcIqEaP6ZUJhAjfk4W9MMea
         cePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156745; x=1795761545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zOfNEWZO6xNHYpFVSEMGJORJZchuusLPTn8ganHRSGc=;
        b=wFDNYobfEVHXdSF6oBjQ6CI753VN2Q2bDyUMj0s5JHBWBeEtozsZRtrwHPsAU1qyaO
         /q93FmdLBONXVSe4hmF6x2T3CM7F47xjLuT2EljKJ8+2QM7hwEcaXsT8hjp1QlHVVNjM
         FsleFq+fVf3HI2UI6j5g9vw7dZYMmIJZHAhTbZNlmv2TdNWczXjfcDE7HAOEyGS9+EfR
         /+K7BmoWniyW9J4/p9/M+hg15iQ+mXYwjBf2ntgo4daOUiF6VQ2eGy5dhC/YuPl8AzuI
         JweimM32YcPcjipmGWmiwjVB3QZD4jp0eOg2Z2HU6GIBVpkuWo/4L5jIQThcrXo7gZbO
         Qh0Q==
X-Gm-Message-State: APuU4Z+8jKwgc8KEsQHbaha+takrJAe2F2/9scLR3wpIGY1gylLVRb+q
	fzcMe8/1SN5srH+Nt4zi8zE7BwVP58SSZ2JgNKR9V1sE5jG1+4LrXdilGsP3g7Nf
X-Gm-Gg: AZFdTZe8/d3Fmel/zOe6SYp3+fk19/ErPMW8XFN3jJSmYpX4KBagFqsLp4z6PV2oAX4
	Dy2jIfJCVY/ZmA/UHW1yJPQHtuZvkddY7Q/mfE2UtBDgQuZWlSf3UW02Dy9HLuRT8WfSbBWJuKQ
	9NcAP95mgKyejOjy/IPkW8+33X++pizX2bWco9VmEt3s1hTJu6yQ3hIk565HsHL2AFve1OgWz+o
	+esCAIAxwVFVcEm50Jztjq4GQFKdfo28eLrYYTwW3UvkY3PN1GBidSP9tqVD6Nzx0cc4q/G8qfy
	+aRhXMvaoKsDl1elLHIancHv3BcAK7wkoCnyCR5Eb6/+EQ0Y14nYWiz7pBtozJ1JiwP3vZj/ed1
	QtunJ48TniS/MVYAghg0rTHHxSU03ut15UOk2B6iB7uwGttLkCkksRJbJMOvNGNCkS2oeiqEX5/
	UNQk1gXw+hNu+VUMkqu4Wnz+DH2LD2JbRm9yiVduJZX/M1udXAwgL3m3RYR6Sy4wJVaXrT8I++L
	os49HW6fpdfVqDKMomoWRNUMd1QtlT719lKeDj84cdo+3fQNFFvzsfhdY6pspnjLmtAlzY49TwW
	8ozgAfQgVevwrpsXssDoJ78+pHyTP+o2VDc=
X-Received: by 2002:a05:6000:26d0:b0:48e:5d5e:c27b with SMTP id ffacd0b85a97d-4abb47b2501mr3617216f8f.6.1795156745084;
        Thu, 19 Nov 2026 22:39:05 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:04 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 04/10] monitor: Fix advertising handle of LE PA commands
Date: Fri, 20 Nov 2026 07:38:50 +0100
Message-ID: <20261120063856.16585-5-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
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

The decoders of LE Set Periodic Advertising Parameters, Data and Enable
print the Advertising_Handle with print_handle(), which looks the value
up as a connection handle. With a connection using the same handle,
the advertising set is shown with the peer of that connection:

< HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e) plen 7
        Handle: 0 (LE-ACL) Address: C0:11:22:33:44:55 (Static)

Print it the way the extended advertising commands do:

        Handle: 0x00

Fixes: 61563bd7b477 ("monitor: Add LE Set Periodic Advertising commands decoding")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 9814e0e96..da4e8aa98 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8704,7 +8704,7 @@ static void le_set_pa_params_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_pa_params *cmd = data;
 
-	print_handle(cmd->handle);
+	print_field("Handle: 0x%2.2x", cmd->handle);
 	print_slot_125("Min interval", cmd->min_interval);
 	print_slot_125("Max interval", cmd->max_interval);
 	print_pa_properties(cmd->properties);
@@ -8715,7 +8715,7 @@ static void le_set_pa_data_cmd(uint16_t index, const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_pa_data *cmd = data;
 	const char *str;
 
-	print_handle(cmd->handle);
+	print_field("Handle: 0x%2.2x", cmd->handle);
 
 	switch (cmd->operation) {
 	case 0x00:
@@ -8745,7 +8745,7 @@ static void le_set_pa_enable_cmd(uint16_t index, const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
 
 	print_enable("Periodic advertising", cmd->enable);
-	print_handle(cmd->handle);
+	print_field("Handle: 0x%2.2x", cmd->handle);
 }
 
 static const struct bitfield_data ext_scan_phys_table[] = {
-- 
2.47.3

