Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Sep 2010 16:45:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Pull request:
 git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
Message-ID: <20100929134521.GA19362@jh-x301>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Sep 23, 2010, Claudio Takahasi wrote:
>       Rename hciops {start, stop}_discovery to {start, stop}_inquiry

I'm not sure about this patch. Wasn't the idea to hide the device
discovery details from the higher layers? I.e. the method could be
called discovery and it'd take care of both BR/EDR and LE discovery
methods.

Johan
