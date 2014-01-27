Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jan 2014 11:45:24 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Rename adapter_remove_device to btd_adapter_remove_device
Message-ID: <20140127194524.GA12181@x220.p-661hnu-f1>
References: <20140125005506.7AD85100900@puck.mtv.corp.google.com>
 <20140125221329.GB14531@x220.p-661hnu-f1>
 <CAGXr9JHEe+9gu-giUF=iH4LAv=FAAutYPeFY483DQU2r40wmkg@mail.gmail.com>
 <20140127181307.GB7831@x220.p-661hnu-f1>
 <CAGXr9JGm1OUnPHdM=m6nH66xQVjUgL=P3zmwJp-aj2f9whbEpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXr9JGm1OUnPHdM=m6nH66xQVjUgL=P3zmwJp-aj2f9whbEpQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Mon, Jan 27, 2014, Petri Gynther wrote:
> Once BlueZ host and the remote have been paired successfully the first
> time, the remote has a key combination available that allows it to be
> unpaired and reset to initial state. But, BlueZ won't know about that.
> It still considers the remote paired. Thus, when the BD address
> arrives to the IR-assist plugin again, the plugin needs to clear all
> old state from BlueZ side and start over as if the device had never
> been discovered before.
> 
> The old device removal and new device creation are handled in the
> plugin, since the device creation part is not possible over D-Bus.
> However, once the device is created, the pairing is handled in a
> separate Python script.

Fair enough. I've now applied the patch.

Btw, please don't use top-posting on this list. It makes it difficult to
track the discussion when we've got inline quoting and top posting mixed
together.

Johan
