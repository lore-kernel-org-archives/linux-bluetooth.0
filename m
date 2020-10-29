Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4DC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 22:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5B320838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 22:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxKM4iE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJ2WC4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WCz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 18:02:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC7AC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 15:02:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f37so3764829otf.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5QCluBo6ybsY8bYrZeCjOpzXSoNHmB7Uf9kJ1jZoen8=;
        b=RxKM4iE+Lv6kWfR7WECoSd7kKuzlCFtE0CWvJYThl8IhBR51uT4I+wA+PB4I7k2woS
         /8rm3n847p17XMcb18WxoiY82jEGlfT24yzsSjjYz8TopBTDB7SJm0R5pWTTj4gQ1HZt
         7GQ9rzI5JiwLSltfR/wqE79VU2DzVP+IMGXZ4deqZ363qY3oGbz83121WT5vVhnq2pMN
         Ae9Gz00UsvOsYbFkQk+BszxgtsIWHr+J7zvNzPO0vsWwZXdwvjzwhbfLUJgobzWyPhPx
         TfyxzhsT2rGUdk54wIjKpQ3LcKtlM4TrtoJlWtb/k1OHWt7Ln4NnvXtJ84MBx0boJvya
         vAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5QCluBo6ybsY8bYrZeCjOpzXSoNHmB7Uf9kJ1jZoen8=;
        b=L7GtFdhknmieK1QvwZbMCsRitl0mHyGX5PN3Gpud4YtU4rSJy5IH+UACffwA6scxXi
         iVv7jVzNOJHhN8yANOjWeSxmyKTkoHykxf0GPfbKXdptU0g4hml+2abf9h4I3HkxnHEp
         T18c9KVqfZbKtAa2IVIDWH6e3IVKFeqx6fBgyiCcY9SsRy/a+KgfW+5X56nj9K1Kx6j0
         EHfBkKRdwL1R6q9A9Eui4XBkyMqUoDgVrLLEPpM/d+KYXzUXbOsTOLP7YivgH/t05OeZ
         NNScElfppfvoh5T9iPw0MzTU40s8m0u6zx1TCLKjwTOIJLrSSchTLXaHjI1QvEdw8AMz
         78pQ==
X-Gm-Message-State: AOAM533Ww2imXn6RzjEm/4eT+9mBSqS+UM3h4RjXf5HVsVO6zDDav076
        +1El2b2jRUv9FmZSx/aqZpyHr06kAO5feWJEsHo=
X-Google-Smtp-Source: ABdhPJzA6FT/06A6W+uo9a+xTsdEyfNiJgaSwry0vkZDMRc4BZt0rkWYtLYgfM9T8if5rWDuSul5L0E5Jf3RcPKlqHc=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr4673268otq.240.1604008975032;
 Thu, 29 Oct 2020 15:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Oct 2020 15:02:44 -0700
Message-ID: <CABBYNZKN1em3O=WFRNGtmhR2yJ79=7Qa16ym-EzUMKdt=k5naw@mail.gmail.com>
Subject: Re: [Bluez PATCH v5 00/10] Bluetooth: Add new MGMT interface for
 advertising add
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Thu, Oct 29, 2020 at 2:27 PM Daniel Winkler <danielwinkler@google.com> w=
rote:
>
> Hi Maintainers,
>
> This patch series defines the new two-call MGMT interface in userspace
> for adding advertising instances. Bluez will detect if kernel supports
> the new MGMT commands, and use them if so. Each new advertising instance
> will be configured by a MGMT call to set advertising parameters,
> followed by a MGMT call to set advertising data. The new data pipeline
> is meant to be unnoticeable from the clients' perspective, with the
> exception of new intervals and tx power support, and new exposed
> advertising manager properties.
>
> All changes have been tested on hatch (extended advertising) and kukui
> (no extended advertising) chromebooks with manual testing verifying
> correctness of parameters/data in btmon traces, and our automated test
> suite of 25 single- and multi-advertising usage scenarios.
>
> V2 of the series puts documentation at the front as requested.
>
> Thank you in advance for your review!
> Daniel Winkler
>
>
> Changes in v5:
> - Changed interval API from jiffies to milliseconds for clarity
> - Changed new dbus endpoints to be experimental
> - Only parse new properties if experimental flag is set
> - Verify capabilities MGMT command is supported before calling it
> - Make SupportedCapabilities experimental
>
> Changes in v4:
> - mgmt-api: moved optional params into 'flags' field
> - mgmt-api: added info for new return parameters for max data size
> - mgmt-api: Move Controller Capabilities MGMT doc into new patch
> - mgmt-api: Tx Power range put into single capabilities entry
> - Moved optional params into flags field
> - Use returned max data length in adv data length check
> - Move tx power range into single capability field
>
> Changes in v3:
> - Removed Tx Power Selected MGMT event
> - Changed Read Security Info cmd to  Read Controller Capabilities
> - Added selected tx power to MGMT params response
> - Removed Tx Power Selected MGMT event from monitor
>
> Changes in v2:
> - Removed extra space in Add Extended Advertising Parameters API
> - Uses btd_has_kernel_features to detect kernel command support
> - Cleaned fail path in add_adv_params_callback
>
> Daniel Winkler (10):
>   doc/advertising-api: update API with new interface
>   doc/mgmt-api: Add new Advertising MGMT interfaces to mgmt-api
>   doc/mgmt-api: Update controller capabilities MGMT command in mgmt-api
>   advertising: Detect if extended advertising mgmt commands are
>     supported
>   advertising: Parse intervals and tx power from adv
>   advertising: Use new mgmt interface for advertising add
>   advertising: Query LE TX range at manager initialization
>   advertising: Expose SupportedCapabilities for advertising
>   client: Add SupportedCapabilities to bluetoothctl
>   monitor: Add new MGMT adv commands and events to monitor
>
>  client/main.c           |   1 +
>  doc/advertising-api.txt |  48 +++++
>  doc/mgmt-api.txt        | 238 +++++++++++++++++++++-
>  lib/mgmt.h              |  46 ++++-
>  monitor/packet.c        |  69 ++++++-
>  src/adapter.c           |   8 +
>  src/adapter.h           |   2 +
>  src/advertising.c       | 428 ++++++++++++++++++++++++++++++++++++++--
>  tools/btmgmt.c          |  12 +-
>  9 files changed, 819 insertions(+), 33 deletions(-)
>
> --
> 2.29.1.341.ge80a0c044ae-goog

[detached HEAD 1cfa60010] advertising: Detect if extended advertising
mgmt commands are supported
 Author: Daniel Winkler <danielwinkler@google.com>
 Date: Thu Oct 29 14:23:29 2020 -0700
 3 files changed, 8 insertions(+)
Executing: make -j12
...
src/adapter.c: In function =E2=80=98read_commands_complete=E2=80=99:
src/adapter.c:9569:8: error: =E2=80=98MGMT_OP_ADD_EXT_ADV_PARAMS=E2=80=99 u=
ndeclared
(first use in this function); did you mean =E2=80=98MGMT_OP_SET_S?
 9569 |   case MGMT_OP_ADD_EXT_ADV_PARAMS:
      |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |        MGMT_OP_SET_SCAN_PARAMS


Please make sure that each individual patch do compile properly, this
ensures the patches can be bisected/reverted cleanly, also it looks
the last patch of the series do need a rebase since I just applied a
few patches to monitor.

--=20
Luiz Augusto von Dentz
