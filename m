Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jan 2010 10:32:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Zotov <whitequark@whitequark.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Handset voice dial signalling patch
Message-ID: <20100113083247.GA18980@jh-x301>
References: <4B4D780F.1080405@whitequark.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B4D780F.1080405@whitequark.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 13, 2010, Peter Zotov wrote:
> I wrote a patch (attached) that makes dummy telephony interface send
> a DBus signal (through org.bluez.TelephonyTest interface) every time
> a voice dialing is started. It may be useful when you have only this
> button on a handset (e.g. SonyEricsson HBH602 owned by me) and want
> to answer some VoIP client call with it.

It sounds to me like you're working around another problem. I suspect
the issue you're facing is that you don't have a telephony driver that'd
keep the headset up-to-date with the current call state, so when you
want to answer a call the headset doesn't generate the right AT command
(ATA) since it doesn't know that there's an incoming call (instead, the
only command it manages to generate is the voice recognition one since
that's the default behaviour when the headset thinks that there are no
active or pending calls).

>From the perspective of adding voice recognition support the patch is a
step in the right direction, but it seems that's not the right way to
solve your issue (of answering incoming calls). You'd also need to add
the new telephony functions to the other drivers since they would fail
to build right now with the patch.

Johan
