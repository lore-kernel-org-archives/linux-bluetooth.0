Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: lambertarthur22@gmail.com
Date: Tue, 20 Mar 2018 16:59:54 +0100
To: Michael Simon <michael.simon.at@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: issue since bluez 48 with ios pairing only
Message-ID: <20180320155954.GA32282@arthur-bzh>
References: <20180320112749.GB21933@arthur-bzh>
 <CAOVXOEb9kzkYQP1YF5QMS2DBN=FWL0-PkENne8dOVcvbLFta2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOVXOEb9kzkYQP1YF5QMS2DBN=FWL0-PkENne8dOVcvbLFta2w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Michael Simon wrote :
>    Hi Arthur,
>    we had the same issue, it was related to the new "Bluetooth LE Battery
>    service", when we built bluez without this module the problem was gone.
>    I think the problem is that iPhones are advertising the battery service
>    but require pairing for it and this module tries to read the services
>    values as soon as the iPhone is connected.
>    Regards,
>    Michael

Thank you very much for your quick and good answer Michael. Its works perfecly now !
I will integrate bluez 49 in my firmware for testing thanks to you !

Luiz Augusto von Dentz wrote :

>    If you running with bluetoothd you should be using bluetoothctl
>    instead of btmgmt, and in case you are not using bluetoothd then the
>    BlueZ version don't really matter and what you should check is the
>    kernels changes.

We are using bluetoothd and dbus api to declare our custom services. We choosed
to use btmgmt because all the options provide by btmgmt was not present in bluetoothctl
one year ago. I will try to look at this tool this week

Regards,
Arthur.
