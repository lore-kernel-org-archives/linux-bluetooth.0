Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522756;
	b=iYj+BeLB8BhR215y8KUFTINobDhgNb98oQgAgeAzYDsTEKE5ZwSHzqcqKwS0CyeOtwE3
	 yMs8RuB9yTJpQGykHOpFfV/+E0pj44ZSQ6e7VEgk8IVcnJAnWkiBnimaON+z/N8CkfP95
	 9iuDzUbf2/4QOItIWUmf2uMEVgQdR+p1R0Wc9H8A9Ed4rDD+4NMs7sAlzB06bvtBtjCnX
	 ijN2XnILf8mSJkyXlWbi1FbTbGvLhwP5dt37x0leCLW9f+y3IPa7sL0sgjsYxCB+fcNOd
	 GQVWBZ0fFFZPgsc3/UVzsj0Q7hu+BCsmhGefCR/RUgDWi7IVrCLi+JvZP0lr4b+8tsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3BDS1UrwPf3P+i7a+X5Yrvl64vk9DSkAutA/WDEu8Jk=;
	b=0Dj/0VDkbRzbqscT6yAnrl8z2zoSyXWTgpMn3HJCpA4YGQnqYqU1EDEpMWtxrM1xLy6a
	 9fPIYXfVDBfraIKdYBG4JTFc1/HMm1uR9XsPZkWCB9dQQVEQ19lbetk0WMELiTw6q5qbR
	 xEk+LKQka0SA4l1rXhXki99PdtA9UJyiPY2Gw6pCZtwq2CwTkoffzdnaPYBNVZwOsIeUe
	 G34LsYfUykC41EMhh+g9NesOK2oL7PdKbxPCalM/vcW2FgD13qsEmI2FROPqM/Kwy8z7O
	 YKgsM+B745H+7H+AlOfLGYFCEHfTPkuLOcIY6PWhAH3asMI/L/PCjBIFPWWRGEpFjPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="kJ4/gtPm";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5A606A331
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C5A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kJ4/gtPm
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so56416305e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522755; x=1796127555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BDS1UrwPf3P+i7a+X5Yrvl64vk9DSkAutA/WDEu8Jk=;
        b=kJ4/gtPmqVJIeMguQdd0aCIJMsec6fxfWCOzfP9x4F3ccrhdslFTlgjqXbNywlgwyi
         sbnvP+cotwCI08BMonZyk1IEnKpVTWTBmUQTIjmI9CrBTiwdpGUih4Hmw5d5QX7DdMw9
         Ph2BguAwFMHtvTcdiBPTeIbXysX43Q+8Fiago=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522755; x=1796127555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3BDS1UrwPf3P+i7a+X5Yrvl64vk9DSkAutA/WDEu8Jk=;
        b=iW6/ok75vem/ze9K5+xRsCBHY6piD7Te2DoBVDwWzx2dNPj+h+AXvMAZKV8KPUlS00
         Sv2eXz4Yd0csOUAL30GHGdpdgsSDYRc9pGRhYJhm/1Q7uhlwMCH/1opagAvtkzWe4Ma3
         +h3iyWrf+86eTq78awzXsn89liLvueGJBrdGo+cexB+9Qs27cE46PGRLb0Wnt6MYe5rM
         WnrWxAV3DS64evHfSEBZad2zkdpPUa1NsvSboJb7DbtZbRS6h0/jbv0S3EDWxIjmFOh8
         3dAeq9BhPnY7z40p0zx2XqH5vmaCf+VZu/goQAX8bU3uzQfs+PXXYe1nNHMmNMQLqvqf
         3emw==
X-Gm-Message-State: APuU4Z8Hr4lfkW9WU6/5Ln/DkUbyGFeD6N8gJ2pGTrCOK8r8LTa0DhLd
	75Y8701kwPEG1tqS4jNqo/CQGwfOz+zX7CnED9R65TFUgrROXW2mUJwlBlipHW9KRnaIwYa1Si5
	NOazD
X-Gm-Gg: AZFdTZdCgGqs6xveFMKBw2NYvNyLf/gJ5hiE/wgP6uvshFwaYboPRCKaNZnJ/dyhjHd
	Q8xnNF95U+L9kIflPxho0Kq8XnDL4XUeF932Dmn1GCX8+BP0QfjUD5NK7SmH59Z3LqT2U1Iao+v
	UgFpXikqyrfPoXdJUUGE9YBylXKKLoM//lUkZxhLnw0Lkg7z8k3EWweDe0Xj4AIQJgdPq0t66Uj
	vjnHAzt8eHKv6ss/HGVnAM0vjNc/tF4Y/6AmiEpqkYKHwiB9nds/bSM+5SBO2GQWfDp0qRLwjZT
	E4LkTTPtfhhHcjgWibwoKf+z7DyOHRrVwYtFab4pxO8tlezriS7ETiREv8rHpWTUY9SafCmGuhV
	brrDFb6t0qrGAqsIM9/0UboBNuBhFsaugMPA6FjthNcVzx18rfCKMhmiYkcl/FDMSljtxmFFwA7
	rpoLh1KUH1Oxn8yv+GAZPG/OCNefWdqdteXfSknGSGh2sluMQuKYGu0jq2Gy7HJZaYWtC8a/DVq
	RNyruTWdGrIsAK9FzJl4eCov6ldMiG7Np36HqNkWKrhEYdVM3Ajod07OFjQ9LLKcHg2b0SuoyC/
	CSfGbCMG59t12spnb2NvK79yPxx/ALpFesC+YgtuB5DDlnmc7Q==
X-Received: by 2002:a05:600c:3547:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4bb88809795mr302217005e9.16.1795522754798;
        Tue, 24 Nov 2026 04:19:14 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:14 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 09/10] unit/test-media-player: Add test for stale NumberOfItems reply
Date: Tue, 24 Nov 2026 13:19:03 +0100
Message-ID: <20261124121904.3267700-10-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
References: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
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

The number of items of a folder may be reported after the client has
moved to another folder. Check that it does not replace the number of
items of the current folder, while the current folder's own is still
taken.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-media-player.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/unit/test-media-player.c b/unit/test-media-player.c
index ba10e5175..53dc6f69b 100644
--- a/unit/test-media-player.c
+++ b/unit/test-media-player.c
@@ -770,6 +770,33 @@ static void test_total_items_scope_change(const void *data)
 	g_assert(context->total_items_calls == 1);
 }
 
+/*
+ * The count of a folder that is no longer the scope must not replace the
+ * count of the current one.
+ */
+static void test_total_items_stale(const void *data)
+{
+	context = create_context();
+	if (context == NULL)
+		return;
+
+	g_assert(media_player_create_folder(context->mp, "/Filesystem",
+					PLAYER_FOLDER_TYPE_MIXED, 0) != NULL);
+	g_assert(media_player_create_folder(context->mp, "/Other",
+					PLAYER_FOLDER_TYPE_MIXED, 0) != NULL);
+
+	media_player_set_folder(context->mp, "/Filesystem", 0);
+	media_player_set_folder(context->mp, "/Other", 0);
+	media_player_set_folder(context->mp, "/Filesystem", 0);
+
+	media_player_total_items_complete(context->mp, "/Filesystem",
+								TOTAL_ITEMS);
+	media_player_total_items_complete(context->mp, "/Other",
+							TOTAL_ITEMS + 1);
+
+	call_get_number_of_items(&context->pending, number_of_items_reply);
+}
+
 /*
  * Search() shares the pending request slot with the other browsing
  * requests, so a busy Search() must report EBUSY like they do.
@@ -834,6 +861,10 @@ int main(int argc, char *argv[])
 					test_total_items_scope_change,
 					test_teardown);
 
+	tester_add("/media_player/total_items_stale", NULL, NULL,
+					test_total_items_stale,
+					test_teardown);
+
 	tester_add("/media_player/search_busy", NULL, NULL,
 					test_search_busy, test_teardown);
 
-- 
2.43.0

