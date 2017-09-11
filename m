Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
References: <CA+55aFztG626Np=z2WUzeVS1O3nmoTj76QRUBPg0J-FBELO7vw@mail.gmail.com>
 <20170911012508.GA17754@kroah.com> <9bc9cc83-212a-b39c-75af-b94fe6cab9f4@gmail.com>
 <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Sep 2017 21:25:08 -0700
Message-ID: <CA+55aFzWABZ+KCKT+r+TgyrWfnc+6YE7ZuHhZmgw-cRQXWTQ2w@mail.gmail.com>
Subject: Re: btusb "firmware request while host is not available" at resume
To: Gabriel C <nix.or.die@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Tejun Heo <tj@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, Sukumar Ghorai <sukumar.ghorai@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Sep 10, 2017 at 8:49 PM, Gabriel C <nix.or.die@gmail.com> wrote:
>
> Yes 81f95076281f is to blame.. After reverting it all is fine again.
>
> 15 resume cycles on the one laptop , 10 on the other without to hit the
> trace.

Yeah, I think that disable/enable_firmware in the suspend/resume path
is basically just completely random code. There  is nothing that
serializes with anything else, and it has no actual basis for saying
"I am now disabled/enabled" except for some entirely random time of
whenever the suspend/resume callbacks happen.

I'm going to revert it.

I wonder why 4.13 seemed to work for me. Or maybe it didn't, and I
just didn't notice, because I didn't use bluetooth and I wasn't
traveling. I test my laptop every release, but I don't necessarily
always _use_ it.

               Linus
