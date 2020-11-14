Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FFC4742C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 00:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273632225F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 00:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XELCpIcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKNAv5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKNAv5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Nov 2020 19:51:57 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0B1C0613D1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 16:51:55 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id c80so12451881oib.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4BkNFYljTSYcGEe1k4zbdgMirVllfsY9P4TuobxxQeI=;
        b=XELCpIcGf2VsbKuntbmjKpHi7yKYkk/JUCY3btjoCb8gMkA9LtPpBBNbHRUYqSiZFO
         fYj1EeY72g/mfZ4qzXVRXjyDwVlPkAACCXekkgsGX6KiJzrtuAd8x0icAlqEQUE5V3yZ
         u3Y/oDBWADZKCiM3lc+QHmrSFKMcfesd2MeRxCEqMXkBklS3cRm5GFCP1BVGsELs6i7n
         EJyN+R51c80o8usI1ljadjNEEaFTiCCofnvtoMiD91I7x9GAyQAUBDsvC8SieeR482qf
         P5dw7CCKv/nbLJ3Gzxwk2iEHzLYWYvX9OacU/SjKzk3HRDom0OkgKJkTpXbCkjEYtt+H
         ge0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4BkNFYljTSYcGEe1k4zbdgMirVllfsY9P4TuobxxQeI=;
        b=f+aXTSILmUnTX6VgOOAT8FlFVgTep9tAS+gvMiRx8EpCpNZohTS0s03YG9JV0YZ1wv
         7FrDIBcGJaMkLru8KJGC/4KPZ3zNO3U8oMrgRCrb9ECSfYfuj5iFkOgFiQApqFV26L2D
         nrEXeCdwq7ofUdBUVrR1C6yidb0iIHgd7hxk5PbozkIQaKhgKUR3rmHylaU7k2XF4Sj+
         CElXncuAwUuhKjW81BUxTwvIQEkT5XdGXt84orAvokSXcqSHhu4cptLGElE+KkjOEl51
         L1uWlwG4Y/WWkZVb5WGpwAUQHzcGylyWFfAXwyfoDHm5p6Aq8HgezKRw4ikpvEgbkCKA
         PbRQ==
X-Gm-Message-State: AOAM531X0j0KD02ajJhd6+RQNx4t0MIa7j01cIKAqsGEVL9SktjsYMxn
        P1Z+0HluIGEb1ahnkOX2mUzDi9Fykb8AmqXW6rVUQFlcGH8=
X-Google-Smtp-Source: ABdhPJzntY8x4ih75uT5pT18+wJod0VoR2yH9o7XKXOb2oNYCZbFHyj4qtFEZYw9tyUa0593w7jftIVNUnwOtrYwsoA=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr3174954oig.161.1605315114983;
 Fri, 13 Nov 2020 16:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 Nov 2020 16:51:43 -0800
Message-ID: <CABBYNZL-1mxSJxhq26vSkyHGthQ+sA9OXvL1cZ6wXqop0kjPcw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Testers/Emulator overhaul
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Nov 11, 2020 at 3:04 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This attempts to fix problems related to emulator and testers being not in
> sync with latest development in the kernel which results in many tests
> failing.
>
> With the current set there are still a very few test failing (3):
>
> Running command tools/mgmt-tester
>
> Test Summary
> ------------
> Controller setup                                     Passed       0.100
> seconds
> Controller setup (BR/EDR-only)                       Passed       0.003
> seconds
> Controller setup (LE)                                Passed       0.003
> seconds
> Invalid command                                      Passed       0.003
> seconds
> Read version - Success                               Passed       0.003
> seconds
> Read version - Invalid parameters                    Passed       0.003
> seconds
> Read version - Invalid index                         Passed       0.003
> seconds
> Read commands - Invalid parameters                   Passed       0.004
> seconds
> Read commands - Invalid index                        Passed       0.003
> seconds
> Read index list - Invalid parameters                 Passed       0.004
> seconds
> Read index list - Invalid index                      Passed       0.004
> seconds
> Read info - Invalid parameters                       Passed       0.003
> seconds
> Read info - Invalid index                            Passed       0.003
> seconds
> Read unconfigured index list - Invalid parameters    Passed       0.004
> seconds
> Read unconfigured index list - Invalid index         Passed       0.003
> seconds
> Read configuration info - Invalid parameters         Passed       0.003
> seconds
> Read configuration info - Invalid index              Passed       0.003
> seconds
> Read extended index list - Invalid parameters        Passed       0.004
> seconds
> Read extended index list - Invalid index             Passed       0.003
> seconds
> Set powered on - Success                             Passed       0.003
> seconds
> Set powered on - Invalid parameters 1                Passed       0.004
> seconds
> Set powered on - Invalid parameters 2                Passed       0.006
> seconds
> Set powered on - Invalid parameters 3                Passed       0.004
> seconds
> Set powered on - Invalid index                       Passed       0.004
> seconds
> Set powered on - Privacy and Advertising             Passed       0.004
> seconds
> Set powered off - Success                            Passed       0.003
> seconds
> Set powered off - Class of Device                    Passed       0.003
> seconds
> Set powered off - Invalid parameters 1               Passed       0.003
> seconds
> Set powered off - Invalid parameters 2               Passed       0.004
> seconds
> Set powered off - Invalid parameters 3               Passed       0.003
> seconds
> Set connectable on - Success 1                       Passed       0.003
> seconds
> Set connectable on - Success 2                       Passed       0.003
> seconds
> Set connectable on - Invalid parameters 1            Passed       0.004
> seconds
> Set connectable on - Invalid parameters 2            Passed       0.003
> seconds
> Set connectable on - Invalid parameters 3            Passed       0.003
> seconds
> Set connectable on - Invalid index                   Passed       0.003
> seconds
> Set connectable on (LE) - Success 1                  Passed       0.003
> seconds
> Set connectable on (LE) - Success 2                  Passed       0.003
> seconds
> Set connectable on (LE) - Success 3                  Passed       0.003
> seconds
> Set connectable off - Success 1                      Passed       0.003
> seconds
> Set connectable off - Success 2                      Passed       0.004
> seconds
> Set connectable off - Success 3                      Passed       0.003
> seconds
> Set connectable off - Success 4                      Passed       0.003
> seconds
> Set connectable off (LE) - Success 1                 Passed       0.003
> seconds
> Set connectable off (LE) - Success 2                 Passed       0.004
> seconds
> Set connectable off (LE) - Success 3                 Passed       0.003
> seconds
> Set connectable off (LE) - Success 4                 Passed       0.003
> seconds
> Set fast connectable on - Success 1                  Passed       0.003
> seconds
> Set fast connectable on - Success 2                  Passed       0.004
> seconds
> Set fast connectable on - Success 3                  Passed       0.003
> seconds
> Set fast connectable on - Invalid Params 1           Passed       0.003
> seconds
> Set fast connectable on - Not Supported 1            Passed       0.003
> seconds
> Set bondable on - Success                            Passed       0.003
> seconds
> Set bondable on - Invalid parameters 1               Passed       0.003
> seconds
> Set bondable on - Invalid parameters 2               Passed       0.003
> seconds
> Set bondable on - Invalid parameters 3               Passed       0.004
> seconds
> Set bondable on - Invalid index                      Passed       0.003
> seconds
> Set discoverable on - Invalid parameters 1           Passed       0.003
> seconds
> Set discoverable on - Invalid parameters 2           Passed       0.003
> seconds
> Set discoverable on - Invalid parameters 3           Passed       0.004
> seconds
> Set discoverable on - Invalid parameters 4           Passed       0.004
> seconds
> Set discoverable on - Not powered 1                  Passed       0.003
> seconds
> Set discoverable on - Not powered 2                  Passed       0.003
> seconds
> Set discoverable on - Rejected 1                     Passed       0.004
> seconds
> Set discoverable on - Rejected 2                     Passed       0.004
> seconds
> Set discoverable on - Rejected 3                     Passed       0.003
> seconds
> Set discoverable on - Success 1                      Passed       0.003
> seconds
> Set discoverable on - Success 2                      Passed       0.003
> seconds
> Set discoverable on (LE) - Success 1                 Passed       0.003
> seconds
> Set discoverable off - Success 1                     Passed       0.003
> seconds
> Set discoverable off - Success 2                     Passed       0.003
> seconds
> Set limited discoverable on - Success 1              Passed       0.004
> seconds
> Set limited discoverable on - Success 2              Passed       0.004
> seconds
> Set limited discoverable on - Success 3              Passed       0.004
> seconds
> Set limited discoverable on (LE) - Success 1         Passed       0.004
> seconds
> Set link security on - Success 1                     Passed       0.004
> seconds
> Set link security on - Success 2                     Passed       0.005
> seconds
> Set link security on - Success 3                     Passed       0.004
> seconds
> Set link security on - Invalid parameters 1          Passed       0.006
> seconds
> Set link security on - Invalid parameters 2          Passed       0.004
> seconds
> Set link security on - Invalid parameters 3          Passed       0.004
> seconds
> Set link security on - Invalid index                 Passed       0.004
> seconds
> Set link security off - Success 1                    Passed       0.003
> seconds
> Set link security off - Success 2                    Passed       0.003
> seconds
> Set SSP on - Success 1                               Passed       0.003
> seconds
> Set SSP on - Success 2                               Passed       0.003
> seconds
> Set SSP on - Success 3                               Passed       0.003
> seconds
> Set SSP on - Invalid parameters 1                    Passed       0.003
> seconds
> Set SSP on - Invalid parameters 2                    Passed       0.003
> seconds
> Set SSP on - Invalid parameters 3                    Passed       0.003
> seconds
> Set SSP on - Invalid index                           Passed       0.003
> seconds
> Set Secure Connections on - Success 1                Passed       0.003
> seconds
> Set Secure Connections on - Success 2                Passed       0.003
> seconds
> Set Secure Connections on - Invalid params 1         Passed       0.004
> seconds
> Set Secure Connections on - Invalid params 2         Passed       0.004
> seconds
> Set Secure Connections on - Invalid params 3         Passed       0.004
> seconds
> Set Secure Connections on - Invalid index            Passed       0.004
> seconds
> Set Secure Connections on - Not supported 1          Passed       0.003
> seconds
> Set Secure Connections on - Not supported 2          Passed       0.003
> seconds
> Set Secure Connections Only on - Success 1           Passed       0.003
> seconds
> Set Secure Connections Only on - Success 2           Passed       0.004
> seconds
> Set High Speed on - Success                          Not Run
> Set High Speed on - Invalid parameters 1             Not Run
> Set High Speed on - Invalid parameters 2             Not Run
> Set High Speed on - Invalid parameters 3             Not Run
> Set High Speed on - Invalid index                    Not Run
> Set Low Energy on - Success 1                        Passed       0.003
> seconds
> Set Low Energy on - Success 2                        Passed       0.004
> seconds
> Set Low Energy on - Success 3                        Passed       0.003
> seconds
> Set Low Energy on - Invalid parameters 1             Passed       0.003
> seconds
> Set Low Energy on - Invalid parameters 2             Passed       0.003
> seconds
> Set Low Energy on - Invalid parameters 3             Passed       0.003
> seconds
> Set Low Energy on - Invalid index                    Passed       0.003
> seconds
> Set Advertising on - Success 1                       Passed       0.003
> seconds
> Set Advertising on - Success 2                       Passed       0.003
> seconds
> Set Advertising on - Rejected 1                      Passed       0.003
> seconds
> Set Advertising on - Appearance 1                    Passed       0.004
> seconds
> Set Advertising on - Local name 1                    Passed       0.003
> seconds
> Set Advertising on - Name + Appear 1                 Passed       0.003
> seconds
> Set BR/EDR off - Success 1                           Passed       0.003
> seconds
> Set BR/EDR on - Success 1                            Passed       0.003
> seconds
> Set BR/EDR on - Success 2                            Passed       0.003
> seconds
> Set BR/EDR off - Not Supported 1                     Passed       0.003
> seconds
> Set BR/EDR off - Not Supported 2                     Passed       0.003
> seconds
> Set BR/EDR off - Rejected 1                          Passed       0.003
> seconds
> Set BR/EDR off - Rejected 2                          Passed       0.003
> seconds
> Set BR/EDR off - Invalid Parameters 1                Passed       0.003
> seconds
> Set Local Name - Success 1                           Passed       0.003
> seconds
> Set Local Name - Success 2                           Passed       0.003
> seconds
> Set Local Name - Success 3                           Passed       0.003
> seconds
> Start Discovery - Not powered 1                      Passed       0.003
> seconds
> Start Discovery - Invalid parameters 1               Passed       0.004
> seconds
> Start Discovery - Not supported 1                    Passed       0.003
> seconds
> Start Discovery - Success 1                          Passed       0.003
> seconds
> Start Discovery - Success 2                          Passed       0.003
> seconds
> Start Discovery - Power Off 1                        Passed       0.003
> seconds
> Stop Discovery - Success 1                           Passed       0.003
> seconds
> Stop Discovery - BR/EDR (Inquiry) Success 1          Passed       0.004
> seconds
> Stop Discovery - Rejected 1                          Passed       0.003
> seconds
> Stop Discovery - Invalid parameters 1                Passed       0.005
> seconds
> Start Service Discovery - Not powered 1              Passed       0.004
> seconds
> Start Service Discovery - Invalid parameters 1       Passed       0.004
> seconds
> Start Service Discovery - Not supported 1            Passed       0.004
> seconds
> Start Service Discovery - Success 1                  Passed       0.005
> seconds
> Start Service Discovery - Success 2                  Passed       0.004
> seconds
> Set Device Class - Success 1                         Passed       0.003
> seconds
> Set Device Class - Success 2                         Passed       0.004
> seconds
> Set Device Class - Invalid parameters 1              Passed       0.005
> seconds
> Add UUID - UUID-16 1                                 Passed       0.005
> seconds
> Add UUID - UUID-16 multiple 1                        Passed       0.004
> seconds
> Add UUID - UUID-16 partial 1                         Passed       0.005
> seconds
> Add UUID - UUID-32 1                                 Passed       0.003
> seconds
> Add UUID - UUID-32 multiple 1                        Passed       0.003
> seconds
> Add UUID - UUID-32 partial 1                         Passed       0.004
> seconds
> Add UUID - UUID-128 1                                Passed       0.003
> seconds
> Add UUID - UUID-128 multiple 1                       Passed       0.003
> seconds
> Add UUID - UUID-128 partial 1                        Passed       0.003
> seconds
> Add UUID - UUID mix                                  Passed       0.003
> seconds
> Load Link Keys - Empty List Success 1                Passed       0.003
> seconds
> Load Link Keys - Empty List Success 2                Passed       0.003
> seconds
> Load Link Keys - Invalid Parameters 1                Passed       0.003
> seconds
> Load Link Keys - Invalid Parameters 2                Passed       0.004
> seconds
> Load Link Keys - Invalid Parameters 3                Passed       0.004
> seconds
> Load Long Term Keys - Success 1                      Passed       0.003
> seconds
> Load Long Term Keys - Invalid Parameters 1           Passed       0.004
> seconds
> Load Long Term Keys - Invalid Parameters 2           Passed       0.003
> seconds
> Load Long Term Keys - Invalid Parameters 3           Passed       0.004
> seconds
> Load Long Term Keys - Invalid Parameters 4           Passed       0.004
> seconds
> Set IO Capability - Invalid Params 1                 Passed       0.003
> seconds
> Pair Device - Not Powered 1                          Passed       0.003
> seconds
> Pair Device - Power off 1                            Passed       0.003
> seconds
> Pair Device - Incorrect transport reject 1           Passed       0.003
> seconds
> Pair Device - Incorrect transport reject 2           Passed       0.003
> seconds
> Pair Device - Reject on not enabled transport 1      Passed       0.004
> seconds
> Pair Device - Reject on not enabled transport 2      Passed       0.004
> seconds
> Pair Device - Invalid Parameters 1                   Passed       0.003
> seconds
> Pair Device - Invalid Parameters 2                   Passed       0.003
> seconds
> Pair Device - Legacy Success 1                       Passed       0.003
> seconds
> Pair Device - Legacy Non-bondable 1                  Passed       0.004
> seconds
> Pair Device - Sec Mode 3 Success 1                   Passed       0.004
> seconds
> Pair Device - Legacy Reject 1                        Passed       0.003
> seconds
> Pair Device - Legacy Reject 2                        Passed       0.003
> seconds
> Pair Device - Sec Mode 3 Reject 1                    Passed       0.003
> seconds
> Pair Device - Sec Mode 3 Reject 2                    Passed       0.003
> seconds
> Pair Device - SSP Just-Works Success 1               Passed       0.004
> seconds
> Pair Device - SSP Just-Works Success 2               Passed       0.004
> seconds
> Pair Device - SSP Just-Works Success 3               Passed       0.004
> seconds
> Pair Device - SSP Confirm Success 1                  Passed       0.004
> seconds
> Pair Device - SSP Confirm Success 2                  Passed       0.004
> seconds
> Pair Device - SSP Confirm Success 3                  Passed       0.004
> seconds
> Pair Device - SSP Confirm Reject 1                   Passed       0.003
> seconds
> Pair Device - SSP Confirm Reject 2                   Passed       0.004
> seconds
> Pair Device - SSP Non-bondable 1                     Passed       0.004
> seconds
> Pair Device - SMP over BR/EDR Success 1              Passed       0.004
> seconds
> Pair Device - SMP over BR/EDR Success 2              Passed       0.004
> seconds
> Pair Device - LE Success 1                           Passed       0.003
> seconds
> Pair Device - LE Success 2                           Passed       0.003
> seconds
> Pair Device - LE Reject 1                            Passed       0.003
> seconds
> Pair Device - LE SC Legacy 1                         Passed       0.003
> seconds
> Pair Device - LE SC Success 1                        Passed       0.059
> seconds
> Pair Device - LE SC Success 2                        Passed       0.007
> seconds
> Pair Device - LE SC Success 3                        Passed       0.007
> seconds
> Pairing Acceptor - Legacy 1                          Passed       0.003
> seconds
> Pairing Acceptor - Legacy 2                          Passed       0.003
> seconds
> Pairing Acceptor - Legacy 3                          Passed       0.003
> seconds
> Pairing Acceptor - Link Sec 1                        Passed       0.004
> seconds
> Pairing Acceptor - Link Sec 2                        Passed       0.003
> seconds
> Pairing Acceptor - SSP 1                             Passed       0.003
> seconds
> Pairing Acceptor - SSP 2                             Passed       0.003
> seconds
> Pairing Acceptor - SSP 3                             Passed       0.003
> seconds
> Pairing Acceptor - SSP 4                             Passed       0.003
> seconds
> Pairing Acceptor - SMP over BR/EDR 1                 Passed       0.004
> seconds
> Pairing Acceptor - SMP over BR/EDR 2                 Passed       0.004
> seconds
> Pairing Acceptor - LE 1                              Passed       0.003
> seconds
> Pairing Acceptor - LE 2                              Passed       0.003
> seconds
> Pairing Acceptor - LE 3                              Passed       0.003
> seconds
> Pairing Acceptor - LE 4                              Passed       0.003
> seconds
> Pairing Acceptor - LE 5                              Passed       0.003
> seconds
> Unpair Device - Not Powered 1                        Passed       0.003
> seconds
> Unpair Device - Invalid Parameters 1                 Passed       0.003
> seconds
> Unpair Device - Invalid Parameters 2                 Passed       0.003
> seconds
> Disconnect - Invalid Parameters 1                    Passed       0.003
> seconds
> Block Device - Invalid Parameters 1                  Passed       0.003
> seconds
> Unblock Device - Invalid Parameters 1                Passed       0.003
> seconds
> Set Static Address - Success 1                       Passed       0.003
> seconds
> Set Static Address - Success 2                       Passed       0.003
> seconds
> Set Static Address - Failure 1                       Passed       0.003
> seconds
> Set Static Address - Failure 2                       Passed       0.003
> seconds
> Set Scan Parameters - Success                        Passed       0.003
> seconds
> Load IRKs - Success 1                                Passed       0.003
> seconds
> Load IRKs - Success 2                                Passed       0.003
> seconds
> Load IRKs - Invalid Parameters 1                     Passed       0.003
> seconds
> Load IRKs - Invalid Parameters 2                     Passed       0.003
> seconds
> Load IRKs - Invalid Parameters 3                     Passed       0.004
> seconds
> Load IRKs - Not Supported                            Passed       0.003
> seconds
> Set Privacy - Success                                Passed       0.003
> seconds
> Set Privacy - Rejected                               Passed       0.003
> seconds
> Set Privacy - Invalid Parameters                     Passed       0.003
> seconds
> Get Conn Info - Success                              Not Run
> Get Conn Info - Not Connected                        Passed       0.003
> seconds
> Get Conn Info - Power off                            Passed       0.003
> seconds
> Load Connection Parameters - Invalid Params 1        Passed       0.004
> seconds
> Add Device - Invalid Params 1                        Passed       0.003
> seconds
> Add Device - Invalid Params 2                        Passed       0.003
> seconds
> Add Device - Invalid Params 3                        Passed       0.003
> seconds
> Add Device - Invalid Params 4                        Passed       0.003
> seconds
> Add Device - Success 1                               Passed       0.003
> seconds
> Add Device - Success 2                               Passed       0.003
> seconds
> Add Device - Success 3                               Passed       0.003
> seconds
> Add Device - Success 4                               Passed       0.003
> seconds
> Add Device - Success 5                               Passed       0.003
> seconds
> Remove Device - Invalid Params 1                     Passed       0.003
> seconds
> Remove Device - Invalid Params 2                     Passed       0.003
> seconds
> Remove Device - Invalid Params 3                     Passed       0.003
> seconds
> Remove Device - Success 1                            Passed       0.003
> seconds
> Remove Device - Success 2                            Passed       0.003
> seconds
> Remove Device - Success 3                            Passed       1.007
> seconds
> Remove Device - Success 4                            Passed       1.014
> seconds
> Remove Device - Success 5                            Passed       1.020
> seconds
> Read Advertising Features - Invalid parameters       Passed       0.017
> seconds
> Read Advertising Features - Invalid index            Passed       0.008
> seconds
> Read Advertising Features - Success 1 (No instance)  Passed       0.006
> seconds
> Read Advertising Features - Success 2 (One instance) Passed       0.006
> seconds
> Add Advertising - Failure: LE off                    Passed       0.004
> seconds
> Add Advertising - Invalid Params 1 (AD too long)     Passed       0.004
> seconds
> Add Advertising - Invalid Params 2 (Malformed len)   Passed       0.004
> seconds
> Add Advertising - Invalid Params 3 (Malformed len)   Passed       0.004
> seconds
> Add Advertising - Invalid Params 4 (Malformed len)   Passed       0.004
> seconds
> Add Advertising - Invalid Params 5 (AD too long)     Passed       0.004
> seconds
> Add Advertising - Invalid Params 6 (ScRsp too long)  Passed       0.004
> seconds
> Add Advertising - Invalid Params 7 (Malformed len)   Passed       0.004
> seconds
> Add Advertising - Invalid Params 8 (Malformed len)   Passed       0.004
> seconds
> Add Advertising - Invalid Params 9 (Malformed len)   Passed       0.004
> seconds
> Add Advertising - Invalid Params 10 (ScRsp too long) Passed       0.004
> seconds
> Add Advertising - Rejected (Timeout, !Powered)       Passed       0.004
> seconds
> Add Advertising - Success 1 (Powered, Add Adv Inst)  Passed       0.004
> seconds
> Add Advertising - Success 2 (!Powered, Add Adv Inst) Passed       0.005
> seconds
> Add Advertising - Success 3 (!Powered, Adv Enable)   Passed       0.004
> seconds
> Add Advertising - Success 4 (Set Adv on override)    Passed       0.004
> seconds
> Add Advertising - Success 5 (Set Adv off override)   Passed       0.004
> seconds
> Add Advertising - Success 6 (Scan Rsp Dta, Adv ok)   Passed       0.004
> seconds
> Add Advertising - Success 7 (Scan Rsp Dta, Scan ok)  Passed       0.004
> seconds
> Add Advertising - Success 8 (Connectable Flag)       Passed       0.004
> seconds
> Add Advertising - Success 9 (General Discov Flag)    Passed       0.004
> seconds
> Add Advertising - Success 10 (Limited Discov Flag)   Passed       0.004
> seconds
> Add Advertising - Success 11 (Managed Flags)         Passed       0.004
> seconds
> Add Advertising - Success 12 (TX Power Flag)         Passed       0.004
> seconds
> Add Advertising - Success 13 (ADV_SCAN_IND)          Passed       0.004
> seconds
> Add Advertising - Success 14 (ADV_NONCONN_IND)       Passed       0.004
> seconds
> Add Advertising - Success 15 (ADV_IND)               Passed       0.004
> seconds
> Add Advertising - Success 16 (Connectable -> on)     Passed       0.004
> seconds
> Add Advertising - Success 17 (Connectable -> off)    Passed       0.004
> seconds
> Add Advertising - Success 18 (Power -> off, Remove)  Passed       0.004
> seconds
> Add Advertising - Success 19 (Power -> off, Keep)    Passed       0.004
> seconds
> Add Advertising - Success 20 (Add Adv override)      Passed       0.004
> seconds
> Add Advertising - Success 21 (Timeout expires)       Passed       1.018
> seconds
> Add Advertising - Success 22 (LE -> off, Remove)     Passed       0.012
> seconds
> Add Advertising - Success (Empty ScRsp)              Passed       0.006
> seconds
> Add Advertising - Success (ScRsp only)               Passed       0.005
> seconds
> Add Advertising - Invalid Params (ScRsp too long)    Passed       0.005
> seconds
> Add Advertising - Success (ScRsp appear)             Passed       0.004
> seconds
> Add Advertising - Invalid Params (ScRsp appear long) Passed       0.004
> seconds
> Add Advertising - Success (Appear is null)           Passed       0.004
> seconds
> Add Advertising - Success (Name is null)             Passed       0.004
> seconds
> Add Advertising - Success (Complete name)            Passed       0.004
> seconds
> Add Advertising - Success (Shortened name)           Passed       0.004
> seconds
> Add Advertising - Success (Short name)               Passed       0.004
> seconds
> Add Advertising - Success (Name + data)              Passed       0.004
> seconds
> Add Advertising - Invalid Params (Name + data)       Passed       0.004
> seconds
> Add Advertising - Success (Name+data+appear)         Passed       0.004
> seconds
> Adv. connectable & connected (slave) - Success       Passed       4.065
> seconds
> Adv. non-connectable & connected (slave) - Success   Passed       2.043
> seconds
> Adv. connectable & connected (master) - Success      Passed       4.092
> seconds
> Adv. non-connectable & connected (master) - Success  Passed       2.035
> seconds
> Remove Advertising - Invalid Params 1                Passed       0.005
> seconds
> Remove Advertising - Success 1                       Passed       0.005
> seconds
> Remove Advertising - Success 2                       Passed       0.003
> seconds
> Multi Advertising - Success 1 (Instance Switch)      Passed       1.012
> seconds
> Multi Advertising - Success 2 (Add Second Inst)      Passed       1.018
> seconds
> Set appearance - BR/EDR only                         Passed       0.016
> seconds
> Set appearance - BR/EDR LE                           Passed       0.008
> seconds
> Set appearance - LE only                             Passed       0.005
> seconds
> Read Ext Controller Info 1                           Passed       0.004
> seconds
> Read Ext Controller Info 2                           Passed       0.004
> seconds
> Read Ext Controller Info 3                           Passed       0.003
> seconds
> Read Ext Controller Info 4                           Passed       0.003
> seconds
> Read Ext Controller Info 5                           Passed       0.003
> seconds
> Read Local OOB Data - Not powered                    Passed       0.003
> seconds
> Read Local OOB Data - Invalid parameters             Passed       0.003
> seconds
> Read Local OOB Data - Invalid index                  Passed       0.003
> seconds
> Read Local OOB Data - Legacy pairing                 Passed       0.003
> seconds
> Read Local OOB Data - Success SSP                    Passed       0.003
> seconds
> Read Local OOB Data - Success SC                     Passed       0.003
> seconds
> Device Found - Advertising data - Zero padded        Passed       1.017
> seconds
> Device Found - Advertising data - Invalid field      Passed       1.013
> seconds
> Read Ext Advertising Features - Success 3 (PHY flags) Passed       0.006
> seconds
> Add Ext Advertising - Invalid Params 1 (Multiple Phys) Passed       0.005
> seconds
> Add Ext Advertising - Invalid Params 2 (Multiple PHYs) Passed       0.005
> seconds
> Add Ext Advertising - Invalid Params 3 (Multiple PHYs) Passed       0.004
> seconds
> Add Ext Advertising - Invalid Params 4 (Multiple PHYs) Passed       0.004
> seconds
> Add Ext Advertising - Success 1 (Powered, Add Adv Inst) Passed       0.005
> seconds
> Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) Passed       0.004
> seconds
> Add Ext Advertising - Success 3 (!Powered, Adv Enable) Passed       0.004
> seconds
> Add Ext Advertising - Success 4 (Set Adv on override) Not Run
> Add Ext Advertising - Success 5 (Set Adv off override) Passed       0.004
> seconds
> Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) Passed       0.004
> seconds
> Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  Passed       0.006
> seconds
> Add Ext Advertising - Success 8 (Connectable Flag)   Passed       0.004
> seconds
> Add Ext Advertising - Success 9 (General Discov Flag) Passed       0.004
> seconds
> Add Ext Advertising - Success 10 (Limited Discov Flag) Passed       0.004
> seconds
> Add Ext Advertising - Success 11 (Managed Flags)     Passed       0.004
> seconds
> Add Ext Advertising - Success 12 (TX Power Flag)     Passed       0.004
> seconds
> Add Ext Advertising - Success 13 (ADV_SCAN_IND)      Passed       0.004
> seconds
> Add Ext Advertising - Success 14 (ADV_NONCONN_IND)   Passed       0.004
> seconds
> Add Ext Advertising - Success 15 (ADV_IND)           Passed       0.004
> seconds
> Add Ext Advertising - Success 16 (Connectable -> on) Passed       0.005
> seconds
> Add Ext Advertising - Success 17 (Connectable -> off) Passed       0.004
> seconds
> Add Ext Advertising - Success 20 (Add Adv override)  Passed       0.004
> seconds
> Add Ext Advertising - Success 21 (Timeout expires)   Not Run
> Add Ext Advertising - Success 22 (LE -> off, Remove) Passed       0.004
> seconds
> Add Ext Advertising - Success (Empty ScRsp)          Passed       0.004
> seconds
> Add Ext Advertising - Success (ScRsp only)           Passed       0.004
> seconds
> Add Ext Advertising - Invalid Params (ScRsp too long) Passed       0.005
> seconds
> Add Ext Advertising - Success (ScRsp appear)         Passed       0.004
> seconds
> Add Ext Advertising - Invalid Params (ScRsp appear long) Passed       0.004
> seconds
> Add Ext Advertising - Success (Appear is null)       Passed       0.004
> seconds
> Add Ext Advertising - Success (Name is null)         Passed       0.004
> seconds
> Add Ext Advertising - Success (Complete name)        Timed out    1.804
> seconds
> Add Ext Advertising - Success (Shortened name)       Timed out    2.001
> seconds
> Add Ext Advertising - Success (Short name)           Timed out    1.992
> seconds
> Add Ext Advertising - Success (Name + data)          Passed       0.004
> seconds
> Add Ext Advertising - Invalid Params (Name + data)   Passed       0.004
> seconds
> Add Ext Advertising - Success (Name+data+appear)     Passed       0.004
> seconds
> Add Ext Advertising - Success (PHY -> 1M)            Passed       0.004
> seconds
> Add Ext Advertising - Success (PHY -> 2M)            Passed       0.004
> seconds
> Add Ext Advertising - Success (PHY -> Coded)         Passed       0.004
> seconds
> Add Ext Advertising - Success (Ext Pdu Scannable)    Passed       0.004
> seconds
> Add Ext Advertising - Success (Ext Pdu Connectable)  Passed       0.004
> seconds
> Add Ext Advertising - Success (Ext Pdu Conn Scan)    Passed       0.004
> seconds
> Add Ext Advertising - Success (1m Connectable -> on) Passed       0.004
> seconds
> Add Ext Advertising - Success (1m Connectable -> off) Passed       0.004
> seconds
> Remove Ext Advertising - Invalid Params 1            Passed       0.004
> seconds
> Remove Ext Advertising - Success 1                   Passed       0.004
> seconds
> Remove Ext Advertising - Success 2                   Passed       0.004
> seconds
> Multi Ext Advertising - Success 1 (Instance Switch)  Not Run
> Multi Ext Advertising - Success 2 (Add Second Inst)  Not Run
> Get PHY Success                                      Passed       0.003
> seconds
> Set PHY 2m Success                                   Passed       0.003
> seconds
> Set PHY coded Succcess                               Passed       0.003
> seconds
> Set PHY 1m 2m coded Succcess                         Passed       0.004
> seconds
> Set PHY 2m tx success                                Passed       0.003
> seconds
> Set PHY 2m rx success                                Passed       0.003
> seconds
> Set PHY Invalid Param                                Passed       0.003
> seconds
> Start Discovery BREDR LE - (Ext Scan Enable)         Passed       0.004
> seconds
> Start Discovery LE - (Ext Scan Enable)               Passed       0.004
> seconds
> Start Discovery LE - (Ext Scan Param)                Passed       0.004
> seconds
> Stop Discovery - (Ext Scan Disable)                  Passed       0.004
> seconds
> Start Discovery - (2m, Scan Param)                   Passed       0.004
> seconds
> Start Discovery - (coded, Scan Param)                Passed       0.004
> seconds
> Start Discovery - (1m, 2m, coded, Scan Param)        Passed       0.004
> seconds
> Ext Device Found - Advertising data - Zero padded    Passed       1.019
> seconds
> Ext Device Found - Advertising data - Invalid field  Passed       1.015
> seconds
> Ext Adv. connectable & connected (slave) - Success   Not Run
> Ext Adv. non-connectable & connected (slave) - Success Not Run
> Ext Adv. connectable & connected (master) - Success  Not Run
> Ext Adv. non-connectable & connected (master) - Success Not Run
> Total: 406, Passed: 389 (95.8%), Failed: 3, Not Run: 14
> Overall execution time: 30.2 seconds
> Process 77 exited with status 1
>
> Running command tools/smp-tester
>
> Test Summary
> ------------
> SMP Server - Basic Request 1                         Passed       0.006
> seconds
> SMP Server - Invalid Request 1                       Passed       0.004
> seconds
> SMP Server - Invalid Request 2                       Passed       0.004
> seconds
> SMP Server - Invalid Request 3                       Passed       0.004
> seconds
> SMP Client - Basic Request 1                         Passed       0.003
> seconds
> SMP Client - Basic Request 2                         Passed       0.003
> seconds
> SMP Client - SC Request 1                            Passed       0.005
> seconds
> SMP Client - SC Request 2                            Passed       0.006
> seconds
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> Overall execution time: 0.0402 seconds
> Process 92 exited with status 0
>
> Running command tools/l2cap-tester
>
> Test Summary
> ------------
> Basic L2CAP Socket - Success                         Passed       0.004
> seconds
> Non-connected getpeername - Failure                  Passed       0.003
> seconds
> L2CAP BR/EDR Client - Success                        Passed       0.003
> seconds
> L2CAP BR/EDR Client SSP - Success 1                  Passed       0.004
> seconds
> L2CAP BR/EDR Client SSP - Success 2                  Passed       0.004
> seconds
> L2CAP BR/EDR Client PIN Code - Success               Passed       0.004
> seconds
> L2CAP BR/EDR Client - Read Success                   Passed       0.003
> seconds
> L2CAP BR/EDR Client - Write Success                  Passed       0.003
> seconds
> L2CAP BR/EDR Client - Invalid PSM 1                  Passed       0.003
> seconds
> L2CAP BR/EDR Client - Invalid PSM 2                  Passed       0.003
> seconds
> L2CAP BR/EDR Client - Invalid PSM 3                  Passed       0.003
> seconds
> L2CAP BR/EDR Client - Socket Shut WR Success         Passed       0.004
> seconds
> L2CAP BR/EDR Server - Success                        Passed       0.004
> seconds
> L2CAP BR/EDR Server - Read Success                   Passed       0.003
> seconds
> L2CAP BR/EDR Server - Write Success                  Passed       0.003
> seconds
> L2CAP BR/EDR Server - Security Block                 Passed       0.003
> seconds
> L2CAP BR/EDR Server - Invalid PSM                    Passed       0.003
> seconds
> L2CAP BR/EDR Server - Invalid PDU                    Passed       0.003
> seconds
> L2CAP BR/EDR Server - Invalid Disconnect CID         Passed       0.004
> seconds
> L2CAP BR/EDR Server - Invalid Config CID             Passed       0.003
> seconds
> L2CAP LE Client - Success                            Passed       0.003
> seconds
> L2CAP LE Client, Direct Advertising - Success        Passed       0.004
> seconds
> L2CAP LE Client SMP - Success                        Passed       0.004
> seconds
> L2CAP LE Client - Command Reject                     Passed       0.003
> seconds
> L2CAP LE Client - Connection Reject                  Passed       0.003
> seconds
> L2CAP LE Client - Close socket 1                     Passed       0.003
> seconds
> L2CAP LE Client - Close socket 2                     Passed       0.003
> seconds
> L2CAP LE Client - Open two sockets                   Passed       0.006
> seconds
> L2CAP LE Client - Open two sockets close one         Passed       0.005
> seconds
> L2CAP LE Client - Invalid PSM                        Passed       0.003
> seconds
> L2CAP LE Server - Success                            Passed       0.003
> seconds
> L2CAP LE Server - Nval SCID                          Passed       0.003
> seconds
> L2CAP Ext-Flowctl Client - Success                   Not Run
> L2CAP Ext-Flowctl Client, Direct Advertising - Success Not Run
> L2CAP Ext-Flowctl Client SMP - Success               Not Run
> L2CAP Ext-Flowctl Client - Command Reject            Not Run
> L2CAP Ext-Flowctl Client - Open two sockets          Not Run
> L2CAP Ext-Flowctl Client - Open two sockets close one Not Run
> L2CAP LE ATT Client - Success                        Passed       0.003
> seconds
> L2CAP LE ATT Server - Success                        Passed       0.003
> seconds
> Total: 40, Passed: 34 (85.0%), Failed: 0, Not Run: 6
> Overall execution time: 0.17 seconds
> Process 93 exited with status 0
>
> Running command tools/rfcomm-tester
>
> Test Summary
> ------------
> Basic RFCOMM Socket - Success                        Passed       0.004
> seconds
> Basic RFCOMM Socket Client - Success                 Passed       0.004
> seconds
> Basic RFCOMM Socket Client - Write Success           Passed       0.004
> seconds
> Basic RFCOMM Socket Client - Read Success            Passed       0.004
> seconds
> Basic RFCOMM Socket Client - Conn Refused            Passed       0.004
> seconds
> Basic RFCOMM Socket Server - Success                 Passed       0.004
> seconds
> Basic RFCOMM Socket Server - Write Success           Passed       0.004
> seconds
> Basic RFCOMM Socket Server - Read Success            Passed       0.006
> seconds
> Basic RFCOMM Socket Server - Conn Refused            Passed       0.004
> seconds
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
> Overall execution time: 0.0441 seconds
> Process 94 exited with status 0
>
> Running command tools/sco-tester
>
> Test Summary
> ------------
> Basic Framework - Success                            Passed       0.003
> seconds
> Basic SCO Socket - Success                           Passed       0.003
> seconds
> Basic SCO Get Socket Option - Success                Passed       0.003
> seconds
> Basic SCO Set Socket Option - Success                Passed       0.003
> seconds
> eSCO CVSD - Success                                  Passed       0.003
> seconds
> eSCO mSBC - Success                                  Passed       0.003
> seconds
> SCO CVSD 1.1 - Success                               Passed       0.003
> seconds
> SCO mSBC 1.1 - Failure                               Passed       0.003
> seconds
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> Overall execution time: 0.0312 seconds
> Process 95 exited with status 0
>
> Running command tools/bnep-tester
>
> Test Summary
> ------------
> Basic BNEP Socket - Success                          Passed       0.003
> seconds
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> Luiz Augusto von Dentz (10):
>   btdev: Rework command handling
>   bthost: Fix running request callbacks for remote requests
>   l2cap-tester: Fix L2CAP LE Server - Success
>   smp-tester: Fix not registering for MGMT_EV_USER_CONFIRM_REQUEST
>   shared/tester: Add option to filter by string
>   mgmt-tester: Update supported-features to not include HS
>   mgmt-tester: Print unexpected command responses
>   mgmt-tester: Update expected advertisement flags
>   hciemu: Fix crash when test is aborted during pre setup
>   bthost: Fix sending uninitilized data
>
>  emulator/btdev.c     | 6985 +++++++++++++++++++++++-------------------
>  emulator/bthost.c    |   33 +-
>  emulator/hciemu.c    |    8 +-
>  src/shared/tester.c  |   14 +
>  src/shared/util.h    |    1 +
>  tools/l2cap-tester.c |    4 +-
>  tools/mgmt-tester.c  |  203 +-
>  tools/smp-tester.c   |    4 +
>  8 files changed, 3996 insertions(+), 3256 deletions(-)
>
> --
> 2.26.2
>

Pushed.

-- 
Luiz Augusto von Dentz
