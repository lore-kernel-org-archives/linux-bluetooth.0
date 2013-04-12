Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <92759276-C5D5-437D-8FB0-4089DA14E749@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org>
 <1365628753-16774-7-git-send-email-deymo@chromium.org> <92759276-C5D5-437D-8FB0-4089DA14E749@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
Date: Fri, 12 Apr 2013 15:58:18 -0700
Message-ID: <CAGd9gwgdQ+kX0XCj7_tsqKnQFE_y2EXWKXSE_NVWY21Vx4Qd4Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] autopair: Add the autopair plugin.
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 10, 2013 at 10:11 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> as mentioned earlier, I do not like the count naming. Here it makes it even worse.
Ok. Got it ;)

> And what I would be doing is creating a string array { "0000", "1234" } that just can be walked and not this hardcoded if statement.
As I mentioned before I like more the idea of the plugin having its
logic because it allows the plugin to do more than just a database.
When I said that I had in mind some ideas that you will find in my
next patch set. I'll change this dumb code to just "0000" at the
beginning and see what devices are out there requiring a dumb pincode
other than "0000".
