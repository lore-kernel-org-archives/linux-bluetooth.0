Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B627EC282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8452620820
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 16:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/y6QydN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfAWQSz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:18:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36774 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQSy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 11:18:54 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so3753996itj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7gO5bphJWOtjqKBEIBru6WNt8o3SL1MOKLfIbqa/edk=;
        b=a/y6QydN3i9dlSATdeUgHFx32PFKX8MlO9uDbfL2a9Oc6iRN5erSnJIy0trx2YEEv6
         SlGxSQE3qmpG4VkSxYa6XaqAD5P2Ap2gHSNdy33766BVD6wrwwd9SZtdhuiHcz22Hc3r
         DEgvEz4pnRs3V2MM3uLCaXcbMpUtq0I2aJ/O3ShHGVgbBqJJXBiyG/BBs8FiU/sS2a9f
         ECdKnPtXtFPoi4nBoKJrW9IUk32oeVD+krtdEfSJ1FV0Hy7DJmJBUAWroSVXU0jnUAsT
         mMQNbLJUwXjjjJuodckWcA/nHJ3VG8NCGype/byWTW8K3a1/VpcsUfkHT+PGi/G+gX35
         XDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7gO5bphJWOtjqKBEIBru6WNt8o3SL1MOKLfIbqa/edk=;
        b=NApGmeYxo+6quSD9jC99PeVmtWpT0e9KjiVr6SfZK5Cp/T6i+eScB/UZ6F9EU86J1z
         dMjKoYPuUmH9Ktb+h3A4hgaBaOPeOUjy5eWEfw8q9nmKBrcN2exg7q7iDYadbKDo20DS
         aybllUGbo20jmyj5+ipgtdTfDwaKsHFnIpvljGXOyc8DjV6DYThY0bQ0OMtTOYlwVvpC
         Ft8XsvlrZZTzUvegHJJTQ55pP+SXAJPEgXmaMoYgUHLzUENcS63z89+c9iiSDe58fNAn
         MNoKWXZPsXnIyCjFz5tvgatBEPAse7ElQLhyV2g1OiuPzGXuPDgW4NVucfEz/+eNnqEk
         DT/w==
X-Gm-Message-State: AJcUukcYWC869GAbmvKSiQI35U0Vbqa1nb3OBh4fQC2b5AWreIi9gKzv
        pbokcS0HGACEsJ2CiO6MYkqund2suewaBT498GnOaNDG
X-Google-Smtp-Source: ALg8bN580p3ISQkhwjGIAlQC81IzWufm16Ss8KDzyL6XnlMHXc4alPuIqKhBE4bauDR4LXS0nWGJEzXl9VVH60a6KJw=
X-Received: by 2002:a24:5015:: with SMTP id m21mr1685051itb.2.1548260333779;
 Wed, 23 Jan 2019 08:18:53 -0800 (PST)
MIME-Version: 1.0
From:   Grigory Fateyev <gfborn@gmail.com>
Date:   Wed, 23 Jan 2019 19:18:42 +0300
Message-ID: <CAAOqupyyrt4_3=1-8rHVoWFAKLX=adE3PopwTfczUCga=4k7gg@mail.gmail.com>
Subject: Battery level of energy
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

I have a bluetooth headset Sony MDR-XB650BT.

# hcitool info 00:18:09:C5:44:1E
Requesting information ...
BD Address:  00:18:09:C5:44:1E
OUI Company: CRESYN (00-18-09)
Device Name: MDR-XB650BT
LMP Version: 4.0 (0x6) LMP Subversion: 0x2576
Manufacturer: Cambridge Silicon Radio (10)
Features page 0: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
<3-slot packets> <5-slot packets> <encryption> <slot offset>
<timing accuracy> <role switch> <hold mode> <sniff mode>
<park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
<power control> <transparent SCO> <broadcast encrypt>
<EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
<interlaced iscan> <interlaced pscan> <inquiry with RSSI>
<extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
<sniff subrating> <pause encryption> <AFH cap. master>
<AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
<3-slot EDR eSCO> <extended inquiry> <simple pairing>
<encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power>
<EPC> <extended features>
Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

I'd like to get the energy level at least in shell. In which direction
I should look for? How to know if my device has GATT support? If it
connected with Android smartphone, where Android version is < 6.0, it
has an icon with level in percents. I want to get the same on my linux
machine.

Thank you!

-- 
Grigory
