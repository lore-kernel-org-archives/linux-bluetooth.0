Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000f01d046d2$2e1048c0$8a30da40$@samsung.com>
References: <000f01d046d2$2e1048c0$8a30da40$@samsung.com>
Date: Thu, 12 Feb 2015 17:06:41 +0200
Message-ID: <CABBYNZJxyro_85TcGorD1u=moZUSKRYhM6pERW=u=ncT+uDCxA@mail.gmail.com>
Subject: Re: Query reagrding the MAS Instance Information Support patchset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Feb 12, 2015 at 4:42 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi Luiz,
>
> I have submitted a patch set to add support for MAP MAS Instance feature on
> the month of October. Below are the links.
> http://thread.gmane.org/gmane.linux.bluez.kernel/54106
> http://article.gmane.org/gmane.linux.bluez.kernel/53974
> http://article.gmane.org/gmane.linux.bluez.kernel/53975
> http://article.gmane.org/gmane.linux.bluez.kernel/53976
> http://article.gmane.org/gmane.linux.bluez.kernel/53977
> http://thread.gmane.org/gmane.linux.bluez.kernel/54110
> http://article.gmane.org/gmane.linux.bluez.kernel/53979
>
> But the suggestion provided was to wait until the Multiple MAS Instance
> support.
> Why can't we implement the multiple MAS Instance support on top of this?
> Some fixes and cleanups are needed in the above submitted patches. I will
> fix that.
> Shall I resend the same?
> What do you think?

I still have plans to implement the folder structure as I mentioned,
this would basically mean no API changes are needed, this would
conflict with your changes. I have been some patches for this already
which should be ready for submission next week.


-- 
Luiz Augusto von Dentz
