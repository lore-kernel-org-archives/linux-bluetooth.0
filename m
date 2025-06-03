Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77349659
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940845; cv=none; b=gHgyFUJcpo7peNe1mRk+1eg8Bc2H9EjCcv7ZNbTety2gCIbPqsHhtpokGO3g37FcOMKWuOen8TuP57fzg3/gYrKm0F1c/DdJpIlXBmi4x9BvN7e1TVBGJeam1y6yFeu3LjSfVQhO8dXzT9a0MZhiTeJ3lr7A9MqNKDKh3CZmO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940845; c=relaxed/simple;
	bh=h3NZMCJlwEVYw5Djo5NsPzpNMCeJE36F/xXruODjtyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMXyy1mVwiwJo+k0GU0pEOdCiQD13G/zahci+LjVXWe96T6K1VaXChU5x9gXllhizdvgaxsS9PQnojTb+8qdoGv7EGjkZGv9isDm/WxfsRjzhm5XwcybOvPz6Dbmiyji/CDAS9N0Ft/fykKyNlx9hARhjgJX7xdJGopiExOUa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=bKlvYWEN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="bKlvYWEN"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-604b9c53f6fso66862a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1748940841; x=1749545641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+dzLzjCFXo1xnup5WIt6vU4fCjkN21tUGLSBSm+X60=;
        b=bKlvYWENY2J5ZI62pYL6bnutk18pjE3ENf6pCE+dc5dNcv1llnClUgCHh6ZYc1z0AK
         7cmdI+KxbIf/71j/bXMlSHEYhDzWX6czpfh1gQ/AsxmBmoQkDKCSklDqweRxe4IMAnYu
         kw7DbJowIiq2nLhZsRQ0T7jVm9qQTnPOti/aGEPkdlQIKS1rxJivKAuRDPlXSFnUU7ZH
         zEGkkekhhMNVtXX9LwUyqopvrE7PMlhaLk5hJcZvhjYRGOPXJ+4CMkoFUa1iTwckHUmf
         DV2XegJt+Jtr4yZ7YEIx+wwe7Ks+W9P1Mo/ITS33hFkOTkbNIoTIYn0+nAQniW9Uziup
         GkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748940841; x=1749545641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+dzLzjCFXo1xnup5WIt6vU4fCjkN21tUGLSBSm+X60=;
        b=YAW6LDhl0cxvkILoO3faJ91VMUOf1+ur4O2E7nErRRy+ACp6btJk5NLP+Xv5K8K13h
         5lfZImbQMgS8/2U3lxdH/xRpOelPcY3ipXYnTHwYDk9SLNQkJDO+RZUjOUgP0McOm/dm
         AXi/zlchg2VQTK0HpDwDE4nTjb0WBeOYYpSSmpTJGHH3tvFz3jrxGE93zJNgXSs4Vehb
         hMpVjnMpLRKteFePyWUboMYbApjyIzagaWIg6hAKPAOvwFuKkEXhVG39CPX9V3dGv6hv
         v6V10xRiXeY58KHmnZM5hm70roGAEYxuETPSWGgptjFqOKPWnBYCSNlLlPv2s6an+tEZ
         M0qw==
X-Gm-Message-State: AOJu0YwWT0eaRltvNz6wfzZPwhUiU1/0iDUsyCYONh+ouap1iYlzO5u+
	8/Pe6t28ZcArEXqqgWw2OM1O8IrlCln19UyRX+6bVKFRVEn3chsR7kUBTeYzUqBEb0rLFXBZsCg
	7NxLebUY=
X-Gm-Gg: ASbGncvRU+hbmOKfw5GpRi5joRveoz05bgMymD+cjbtrHLP7fjERuNhBYq8rsEIQlgN
	AgXJXk21xntgF1mmpn1i/3UsQezfYu6ZpvLrpEWlQHY9ohpWpmNmSbLBT1OJRmW9brB7JoQ70m0
	JSOt93pvijHjXNcXbuk/VRnXa26Z6T3+aUhYq+z1sPew98UOo4AtrCNRR+g8jC6KN5T7xqESJdi
	Rk0MKUlgW26zDD+zZ9Gex8y9WJ9b+o0qi6ow0QnVgeY8WzpGCwlYhfBMHXH0m3LFfbjZL4Apf28
	M7toaRgl8CQDH1KEjJcsxittARJ1lnyfRy9KFIWzagJkUBgVxWqR5hNY4hWx1N8DHBrLou+H5Q=
	=
X-Google-Smtp-Source: AGHT+IGeTJFBDZMt8bjKAhavitRSLyG5hanm/BpSouax1oWdjT565CurMWLIKu0sch1iWBIgk76Jwg==
X-Received: by 2002:a05:6402:2353:b0:5f8:504a:88d5 with SMTP id 4fb4d7f45d1cf-6056db0ec69mr15886002a12.7.1748940840665;
        Tue, 03 Jun 2025 01:54:00 -0700 (PDT)
Received: from ThinkPad-Ryzen7.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606add9c4afsm777366a12.4.2025.06.03.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 01:54:00 -0700 (PDT)
From: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Subject: [PATCH BlueZ 0/1] monitor: Fix bit for HCI_LE_Read_ISO_Link_QUALITY
Date: Tue,  3 Jun 2025 10:53:51 +0200
Message-Id: <20250603085352.1297099-1-magdalena.kasenberg@codecoup.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch fixes the bit ID assigned to the HCI_LE_Read_ISO_Link_QUALITY command to match the value defined in Supported_Commands table in the Bluetooth Core Specification.

Best regards,
Magda

Magdalena Kasenberg (1):
  monitor: Fix bit for HCI_LE_Read_ISO_Link_QUALITY

 monitor/bt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

