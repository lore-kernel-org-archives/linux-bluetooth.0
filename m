Return-Path: <cyrus@holtmann.org>
Message-ID: <1333097689.1870.249.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Clean up l2cap_chan_connect
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 30 Mar 2012 10:54:49 +0200
In-Reply-To: <1333094228-31591-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1333094228-31591-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Reduce number of arguments by two and in future by another one. All
> those parameters are passed inside L2CAP sockaddr_l2 pointer.

I am not sure that using sockaddr_l2 is a good idea. Are these socket
address structs used directly in other parts of the networking
subsystems anywhere?

Regards

Marcel


