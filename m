Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D1661A8A-7A16-4B53-98B3-03D256B76766@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org>
 <1365628753-16774-3-git-send-email-deymo@chromium.org> <D1661A8A-7A16-4B53-98B3-03D256B76766@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 11 Apr 2013 10:00:53 -0700
Message-ID: <CAGd9gwhXi0iiwOiN09FdEftk9rgOaMM9UP6g-fx8K0QNTVYjwQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] plugins: Extend the pin code callback with the call number
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 10, 2013 at 10:06 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> so I do not think that "count" is a really good name here. Wouldn't it be better to call it "attempt" or something like that?

No strong preference. "attempt" looks good.

> And I prefer to make these things unsigned if we are not planning to have -1 handed to it.

Actually, I'm using a -1 internally in the struct pincb_iter to mark
that the iterator reached the end (see pincb_iter_end()), but it is
never passed to the plugin.
