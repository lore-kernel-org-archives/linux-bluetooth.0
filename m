Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Sep 2009 22:41:00 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Peter Hurley <phurley@charter.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [4.48] SDP Discovery not reset on error
Message-ID: <20090904193531.GA11406@jh-x301>
References: <4AA08357.7050903@charter.net> <20090904063104.GA23278@jh-x301> <4AA13234.5060909@charter.net> <20090904155536.GA5889@jh-x301> <4AA1533D.7090505@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AA1533D.7090505@charter.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Sep 04, 2009, Peter Hurley wrote:
> Maybe.  The race I'm observing may have something to do with your  
> auth_cb fix (tbh, I don't fully understand the sequence avdtp_confirm_cb  
> -> avdtp_connect_cb -> session_cb and how auth_cb fits in).
>
> Here's the daemon log (notice the "Transport endpoint is not connected
> (107)" errors):
>
<debug logs snipped>
> If this is related to the auth_cb fix, would you please explain how?

No, it doesn't look like it's related. The "Transport endpoint is not
connected" error is what's returned by the kernel when bluetoothd tries to
write to the AVDTP L2CAP socket. What kernel version are you running? I
remember us having a similar issue when the DEFER_SETUP socket option was
originally introduced. The output of hcidump might also reveal something
interesting.

Johan
