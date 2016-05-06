Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: connect() returning EINPROGRESS
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGup35xNHnGOeB2KT9n0oUBetqRJVygmHbNZBaNqu9HXw+98nA@mail.gmail.com>
Date: Fri, 6 May 2016 09:09:16 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ED3CFF35-4B10-403E-B435-4DD69A5DFB90@holtmann.org>
References: <CAGup35xNHnGOeB2KT9n0oUBetqRJVygmHbNZBaNqu9HXw+98nA@mail.gmail.com>
To: Allan Hessenflow <allan@flynixie.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Allan,

> I have a tool that was developed with bluez 4.101 and it works fine
> there.  Now I'm trying to get it to run on a different machine with
> bluez 5.37 and it is failing.  It communicates with a BLE device.  It
> first listens to advertising packets until it sees the device it is
> looking for, then does an hci_le_create_conn().  That much appears to
> work fine.  It creates a bluetooth socket, binds it (to BDADDR_ANY),
> and does a setsockopt() to set BT_SECURITY to BT_SECURITY_LOW.  All of
> that returns success.  Finally it does a connect().  That goes away
> for quite a while (I haven't timed it, something on the order of a
> minute) and then returns non-zero with errno set to EINPROGRESS.  I
> didn't explicitly set the socket to non-blocking and it certainly
> doesn't appear to be some implicitly set characteristic since it takes
> so long to return, so I don't know what EINPROGRESS could mean in this
> case.  Can anyone tell what I'm doing wrong?

do you have a dead simple proof-of-concept that can show this issue. I do not recall any of this issue. Have you tried it with the latest bluetooth-next kernel?

Regards

Marcel

