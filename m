Return-Path: <cyrus@holtmann.org>
Message-ID: <4F60B259.5040800@tu-ilmenau.de>
Date: Wed, 14 Mar 2012 15:59:37 +0100
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Encrypting problem while sending data via bluetooth
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

At first: Sorry for my bad english, it's not my native language. So i 
wrote my problem in german and english.

My problem refers to bluez. I didn't got useful hits on Google, IRC 
didnt help and the only answer i got in a forum was: "there are not many 
people who are familiar with that". So i hope you can help me.

My problem:
After installing the latest bluez, i connected two gentoo-PC's (v2.1.6) 
via two bluetooth-dongles (BT3.0).
PC2:# rfcomm listen 0 1
PC1:# rfcomm connect 0 <bluetooth-adress> 1
This works fine.

But now, when i try to send some data:
PC2:# cat /dev/rfcomm0
PC1:# echo "test" > /dev/rfcomm0
it looks like this on the screen of PC2:
"^J^J^J^J^^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^test^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J" 

[and many more rows]

So i think it's an encrypting problem, but i really don't know how to 
solve it!
i opened /etc/bluetooth/network.conf and uncommented
DisableSecurity=true
but that didn't changed my problem.
I also tried
# hciconfig hci0 nosecmgr
but this command didn't work.

So how can i disable the Security for not getting those cryptic symbols 
(^J^J^J^J^...) ? I really hope you can help me.

Best regards,
Steffen Becker

----------------------------------------------------------------------------

Hallo,

ich habe ein Problem beim Umgang mit bluez. Ich habe bereits Google 
benutzt, IRC aufgesucht und in Foren gepostet, aber ich habe keine 
hilfreichen Informationen bekommen. Lediglich die Antwort: "Es gibt 
nicht viele Leute die sich damit auskennen".

Zu meinem Problem:
Ich habe zwei baugleiche Gentoo-Rechner(v2.1.6) mit je einem 
Bluetooth-Dongle(BT3.0) und das neueste bleuz installiert. Diese 
funktionieren soweit wunderbar. Die Verbindungsherstellung klappt ohne 
Probleme:
PC2:# rfcomm listen 0 1
PC1:# rfcomm connect 0 <bluetooth-adress> 1

Wenn ich aber nun über ">" Daten senden will passiert folgendes:
PC2:# cat /dev/rfcomm0
PC1:# echo "test" > /dev/rfcomm0
dann erscheint auf dem Bildschirm von PC2 dieses:
"^J^J^J^J^^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^test^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J" 

[und viele weitere solcher Zeilen]

Ich vermute, dass es sich um ein Verschlüsselungsproblem handelt.
Dazu habe ich die /etc/bluetooth/network.conf geöffnet und folgende 
Zeile gesetzt (welche standardmäßig auskommentiert war):
DisableSecurity=true
Das hat leider nichts geändert.
Ich habe auch versucht mit dem Befehl
# hciconfig hci0 nosecmgr
die Sicherheit zu deaktivieren, aber bei diesem Befehl ist gar nichts 
passiert, da ich hier auch nicht herausgefunden habe wie die genaue 
Syntax lautet.

Ich hoffe, Sie können mir hierbei helfen. Ist das Erscheinen der 
kryptischen Zeichen (^J^J^J^J^...) wirklich auf eine 
Verschlüsselungseinstellung zurückzuführen? Und wenn ja, wie kanndagegen 
vorgehen?

Mit freundlichen Grüßen,
Steffen Becker
