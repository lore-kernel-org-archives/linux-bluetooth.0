Return-Path: <Jose-Luis.Mateo@t-systems.com>
Message-Id: <D971A27FCD3DE04689089E8A98D8AF710361C30D@G9JJ1.mgb01.telekom.de>
From: "Mateo, Jose-Luis" <Jose-Luis.Mateo@t-systems.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: AW: [Bluez-users] Zaurus and PAN profile
Date: Thu, 24 Jun 2004 13:53:49 +0200
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <bluez-users.lists.sourceforge.net>

Hallo Marcel,
hcidump hangs when I try to connect from the PC. hciconfig runs ok:

Type : UART
BD Adress: ... ACL MUT:192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
.....

but with the option "-a" hangs just before the filed "Name". Can it be because of the different MTU values on the two devices?

I'm using Kernel 2.4.6 (module bluez-zaurus_2.3b_arm) and a CSR BlueCore02 chipset.

Regards,
Jose


-----Ursprungliche Nachricht-----
Von: Marcel Holtmann [mailto:marcel@holtmann.org]
Gesendet: Mittwoch, 23. Juni 2004 18:10
An: Mateo, Jose-Luis
Cc: BlueZ Mailing List
Betreff: Re: [Bluez-users] Zaurus and PAN profile


Hi Jose,

> I'm trying to connect a Zaurus PDA with a Laptop using the PAN Profile. I can ping with l2ping and connect using hcitool, but not using pand. The message error is: Connection refused (111).

sounds like a PIN problem. Look with "hcidump -x" at it. What does
"hciconfig -a" say?

Regards

Marcel
