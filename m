Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201105171715.47064.alanbluetooth@aiaware.com>
References: <201105171715.47064.alanbluetooth@aiaware.com>
Date: Tue, 17 May 2011 23:00:53 +0530
Message-ID: <BANLkTinCkT1wXAUiuQz2jmgfGCHwmvhonw@mail.gmail.com>
Subject: Re: Does any one recognise this protocol? is it RF_COMM
From: James Steele <james.steele@kevel.org>
To: Alan <alanbluetooth@aiaware.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 17 May 2011 12:45, Alan <alanbluetooth@aiaware.com> wrote:
>
> What protocol is this?   Can it be RF_COMM ?

It looks like it is RFCOMM yes (at least it looks sane from my mental parser).

> Im pretty sure the   2b 20 20 00  is
> Protocol: “Core_V4.0.pdf” Figure 5.2: HCI ACL Data Packet   p429
> and 1c 00 8c 00
> is L2CAP  [size and channel ID].

Yes

> Does anyone recognise a protocol runnign on L2CAP that looks like this
>
> 09 ef 3f       Data        40   for inbound packets and
> 0b ff 2f 00    Data       86  for outbound packets

Yes - it's RFCOMM

> Note there are binary differences in both the L2CAP and RFCOMM parts.
> Most worrying to me is the missing 0.

I assume you mean the "extra" 00 in the "outbound packet" you
mentioned above?  If so then don't worry, that is the "credits" field
when RFCOMM is operating with credit based flow control - it's present
when the poll bit (0x10) is set in the control field for a UIH
(control field = 0xef).

> Any idea why the differences or where there is a reasonable document on what
> those RF_COMM bytes mean.

The RFCOMM specification gives a basic introduction, but the headers
can be quite gnarly since they are quite "packed" and there are quite
a few extension bits (with their frame structure changing properties.)
 The RFCOMM specification does have the simple frame structure
overview for the regular frames (Figure 5.1) and credit based flow
control frames (Figure 6.1) though .
Otherwise TS 07.10 - you can find it on 3GPP.

James
