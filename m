Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [BUG] HCI_RESET and Num_HCI_Command_Packets limit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGd9gwiBts9DE8taJ_MzpCsho6Eh7hsq1Eq7g7WbZySaHMfnSg@mail.gmail.com>
Date: Tue, 25 Jun 2013 06:33:00 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Message-Id: <5C1A422A-58B6-47C7-A285-4BFD7D478B97@holtmann.org>
References: <CAGd9gwhd4DuEw_jHJAZF99YwNT==-s9yW6KEkZ_A2w+eeFy88w@mail.gmail.com> <6D8CE567-F4C5-42BE-8E0E-5D558E9C439D@holtmann.org> <CAGd9gwjLr8vhqXNW0ALBsfpjZ+Rnt0bhif1sHDExqT7Syc4NFA@mail.gmail.com> <38279439-FECC-452A-9514-A431580DFA7C@holtmann.org> <CAGd9gwjHXfcG6uaZYmoV2y+ymCX4PzCvuvA1mwT00wOExkwXmg@mail.gmail.com> <8D8512CF-7924-48A3-9B8E-78145262DA99@holtmann.org> <CAGd9gwiBts9DE8taJ_MzpCsho6Eh7hsq1Eq7g7WbZySaHMfnSg@mail.gmail.com>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>>>> I can't say this for sure, but if this is our fault and not a hardware issue then this seems to be a pretty nasty race condition.
>>>> 
>>>> To debug this you might need to work with dynamic_debug for Bluetooth core and add a few more DBG statements so we get timing information that we can compare with the btmon trace.
>>>> 
>>>> So in theory all modern chips should send HCI_Reset on devup. Only a few old broken ones will send HCI_Reset on devdown. Can you check that the ath3k does not send a quirk here and really does HCI_Reset on devup. And that the ath3k firmware loading part not accidentally gets in the way.
>>>> 
>>>> It would be also good to verify if devup or devdown is the root cause here.
>>> 
>>> I don't understand how this could be a hardware problem. I must be
>>> missing something. The host is sending to the controller two
>>> consecutive commands, the second one is a HCI_Reset caused by the
>>> power off/on, but the spec says that we should not send more than one
>>> command at that point (ncmd of the last event is 1). So, since we are
>>> out of spec the firmware is happy to block itself in a bad way :)
>>> right?
>> 
>> It is most likely our bug. Sometimes the hardware does however behave funny.
>> 
>> My guess right now is that you are hitting a really nasty race conditions and in ath3k chips is shows up easier since the command processing is slower.
>> 
>> So in hci_do_dev_close() we forcefully set the cmd_cnt to 1. And in case of HCI_QUIRK_RESET_ON_CLOSE we are sending a HCI Reset from close.
>> 
>> Before we go ahead with this, I like you to confirm what HCI Reset behavior you actually have for your hardware. HCI Reset on devup or on devdown. Check your full btmon where we send the HCI Reset.
>> 
>> What we might need to do different here is to check if we have a pending command, flush all other commands and then wait for this command to complete before sending HCI Reset.
>> 
>> So in theory that HCI Request Lock should protect the whole init and shutdown procedures and all mgmt and ioctl interfaces should block each other. Why this is not the case is something else to investigate. Maybe we have some issue there as well.
> 
> I enabled dynamic debug on this kernel. Again, I'm running 3.8.11. I
> added a debug line to check HCI_QUIRK_RESET_ON_CLOSE and
> "test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)" evaluates to 0; so
> the reset is sent during device up. Nevertheless, the bug is because a
> combination of both:
> 
> The timelime for the bug is the following.
> 1. Due a previous "btmgmt power on" we are interacting with the
> bluetooth controller. There are 3 commands queued. The last command
> sent was a HCI_Write_Scan_Enable.
> 2. The Command complete event for HCI_Write_Scan_Enable is received,
> with status = 0 and ncmd = 1
> 3. The following command on the queue goes out (a
> HCI_Write_Class_of_Device, but is irrelevant). Two other commands
> remain in the queue.
> 4. We have bad luck and "btmgmt power off" is executed. This opens a
> mgmt socket and sends the power off. hci_dev_do_close gets called as a
> consequence of this.
> 5. hci_dev_do_close clears the cmd, rx and tx queues in the kernel,
> and sets the cmd_cnt to 1, even if the current command
> (HCI_Write_Class_of_Device in this case) did not finish. From this
> point we have an inconsistent state, since cmd_cnt is 1, but we are
> not allowed to send a command to the adapter.

I think this forcefully setting cmd_cnt to 1 is actually a problem when we have pending commands.

You can trigger this via ioctl and also rfkill since both go via hci_dev_do_close to shutdown the handling of the device.

We need to wait for the command timeout of the pending command. While we could pretend that the ioctl is deprecated and should not be used, but rfkill clearly isn't. And honestly hciconfig hci0 up/down is way to useful for low-level testing that it might not go away any time soon.

> 6. We have even more bad luck, and "btmgmt power on" is executed. This
> causes, eventually, hci_dev_open to be called which schedules a
> HCI_Reset command (and a few more that are queued).
> 7. The HCI_Reset command is sent to the Bluetooth Controller since cmd_cnt is 1.
> 
> The dmesg log (with opcode anotations) is included below. I don't see
> any hci_rx_work after step 2 in the log.
> Running this with usbmon shows that the two commands are being sent
> without the event received in the middle.
> 
> I agree with Marcel that the right fix should be to wait until we
> receive the completion event from the adapter. I'm certainly not very
> familiar with this code, but I'll try to hack it =) Suggestions are
> welcomed!

Check if you have the patch that Johan mentioned in your tree. That should at least fix the problem when using mgmt. It is a bit funky, but at least mgmt power off will be blocked until you mgmt power on finished and thus should make this race a lot harder trigger.

Regards

Marcel

