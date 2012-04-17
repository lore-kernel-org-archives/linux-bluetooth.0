Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 17 Apr 2012 12:28:15 +0100
Message-ID: <CAJ2qBzZwuiAaL99=mT5P+MQKXd-gc7zdn6x5f1sr5Kpw=tQytw@mail.gmail.com>
Subject: A request to understand the design decisions why tasklets were
 changed to workqueues eg. hci_rx_task() to hci_rx_work()
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am interested to the understand the design decisions for changing
from tasklets to workqueues.

Was there a fundamental flaw that necessitated the change ?

I am asking because I am getting a Bluetooth "scheduling while atomic"
failure on an ARM based 2.6.34 kernel (with some 2.6.37 Bluez
backports). Changing to workqueues would avoid this issue as a
workqueue use process context that can sleep.

Thanks for any info on the design decisions.

Regards,
Dean
