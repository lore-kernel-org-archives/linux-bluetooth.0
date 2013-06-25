Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Jun 2013 07:55:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
Message-ID: <20130625045512.GA29467@x220.P-661HNU-F1>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
 <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org>
 <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
 <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org>
 <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com>
 <8D8512CF-7924-48A3-9B8E-78145262DA99@holtmann.org>
 <CAGd9gwiBts9DE8taJ_MzpCsho6Eh7hsq1Eq7g7WbZySaHMfnSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGd9gwiBts9DE8taJ_MzpCsho6Eh7hsq1Eq7g7WbZySaHMfnSg@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, Jun 24, 2013, Alex Deymo wrote:
> The timelime for the bug is the following.
> 1. Due a previous "btmgmt power on" we are interacting with the
> bluetooth controller. There are 3 commands queued. The last command
> sent was a HCI_Write_Scan_Enable.

The kernel should only respond to the mgmt_set_powered once *all* HCI
commands are completed. Maybe you're missing the following patch from
your kernel:

commit 229ab39caf8c1321527e408725c1350f7c9aaa84
Author: Johan Hedberg <johan.hedberg@intel.com>
Date:   Fri Mar 15 17:06:53 2013 -0500

    Bluetooth: Wait for HCI command completion with mgmt_set_powered

Johan
