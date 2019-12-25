Return-Path: <SRS0=7lkf=2P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEBFC2D0DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Dec 2019 07:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF72071E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Dec 2019 07:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfLYHkv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Dec 2019 02:40:51 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:43462 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfLYHkv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Dec 2019 02:40:51 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 02:40:49 EST
IronPort-SDR: jQw2iwoYROwyOD/OAet41kcjHu8fzEY7DtooW8Aml02CYtlutIkwOrQ0aId6lQb+dfnSapSF/B
 wFs11xsm8zfQ==
IronPort-PHdr: =?us-ascii?q?9a23=3AqUJUPB3B8z/s2tuVsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIULPad9pjvdHbS+e9qxAeQG9mCsLQe0bGd7fqocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBmoowjducgbjZV/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTljjoMOTwk/2HNksF+gqJVoAi/qRJ83oDbb52aOvVlc6PBf94VWX?=
 =?us-ascii?q?ZNUtpNWyBfBI63cosBD/AGPeZdt4TzoUEBpgakCwm2BePvzz5IhmP33a0kye?=
 =?us-ascii?q?sqDAbL3BA9H9IKrHvUrcj6O70JUe2uyanH1zTDb/dM1Tfh9ofIdg4uoemWUr?=
 =?us-ascii?q?1sa8bR0VUvGhrDg16NqoLlJyuY2voQv2WZ9eZsSOyih3I9pw1vrTWj3Mkhh4?=
 =?us-ascii?q?nPi4kI0F7L7z95z5wwJdCgTU57ZsOrH4VIuiGBMot2XtsiQ2Z1uCYm0rEGuY?=
 =?us-ascii?q?C0fCwNyJk/wh7Qcf2Hc4yS4h39UOadPTh1iGh7eLK4mhm960agyur6Vsaqyl?=
 =?us-ascii?q?pFsDFFnsHNtnALyRPT9tCKRuVg8kqjwzqDyg7e5v1eLUwqmqfXMZAsz74omp?=
 =?us-ascii?q?oWq0vDHyv2mEvsjK+Rc0Up4vSo6/njYrr6p5+TKpV7ihrlP6QrgMO/AOA4Ph?=
 =?us-ascii?q?ISX2eF/eSzyqXj8lflT7lQlv02jrHVsIrGKsQDuq65HwhV354n6xa+CTemzd?=
 =?us-ascii?q?sZkWAcI1JBZRKIkZTpO1bJIPDkDfeymEqskDh1yPDcJLHhAYvCLmLFkLj/eb?=
 =?us-ascii?q?Zx8UlcyBA8zYMX25UBDrAHPeK2UEvsucDfCQM5GxK7zvyhC9hn0I4aH2WVDf?=
 =?us-ascii?q?yjPbvWoGOPs8Yma9GWZYoUpDfjIrBx4/f2l348mEMcY6CkxrMFb3C/G/1nJw?=
 =?us-ascii?q?OUfCy/rM0GFDIut0IGVu3viUGDTzcbM2qvW6k96jggIIevDIOFWo2pjaSI12?=
 =?us-ascii?q?GjAssFNSh9FlmQHCKwJM2/UPAWZXfKLw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GEKgArEANelyMYgtllgkQBGAEBgns?=
 =?us-ascii?q?3GyASk0JUBnUdihKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECEAEBAQEBCBYGhXNCAQwBgWsihBeBA4EsgwOCUymtGhoChSO?=
 =?us-ascii?q?Ec4E2AYwYGnmBB4FEgjKFAgESAWyFIQSNRSGIS2GXfoI+BJYwDYIpAYw4A4J?=
 =?us-ascii?q?UiRGnIoI3VYELgQpxTTiBchmBHU8YDY0sji1AgRYQAk+FQIdcgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GEKgArEANelyMYgtllgkQBGAEBgns3GyASk0JUBnUdi?=
 =?us-ascii?q?hKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQUBAQEBAQUEAQECE?=
 =?us-ascii?q?AEBAQEBCBYGhXNCAQwBgWsihBeBA4EsgwOCUymtGhoChSOEc4E2AYwYGnmBB?=
 =?us-ascii?q?4FEgjKFAgESAWyFIQSNRSGIS2GXfoI+BJYwDYIpAYw4A4JUiRGnIoI3VYELg?=
 =?us-ascii?q?QpxTTiBchmBHU8YDY0sji1AgRYQAk+FQIdcgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="298569150"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 25 Dec 2019 08:35:46 +0100
Received: (qmail 32118 invoked from network); 25 Dec 2019 04:33:50 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-bluetooth@vger.kernel.org>; 25 Dec 2019 04:33:50 -0000
Date:   Wed, 25 Dec 2019 05:33:41 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <23632181.259351.1577248422082.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

