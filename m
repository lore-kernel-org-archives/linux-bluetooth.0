Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Dec 2009 16:07:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] spurious disconnection attempt
Message-ID: <20091217140711.GA1481@jh-x301>
References: <eb7933e20912170544p2d07fc0endc0c50026e42f8c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <eb7933e20912170544p2d07fc0endc0c50026e42f8c1@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Dec 17, 2009, Daniel Örstadius wrote:
> The problem seems to be that bluetoothd still calls
> src/device.c:do_disconnect even though the link has been disconnected.
> Attaching a patch proposal for function device_remove_connection to
> try to avoid this. The function looks to be called only when there is
> no longer an hci connection to the remote.

Thanks! The patch looks good and I've pushed it upstream. In the future,
please pay a little bit more attention to your commit messages. Usually
we start the summary lines of bugfixes with "Fix.." and feature
additions with "Add.." or "Implement.." as well as include an
appropriately detailed description of the commit for any non-trivial
change. I now fixed the commit messages of your two latest patches
manually and you can check the result in the upstream git tree.

Johan
