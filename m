Return-Path: <cyrus@holtmann.org>
Message-ID: <4EF4582E.6020308@visionsystems.de>
Date: Fri, 23 Dec 2011 11:30:06 +0100
From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com
Subject: bluez-4.97: check dependnecy
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

I was cross compiling bluez-4.97 under Buildroot and with the same configuration as for 4.96 configure failed by not being able to find check framework. Could this dependency be dropped if I don't want to compile tests? I mean it doesn't make much sense using check on x86 build host for arm binaries.

Best regards,
Yegor
