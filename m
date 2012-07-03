Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Jul 2012 10:45:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: bubba junk <junkbubba2@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Question For Devs: Is Headset Connection Automatic?
Message-ID: <20120703074527.GA23089@x220>
References: <CAMk70DBgaYSK5bMLPUR1c7Gf1xFO8px4fgtqqnQ1-qMXUOq3PA@mail.gmail.com>
 <CAFsbExJZd6w4-o4YZ82oeVLdRDr-tWhrNwN+zQv2WbJb6cKqUg@mail.gmail.com>
 <CAMk70DBXqUnXNkOSx9Cct7ATbCWWwXzbV1jFWNyBkULzNZ6dHA@mail.gmail.com>
 <CAMk70DCvRsuq7SN4dxY4Qo+saSzY8vsK1=5nDtuWA3cLGkcJWw@mail.gmail.com>
 <CAMk70DD7-wN9AdgoBsAcuQtCOGDL_wBa2YbYDOFaW0Xtgu8TYA@mail.gmail.com>
 <CAMk70DD3+26Q885KPbnim1Rj04=y9APOUOQM7teUNq95q7EPCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMk70DD3+26Q885KPbnim1Rj04=y9APOUOQM7teUNq95q7EPCw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

First of all, please don't top-post on this list.

On Mon, Jul 02, 2012, bubba junk wrote:
> I was wondering if you've had a chance to review the output of the
> hcidump and list-devices that you requested me to provide. I noticed
> the text "Connection refused - security block" in the output. Prior to
> the following patch, I was not able to connect my headset using the
> panel applet: [PATCH] Bluetooth: Fix l2cap connfailures for ssp
> devices. Since that patch, I am now able to connect the headset using
> the panel applet, but the headset does not connect automatically.
> Based on the output, is this another bug related to SSP?

I'll copy-paste it below:

> >> ACL data: handle 11 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 3 scid 0x0041
> > < ACL data: handle 11 flags 0x00 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
> >       Connection refused - security block
> >> HCI Event: Encrypt Change (0x08) plen 4
> >     status 0x00 handle 11 encrypt 0x01

This looks like a well known hardware bug where the controller doesn't
send HCI events and ACL data packets in the right order. If you had an
air sniffer you'd probably see that the link is encrypted *before* the
L2CAP Connect request is sent (as opposed to after it as the log above
indicates). For connect requests to non-SDP PSMs coming before an
encrypted link a security block response is the correct behavior for
BlueZ.

Johan
