Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD21C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 04:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EE361040
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 04:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhIWEQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 00:16:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:17444 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhIWEQA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 00:16:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223792264"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="223792264"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 21:14:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="518833249"
Received: from kvander-mobl.amr.corp.intel.com ([10.209.109.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 21:14:28 -0700
Message-ID: <d6be094a81d659e48148dc0e1a949c48ec955550.camel@linux.intel.com>
Subject: Re: Mesh Configuration Database
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Date:   Wed, 22 Sep 2021 21:14:28 -0700
In-Reply-To: <614bfbd8.1c69fb81.a75af.a5f5@mx.google.com>
References: <20210923032603.50536-2-inga.stotland@intel.com>
         <614bfbd8.1c69fb81.a75af.a5f5@mx.google.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

Please discard the Gitlint result here.
I will take a look CI tomorrow.

On Wed, 2021-09-22 at 21:00 -0700, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551419
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PASS      30.23 seconds
> GitLint                       FAIL      18.49 seconds
> Prep - Setup ELL              PASS      49.39 seconds
> Build - Prep                  PASS      0.51 seconds
> Build - Configure             PASS      9.05 seconds
> Build - Make                  PASS      216.88 seconds
> Make Check                    PASS      10.03 seconds
> Make Distcheck                PASS      252.94 seconds
> Build w/ext ELL - Configure   PASS      9.10 seconds
> Build w/ext ELL - Make        PASS      205.82 seconds
> 
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> [BlueZ,01/20] tools/mesh-cfgclient: Save provisioner info
> 1: T3 Title has trailing punctuation (.): "This adds "provisioners" property to the config
> database."
> 
> [BlueZ,02/20] tools/mesh-cfgclient: Add timestamp to config database
> 1: T3 Title has trailing punctuation (.): "This adds timestamp property to the configuration
> database."
> 
> [BlueZ,03/20] tools/mesh-cfgclient: Update stored NetKey and AppKey
> 1: T3 Title has trailing punctuation (:): "NetKeys:"
> 
> [BlueZ,04/20] tools/mesh-cfgclient: Keep track of updated keys
> 1: T8 Title is too short (3<5): "---"
> 
> [BlueZ,05/20] tools/mesh: Add new info to stored remote nodes
> 1: T3 Title has trailing punctuation (,): "When adding a new remote node into configuration
> database,"
> 
> [BlueZ,12/20] tools/mesh-cfgclient: Rename mesh-db APIs for consistency
> 1: T8 Title is too short (3<5): "---"
> 
> [BlueZ,15/20] tools/mesh-cfgclient: Add group parent address for DB compliance
> 1: T8 Title is too short (3<5): "---"
> 
> [BlueZ,16/20] doc/mesh-api: Add ExportKeys call
> 1: T3 Title has trailing punctuation (:): "Add description for a new method:"
> 
> [BlueZ,20/20] tools/mesh-cfgclient: Export configuration database
> 1: T3 Title has trailing punctuation (.): "This adds main menu command "export-db"."
> 
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

