Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623E38DE0;
	Thu,  3 Oct 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983300; cv=none; b=SURD/Ln8W5BwtR/oAbITRckKLa6RdNq4IIK8bh0I8dNRiuhxIuSjjAOEQpD82KThfw5FOKHyFexCS0DPCuZyUBdM6l2Dv/Gj6/bHDLcw1CkUH8dRU/n3acuZfwlXeGXV8BU1ezEbcuywZMTuSi8QMu1U1jrp1XAet3difjc8n9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983300; c=relaxed/simple;
	bh=pGfDGE3JarQ4dFHECfyNA1u4oLeW9xiHHpjX4qsT5rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SpxEfLaC4oYBJDtnpwl+A+lAJE2s4zVsMVZnNIPfSiM3TFbWPpNFekY+l7DWmY3WWjHhimmZHFRkuQZZzvkCXvtIwitXCrVi1+N7gQ6W+ITaiKBdCBAEdl3hONHTKHEdVZVRe5KgzUID87NUqT8PVJgrr1Dj9Cws09On+sCiycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfvbF8Ep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfvbF8Ep"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAA24C4CEC5;
	Thu,  3 Oct 2024 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727983300;
	bh=pGfDGE3JarQ4dFHECfyNA1u4oLeW9xiHHpjX4qsT5rk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VfvbF8Epfz8KtUWH+OBR+l5kTu5OTbx/CWrPC/MO4aMJtgc3POrKO8O1qh42tEg7x
	 ruI1B6uviQCUsmdpTAPVfg5qTo+3FzohM0uoMXsaUBKt/vY1jQE43yzGeZJ2+Rm3Wq
	 ZG6ioD2ZOuhBAkfPRtyaxfEbeZ87jD4pv/xVFB5b8xWvQCXY+rYncKF8EKN+iTtXXY
	 bOXyTTUwc3K6lIcXqxg79gutZo8eiziMsn0TPVG/atbibHBVexCLk+N38QHVoGtN2v
	 5QiYHiDhoDpwXTA+0NDKJ1TNx9D99KLXks62AdkkoX1V0Wjq0dbPJUTvwd44pQNpJA
	 Wvta2XD1MwnRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D347FCF34B9;
	Thu,  3 Oct 2024 19:21:39 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Thu, 03 Oct 2024 21:21:25 +0200
Subject: [PATCH RFC] bluetooth: qca: generate nvm fw name from boardid for
 WCN6855
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-bt-nvm-firmware-v1-1-79028931214f@oldschoolsolutions.biz>
X-B4-Tracking: v=1; b=H4sIALTu/mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNj3aQS3byyXN20zKLc8sSiVF0T81STFMMkc4NES0sloK6CotS0zAq
 widFKQW7OSrG1tQDFV46DZgAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steev Klimaszewski <steev@kali.org>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727983298; l=4402;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=A//l2c8M2myBYVFdvINmnr1+5nW8/KoVbzWje8K7CX0=;
 b=MXyXjDalzxxrJ8VvkIZiXmIU1UMrwtP5JPWqyjJfKYzP+BWbmRLzAi+3pAxWwLWgDzi2m7FO6
 LsdFgqZHKl1Adg4qSSxmOb+0aUr10hMFV8YtC/V2uclWd7FYnxMla08
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Steev Klimaszewski <steev@kali.org>

This is based on the 2066 work, which the 6855 is basically the same
thing.

The already existing function qca_generate_hsp_nvm_name() appears to do
the right steps to generate the hpnv file name. For WCN6855, the suffix
seems to be the board id with prefix b, though.

Add specific masking for boardid to generate the full name.

boardid == 0 -> use 0 as parameter
boardid <  0x100 -> add 0x0b00 to it, otherwise add 0xb000

This generates correct hpnv* file names for the files on the Windows
partition that appear to work better with the hardware than the default
.bin.
Tested on Lenovo Thinkpad X13s, Microsoft WDK2023, and HP Omnibook X14.

The specific firmware is found on the Windows partition, and is supposed
to work a little bit better than the default .bin.

Co-authored-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
This is based on the 2066 work, which the 6855 is basically the same
thing.

It generates the fw name to load from the board id, taking the file
name format for the WCN6855 into account. The hpnv* firmware files 
can be found on the Windows partition ofthe device. They usually 
work better with the specific hardware. If the file is not found it 
retries with the default name.

This has been tested on:

Lenovo Thinkpad X13s
Microsoft Windows Dev Kit 2023 (Blackrock)
HP Omnibook X14
---
 drivers/bluetooth/btqca.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dfbbac92242a8..ffc75680b322b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -564,6 +564,21 @@ static int qca_download_firmware(struct hci_dev *hdev,
 					   config->fwname, ret);
 				return ret;
 			}
+			/* For WCN6855, if Windows firmware file isn't in place
+			 * then use the default .bin file.
+			 */
+		} else if (soc_type == QCA_WCN6855) {
+			bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
+				   config->fwname, ret);
+			snprintf(config->fwname, sizeof(config->fwname),
+				 "qca/hpnv%02x.bin", rom_ver);
+			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
+			ret = request_firmware(&fw, config->fwname, &hdev->dev);
+			if (ret) {
+				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+					   config->fwname, ret);
+				return ret;
+			}
 		} else {
 			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
 				   config->fwname, ret);
@@ -773,6 +788,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			 "qca/apbtfw%02x.tlv", rom_ver);
 		break;
 	case QCA_QCA2066:
+	case QCA_WCN6855:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hpbtfw%02x.tlv", rom_ver);
 		break;
@@ -788,10 +804,6 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/msbtfw%02x.mbn", rom_ver);
 		break;
-	case QCA_WCN6855:
-		snprintf(config.fwname, sizeof(config.fwname),
-			 "qca/hpbtfw%02x.tlv", rom_ver);
-		break;
 	case QCA_WCN7850:
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/hmtbtfw%02x.tlv", rom_ver);
@@ -810,7 +822,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
-	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
+	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850 || soc_type == QCA_WCN6855)
 		qca_read_fw_board_id(hdev, &boardid);
 
 	/* Download NVM configuration */
@@ -848,8 +860,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN6855:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpnv%02x.bin", rom_ver);
+			qca_generate_hsp_nvm_name(config.fwname,
+				sizeof(config.fwname), ver, rom_ver,
+				boardid == 0 ? boardid : (boardid < 0x0100 ?
+				(boardid & 0x00ff)|0x0b00 : (boardid & 0x0fff)|0xb000));
 			break;
 		case QCA_WCN7850:
 			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241003-bt-nvm-firmware-47e4d1b70a99

Best regards,
-- 
Jens Glathe <jens.glathe@oldschoolsolutions.biz>


