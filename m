Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 12:54:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ v0 0/4] Remove profile specific storage
Message-ID: <20121001095441.GA2423@x220.ger.corp.intel.com>
References: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Sep 28, 2012, Claudio Takahasi wrote:
> There is also a TODO file item: "Convert storage to user per-remote
> device directories and ini-file format". What is the idea? Should the
> core remove everything under the remote device address directory?

I hadn't thought of that previously (i.e. it's not the reason for the
proposed layout) but now that you mention it I think that'd be a nicer
way of handling this. I.e. let's let the core remove the per-device
directory and everything stored inside it so that the drivers themselves
do not need to differentiate between bluetoothd exit and device removal.

Johan
