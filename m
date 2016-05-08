Return-Path: <allan@flynixie.com>
MIME-Version: 1.0
In-Reply-To: <037C0C00-997A-4124-9589-8492F2E08A1E@holtmann.org>
References: <CAGup35xNHnGOeB2KT9n0oUBetqRJVygmHbNZBaNqu9HXw+98nA@mail.gmail.com>
	<ED3CFF35-4B10-403E-B435-4DD69A5DFB90@holtmann.org>
	<CAGup35y4ZjSR4QfxvKCG7q2bHv3cH8HLkiHuciP1zpp9-WN4cw@mail.gmail.com>
	<037C0C00-997A-4124-9589-8492F2E08A1E@holtmann.org>
Date: Sun, 8 May 2016 15:04:34 -0700
Message-ID: <CAGup35zbTFHvQQmZkAu7ONxezv=pTHAyZYLfw-Vy3cWKMQDV1A@mail.gmail.com>
Subject: Re: connect() returning EINPROGRESS
From: Allan Hessenflow <allan@flynixie.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, May 8, 2016 at 2:41 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> So you might want look at the management API (doc/mgmt-api.txt) that allows you to scan properly and also has features like background scanning + connection support.


Okay, thanks, I'll look through that; I hadn't seen doc/mgmt-api.txt
before because
I originally wrote the tool with bluez 4.101 and that doc didn't exist then.

allan

-- 
Allan Hessenflow            allan@flynixie.com
