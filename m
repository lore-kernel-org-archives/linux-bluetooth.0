Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Allow BT_SECURITY for L2CAP raw sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090220132346.GA5255@jh-x301>
References: <20090220132346.GA5255@jh-x301>
Content-Type: text/plain
Date: Fri, 20 Feb 2009 20:57:38 +0100
Message-Id: <1235159858.24255.4.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's the patch to permit BT_SECURITY for L2CAP raw sockets. It allows
> our BtIO code to be simpler since there's no need to do special L2CAP_LM
> tricks when doing paring using L2CAP raw sockets. It seemed to work fine
> in my tests (both SSP and legacy pairing) so if it's ok with you I'll
> also push the corresponding patch for bluetoothd (which without this
> patch would cause EINVAL when trying pairing on a newer kernel).

I pushed a little bit different version of the patch that only
explicitly allows SOCK_SEQPACKET and SOCK_RAW. In addition I did the
same for the getsockopt() case :)

Regards

Marcel


