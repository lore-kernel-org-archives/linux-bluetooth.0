Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d8640503240350250aae5e@mail.gmail.com>
From: Benny <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Serial(HCI-UART) Bluetooth Module - Initialization timeout error
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Mar 2005 17:20:33 +0530

Dear all,
            
We are now working with a RFMD Silicon wave based serial(hci-uart)
bluetooth module.  We are trying to test for its working under linux
2.6.  We have installed the Bluetooth stack (bluetooth.o) module and
the HCI Uart (hci_uart.ko ) module.
We have tested for the working under windows.

When we try to do hciattach the device with Serial port using the
following command.

             hciattach  /dev/ttyS0 swave 115200 flow

we are getting the INITIALIAZATION TIME OUT error. And it is the same
result with the following commands also:

             hciattach ttyS0 swave 115200 flow
             hciattach  -s 115200 ttyS0  swave 115200 flow
             hciattach /dev/ttyS0 swave 115200
                      
Has anyone faced this problem before. Any pointers? Please advice.

Thanks and regards
Benny


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
