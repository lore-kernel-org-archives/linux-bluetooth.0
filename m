Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A483290C3
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477186; cv=pass; b=JgWIQLm8niLcRzjx46nDC+f3gG4SqjaLtnpixyaxUB+JV2Z0IjY4HwaXwdRxLKVjNynD/liXdQrEE0IDgVAh7CHbRsfyHq7ptGzOQfOMLWSZgnvvQNeA17w+0jCPMmMSovmALjOYG4o8lq1rmHoW2N/w9mbmURwIHNPDmlNprIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477186; c=relaxed/simple;
	bh=jHko2ACuuYcssfHCS+rWGjZNdP8m/lKv7Ezy42xhx2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsG2rQYyOw1f280CDvY8v3Xf4BGO3+KYMRI96kN3qU8OwkkGg/eVxDMna/jAXBQ3Lv3wbLCQE7b251x5WBFw5FVNRDwV2jqBviooCrsbk4j58ymjTi+hWJ8eE5QSKn7ei2jOxqinnzk66Sdl4kk5bQJuopE7T+NhVmZixGGedVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qkWk/zyh; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qkWk/zyh"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq7Mz0gnQzyvg;
	Mon, 06 Apr 2026 15:06:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775477183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwtbfduaGFDBsOrEFL9+UNjaz7ZlCTiQv+U0phTWrR0=;
	b=qkWk/zyhe471AF8a275dV6u04AfO7H+gvYB7nIFF2i3KlF+XNarEEB4joRqAJDOVZEFQTK
	s48lok03JZgGjXXt7UKNJw0wHBneKcTuEzMlbugkIEfxsnOGg/szmP8RotjcwqaDNj3TRg
	Ppu5kW5nR2wdluGmXOV/JeWQLQLSVAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775477183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwtbfduaGFDBsOrEFL9+UNjaz7ZlCTiQv+U0phTWrR0=;
	b=NV/11C/mL87RK+MkxUrYt3QCNNseEtuexg5gPwkUdShtDWWRJwV6X6mlqM/xpY+G9t/qrn
	Qus/eAtQm7ffkh5c2RdicAt1URVE/a7/8yS2ujS1y/4hF5Pve4cL0t7L97zepvpOfmUkeS
	o/GapMCiS/0ev1YbtJqOJJ+gx5uWbtM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775477183;
	b=xulrz+hEWFIoxPMfKkNyRQIPBEbwPMt70z5bIsVlm0xpHZYr/ViRIaqkclP7Vu4S16Ubs9
	uwbVAzvCGi4fLkgaGSbCr76oH0e+eBxLOnmHw1mp9xpxBjTRWqx/YQcyjZtWeDjayd+fl6
	HPIjflz5eYr4eY2aEo3PEYb+YASIUqA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] tools/ioctl-tester: don't read array out of bounds
Date: Mon,  6 Apr 2026 15:06:20 +0300
Message-ID: <e026a7a255502d03b1b46d7e96eba9b8d0c7b106.1775477129.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2ea7fb22224bbe69de6bbbd93f9d18f0cf5045f5.1775477129.git.pav@iki.fi>
References: <2ea7fb22224bbe69de6bbbd93f9d18f0cf5045f5.1775477129.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix accessing (invalid) param data out of bounds.
---
 tools/ioctl-tester.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
index c29b30268..e0627eef5 100644
--- a/tools/ioctl-tester.c
+++ b/tools/ioctl-tester.c
@@ -62,6 +62,7 @@ struct ioctl_data {
 	uint32_t cmd;
 	const uint32_t opt;
 	const void *param;
+	size_t param_len;
 	int (*cmd_param_func)(void *param, uint32_t *length);
 	int expected_ioctl_err;
 	const void *block_bdaddr;
@@ -434,6 +435,7 @@ static const struct hci_dev_list_req dev_list_invalid_1_param = {
 static const struct ioctl_data dev_list_invalid_1 = {
 	.cmd = HCIGETDEVLIST,
 	.param = (void *)&dev_list_invalid_1_param,
+	.param_len = sizeof(dev_list_invalid_1_param),
 	.expected_ioctl_err = EINVAL,
 };
 
@@ -772,8 +774,13 @@ static void test_ioctl_common(const void *test_data)
 				tester_test_failed();
 				goto exit_free;
 			}
-		} else
+		} else {
+			if (ioctl_data->param_len) {
+				g_assert(req_len >= ioctl_data->param_len);
+				req_len = ioctl_data->param_len;
+			}
 			memcpy(req, ioctl_data->param, req_len);
+		}
 
 		tester_print("Command Parameter is updated");
 		test_condition_complete(data);
-- 
2.53.0

