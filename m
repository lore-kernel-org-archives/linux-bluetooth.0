Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: connect() returning EINPROGRESS
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGup35y4ZjSR4QfxvKCG7q2bHv3cH8HLkiHuciP1zpp9-WN4cw@mail.gmail.com>
Date: Sun, 8 May 2016 14:41:00 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <037C0C00-997A-4124-9589-8492F2E08A1E@holtmann.org>
References: <CAGup35xNHnGOeB2KT9n0oUBetqRJVygmHbNZBaNqu9HXw+98nA@mail.gmail.com> <ED3CFF35-4B10-403E-B435-4DD69A5DFB90@holtmann.org> <CAGup35y4ZjSR4QfxvKCG7q2bHv3cH8HLkiHuciP1zpp9-WN4cw@mail.gmail.com>
To: Allan Hessenflow <allan@flynixie.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Allan,

>> do you have a dead simple proof-of-concept that can show this issue. I do not recall any of this issue. Have you tried it with the latest bluetooth-next kernel?
> 
> I have only tried it with bluez 5.37 under kernel "4.4.0-21-generic #37-Ubuntu
> SMP Mon Apr 18 18:33:37 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux", and
> bluez 4.101 under kernel "3.13.0-85-generic #129-Ubuntu SMP Thu Mar 17
> 20:50:41 UTC 2016 i686 i686 i686 GNU/Linux".
> 
> I have created a test that I think is reasonably close to being as simple as
> possible for showing the issue (or possible issue, I could certainly have some
> misunderstanding of part of the API that just happens to not cause a problem
> with the older bluez).  I have attached the test code, although it
> finds and opens
> a custom device which of course you won't have.  Probably modifying it to find
> some other connectable device would show the same issue but I haven't tried
> so can't say that for certain.
> 
> The output of the test code with bluez 4.101 is:
> found device
> hci_le_create_connn okay
> Connected
> 
> And the output with bluez 5.37 is:
> found device
> hci_le_create_connn okay
> attconnect failed errno 115: Operation now in progress
> 
> That last line, showing that attconnect failed, takes something on the order
> of a minute to appear.

your usage of hci_le_create_conn is fundamentally hacking on a raw HCI channel and has high chances to cause issues. So you are creating your own problem here. If it worked before than that is just by pure luck. It is like you are injecting IP packets and excepting TCP to still functional properly.

So you might want look at the management API (doc/mgmt-api.txt) that allows you to scan properly and also has features like background scanning + connection support.

For you bind() usage, I think you better just memset the struct and not assign l2_cid or l2_bdaddr_type since they are not actually valid for socket you want to connect. They are mainly meant for sockets you listen on.

Regards

Marcel

