Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 25 Feb 2009 21:19:27 +0530
Message-ID: <6887eb5d0902250749t784b97cahe8f24af7b335570a@mail.gmail.com>
Subject: Abt hcid.conf
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi
I m modifying hcid.com lying in /etc/bluetooth for "security none"
which as per hcid.conf disables security manager.
So after that when I reboot my linux and then try to connect with
bluetooth headset BH-209 (Nokia) it doesn't connect to it.
Error is "Connection refused" which is because of no linkkey.

when I disable security manager why it checks for security???
Even I tried with "security auto" which reads local passkey that I
have set to "0000" and my BH-209 also have default PIN "0000", still
it prompts to enter passkey in bluetooth pairing & control wizard.

So I m confused...exactly how can we disable security manager for
simple connections?
Does changes in hcid.conf make any impact?
I m using bluez-4.30 on Fedora 9 (kernel 2.6.25-14)

pls help me to solve this...

-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
