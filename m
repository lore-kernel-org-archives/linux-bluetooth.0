Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 193821] New: USB Bluetooth stops working after "usb 2-7: reset
 full-speed USB device number 5 using xhci_hcd"
Date: Thu, 02 Feb 2017 09:57:44 +0000
Message-ID: <bug-193821-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=193821

            Bug ID: 193821
           Summary: USB Bluetooth stops working after "usb 2-7: reset
                    full-speed USB device number 5 using xhci_hcd"
           Product: Drivers
           Version: 2.5
    Kernel Version: Opensuse Tumbleweed 4.9.6-1-default #1 SMP PREEMPT
                    x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mail@felixfischer.org
        Regression: No

Created attachment 253871
  --> https://bugzilla.kernel.org/attachment.cgi?id=253871&action=edit
dmesg with 'echo "module btusb +mfp" > /sys/kernel/debug/dynamic_debug/control'

Every time usb gets reset the bluetooth device stops working

dmesg:
[19352.497648] usb 2-7: reset full-speed USB device number 5 using xhci_hcd
[19357.757569] Bluetooth: hci0 command 0x0804 tx timeout

Most of the time i can reset and fix this with and bluetooth works till next
usb reset.

# modprobe -r btusb && modprobe btusb

Sometimes this doesn't help (I get the same timeout again). Then this ususally
helps:

# echo -n "0000:00:14.0" | tee /sys/bus/pci/drivers/xhci_hcd/unbind && sleep 2
&&  echo -n "0000:00:14.0" | tee /sys/bus/pci/drivers/xhci_hcd/bind"

Then bluetooth works again till the next usb reset. I don't know why the usb
reset happens in the first place.

Hardware: Thinkpad T440s (Intel Core i5-4200U)


In the attached dmesg output the first reset with 'echo "module btusb +mfp" >
/sys/kernel/debug/dynamic_debug/control' enabled happens at
[ 5507.237892] usb 2-7: reset full-speed USB device number 5 using xhci_hcd

-- 
You are receiving this mail because:
You are the assignee for the bug.
