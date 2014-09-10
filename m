Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind PDUs.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com>
Date: Tue, 9 Sep 2014 19:06:47 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <91778176-68DD-4FE5-8A10-601BFEDE83C2@holtmann.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org> <1410282249-22004-5-git-send-email-armansito@chromium.org> <B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org> <CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> +     assert(notify_data->chrc->ccc_handle);
>> 
>> You are going heavy on the asserts. I am not convinced that is always a good idea. If remote devices can exploit such an assert, we have a problem. Gracefully disconnect might be better in many cases.
>> 
> 
> There are certain invariants that go with how the reference count is
> managed and I chose to add asserts in certain places to help catch
> potential bugs. I used them only for things that should never ever
> fail: i.e. if any of these assertions fails then there is a bug in the
> code and we should fix them. I don't mind removing them, but all the
> asserts that I added here (and in the previous patch that you
> responded to) try to capture the logical state and assumptions that
> are made in the code from which there isn't really a good way to
> recover if these assumptions do not hold.
> 
> In short, these assertions should always succeed in non-buggy code.
> Does BlueZ have debug-mode-only assert macros? Maybe such a thing
> might be useful to make the code self document these assumptions.
> Otherwise, I can remove them and replace them with comments instead?

actually that is a good idea. We might should look into introducing some nice and handy asserts helpers for exactly the case when you want it on during development and testing.

For now, just keep the asserts in it. I just wanted to point it out since I have seen people going crazy with asserts and then they can be remotely exploited. And that is something I want to avoid at all costs. A remote side should never ever be able to trigger an assert.

Regards

Marcel

