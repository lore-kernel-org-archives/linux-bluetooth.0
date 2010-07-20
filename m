Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Jul 2010 12:37:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Liang Bao <tim.bao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Virtual cable unplug not supported in BlueZ?
Message-ID: <20100720093732.GA3210@jh-x301>
References: <AANLkTimYuaveU7To6oLdtDLlxXIky1KU7QHMTD47Mwwh@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimYuaveU7To6oLdtDLlxXIky1KU7QHMTD47Mwwh@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 20, 2010, Liang Bao wrote:
> I have a question on "Virtual Cable Unplug" in current BlueZ version.
> 
> Currently BlueZ doesn't expose a D-Bus method in input/device.c for
> virtually unplug cable which is a mandatory requirement to pass
> TC_HOS_HCR_BV_03_I. Actually the support in kernel is already there.
> Can anyone give some insight to why this is not exposed at the DBUS
> API level like Connect/Disconnect/GetProperties? Can I think the
> reason behind this design is we only need one of "Disconnect" and
> "VirtualUnplug" to allow user to disconnect?

AFAIK the unplug should be sent when you do Adapter.RemoveDevice()

Johan
