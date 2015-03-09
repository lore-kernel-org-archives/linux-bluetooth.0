Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: bt dongle goes awry after too many connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54FDBBD2.10608@ubnt.com>
Date: Mon, 9 Mar 2015 09:21:48 -0700
Cc: Tim Tisdall <tisdall@gmail.com>, linux-bluetooth@vger.kernel.org
Message-Id: <185295B8-ABD9-4EDF-B290-12C430CCA906@holtmann.org>
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com> <6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org> <CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com> <EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org> <CAGxYWpaaj=_J801VUe1WphQtdEr-MOMzZ10-w_iFWUdjBPkL5Q@mail.gmail.com> <CAGxYWpZCC1m1Ow-NAXp_f3AV9StE3sBHNJ2_vtY0owJ8SknffA@mail.gmail.com> <54FDBBD2.10608@ubnt.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

>>> If you do not need BR/EDR, you can switch that off and it might free the radio resources you need for the many LE connections.
>> Would someone please tell me how you do that?  I haven't seen this
>> being done before.  Is it an HCI command?  ioctl command to the
>> kernel?
> ControllerMode = le
> in /etc/bluetooth/main.conf

which might at least need a 3.13.x kernel to actually work correctly. While the API is there, we have made significant fixes to the LE only mode in later kernels. Using a dual-mode controller in LE only mode actually needed some extra care.

As I said, if it is not 3.18.x or 3.19.x kernel, then personally I would not bet on it. We have made sure that bug fixes are put into the -stable kernels for these release. Anything older has no guarantee anymore.

Regards

Marcel

