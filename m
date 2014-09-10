Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <91778176-68DD-4FE5-8A10-601BFEDE83C2@holtmann.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org>
	<1410282249-22004-5-git-send-email-armansito@chromium.org>
	<B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org>
	<CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com>
	<91778176-68DD-4FE5-8A10-601BFEDE83C2@holtmann.org>
Date: Wed, 10 Sep 2014 09:24:33 -0700
Message-ID: <CAHrH25S2zX9QtrFEuGOAMipv25hEpEOKq-h5nR-nuT0d0o-4JA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind PDUs.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> actually that is a good idea. We might should look into introducing some =
nice and handy asserts helpers for exactly the case when you want it on dur=
ing development and testing.
>
> For now, just keep the asserts in it. I just wanted to point it out since=
 I have seen people going crazy with asserts and then they can be remotely =
exploited. And that is something I want to avoid at all costs. A remote sid=
e should never ever be able to trigger an assert.
>

Sounds good, leaving them in for now. In the future we can explore
adding macros such as DASSERT or DCHECK that are defined as "assert"
if compiled with --debug and nothing otherwise.


-Arman
