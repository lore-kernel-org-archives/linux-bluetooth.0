Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5DFA373E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 18:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiJYSAb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiJYSA3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 14:00:29 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55F8A1C8
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 11:00:27 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id u7so9228283qvn.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 11:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:message-id
         :in-reply-to:mime-version:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBym0GmomIZltoexJ1vfVZBoQS+pEtfn4uND5i/qKeI=;
        b=D0PZSZGIDNUHTZN7l90XgzsXb5xXTKGTSKCFKohseAjeegdCgsIaxUJYRd4OdYdtWW
         Td6hIWzLaZaHoRoa+0iprZaA+7t1Zr0OejsVWHi/SQPLGLKtuv72EkVNuqt7bh4LJBBq
         lh5V1XLG1zbtmg5OBiqWBc7A1G9qPwn9isNRRiqMVSJ67Y11PLm2gBbrzqLz+FSqts73
         gODZ+wtDjCpVGGKCjd2VjmeJzqF+e3OX+gnUjO9Bh+nlNMFY/15iUedUCEan4kd+isB8
         te3uXrrKmhlyKkbcb+0ERd9i+ZC9ZNQxQ76NvOd18rW+ZB3Yh6g3YsnfH7/sHRXoQbvN
         1QEg==
X-Gm-Message-State: ACrzQf06EJX0Z5+x5knK8KxtyUuNRrGlXSKt9IeD1nnHAvobXI9FACNB
        vUIlrbpF53Dr+FkqyFKT9dgCENverbwOr0fvxQg=
X-Google-Smtp-Source: AMsMyM6woIFQWzH39/kMe8fWV9JFuIgWte2L9A8Y4XjHrEPvKlChlyDBD/sIAjmaC8V1zNH+/+h1Kw==
X-Received: by 2002:a05:6214:252b:b0:4bb:60df:24e5 with SMTP id gg11-20020a056214252b00b004bb60df24e5mr14504697qvb.3.1666720825805;
        Tue, 25 Oct 2022 11:00:25 -0700 (PDT)
Received: from ffortso9 (c-73-238-129-126.hsd1.ct.comcast.net. [73.238.129.126])
        by smtp.gmail.com with ESMTPSA id q11-20020a05620a0d8b00b006f1187ca494sm2453934qkl.28.2022.10.25.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:00:25 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:00:24 -0400
From:   Jack <ostroffjh@users.sourceforge.net>
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
 unusable again with kernel 6.0
To:     linux-bluetooth@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
MIME-Version: 1.0
In-Reply-To: <ab082d3c-9ba6-b1bd-a895-65ea58cec926@molgen.mpg.de>
X-Mailer: Balsa 2.6.4
Message-Id: <O224FXKX.42565NIW.L5YD2R5Q@C37RPHFZ.QBNZTYLX.ESJXSIHV>
Content-Type: text/plain; charset=UTF-8; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2022.10.25 03:02, Paul Menzel wrote:
> Thank you for your work on this driver.
> 
> Am 24.10.22 um 23:11 schrieb Jack:
>> Cheap USB BT dongles that are bad clones of CSR  "ID 0a12:0001  
>> Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" have had  
>> historic problems, due to various bad behaviors.  See [Bug 60824]  
>> [PATCH][regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle  
>> unusable (https://bugzilla.kernel.org/show_bug.cgi) for more details  
>> and background.  The patch in that bug was initially mainlined in  
>> 5.9, and underwent several revisions since then.  It has continued  
>> to work through all of the 5.19 series, but it does not work with  
>> any of the 6.0 kernels.
>> 
>> I have made three unsuccessful attempts to git bisect using vanilla  
>> sources.  All settled on totally irrelevant commits.  These have all  
>> used v6.0-rc1 and v5.19 as the starting bad and good commits.
> 
Before receiving your reply, I made another start at bisect

# bad: [5030a9a03f0107f645772450bcba521b2ec19a51] dt-bindings: net:  
fsl,fec: Add nvmem-cells / nvmem-cell-names properties
# good: [8a958732818bc27f7da4d41ecf2c5c99d9aa8b0e] tls: rx: factor out  
device darg update
git bisect start '5030a9a03f0107f645772450bcba521b2ec19a51'  
'8a958732818bc27f7da4d41ecf2c5c99d9aa8b0e'
# good: [7ca433dc6dedb2ec98dfc943f6db0c9b8996ed11] Merge tag  
'net-5.19-rc8' of  
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 7ca433dc6dedb2ec98dfc943f6db0c9b8996ed11
# bad: [e168f690087735ad12604ee6ee2db1b93e323072] Bluetooth: btusb:  
Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for fake CSR
git bisect bad e168f690087735ad12604ee6ee2db1b93e323072
# good: [5fb859f79f4f49d9df16bac2b3a84a6fa3aaccf1] net: ipa: initialize  
ring indexes to 0
git bisect good 5fb859f79f4f49d9df16bac2b3a84a6fa3aaccf1
# good: [ec2ea5e06c67f85c6541a74b661722a176be086f] net: ipa: list  
supported IPA versions in the Makefile
git bisect good ec2ea5e06c67f85c6541a74b661722a176be086f
# good: [df332800a914e9fd97b83aa63832979227fd8a8d] Bluetooth:  
btmtksdio: Add in-band wakeup support
git bisect good df332800a914e9fd97b83aa63832979227fd8a8d
# good: [6f43f6169a8229bb6ddbf483d3be760d48c4cdd1] Bluetooth: clean up  
error pointer checking
git bisect good 6f43f6169a8229bb6ddbf483d3be760d48c4cdd1
# good: [46459cb6d4e63066e227a496ae8af35ba8c0b23b] Bluetooth: hci_bcm:  
Increase host baudrate for CYW55572 in autobaud mode
git bisect good 46459cb6d4e63066e227a496ae8af35ba8c0b23b
# good: [0feb8af0275d196a29e321bedc15319673923cb6] Bluetooth: hci_sync:  
Correct hci_set_event_mask_page_2_sync() event mask
git bisect good 0feb8af0275d196a29e321bedc15319673923cb6
# bad: [1172c59f451f524a14bac5e7b047781883dfe441] Bluetooth: btusb:  
Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
git bisect bad 1172c59f451f524a14bac5e7b047781883dfe441
# bad: [766ae2422b4312a73510ebee9266bc23b466fbbb] Bluetooth: hci_sync:  
Check LMP feature bit instead of quirk
git bisect bad 766ae2422b4312a73510ebee9266bc23b466fbbb
# first bad commit: [766ae2422b4312a73510ebee9266bc23b466fbbb]  
Bluetooth: hci_sync: Check LMP feature bit instead of quirk

And 766ae2422b4312a73510ebee9266bc23b466fbbb does make sense as a  
likely culprit.

> Thank you for trying to bisect the issue. Too bad, it’s inconclusive.  
> Did you or can you please test the commits below, relating to the  
> merges of the Bluetooth trees.
> 
> 1.  b8c3bf0ed2edf2deaedba5f0bf0bb54c76dee71d
> 2.  1d1ab5d39be7590bb2400418877bff43da9e75ec
> 3.  2e64fe4624d19bc71212aae434c54874e5c49c5a
> 4.  4a934eca7b39df35569f97a070701d6846ce46df
> 5.  14202eff214e1e941fefa0366d4c3bc4b1a0d500
> 6.  c69ecb0ea4c96b8b191cbaa0b420222a37867655
> 7.  6e0e846ee2ab01bc44254e6a0a6a6a0db1cba16d
> 8.  5588d628027092e66195097bdf6835ddf64418b3
Let me know if you think there is still any need to test these.
> 
>> Having read all the pages on filing a [REGRESSION} bug, I'm a bit  
>> intimidated to file something without sufficient information to be  
>> taken seriously, but will do so using this information, if that  
>> seems the best course of action.
> 
> Having the regression documented is the most important thing, and it  
> will be taken seriously even if the reporter has not fully analyzed  
> or solved it.
Questions on actually filing the bug:  my understanding is that as a BT  
bug, this list will be notified, or do I need to explicitly do  
anything.  Do I just add regressions@lists.linux.dev as a cc?

> 
> […]
> 
> 
> Kind regards,
> 
> Paul
Jack
