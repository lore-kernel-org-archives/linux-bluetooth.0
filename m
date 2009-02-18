Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 18 Feb 2009 17:49:08 +0530
Message-ID: <6887eb5d0902180419k7b6220fdx5a8c7abd71daa169@mail.gmail.com>
Subject: obexftp apps related
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi

I have installed bluez-4.30, openobex-1.4 and obexftp-0.22 on Fedora 9

When I run the test application by writing:

obexftp --bluetooth ----nopath --noconn --uuid none --put obexftp.c

it starts executing and on my bluetooth enable mobile it prompts me to
accept connection with computer.
When I accept it, it prompts me to Enter Access Code...

I tried with 0000, 1111 and lot more but evertime it shows an error
"error: connect()" and "still trying to connect"...

I have configured my hci device with command ./hciconfig -a hci0
noauth and ./hciconfig -a hci0 noencrypt

Still it prompts for access code on connection attemp...

As per bluetooth core specification and OBEX protocol specification,
authentication is optional parameter... so since I m not requesting
authentication from my hci device which runs bluetooth adapter why
access code is being prompted on my bluetooth enable mobile device?

This happens when the software module attempt to connect with the
remote device on RFCOMM...

Is there any mistake in writing commands by me or there is a bug in
either bluez-4.30, openobex-1.4 or obexftp-0.22?

Kindly suggest me solution so i can continue.. with my development...

Awaiting for reply..

Thanks & Regards,
-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
