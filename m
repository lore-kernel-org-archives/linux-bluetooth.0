Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5eee8c670907280453i76f4957fvcca9c3954576580d@mail.gmail.com>
References: <5eee8c670907280453i76f4957fvcca9c3954576580d@mail.gmail.com>
From: Alexander H Deriziotis <deriziotis@gmail.com>
Date: Tue, 28 Jul 2009 12:55:17 +0100
Message-ID: <5eee8c670907280455ube96c5aka5a9a97149034a71@mail.gmail.com>
Subject: non-blocking hci_inquiry()
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been playing with the linux wiimote daemon called Cwiid, and
noticed that while it's waiting for a connection from a wiimote, it's
blocking the bluetooth adapter from doing anything else.

Searching around and looking at the code, I can see it's calling
hci_inquiry() in a loop which is blocking the device.

Does a non-blocking hci_inquiry() function exist? If not, could I get
some help on how to go about writing one?

Looking around, someone mentions that it might be the ioctl() function
called within hci_inquiry() which is causing the blocking, could it be
something as trivial as playing with that?

from lib/hci.c:

int hci_inquiry(int dev_id, int len, int nrsp, const uint8_t *lap,
inquiry_info **ii, long flags)
{
[snip]
        ret = ioctl(dd, HCIINQUIRY, (unsigned long) buf);
        if (ret < 0)
                goto free;


Many thanks,

Alex
