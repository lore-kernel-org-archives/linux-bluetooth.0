Return-Path: <cyrus@holtmann.org>
Message-ID: <55CA52FC.5060001@gmail.com>
Date: Tue, 11 Aug 2015 22:54:36 +0300
From: Dmitry Tunin <hanipouspilot@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ath3k: Revert 7e730c7f3d1f39c25cf5f7cf70c0ff4c28d7bec7
References: <1439290229-6937-1-git-send-email-hanipouspilot@gmail.com> <96FCB7AC-6E4C-4ED1-8048-87843978A63B@holtmann.org> <55CA507F.9000205@gmail.com>
In-Reply-To: <55CA507F.9000205@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>



11.08.2015 22:43, Dmitry Tunin пишет:
> 
> 
> 11.08.2015 22:23, Marcel Holtmann пишет:
>> Hi Dmitry,
>>
>>> This patch causes infinite loop on loading firmware on Acer Aspire
>>> V3è371-31KW and probably other laptops.
>>>
>>> This is a serious regression, because system becomes unresponsive.
>>>
>>> This should be reverted until the firmware loading issue is sorted out.
>>
>> this needs a lot more explanation on why I am suppose to revert this now.
>>
>> And now I am really reluctant to have any ath3k patches marked as stable. If things are not tested properly, then please refrain from adding stable tags since these are clearly more than just VID/PID additions.
>>
>> Regards
>>
>> Marcel
>>
> 
> Here is the explanation.
> 
> This is a report I got from a user. He tried to write you too, but did not get a response.
> 
> ------------------------------quote-----------------------------
> 
> However, the same patch makes the same device enter a disconnect /
> reconnect infinite loop in my specific laptop model (Acer Aspire
> V3è371-31KW). The original poster of the duplicate, #1397885, also has
> an Acer Aspire and might be affected by the same issue (not sure about
> it). Sorry about commenting the duplicate if it was wrong.
> 
> On my laptop, the patch makes the firmware load into the device and it
> begins an infinite disconnect/reconnect cycle. The boot makes ages,
> lsusb freezes.
> 
> Under your kernel, the whole computer runs unstable. the login manager
> and X won't always start, the system takes ages to start, lsusb feezes
> and I get a log of the following with journalctl -xe.
> 
>   mai 02 19:21:00 white kernel: usb 1-5: new full-speed USB device
> number 49 using xhci_hcd
> mai 02 19:21:01 white kernel: usb 1-5: New USB device found,
> idVendor=04ca, idProduct=300d
> mai 02 19:21:01 white kernel: usb 1-5: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> mai 02 19:21:01 white kernel: usb 1-5: USB disconnect, device number 49
> mai 02 19:21:01 white kernel: usb 1-5: new full-speed USB device number
> 50 using xhci_hcd
> mai 02 19:21:01 white kernel: usb 1-5: New USB device found,
> idVendor=04ca, idProduct=300d
> mai 02 19:21:01 white kernel: usb 1-5: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> mai 02 19:21:01 white kernel: usb 1-5: USB disconnect, device number 50
> mai 02 19:21:01 white kernel: usb 1-5: new full-speed USB device number
> 51 using xhci_hcd
> mai 02 19:21:02 white kernel: usb 1-5: New USB device found,
> idVendor=04ca, idProduct=300d
> mai 02 19:21:02 white kernel: usb 1-5: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> mai 02 19:21:02 white kernel: usb 1-5: USB disconnect, device number 51
> mai 02 19:21:02 white kernel: usb 1-5: new full-speed USB device number
> 52 using xhci_hcd
> mai 02 19:21:02 white kernel: usb 1-5: New USB device found,
> idVendor=04ca, idProduct=300d
> mai 02 19:21:02 white kernel: usb 1-5: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> mai 02 19:21:02 white kernel: usb 1-5: USB disconnect, device number 52
> mai 02 19:21:03 white kernel: usb 1-5: new full-speed USB device number
> 53 using xhci_hcd
> mai 02 19:21:03 white kernel: usb 1-5: New USB device found,
> idVendor=04ca, idProduct=300d
> mai 02 19:21:03 white kernel: usb 1-5: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0
> mai 02 19:21:03 white kernel: usb 1-5: USB disconnect, device number 53
> mai 02 19:21:03 white kernel: usb 1-5: new full-speed USB device number
> 54 using xhci_hcd
> mai 02 19:21:03 white kernel: usb 1-5: New USB device found,
> idVendor=04ca, idProduct=300d
> mai 02 19:21:03 white kernel: usb 1-5: New USB device strings: Mfr=0,
> Product=0, SerialNumber=0"
> 
> I made a workaround which makes the device work by loading the patched
> modules, unload them and load the unpatched ones. The firmware being
> loaded, the unpatched modules are able to drive the device.
> 
> I sent a mail to the Bluetooth maintainer's mailing list last month, but
> for some reasons, it might have been unnoticed, I didn't received any reply.
> 
> I'm concerned for unexperienced users of this computer getting trouble
> with new kernels. If I can help, don't hesitate to ask me any
> information about by laptop.
> 
> Cheers,
> Raphaël.
> 
> ----------------------end of quote----------------------------------
> 
> I told him to write directly to maintainers and it seem that he has done it.
> 
> Before I got responses that the patch worked well. I sent it to you when it was tested by two users.
> 
> This issue is really weird, because it appears only on some laptops.
> Maybe it is related to the new Atheros firmware files, that can't be loaded properly in certain cases.
> 
> It's up to you to decide if marking for stable is appropriate, but before all AR devices ran smoothly and there seemed to be no 
> reason not to add them for stable.
> 
> I suggest a compromise. Not to add those devices that require the new firmware, because its loading really is not tested well.
> If some older devices are discovered, it is very unlikely that there may be any troubles.
> 
> I know that it is a pain in the ass to revert it from stable.
> 
> Another option is to leave it there, because probably if the firmware is not added, ath3k will just fail to find it and will not cause any trouble.
> The new firmware has not been added to linux-firmware yet.
> 
> But in this case any time the regression may appear as soon as they add it there. It seems not to be a good idea either.
> 
> Regards,
> 
> Dmitry
> 

And in addition I am adding a very good desription by Raphael

This is a workaround to make Bluetooth working on some computers
like Acer Aspire V3-371.

This WILL NOT FIX your problem reliably, so please stay tuned by writing an email
to raphael dot jakse at gmail dot com if you choose to skip the following
introduction (what you *should not* do).

This workaround has only been tested in Mint Linux and should apply to Ubuntu,
Debian and other Debian-like system as well. For other systems, some adaptations
might be necessary. Please ask if you need help for this.

0) INTRODUCTION

    a) PREREQUISITES: MINI HOW-TO FOR USING A TERMINAL

    If you know how to use a terminal, please skip this section.

    In order to test and install this workaround, it is necessary to know how to
    run commands in a terminal. If you don't, you should get help from somebody
    who does. Nonetheless, here is a basic introduction to using a terminal if
    you which to go by yourself.

    To open a terminal, find a terminal application in the menus of your
    computer. It is often in a "Accessories" or a "System" menu.

    Running a command basically means copy it in your terminal and then press
    the Enter key.

    The ls command shows the contents of the directory inside which the terminal
    is. To go to another directory named my_directory, use the the following
    command:

        cd my_directory

    To go back to the parent directory, run:

        cd ..

    For this workaround, the easiest way to open the terminal is to go to open
    the directory which was extracted from the archive you downloaded, right
    click on a blank area and choose an option like "Open a terminal here",
    maybe in an "actions" submenu, if this option exists.

    b) What is a workaround

    A workaround is a temporary fix to a problem. What is really important to
    understand is that it doesn't really fix the cause of the problem.

    So this workaround is unreliable in the long run. It can prevent Bluetooth
    from working in the long term on your computer if you upgrade it to a more
    recent system which fixes (or not) the problem, without uninstalling this
    workaround.

    This is why it is *important you stay tuned* by subscribing to the
    corresponding bug report or, at least, by writing an email to raphael dot
    jakse at gmail dot com so you can get information so everything goes well.

    DISCLAIMER: No guarantee or support can be given for this workaround. That
    said, this workaround should cause no harm to your system and does nothing
    dangerous. Anything it does can be reverted. If you are not sure, please ask
    help to someone who is likely more at ease than you for this kind of
    problems. If you have any question, don't hesitate to ask to the author of
    this workaround at the email address given in the previous paragraph.

    Please report any problem or any success with this workaround. I would be
    glad to hear about it and fix anything within the realms of possibility.

1) SYMPTOMS

    In this section, we check whether this workaround can help you. Your
    situation should be the following:

    a) The Bluetooth icon appears on the system but no Bluetooth device can be
    discovered, and other Bluetooth devices don't see the computer even though
    your Bluetooth adapter seems to be recognized

    ==== OR, on very new Linux systems (after Spring of 2015) ====

    b) The computer takes ages to start, and Bluetooth isn't working.

    If your computer has one of these symptoms, it is likely this workaround is
    for you.

2) CHECKING MORE SERIOUSLY THAT YOU ARE CONCERNED

    a) First, in a terminal, please run the following two commands:

        sudo modprobe -r btusb

        sudo modprobe -r ath3k

    These commands unload the kernel modules which handle the device. This is
    not strictly mandatory, but in newest kernel, as of summer 2015, the
    following lsusb command takes forever (it never ends) if you don't.

    b) Then, please run:

        lsusb | grep 04ca:300d

    It should output something like:

        ------
        Bus 001 Device 084: ID 04ca:300d Lite-On Technology Corp.
        ------

    Numbers after "Bus" and "Device" probably don't matter. The "04ca:300d" is
    important, "Lite-On Technology Corp" also probably. This is your faulty
    Bluetooth card. However, if the command don't output anything, stop here,
    you are probably not concerned by this workaround in its current form.
    Please leave a bug report in your distribution's bug tracking system.

3) TESTING THE WORKAROUND

    In order to test the workaround, open a terminal in the folder where
    you downloaded and extracted the workaround and run:

        ./run.sh

    If it asks you to install something:

        Your kernel's headers are not installed, trying to install them.
        [sudo] password for your_name:


    Please input your password and press enter. Please be aware that nothing is
    shown in the terminal while your enter your password. Then, please enter
    another time and it asks confirmation.


    Wait for the command to end. It should take 2 seconds and a bit. When it
    completes, you can test your Bluetooth. If it succeeds, you got lucky, the
    workaround works in your case. So you can try to install it.

4) INSTALLING THE WORKAROUND

    In order to test the workaround, open a terminal and go to the folder where
    you downloaded and extracted the workaround.

        ./install.sh

    It should apply the workaround each time your computer is turned on and after
    each suspend. If this doesn't work, please drop me an email so I'm aware of
    the problem.


5) UNDESTANDING THE WORKAROUND

    If you are interested in how this workaround works, please keep reading.

    Recently, a patch has been written by Pilot6 (https://launchpad.net/~hanipouspilot)
    in order to support our Bluetooth card. However, at least on some system,
    this makes the card disconnect and reconnect indefinitely (which cause the
    Bluetooth not working, the lsusb command to hang and the system to take ages
    to boot).

    However, it  makes the card work after reboot on a kernel which doesn't
    contain the patch. It is likely because the patch allows the firmware of the
    card to be loaded, which the unpatched driver probably doesn't do. The
    unpatched driver is then able to drive the card after a reboot.

    This workaround loads the patched driver (kernel module) for two seconds,
    then unloads them and load the unpatched driver. It is necessary to apply
    this workaround when starting the system and after suspend.

    The cause of the disconnect-reconnect loop is still unknown as of the
    publication of this workaround and still needs to be worked out.

6) CONTACT

    Raphaël JAKSE: raphael dot jakse at gmail dot com

    Relevant bug report, for more details and to stay tuned (you should indicate
    that you are affected by the bug and subscribe for updates):

        https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1397885
