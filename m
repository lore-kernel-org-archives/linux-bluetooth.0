Return-Path: <ashuang@gmail.com>
Message-ID: <ef9938ec04062308122c10675d@mail.gmail.com>
Date: Wed, 23 Jun 2004 11:12:04 -0400
From: Albert Huang <ashuang@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Re: [Bluez-devel] how well supported is hci_read_rssi and hci_read_link_quality?
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1087975911.4209.58.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <ef9938ec0406222219c5d442b@mail.gmail.com> <1087975911.4209.58.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

> Does this make any difference? The link quality is only uint8.

hmm... yes, I don't know what got into me that late in the night.  I
guess I was seeing negative numbers for rssi and thought gee, link
quality shouldn't be negative.  A useless, but harmless patch.

-albert
