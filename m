Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E962AC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 16:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9912193E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600101490;
	bh=eMnr+X3ACCBlvUcal7w11UX5fuuRTjnCIruIdTho9mY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0Lb93op4hNF+KZ1BXs8++6OHz9nE0XidI/gxubjxkxPFNH7onsbxc07k7QiaYZT0x
	 N5hU8MelXoydmmAhYsSSv5HLeq5vRZyawAmbkRwCgkP3sm4mFIvfrshPrNEn248/Ha
	 iKjYSlsrX1naf5vj8yStLuKpsw3rrRuYOf2LYwmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgINQhb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 12:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgINPiQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 11:38:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28CD120EDD;
        Mon, 14 Sep 2020 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097881;
        bh=eMnr+X3ACCBlvUcal7w11UX5fuuRTjnCIruIdTho9mY=;
        h=From:To:Cc:Subject:Date:From;
        b=0Ax3veUWya2pauThyCeqC044APqyL6V/aqtPNVrTaTYfcQqtVxDnXxkIcr1psOgIM
         TTYoB4t4vYmxxKpa21YExO0UKGXlblUkC6KCLR4AbaHKorJkvArXPcCV4/ReplxRoa
         auKSCyMB+dvEXpOu5HePg0CKpK0OLbUQsm3atgvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 00/11] USB: new USB control message helper functions
Date:   Mon, 14 Sep 2020 17:37:45 +0200
Message-Id: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a recent discussion about a USB networking bug found by syzbot, and
fixed by Himadri Pandya, the design of the existing usb_control_msg()
call was brought up as not being the "nicest" thing to use by Dmitry
Vyukov:
        https://lore.kernel.org/r/CACT4Y+YbDODLRFn8M5QcY4CazhpeCaunJnP_udXtAs0rYoASSg@mail.gmail.com

The function makes it hard to get right, in that it will return the
number of bytes sent/received, but almost no one checks to see if a
short read/write happens.  With a malicious, or broken, USB device, this
can cause drivers to act on data that they did not anticipate, and
sometimes copy internal kernel data out to userspace.

So let's fix this up by creating two new functions,
usb_control_msg_send() and usb_control_msg_recv().  These functions
either complete the full transation, or they return an error, a short
send/recv is now an error.

They also accept data off of the stack, saving individual drivers the
pain of having to constantly allocate memory on their own for tiny
messages, thereby saving overall kernel code space.

The api also does not require a raw USB "pipe" to be sent to the
function, as we know the direction, so just pass in the endpoint number
instead, again making it easier on the USB driver author to use.

This series first takes a helper function out of the sound core for
verifying USB endpoints to be able to use internally, and then adds the
new functions, converts over some internal USB code to use them, and
then starts to clean up some drivers using these new functions, as an
example of the savings that can happen by using these functions.

Thanks to Dmitry and Himadri for the idea on how to do all of this.

greg k-h

-----

Changes from v2:
	- add Andy's reviewed-by: to patch 3
	- remove unneeded change in usb_enable_link_state() in hub.c
	  in patch 4

Changes from v1:
        - added acks from Takashi Iwai
        - dropped changes to one function in patch 04 thanks to review
          from Alan Stern
        - typo fix in comment in patch 01
        - added new patch 11 to remove some unneeded checks in the sound
          drivers for endpoint statuses that would always be true.



Greg Kroah-Hartman (11):
  USB: move snd_usb_pipe_sanity_check into the USB core
  USB: add usb_control_msg_send() and usb_control_msg_recv()
  USB: core: message.c: use usb_control_msg_send() in a few places
  USB: core: hub.c: use usb_control_msg_send() in a few places
  USB: legousbtower: use usb_control_msg_recv()
  sound: usx2y: move to use usb_control_msg_send()
  sound: 6fire: move to use usb_control_msg_send() and
    usb_control_msg_recv()
  sound: line6: move to use usb_control_msg_send() and
    usb_control_msg_recv()
  sound: hiface: move to use usb_control_msg_send()
  Bluetooth: ath3k: use usb_control_msg_send() and
    usb_control_msg_recv()
  ALSA: remove calls to usb_pipe_type_check for control endpoints

 drivers/bluetooth/ath3k.c       |  90 +++++------------
 drivers/usb/core/hub.c          |  99 ++++++++----------
 drivers/usb/core/message.c      | 171 ++++++++++++++++++++++++++++----
 drivers/usb/core/urb.c          |  31 ++++--
 drivers/usb/misc/legousbtower.c |  60 ++++-------
 include/linux/usb.h             |   7 ++
 sound/usb/6fire/firmware.c      |  38 +++----
 sound/usb/helper.c              |  16 +--
 sound/usb/helper.h              |   1 -
 sound/usb/hiface/pcm.c          |  14 ++-
 sound/usb/line6/driver.c        |  69 +++++--------
 sound/usb/line6/podhd.c         |  17 ++--
 sound/usb/line6/toneport.c      |   8 +-
 sound/usb/mixer_scarlett_gen2.c |   2 +-
 sound/usb/quirks.c              |  12 +--
 sound/usb/usx2y/us122l.c        |  42 ++------
 16 files changed, 336 insertions(+), 341 deletions(-)

-- 
2.28.0

