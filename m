Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110312014749.GB2164@joana>
References: <AANLkTinN=eYJB3wF9jw7vbbTtUgOzr8oap4+i21Uei5X@mail.gmail.com>
	<20110312014749.GB2164@joana>
Date: Sun, 13 Mar 2011 11:59:27 +0800
Message-ID: <AANLkTimckJ5tYv2Fvy+RgTPbP3SFex2+4MxE+Rn2314H@mail.gmail.com>
Subject: Re: [2.6.38-rc8, patch] fix hci_dev_list locking
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 12 March 2011 09:47, Gustavo F. Padovan <padovan@profusion.mobi> wrote:
> Hi Daniel,
>
> * Daniel J Blueman <daniel.blueman@gmail.com> [2011-03-09 00:07:54 +0800]:
>
>> No response from original post, and it missed getting taken into -rc7
>> and -rc8, so repost:
>>
>> Release acquired lock on error path, fixing potential hang up.
>
> I already have a patch like this one in my tree, thanks anyway. :)

I guess I'm not looking in the right public tree, but I still couldn't
detect the fix in:
http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git
or:
http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-next-2.6.git

Thanks,
  Daniel
-- 
Daniel J Blueman
