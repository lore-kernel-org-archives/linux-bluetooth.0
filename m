Return-Path: <cyrus@holtmann.org>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL
 packets  with L2CAP_LM_RELIABLE
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 06:06:15 +0100
Message-ID: <1260335175.2901.20.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> Right now Bluez always requests flushable ACL packets (but does not
> set a flush timeout, so effectively they are non-flushable):
> 
> However it is desirable to use an ACL flush timeout on A2DP packets so
> that if the ACL packets block for some reason then the LM can flush
> them to make room for newer packets.
> 
> Is it reasonable for Bluez to use the 0x00 ACL packet boundary flag by
> default (non-flushable packet), and let userspace request flushable
> packets on A2DP L2CAP sockets with the socket option
> L2CAP_LM_RELIABLE.

the reliable option has a different meaning. It comes back from the old
Bluetooth 1.1 qualification days where we had to tests on L2CAP that had
to confirm that we can detect malformed packets and report them. These
days it is just fine to drop them.

You can not just blindly use ACL_START_FLUSHABLE without proper version
checking. This feature has been introduced later and will not work with
all stacks out there. Please go through the different spec. versions to
see the difference.

Regards

Marcel


