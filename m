Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jun 2010 01:27:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix unblock removed device
Message-ID: <20100628222738.GA16898@jh-x301>
References: <AANLkTil1_LwZYuTuZT0gQgd7Mxjo0CoY2WVI8CW-f-wj@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTil1_LwZYuTuZT0gQgd7Mxjo0CoY2WVI8CW-f-wj@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Mon, Jun 28, 2010, Daniel Örstadius wrote:
> This patch unblocks a device when removing it. Adds boolean argument
> to function device_unblock to only emit property changed signal and
> probe drivers when unblocking a device if the device is not unblocked
> as part of being removed.

Thanks for the patch. It has now been pushed upstream with a couple of
over 80 character line fixes. Please pay attention to that in the
future.

Johan
