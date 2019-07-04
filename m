Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA58C0650E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 04:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEF02082E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 04:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.in header.i=@phytec.in header.b="eA3dWLAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfGDEIH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 00:08:07 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:50212 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfGDEIH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 00:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.in; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.in; t=1562213286; x=1564805286;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q5+UW86mkCNDOaASBatsP9CwxGLgRWb/1nAQU1uGigw=;
        b=eA3dWLAiJ82mCPPw/rncFEW0d/0+RGkWgxEWnCRxZaqBAZRvoLtEuQPDUC/lXWTv
        8LLpn5xt3nniE3+qAT+fKbnY15OTJTZtljajipOcwJJpIC5RAu3La6SijiSwX9GE
        g/FzoDDwalzFYjq+X2bvm4jMJDhh6C6T6Q0s6fWchP4=;
X-AuditID: c39127d2-193ff70000001aee-19-5d1d7ba63260
Received: from tumirnix.phytec.de (tumirnix.phytec.de [172.16.0.38])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C2.DA.06894.6AB7D1D5; Thu,  4 Jul 2019 06:08:06 +0200 (CEST)
X-Disclaimed: 1
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
Subject: Testing Bluetooth Mesh with python
From:   Mahaboob Nazeer SK <nazeer.m@phytec.in>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <OFCEFD7E67.77A1AF25-ONC125842D.001694FD-C125842D.001694FE@phytec.de>
Date:   Thu, 4 Jul 2019 06:06:39 +0200
X-Mailer: Lotus Domino Web Server Release 9.0.1FP7 August  17, 2016
X-MIMETrack: Serialize by http on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 04.07.2019 06:06:39,
        Serialize complete at 04.07.2019 06:06:39,
        Serialize by Router on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 04.07.2019 06:06:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWyRoBBTXdZtWyswfwWGYs51/qYHRg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mro+zKPtWAxc8WMTQkNjPuYuhg5OSQETCT2z53N1sXIxSEksIdR
        YunrLawQCX6JT39a2UBsXgFBiZMzn7CA2MICvBKb3s5mBLE5BYQkOq52QtWLSUxY94u5i5ED
        KM4rMeGfNUhYSIBH4tWG/YwQrdoSz849BrPZBHQlVl54CGaLCChLPNt3mAliVaDEhKu/wNay
        CKhI3J6zE+pOZ4nFfy6wgNwpIdDAJNFyeQkLyC5mAXWJ9fOEQGqYgeYvW/iaeQKj0CwkV89C
        qJqFpGoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjMAgPTxR/dIOxr45HocYmTgYDzFKcDAr
        ifB+/y0TK8SbklhZlVqUH19UmpNafIhRmoNFSZx3A29JmJBAemJJanZqakFqEUyWiYNTqoGx
        4sjOuUGXZV1lFnGpT3dYNGfuWc81rFF5FR8dllyLfKP61ODyAg+3xE05lnkbtVuqnI/zVt+/
        oPzjxbvzcUWtTQ6rOv/WbDy340Ox0XfBP7Yziu1Elwp3btLz2xz07H1QfMOxvkPqcw5MKru2
        /tYGPa7MmI1zDOzyfI6+0eOtq7jxYU+dJ1OkEktxRqKhFnNRcSIAO041L0ACAAA=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

We are using Zephyr Mesh onoff example on nrf52 eval kit to test the Mesh F=
unctionality.For provisioning of the
node we are using meshctl tool.

But is there any other way to provision a node using a python script.I foun=
d a test-mesh script in the test folder=20
of bluez stack ,but i was unable to provision and test a node with it.Could=
 you share a test procedure if any.

--
Thanks





