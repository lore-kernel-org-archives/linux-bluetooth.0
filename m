Return-Path: <SRS0=SJVD=4F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D1C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Feb 2020 08:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14042072C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Feb 2020 08:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgBQICb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:02:31 -0500
Received: from mail3-bck.iservicesmail.com ([217.130.24.85]:27503 "EHLO
        mail3-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbgBQICa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Feb 2020 03:02:30 -0500
IronPort-SDR: JhS6/zAvMlzoyF9fMgLUa3BkTgaxUQdg3z5i8MwjqZTN5P4QLl9GRIRs0sYU0gaa4+h2ndT0sM
 Z98EGrVABWOA==
IronPort-PHdr: =?us-ascii?q?9a23=3ATH8iPxXGWsctRPSfBcbqQEw0wDDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYx2At8tkgFKBZ4jH8fUM07OQ7/m8HzNdqs/Y6jgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4lvJ6Y+xh?=
 =?us-ascii?q?fUv3dEZfldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U7NVCSktPn?=
 =?us-ascii?q?426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07Qz?=
 =?us-ascii?q?Wi76NsSB/1lCcKMiMy/W/LhsBsiq9QvRSsrAF9zYHJeoGYLPRwcKPHfd0ERm?=
 =?us-ascii?q?RPQ8leWDBODI6nc4sCDfYOMfpEo4XhuVcDqwa1Cwm2BOPozz9FnmX40rMm0+?=
 =?us-ascii?q?s/CwHNwQwvH9UIsHTbsd74M78SUeevzKnU1zrOdO5W2TH86IjTbhAhu+uDUq?=
 =?us-ascii?q?9qfsbLyEkvCxrIg1ONooLmJzOYzvoBv3WZ4uZ6SO6ihXIrpxtvrjWg3MshhI?=
 =?us-ascii?q?nEi4QIwV7e7yp52pw6JdigRU5+Zt6rDYVfujmBN4tzXsMiW2ZouDsmyrEeuZ?=
 =?us-ascii?q?60YiwKyJM/yh7acfOHcoyI4gj9W+aVPTt1i2hpeKy4hxmv60egxOr8Vs+q31?=
 =?us-ascii?q?pQsCVFicHAtnEL1xPN9siKUuVx8lqj1DqVygze5P1ILVoqmafUMZIszL49mo?=
 =?us-ascii?q?IWsUvZHy/2nEv2jLWRdkUh4uWo8+PnYq/6ppCGLIJ0lwf+MqU1msyjG+Q3KB?=
 =?us-ascii?q?UBUHKB9eS9yL3v5Vf5T6lSjv0qjqnZt4jXJcAapq6/Hg9U3Z8v5A27Dze7zt?=
 =?us-ascii?q?sYgX4HLFVZeBKHlIXpJV7OL+7iDfulgFSjji1rx/bYMb3lGJnNKWLDkLiyNY?=
 =?us-ascii?q?p6vkpdzhcjiNpb+p9IDbYdINrtVULr8t/VFBk0N0qz2em0Mthl0pIiXje3D7?=
 =?us-ascii?q?OUKuvttlmHrrY3LvWBfpASvjn9KPg+7fXGgnowmFtbdq6si8g5cne9S8xrP0?=
 =?us-ascii?q?iDKUXrhNhJRX8NpBY3ZPHsiUaeSzdfbjCzQ/RvtXkAFIu6ANKbFciWi7ub0X?=
 =?us-ascii?q?LjEw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G9TQBkR0pelyMYgtllgkOBPgIBgUU?=
 =?us-ascii?q?QUiASjGOGa1QGcx+DQ4ZShRaBAIMzhgcTDIFbDQEBAQEBNQIEAQGEQIIEJDw?=
 =?us-ascii?q?CDQIDDQEBBgEBAQEBBQQBAQIQAQEBAQEIFgaFc4I7IoNwIA85SkwBDgGDV4J?=
 =?us-ascii?q?LAQEKKax2DQ0ChR6CSAQKgQiBGyOBNgMBAYwhGnmBB4EjIYIrCAGCAYJ/ARI?=
 =?us-ascii?q?BboJIglkEjVISIYlFmDSBaloElmuCOQEPiBaENwOCWg+BC4MdgwmBZ4RSgX+?=
 =?us-ascii?q?fZoQUV4Egc3EzGggwgW4agSBPGA2ON44rAkCBFxACT4tJgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2G9TQBkR0pelyMYgtllgkOBPgIBgUUQUiASjGOGa1QGc?=
 =?us-ascii?q?x+DQ4ZShRaBAIMzhgcTDIFbDQEBAQEBNQIEAQGEQIIEJDwCDQIDDQEBBgEBA?=
 =?us-ascii?q?QEBBQQBAQIQAQEBAQEIFgaFc4I7IoNwIA85SkwBDgGDV4JLAQEKKax2DQ0Ch?=
 =?us-ascii?q?R6CSAQKgQiBGyOBNgMBAYwhGnmBB4EjIYIrCAGCAYJ/ARIBboJIglkEjVISI?=
 =?us-ascii?q?YlFmDSBaloElmuCOQEPiBaENwOCWg+BC4MdgwmBZ4RSgX+fZoQUV4Egc3EzG?=
 =?us-ascii?q?ggwgW4agSBPGA2ON44rAkCBFxACT4tJgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.70,451,1574118000"; 
   d="scan'208";a="338073378"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 17 Feb 2020 09:02:22 +0100
Received: (qmail 1141 invoked from network); 17 Feb 2020 06:34:31 -0000
Received: from unknown (HELO 192.168.1.163) (mariapazos@[217.217.179.17])
          (envelope-sender <porta@unistrada.it>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-bluetooth@vger.kernel.org>; 17 Feb 2020 06:34:31 -0000
Date:   Mon, 17 Feb 2020 07:34:30 +0100 (CET)
From:   Peter Wong <porta@unistrada.it>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <22318792.419763.1581921271245.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Greetings,
Please check the attached email for a buisness proposal to explore.
Looking forward to hearing from you for more details.
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

