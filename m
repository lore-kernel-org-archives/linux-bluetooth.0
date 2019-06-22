Return-Path: <SRS0=TRpe=UV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6FC48BE7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 22:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D944120673
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 22:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="gzU2UxSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFVWs2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:48:28 -0400
Received: from mr85p00im-hyfv06021301.me.com ([17.58.23.188]:10319 "EHLO
        mr85p00im-hyfv06021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbfFVWs2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jun 2019 18:48:28 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jun 2019 18:48:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1561243317; bh=NXzdK2SWkWPi17tyJ2ltxFdRJfR4LDuP1lbms16jNUQ=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=gzU2UxSqoX9FQLonWGZywWrLVGgBEF0z2MtxuXwf2aCoemABJF4jNNT/ahJF98unp
         H1MaZnTLuGvgkLQxHMUraln2rPHyisaHFBZYX2Gzg+DrRvoaiAaXr4/a0W7eF9dUpf
         X9S7dpgTNPcLFRf+HNyXddAhM0As7Zv0n4aaEBCt9h0NKQp3cEd1pxFdAvNfPZu5mK
         yQl9rxvI1Tckre/6DpmCPzCUQBUUhBZbR6VMnFHwUjydoGA1DH9Fof0CzQpQ3avCuB
         37uGAwYyj6C3veh8+1mgrRy62txd5ozvUwFP8M1q2VvAb8PZ5YDEvxYXi56ZzcDQNu
         oRcqbdbV0zJyA==
Received: from [192.168.2.34] (cpe-70-95-69-18.san.res.rr.com [70.95.69.18])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 0EA7E40B5E
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jun 2019 22:41:57 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   John Meisner <jhn_msnr@me.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 22 Jun 2019 15:41:55 -0700
Subject: Linux bluetooth
Message-Id: <F2DFEBEC-D3F6-4C78-8153-BE1EE328470B@me.com>
To:     linux-bluetooth@vger.kernel.org
X-Mailer: iPhone Mail (16F203)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-22_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=478 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1906220207
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am new to Bluetooth, but would also contribute

Sent from my iPhone
