Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 Nov 2014 20:15:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gilles =?iso-8859-1?Q?Gr=E9goire?= <gilles.gregoire@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Where in the code is a BLE connection accepted?
Message-ID: <20141122181505.GA14692@t440s.P-661HNU-F1>
References: <CANpMpoQoBhmprKEkrJrA1cdmwX=JvabtiJpm64hnxnR46MEFDA@mail.gmail.com>
 <CAHrH25RdVd0DWRy8Z6sheHvhYQtCcPJdyg0_2aVSisSCcG4S-g@mail.gmail.com>
 <CANpMpoQ+6W3Tz9fmeNiH2wL9c15dSFVhzRA2Dv920VXXD99U1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CANpMpoQ+6W3Tz9fmeNiH2wL9c15dSFVhzRA2Dv920VXXD99U1A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gilles,

On Sat, Nov 22, 2014, Gilles Grégoire wrote:
> I still find this a bit surprising: when using an l2capSocket, I still
> have to listen() and accept() the connection. One would expect that
> without anyone accept()'ing, the connection is not accepted!

E.g. ATT uses a fixed L2CAP channel, i.e. there is no L2CAP signaling
involved to establish it. Instead the channel is implicitly available
once the baseband link becomes available (i.e. through the LE Connection
Complete HCI event). There's therefore nothing to accept or reject as as
far as a fixed channel like ATT is concerned. If you were doing
Connection oriented Channels which have an actual L2CAP Connect
request/response pair the socket accept() would indeed map to the L2CAP
Connect Response.

Johan
