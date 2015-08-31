Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2015 11:48:48 +0600
Message-ID: <CACjvawnbjjE3tNuo9Bo76ose1cfzAMrrmyTOO8TaXZJvksf3Pw@mail.gmail.com>
Subject: controlling scan/adv window and interval
From: Nazmul Alam <fadedreamz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I was trying to simultaneously scan and advertise and found out that
when the device is discovering it stops advertising. It only re
advertise when the scan stops.

I am not sure if this behavior is intended and if so, can I change it?

And if not then is it possible to control the scan/adv interval and
window so that I can do TDM fashion scanning and advertising?

Thanks in advance.
