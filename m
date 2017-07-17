Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 17 Jul 2017 23:14:45 +0200
From: Olivier MARTIN <olivier@labapart.com>
To: linux-bluetooth@vger.kernel.org
Subject: AcquireWrite & AcquireNotify
Message-ID: <9849e4169bcd4e919628054345b533e5@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
After exchanging a couple of emails about MTU on the mailing-list last 
week, Luiz suggested the new functions AcquireWrite() & AcquireNotify() 
would do the job. I wanted to give a try and I changed my application 
protocol to take advantage of them.

But I have just realized they are both for the client side but I am 
using Bluez on the GATT server side. I am a bit worry to come back to my 
initial issue where I was thinking I will need the MTU... How can I send 
the longest GATT notification from the GATT server (in the context of a 
DBUS-based application)?

Thanks in advance,
Olivier
