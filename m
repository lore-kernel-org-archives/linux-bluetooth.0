Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
Date: Fri, 17 Apr 2015 09:44:59 -0400
Message-ID: <CA+55aFz3hLbESYbzeMWtyMLbYnCUr-Tx56DA_C=39wxhVGJd6g@mail.gmail.com>
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: Linus Torvalds <torvalds@linux-foundation.org>
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 17, 2015 at 5:36 AM, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> The BT mouse is "death" in v4.1.
> The BT mouse has been working in 4.0 and previous kernels, so this
> is a regression.

Any chance of bisecting it?

              Linus
