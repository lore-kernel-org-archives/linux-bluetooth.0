Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKCXgJ25JzJ7H4sYdA6z7EFZYNC1OBpZ_rwPvLkgAirbqDd74A@mail.gmail.com>
References: <CAKCXgJ25JzJ7H4sYdA6z7EFZYNC1OBpZ_rwPvLkgAirbqDd74A@mail.gmail.com>
Date: Fri, 18 Oct 2013 10:48:34 +0300
Message-ID: <CABBYNZJqE_iY=LgZ82bpwmWWfM6wZULR0Ux-JSbVA8AaERCzVg@mail.gmail.com>
Subject: Re: How to contribute
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tim Wei <junping.wei@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

On Fri, Oct 18, 2013 at 5:36 AM, Tim Wei <junping.wei@gmail.com> wrote:
> I just fixed a bug in kernel. How can I contribute it?
> My base version is Linux kernel 3.9.6. Should I download the latest
> kernel and check whether it has been fixed?

Any patch going upstream should probably be based on bluetooth-next:
https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/

Patches are expected to be send via git commit -s <try to be as
descriptive as possible in the commit message> + git format-patch +
git send-email like any other kernel patch and please be patient
sometimes the patches takes a while to be reviewed because the
maintainers are busy.


-- 
Luiz Augusto von Dentz
