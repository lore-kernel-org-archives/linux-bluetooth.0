Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ABEC77B73
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 18:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjD3SXz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 14:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjD3SXy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 14:23:54 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 999FFBB
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=Ez0gpkb/yqstiSG/r68v1EUGzTIO
        7KYZvnvljm0Lsto=; b=kp2OBQo/bVy1EVKA7epD0iPFSiAv3HMC4mtEhOVtAb79
        0K2N7MqrGtCgBjApHJeJnY1IfZkQkmZVdP+qRgB4jMIPvuc5rslfGrI1v8Xld+py
        LB6nVd5I4/PkKJ1zqwU+i4byQKDJgK79F8KMROyPOo33RajWpHva5JGxifOZ++M=
Received: from localhost (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogCXnmYqsk5kjbP2AA--.10460S2;
        Mon, 01 May 2023 02:23:44 +0800 (CST)
Date:   Mon, 1 May 2023 02:23:38 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: Bluetooth: Fix UAF in hci_conn_hash_flush again
Message-ID: <rr6fty7uos26m2yh4aphn4bd4q6nrbnjhgfi4kvah7llkuvycp@gryksomvznb4>
References: <20230430171847.156825-1-lrh2000@pku.edu.cn>
 <644eabeb.0c0a0220.1245d.fc0b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644eabeb.0c0a0220.1245d.fc0b@mx.google.com>
X-CM-TRANSID: 5oFpogCXnmYqsk5kjbP2AA--.10460S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWxGF45CFy3KFWDXw1rCrg_yoW8XF4kpa
        1UZwn8XrWvqry7ZrW093WjqF10gFnxuFW7t348XF17Aa4kKr13Ar1SvrWDuw4DCr409a4Y
        ya15Z340va1jq3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AAMsu
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Apr 30, 2023 at 10:56:59AM -0700, bluez.test.bot@gmail.com wrote:
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> Bluetooth: Fix UAF in hci_conn_hash_flush again
> WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
> #92: 
> Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8bb72f86fc823817bc5d
> 
> WARNING: Unknown link reference 'Closes:', use 'Link:' instead
> #93: 
> Closes: https://syzkaller.appspot.com/bug?extid=8bb72f86fc823817bc5d
> 

Well, CI is out of date, as the mainline has changed this from 'Link:' to
'Closes:' [1].

 [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44c31888098a590b8ec5ba37009e5a983f7c4b46

> CHECK: Alignment should match open parenthesis
> #163: FILE: net/bluetooth/hci_conn.c:2473:
> +	while ((conn = list_first_entry_or_null(head,
> +				struct hci_conn, list)) != NULL) {
> 
> total: 0 errors, 2 warnings, 1 checks, 57 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> /github/workspace/src/src/13227257.patch has style problems, please review.
> 
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.

Thanks,
Ruihan Li

