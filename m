Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez 4.x, SCO socket - connection reset by peer
From: Marcel Holtmann <marcel@holtmann.org>
To: Rafael Seste <rseste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com>
References: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 May 2009 13:59:10 -0700
Message-Id: <1242853150.3147.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafael,

> I trying to use asterisk (with chan_mobile) to connect with my mobile phone.
> When there is a incoming/outgoing call, this module creates a
> sco_socket to send/receive audio packets.
> 
> socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)
> 
> when this socket is ready...it can write data once, after that when it
> tries to read an error is returned:
> 
> sco_read() error 104
> 
> 104 means - connection reset by peer
> 
> after this i got error 107 - not connect.
> 
> Some one knows why is the reason of this error 104???
> 
> kernel 2.6.22.18
> bluez 4.32

I don't know, but your kernel is ancient. Please re-test with 2.6.30-rc6
and bluez-4.40 to see if this error still persists.

Regards

Marcel


