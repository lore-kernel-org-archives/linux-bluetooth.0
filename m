Return-Path: <cyrus@holtmann.org>
Message-ID: <557AE43F.5040402@albus.fr>
Date: Fri, 12 Jun 2015 15:53:03 +0200
From: =?UTF-8?B?SsOpcsOpbWllIFNjaGVlcg==?= <j.scheer@albus.fr>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Gatttool automatically stop listening to notifications
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm trying to register to notifications from a peripheral with 
"gatttool" command, for an undefined time.
I correctly receive the notifications when listening, but the problem is 
that gatttool stop listening after 25s and automatically unsubscribe 
from the peripheral's characteristic.

I register like this :
gatttool -b 4F:2B:CF:4F:EB:7C --char-write-req --handle=0x0038 
--value=0100 --listen

Is there some GATT configuration that define a timeout for notification 
listening ?
How can I do to be able to stay registered and listening until I 
manually unsubscribe ?

Thanks,

Jérémie
