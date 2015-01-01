Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: PROBLEM: 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does not see BT devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54A54E4C.4080005@gmail.com>
Date: Thu, 1 Jan 2015 11:47:37 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7AAB2B3D-746D-40AC-B8EF-B2F57BC91912@holtmann.org>
References: <54A2D333.7090607@gmail.com> <FB8B7DF3-D835-4270-8932-BAED0DA050BE@holtmann.org> <54A3DD1B.4040100@gmail.com> <F1981414-E281-4925-9C71-7310F538219F@holtmann.org> <54A3F213.20106@gmail.com> <6DA7C965-5DC7-4A67-81FA-6182DF3A12F5@holtmann.org> <54A54E4C.4080005@gmail.com>
To: Miguel Barrio Orsikowsky <megamik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Miguel,

>> I have done the following:
>> 
>> 1. dmesg | grep Bluetooth. This reveals the name of the firmware patch needed:
>> 
>> [   15.825275] Bluetooth: hci0: BCM: patch brcm/BCM43142A0-0489-e062.hcd not found
>> 
>> 2. Mounted the Windows 8.1 x64 partition into /mnt
>> 
>> 3. find /mnt -iname '*brcm.inf'. This leads to '/mnt/Program Files/WIDCOMM/Bluetooth Software/bin/bcbtums-win8x64-brcm.inf', viewed it and located the E062 string which leads to the file BCM43142A0_001.001.011.0161.0182.hex:
>> 
>> ...
>> %BRCM43142BtAdapter.DeviceDesc%=BlueRAMUSBE062, USB\VID_0489&PID_E062       ; Sony 43142A0 combo
>> ...
>> ;;;;;;;;;;;;;RAMUSBE062;;;;;;;;;;;;;;;;;
>> 
>> [RAMUSBE062.CopyList]
>> bcbtums.sys
>> btwampfl.sys
>> BCM43142A0_001.001.011.0161.0182.hex
>> ...
>> 
>> 4. find /mnt -name 'BCM43142A0_001.001.011.0161.0182.hex'. Copied the '/mnt/Program Files/WIDCOMM/Bluetooth Software/bin/BCM43142A0_001.001.011.0161.0182.hex' file into my home dir.
>> 
>> 5. Downloaded and compiled hex2hcd (https://github.com/jessesung/hex2hcd<https://github.com/jessesung/hex2hcd>). Executed it against the BCM43142A0_001.001.011.0161.0182.hex file to get the BCM43142A0-0489-e062.hcd as requested by the dmesg message, and put it in /lib/firmare/brcm.
>> 
>> 6. Reboot.
>> 
>> 7. Now dmesg does not show the error "patch brcm/BCM43142A0-0489-e062.hcd not found", but the BT adapter is not even recognized ("hcitool scan" shows No such device), and dmesg shows this error in addition to the "hci0 command 0x1001 tx timeout" one:
>> 
>> [   26.265214] Bluetooth: hci0: HCI_OP_READ_LOCAL_VERSION failed (-110)
>> can you show us btmon output for this. And it might be really hard to capture it since it is a physical present adapter. Might need to see if rfkill {block,unblock} bluetooth would kick if off the USB bus.
> 
> Issuing an rfkill block and then unblock *fixes this issue*, making the BT adapter fully functional after the unblock. This is the sequence of commands and its output (I have put btmon's output after each rfkill {block,unblock} command), with the laptop just powered on:
> 
> miguel@vaio:~$ dmesg|grep -e 'Bluetooth\|usb 1\-4'
> [    1.059093] usb 1-4: new full-speed USB device number 2 using xhci_hcd
> [    1.189158] usb 1-4: New USB device found, idVendor=0489, idProduct=e062
> [    1.189163] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    1.189166] usb 1-4: Product: BCM43142A0
> [    1.189168] usb 1-4: Manufacturer: Broadcom Corp
> [    1.189170] usb 1-4: SerialNumber: 3C77E6DC7494
> [   14.959274] Bluetooth: Core ver 2.20
> [   14.959296] Bluetooth: HCI device and connection manager initialized
> [   14.959299] Bluetooth: HCI socket layer initialized
> [   14.959301] Bluetooth: L2CAP socket layer initialized
> [   14.959305] Bluetooth: SCO socket layer initialized
> [   17.505949] Bluetooth: hci0 command 0x1001 tx timeout
> [   19.345404] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   19.345409] Bluetooth: BNEP filters: protocol multicast
> [   19.345415] Bluetooth: BNEP socket layer initialized
> [   19.418888] Bluetooth: RFCOMM TTY layer initialized
> [   19.418896] Bluetooth: RFCOMM socket layer initialized
> [   19.418901] Bluetooth: RFCOMM ver 1.11
> [   25.497507] Bluetooth: hci0: HCI_OP_READ_LOCAL_VERSION failed (-110)
> miguel@vaio:~$ rfkill list 1
> 1: sony-bluetooth: Bluetooth
>    Soft blocked: no
>    Hard blocked: no
> miguel@vaio:~$ rfkill list 5
> 5: hci0: Bluetooth
>    Soft blocked: no
>    Hard blocked: no
> miguel@vaio:~$ rfkill block 1
> 
> = Delete Index: 00:00:00:00:00:00                             [hci0] 366.446485
> 
> miguel@vaio:~$ rfkill list 1
> 1: sony-bluetooth: Bluetooth
>    Soft blocked: yes
>    Hard blocked: no
> miguel@vaio:~$ dmesg|tail -1
> [  580.695923] usb 1-4: USB disconnect, device number 2
> miguel@vaio:~$ rfkill unblock 1
> 
> = New Index: 00:00:00:00:00:00 (BR/EDR,USB,hci0)              [hci0] 592.834707
> < HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 592.834920
> > HCI Event: Command Complete (0x0e) plen 12 [hci0] 592.835593
>      Read Local Version Information (0x04|0x0001) ncmd 1
>        Status: Success (0x00)
>        HCI version: Bluetooth 4.0 (0x06) - Revision 0 (0x0000)
>        LMP version: Bluetooth 4.0 (0x06) - Subversion 8459 (0x210b)
>        Manufacturer: Broadcom Corporation (15)
> > HCI Event: Command Complete (0x0e) plen 4 [hci0] 592.837588
>      Reset (0x03|0x0003) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Read Local Version Inf.. (0x04|0x0001) plen 0 [hci0] 592.837636
> > HCI Event: Command Complete (0x0e) plen 12 [hci0] 592.838589
>      Read Local Version Information (0x04|0x0001) ncmd 1
>        Status: Success (0x00)
>        HCI version: Bluetooth 4.0 (0x06) - Revision 0 (0x0000)
>        LMP version: Bluetooth 4.0 (0x06) - Subversion 8459 (0x210b)
>        Manufacturer: Broadcom Corporation (15)

this is the odd one right here. If the events really arrive in this order, then the Bluetooth chip is pretty much confused.

These are essentially the first two commands in btusb_setup_bcm_patchram() function. You can see if adding some msleep() between HCI Reset and HCI Read Local Version Information would make any difference.

Some guessing involved here is that the first time around, the HCI Reset succeeds, but the HCI Read Local Version Information times out. And the Command Complete for HCI Read Local Version Information you see here is a leftover. So eventually the controller will send it.

This means it might be enough to let the controller settle for 50 msec after issuing HCI Reset. So that the HCI Read Local Version Information can complete. Or you increase the HCI_INIT_TIMEOUT parameter of that command to something larger and see if that is enough.

In addition there is a core HCI_CMD_TIMEOUT that handles the HCI commands that is only 2 seconds at the moment. Try increasing that to 5 seconds and see if that might be the culprit. Some people have in the past reported problems in that area.

Regards

Marcel

