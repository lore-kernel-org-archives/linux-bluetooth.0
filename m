Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 Jun 2011 17:52:01 -0300
Message-ID: <BANLkTi=9F=3gXcPte3NF-XA21C=Dkv04kw@mail.gmail.com>
Subject: LE supported host configuration using management
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We need a way to set the LE supported(host) bit using the management
interface. The question is: create a new command for this purpose only
or there are other adapter initialization settings planned to be
implemented? We could create a generic message passing all settings
once.

Even if the controller supports LE, we need a way to disable LE. The
current interleaved discovery implementation checks the if the
controller LE bit only, a correct implementation should check both:
controller and host bits. BlueZ has an option "EnableLE" in main.conf
used to control if the LE supported host bit should be set or not.

SPEC page 915 describe how this Write_LE_Host_Support command works.

Initially I thought that this bit could interfere/change the firmware
behavior, but it didn't, at least not for the hardwares that we have.
But the manufacturers are recommending to set and check it to avoid
IOP issues in the future.

Comments? New command or a generic management command?

Regards,
Claudio
