Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5C1A422A-58B6-47C7-A285-4BFD7D478B97@holtmann.org>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com>
 <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org> <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com>
 <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org> <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com>
 <8D8512CF-7924-48A3-9B8E-78145262DA99@holtmann.org> <CAGd9gwiBts9DE8taJ_MzpCsho6Eh7hsq1Eq7g7WbZySaHMfnSg@mail.gmail.com>
 <5C1A422A-58B6-47C7-A285-4BFD7D478B97@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
Date: Tue, 25 Jun 2013 13:34:33 -0700
Message-ID: <CAGd9gwiQJf7T_PS=618N3NNErxWY5TiqOh-QBLxxAHGovxOYTQ@mail.gmail.com>
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jun 25, 2013 at 6:33 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>> I enabled dynamic debug on this kernel. Again, I'm running 3.8.11. I
>> added a debug line to check HCI_QUIRK_RESET_ON_CLOSE and
>> "test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)" evaluates to 0; so
>> the reset is sent during device up. Nevertheless, the bug is because a
>> combination of both:
>>
>> The timelime for the bug is the following.

>> 5. hci_dev_do_close clears the cmd, rx and tx queues in the kernel,
>> and sets the cmd_cnt to 1, even if the current command
>> (HCI_Write_Class_of_Device in this case) did not finish. From this
>> point we have an inconsistent state, since cmd_cnt is 1, but we are
>> not allowed to send a command to the adapter.
>
> I think this forcefully setting cmd_cnt to 1 is actually a problem when w=
e have pending commands.

Yes, but the problem is that if the driver powers down the controller
on close or the command complete event is in the rx_work queue (that
we just flushed) then we need to set this cmd_cnt to 1.

> You can trigger this via ioctl and also rfkill since both go via hci_dev_=
do_close to shutdown the handling of the device.
>
> We need to wait for the command timeout of the pending command. While we =
could pretend that the ioctl is deprecated and should not be used, but rfki=
ll clearly isn't. And honestly hciconfig hci0 up/down is way to useful for =
low-level testing that it might not go away any time soon.
>
>> I agree with Marcel that the right fix should be to wait until we
>> receive the completion event from the adapter. I'm certainly not very
>> familiar with this code, but I'll try to hack it =3D) Suggestions are
>> welcomed!
>
> Check if you have the patch that Johan mentioned in your tree. That shoul=
d at least fix the problem when using mgmt. It is a bit funky, but at least=
 mgmt power off will be blocked until you mgmt power on finished and thus s=
hould make this race a lot harder trigger.

I'm in 3.8.11 and I don't have that patch... and as I can see from the
log in mgmt.c it is not going to apply... there are already several
changes from this kernel to that point. But anyway... that won't fix
the problem. The scenario is "send a command, btmgmt power off, btmgmt
power on". The fact that the command was sent because a previous power
on is not relevant, and bluetoothd normally sends more commands when
it sees an interface going up that aren't covered by this lock (like
Write EIR, Write Class of Device, Write Local Name)... right?

I'll try to test that on a linux desktop with a recent compat-drivers
and an usb adapter.

Alex.
