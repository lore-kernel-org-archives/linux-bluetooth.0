Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF29FC04E87
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 20:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A566521708
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com.br header.i=@yahoo.com.br header.b="JML9ly9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A566521708
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeI1Ci7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:38:59 -0400
Received: from sonic304-22.consmr.mail.ne1.yahoo.com ([66.163.191.148]:43119
        "EHLO sonic304-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbeI1Ci6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 22:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s2048; t=1538079537; bh=E0pv0AIxGeX4l+GbCxPEkANA0BmgEo+SeZLPKWsQBok=; h=Date:From:To:Cc:Subject:From:Subject; b=JML9ly9e1q9O6ZqW0dSoACmY6iKFVCBTnWzEP7JtMYCc0nvPy91aaaLYetCTLnW8xj0G+bpS2lygdU1nAPaivu636aFbYM2SnjpMt7Znvnz7FgiiY4L4cAXV5cHapeIfobZqgRksNvi8Kagpi3KxzjTsZHHipkpXY4d+dQ07/T+MgnGzyqGwXSoQtTyW0nkRsP1L57MLRUwxcfqS7r12sR7rZmGCVfueCJjcLzcMkERd+pgNTlon29hloSi8q8NAw+5nKuNRB6GjS9URi6imw8k8KEmCvq35COLGcrTdo74mlnFjEXf99/Yz4zv+mXfcutZkm8yf2YsJIbK3kumSOQ==
X-YMail-OSG: erlRp_QVM1m18sZM4OUThLSJuzqLP4B8dHn.YPMWO5RtH6oS_6HUkIglqO47wEr
 h4unwZsDKmpwRF.PIfQyi.x4J8I9Pu63n4bcL6f6xLrPuSXCOhJ99IBQ140zsnu2mV6TGQo9USIN
 LwkhWxLKlaRObXVA.S8PtgzXG8VPJr81yOpTZVadTLZaN0uNct2gZkycWtobgVT7UbqrBeT6IYwV
 _XoHMwVSQ0Hc7pbU4zA2XdDkt21iwrOC6ZxjmUMqpSHqI1JPWJFk5L2pACI6OlI6vCNGbmg47KJa
 oEOHBYOiI_Gy1LxEFFly4XfN9LCwYNC29kaFKTpgvaLdkAWkjozNThPqkROnZYWvaYvdUFlcnwq0
 VbYvWvlGU27knV_zaIFPEUpGCWwPnowEA90ydqyyX8UKqZ9.i6yuWfI2uPKaxLQjGrqcX2oPr2bn
 5UoFSWlSndgRYaFBsDzaklUq.fRWevNBWag.6dcK5rRXvuKMadpUrRNK7Pe4kr_LDc_Y6JCO985u
 O49xFuUsjoyqzDyUvjPYqGR3aNLutsudj8A6lZnR.r2BgdlfdPzvqFFARbNycD2.v.gg4i.Wb0LE
 Vi.MtNtkIKzX7cDLh_7l5ZhnqZTgq9GnVkDem7osup6F73pOxbfL8nezgLsUyhVNDS75dMoBvHCi
 eroAcLXsLmCauTQdUOLYwc.Dbn2KqhxQYPcbeETVCpm9fVTfFt_joSkP60_OKM0NcuETsPs4RlX8
 IpVEGq5Cf0C9ZsYTiJgWVj1IXMj7D8NahAkIqMO.UEhLW27cyQo_aJhfSjcgWqDPzD0h8NMdEEoo
 nljKbF4MA00SOdgyPaV3qPcg9KViMy1qH1p8MnOY3jS7xGQCjaIorO4xxK7iad6FOMZ_BQ9eKU4q
 KtIwM1I7oasWD2kyjAjRI_i9xthuVuBoxVJnZu.7pQe6hJxwyS6NtmF9a2OhqhGDuAUcNy92gilT
 d0sPCCl7SjtO2UjzMY7ZvcWRsdTrnq1Kfhmlq9nUxiS_u2bh4X4spRNPTU9fI6.RDFiiNPH6BaPo
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Sep 2018 20:18:57 +0000
Received: from 177.81.17.223 (EHLO giustizia.org) ([177.81.17.223])
          by smtp420.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0a5e3192dfd6e5660bc0cbdefed84b5;
          Thu, 27 Sep 2018 20:18:55 +0000 (UTC)
Date:   Thu, 27 Sep 2018 17:19:26 -0300
From:   Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] ath3k: add more information to error message
Message-ID: <20180927201926.GB19318@giustizia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When there is an error in either ath3k_load_firmware() or
ath3k_load_fwfile(), the inlined function ath3k_log_failed_loading() is
called receiving the error returned and both the block size requested to
load and the size actually loaded. These values are printed in an error
message using the macro BT_ERR.

This patch changes that function in order to print the variable "count"
as well, to show more information when a failing firmware loading
operation happens. The calls to the older function were changed to the
new one.

This event is being monitored in a laptop with an adapter which
identifies itself as 0cf3:0036, where sometimes there are errors in the
firmware loading process.

Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
---
 drivers/bluetooth/ath3k.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 3a8c47efea55..73453fdff4e7 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -203,10 +203,12 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ }	/* Terminating entry */
 };
 
-static inline void ath3k_log_failed_loading(int err, int len, int size)
+static inline void ath3k_log_failed_loading(int err, int len, int size,
+						int count)
 {
-	BT_ERR("Error in firmware loading err = %d, len = %d, size = %d",
-			err, len, size);
+	BT_ERR("%s err = %d, len = %d, size = %d, count = %d",
+			"Error in firmware loading",
+			err, len, size, count);
 }
 
 #define USB_REQ_DFU_DNLOAD	1
@@ -257,7 +259,7 @@ static int ath3k_load_firmware(struct usb_device *udev,
 					&len, 3000);
 
 		if (err || (len != size)) {
-			ath3k_log_failed_loading(err, len, size);
+			ath3k_log_failed_loading(err, len, size, count);
 			goto error;
 		}
 
@@ -356,7 +358,7 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
 					&len, 3000);
 		if (err || (len != size)) {
-			ath3k_log_failed_loading(err, len, size);
+			ath3k_log_failed_loading(err, len, size, count);
 			kfree(send_buf);
 			return err;
 		}
-- 
2.14.4

