Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jun 2013 08:38:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
Message-ID: <20130626053830.GA14698@x220>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
 <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org>
 <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
 <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org>
 <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com>
 <8D8512CF-7924-48A3-9B8E-78145262DA99@holtmann.org>
 <CAGd9gwiBts9DE8taJ_MzpCsho6Eh7hsq1Eq7g7WbZySaHMfnSg@mail.gmail.com>
 <5C1A422A-58B6-47C7-A285-4BFD7D478B97@holtmann.org>
 <CAGd9gwiQJf7T_PS=618N3NNErxWY5TiqOh-QBLxxAHGovxOYTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGd9gwiQJf7T_PS=618N3NNErxWY5TiqOh-QBLxxAHGovxOYTQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Tue, Jun 25, 2013, Alex Deymo wrote:
> I'm in 3.8.11 and I don't have that patch... and as I can see from the
> log in mgmt.c it is not going to apply... there are already several
> changes from this kernel to that point. But anyway... that won't fix
> the problem. The scenario is "send a command, btmgmt power off, btmgmt
> power on". The fact that the command was sent because a previous power
> on is not relevant, and bluetoothd normally sends more commands when
> it sees an interface going up that aren't covered by this lock (like
> Write EIR, Write Class of Device, Write Local Name)... right?

Not quite. What we do is program these values to the kernel as soon as
we discover a new adapter and before powering it on. After this
mgmt_set_powered takes care of actually "applying" the values as part of
the power on process. The patch I mentioned should ensure that the
kernel doesn't reply to the mgmt command before all of these HCI
commands have completed.

Of course this still doesn't fix the situation of an HCI command that's
pending that's not part of the power on process (e.g. changing the name
while powered on), so something will probably need to be done about that
anyway.

Johan
