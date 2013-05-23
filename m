Return-Path: <cyrus@holtmann.org>
Message-ID: <519E0CC5.9010300@pdm.ac.in>
Date: Thu, 23 May 2013 18:04:13 +0530
From: Mohit <mt1037ag11@pdm.ac.in>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Support for Ralink RT3298 Bluetooth Module
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
There was a proprietary driver for Ralink RT3298 bluetooth module that 
compiled in kernel 3.2 but stopped compiling in kernel 3.3, 3.4 or 3.5 
which is available here 
http://downloads.zotac.com/mediadrivers/mb/download/NB087_Ubuntu.zip. I 
get the following output when compiling in kernel 3.5 :

mohit@linux-xmln:~/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3> make
make -C /lib/modules/3.7.10-1.4-desktop/build M=/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3 modules
make[1]: Entering directory `/usr/src/linux-3.7.10-1.4-obj/x86_64/desktop'
   CC [M]  /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_main.o
   CC [M]  /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_init.o
   CC [M]  /home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.o
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c: In function ‘rtbt_pci_suspend’:
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c:60:43: error: ‘struct hci_dev’ has no member named ‘driver_data’
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c: In function ‘rtbt_pci_resume’:
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c:87:46: error: ‘struct hci_dev’ has no member named ‘driver_data’
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c: In function ‘rtbt_pci_probe’:
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c:198:1: warning: label ‘err_hps_iface’ defined but not used [-Wunused-label]
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c: In function ‘rtbt_pci_remove’:
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c:240:43: error: ‘struct hci_dev’ has no member named ‘driver_data’
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c: In function ‘BthIsr’:
/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.c:346:40: error: ‘struct hci_dev’ has no member named ‘driver_data’
make[4]: *** [/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3/rtbth_core_pci.o] Error 1
make[3]: *** [_module_/home/mohit/Downloads/NB087_Ubuntu/NB087_BT_ubuntu_release/rtbth_v3.9.3/rtbth_v3.9.3] Error 2
make[2]: *** [sub-make] Error 2
make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/src/linux-3.7.10-1.4-obj/x86_64/desktop'
make: *** [all] Error 2



-- 









--
******************************************************************************************************************************************************************
"This e-Mail may contain proprietary and confidential information and is 
sent for the intended  recipient(s) only. If, by an addressing or 
transmission error, this mail has been misdirected to you, you are 
requested to delete this mail immediately.You are also hereby notified that 
any use, any form of reproduction, dissemination, copying, disclosure, 
modification, distribution and/or publication of this e-mail 
message,contents or its attachment(s) other than by its intended 
recipient(s) is strictly prohibited.Any opinions expressed in this email 
are those of the individual and not necessarily of the organization.Before 
opening attachment(s), please scan for viruses."
**********************************************************************************************************************************************************************

