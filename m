Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 20 May 2009 17:49:38 -0300
Message-ID: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com>
Subject: bluez 4.x, SCO socket - connection reset by peer
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I trying to use asterisk (with chan_mobile) to connect with my mobile phone.
When there is a incoming/outgoing call, this module creates a
sco_socket to send/receive audio packets.

socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)

when this socket is ready...it can write data once, after that when it
tries to read an error is returned:

sco_read() error 104

104 means - connection reset by peer

after this i got error 107 - not connect.

Some one knows why is the reason of this error 104???

kernel 2.6.22.18
bluez 4.32

tks
-- 
Rafael S. Seste
