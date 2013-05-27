Return-Path: <cyrus@holtmann.org>
Message-ID: <51A3355D.2030107@gmail.com>
Date: Mon, 27 May 2013 12:28:45 +0200
From: Emilio Pozuelo Monfort <pochu27@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Powered state in BlueZ 5
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm porting the GNOME stack to BlueZ 5 and I'm hitting one issue. It looks like 
the Powered state is not persistent anymore:

commit 0f575386a54382b63a1aa8e90589917747ee1a79
Author: Johan Hedberg <johan.hedberg@intel.com>
Date:   Thu Dec 13 16:35:30 2012 +0200

     core: Remove persistent storing of the powered state

commit 0bd31205e667de7a809a683e5c42c58a8d547a6e
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Sat Dec 29 16:28:03 2012 -0800

     doc: Mention that the adapter powered property is not persistent

The problem with this is that if the adapter is switched off with rfkill (that's 
what the toggles to turn bluetooth on and off do), then when it's switched back 
on it won't be powered. Should those toggle buttons also take care of powering 
the adapter? What if the user uses a hardware switch to turn it off? Or is there 
another way this should be done in BlueZ 5? I couldn't find any documentation 
about this in [1], but [2] suggests this needs to be handled elsewhere, such as 
in NM.

Thanks,
Emilio

[1] http://www.bluez.org/bluez-5-api-introduction-and-porting-guide/
[2] http://article.gmane.org/gmane.linux.bluez.kernel/35532
