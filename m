Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Mar 2011 15:04:48 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [2.6.38-rc8, patch] fix hci_dev_list locking
Message-ID: <20110314180448.GA10117@joana>
References: <AANLkTinN=eYJB3wF9jw7vbbTtUgOzr8oap4+i21Uei5X@mail.gmail.com>
 <20110312014749.GB2164@joana>
 <AANLkTimckJ5tYv2Fvy+RgTPbP3SFex2+4MxE+Rn2314H@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimckJ5tYv2Fvy+RgTPbP3SFex2+4MxE+Rn2314H@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

* Daniel J Blueman <daniel.blueman@gmail.com> [2011-03-13 11:59:27 +0800]:

> Hi Gustavo,
> 
> On 12 March 2011 09:47, Gustavo F. Padovan <padovan@profusion.mobi> wrote:
> > Hi Daniel,
> >
> > * Daniel J Blueman <daniel.blueman@gmail.com> [2011-03-09 00:07:54 +0800]:
> >
> >> No response from original post, and it missed getting taken into -rc7
> >> and -rc8, so repost:
> >>
> >> Release acquired lock on error path, fixing potential hang up.
> >
> > I already have a patch like this one in my tree, thanks anyway. :)
> 
> I guess I'm not looking in the right public tree, but I still couldn't
> detect the fix in:
> http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git
> or:
> http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-next-2.6.git

On bluetooth-next:

commit b2c60d42db0fea1e6c4345739601024863566a13
Author: Jesper Juhl <jj@chaosbits.net>
Date:   Fri Jan 14 00:18:49 2011 +0100

    Bluetooth: Fix failure to release lock in read_index_list()
    
    If alloc_skb() fails in read_index_list() we'll return -ENOMEM without
    releasing 'hci_dev_list_lock'.
    
    Signed-off-by: Jesper Juhl <jj@chaosbits.net>
    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://profusion.mobi
