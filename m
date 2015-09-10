Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2015 12:45:46 +0600
Message-ID: <CACjvaw==Z9Mbgd6tBdHsNs1W+o7UbSudDUaGuwTLeY=LWkyW2A@mail.gmail.com>
Subject: mgmt-api callback not firing properly
From: Nazmul Alam <fadedreamz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am using mgmt-api to send command to the bluetooth kernel driver.

The problem is that sometimes the callback of the mgmt_send() command
is not fired even though the return value of the mgmt_send() is
indicating a success.

is there any special case which may cause this kind of issue?

using bluez 5.31 and 4.1+ kernel.

Thanks in advance.
