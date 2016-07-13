Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 13 Jul 2016 08:50:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Jacquemin <clement.jacquemin@epita.fr>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Connection handler and btmgmt/bluetoothctl
Message-ID: <20160713055005.GA30167@t440s.P-661HNU-F1>
References: <578439E0.5080703@epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <578439E0.5080703@epita.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Clément,

On Tue, Jul 12, 2016, Clément Jacquemin wrote:
> Another question about best practice. For the moment I use "btmgmt" to
> configure my daemon. However, the "bluetoothctl" binary seems to be a more
> stable alternative except that i cannot find any way to do the "le on"
> command as in "btmgmt".
> Is there any way to activate the low energy option with bluetoothctl?

bluetoothctl talks to bluetoothd and bluetoothd already automatically
enables LE support whenever it's reported to be supported by the kernel.

Johan
