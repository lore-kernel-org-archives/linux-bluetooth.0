Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89472C4708E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Jan 2023 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjACWcL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Jan 2023 17:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbjACWcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Jan 2023 17:32:01 -0500
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD5265A
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 14:31:59 -0800 (PST)
Received: from github.com (hubbernetes-node-3101d95.va3-iad.github.net [10.48.204.27])
        by smtp.github.com (Postfix) with ESMTPA id DF0EAE022E
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 14:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1672785118;
        bh=7bLvmWkeVj4ALbmTaraKOQz0A60QJgL0RGujOhBcjeA=;
        h=Date:From:To:Subject:From;
        b=Afpk5r5TE4607cBtztfKisrS9crJgDWtAWwT/2kc8VNL0OSFyOO439x/eC5REfpEu
         yuUr2Mp75aa0Osa+mSPGEdJf84+9OJScRxm24RvXPZcGJu9LvxwZ3LdSrHZ9dMLr8t
         vAGA2t4+C1UicA0Iftn2AuHPkxcmvOkE9/vcVRXc=
Date:   Tue, 03 Jan 2023 14:31:58 -0800
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/90a662-7a32f2@github.com>
Subject: [bluez/bluez] 5abd99: shared/crypto: Adds bt_crypto_sih
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5abd9914a1eb23e7d2b985516453f1fe7559c79f
      https://github.com/bluez/bluez/commit/5abd9914a1eb23e7d2b985516453f1fe7559c79f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-21 (Wed, 21 Dec 2022)

  Changed paths:
    M src/shared/crypto.c
    M src/shared/crypto.h

  Log Message:
  -----------
  shared/crypto: Adds bt_crypto_sih

This adds bt_crypto_sih is is used to create a hash as stated on
CSIS[1] spec:

  '4.7. Resolvable Set Identifier hash function sih'

https://www.bluetooth.com/specifications/csis-1-0-1/


  Commit: 09293fd22b3edb825a268fbf28480f4e3a53a1e9
      https://github.com/bluez/bluez/commit/09293fd22b3edb825a268fbf28480f4e3a53a1e9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-21 (Wed, 21 Dec 2022)

  Changed paths:
    M unit/test-crypto.c

  Log Message:
  -----------
  test-crypto: Add /crypto/sih test

This adds test /crypto/sih which validas the implementation of
bt_crypto_sih using the sample data from CSIS[1] spec:

  A.1. sih Resolvable Set Identifier hash function

> unit/test-crypto -s "/crypto/sih"
  K:
    cd cc 72 dd 86 8c cd ce 22 fd a1 21 09 7d 7d 45  ..r....."..!.}}E
  R:
    63 f5 69                                         c.i
  Expected:
    da 48 19                                         .H.
  Result:
    da 48 19                                         .H.

[1] https://www.bluetooth.com/specifications/csis-1-0-1/


  Commit: a38b6ca525b392c7ad7e04368abd48ddc64b2142
      https://github.com/bluez/bluez/commit/a38b6ca525b392c7ad7e04368abd48ddc64b2142
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-22 (Thu, 22 Dec 2022)

  Changed paths:
    M src/shared/crypto.c
    M src/shared/crypto.h

  Log Message:
  -----------
  shared/crypto: Adds bt_crypto_sef

This adds bt_crypto_sef is is used to create a hash as stated on CSIS
spec:

  '4.5. SIRK encryption function sef'

https://www.bluetooth.com/specifications/csis-1-0-1/


  Commit: 051ccb1e878be5451603c8ea2a3820e759281724
      https://github.com/bluez/bluez/commit/051ccb1e878be5451603c8ea2a3820e759281724
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-22 (Thu, 22 Dec 2022)

  Changed paths:
    M unit/test-crypto.c

  Log Message:
  -----------
  test-crypto: Add /crypto/sef test

This adds test /crypto/sef which validas the implementation of
bt_crypto_sef using the sample data from CSIS[1] spec:

 A.2. sef SIRK Encryption Function

> unit/test-crypto -s "/crypto/sef"
  SIRK:
    cd cc 72 dd 86 8c cd ce 22 fd a1 21 09 7d 7d 45  ..r....."..!.}}E
  K:
    d9 ce e5 3c 22 c6 1e 06 6f 69 48 d4 9b 1b 6e 67  ...<"...oiH...ng
  Expected:
    46 d3 5f f2 d5 62 25 7e a0 24 35 e1 35 38 0a 17  F._..b%~.$5.58..
  Result:
    46 d3 5f f2 d5 62 25 7e a0 24 35 e1 35 38 0a 17  F._..b%~.$5.58..

[1]https://www.bluetooth.com/specifications/csis-1-0-1/


  Commit: 7a32f29180351dbac3727c7f4a08a577093ceddc
      https://github.com/bluez/bluez/commit/7a32f29180351dbac3727c7f4a08a577093ceddc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-22 (Thu, 22 Dec 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for decoding RSI

This adds support for decoding Resolvable Set Identifier[1] advertising
type (0x2e) according to CIS[2] spec:

        Resolvable Set Identifier: 46-BB-DB-26-D8-55
          Hash: 0x26d855
          Random: 0x46bbdb

[1] https://www.bluetooth.com/specifications/assigned-numbers/
[2] https://www.bluetooth.com/specifications/csis-1-0-1/


Compare: https://github.com/bluez/bluez/compare/90a662392c6e...7a32f2918035
