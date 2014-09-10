Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org>
	<1410282249-22004-5-git-send-email-armansito@chromium.org>
	<B3B84C22-937B-4880-B59F-0CFA680192D1@holtmann.org>
Date: Tue, 9 Sep 2014 17:09:46 -0700
Message-ID: <CAHrH25SVxPLYdjAGNHSwOKLx60wUOSRTzBTHDJfmvpFkiFhRPA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind PDUs.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


>> +     unsigned int notify_id, indic_id;
>
> I have never seen indication shorted into indic. I have to say that I do not like it that much. However I do not have any good suggestion either.
>

Perhaps "indicn_id"? I could just spell out "indication_id" :P.


>> +     assert(notify_data->chrc->ccc_handle);
>
> You are going heavy on the asserts. I am not convinced that is always a good idea. If remote devices can exploit such an assert, we have a problem. Gracefully disconnect might be better in many cases.
>

There are certain invariants that go with how the reference count is
managed and I chose to add asserts in certain places to help catch
potential bugs. I used them only for things that should never ever
fail: i.e. if any of these assertions fails then there is a bug in the
code and we should fix them. I don't mind removing them, but all the
asserts that I added here (and in the previous patch that you
responded to) try to capture the logical state and assumptions that
are made in the code from which there isn't really a good way to
recover if these assumptions do not hold.

In short, these assertions should always succeed in non-buggy code.
Does BlueZ have debug-mode-only assert macros? Maybe such a thing
might be useful to make the code self document these assumptions.
Otherwise, I can remove them and replace them with comments instead?

-Arman
