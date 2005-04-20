Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Accessing "/dev/rfcomm0" regarding
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <f54d864050420060454c6aa76@mail.gmail.com>
References: <f54d864050420060454c6aa76@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114008769.2469.177.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 20 Apr 2005 16:52:49 +0200

Hi Benjamin,

> We are testing for the bidirectional data transfer between 2 PCs over Bluetooth.
> 
> The setup is as follows:
>     i) Host PC(Fedora 3-Linux kernel 2.6.9) with USB Bluetooth
> dongle(CSR Chipset). We have used the Bluez utilities(rfcomm
> application) to connect the device and send data through the device
> handle "/dev/rfcomm0".
>     ii) Device PC(Linux/Windows) hyperterminal(COM1/"/dev/ttyS0"). The
> BT-SPP  module is connected to the Device PC.
> 
> We using the commands in the following sequence on the Host PC:
> i) hcid
> ii) sdpd
> iii) sdptool add --channel=1 SP
> iv) rfcomm connect 0 <BDADDR> 1
> v) ls -l > /dev/rfcomm0 - for sending the data, working fine
> vi) cat /dev/rfcomm0 - for reading the data, working fine.
> 
> We have written a simple program which opens "/dev/rfcomm0" using
> "open("/dev/rfcomm0",O_RDWR)". We are able to send data using the
> system call "write()". But we are not able recieve data using the
> system call "read()". But the "hcidump -x" utility is showing the
> recieved data.

this is working. Check the attest program from bluez-utils.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
