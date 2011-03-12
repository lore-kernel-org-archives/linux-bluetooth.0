Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Mar 2011 22:47:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [2.6.38-rc8, patch] fix hci_dev_list locking
Message-ID: <20110312014749.GB2164@joana>
References: <AANLkTinN=eYJB3wF9jw7vbbTtUgOzr8oap4+i21Uei5X@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinN=eYJB3wF9jw7vbbTtUgOzr8oap4+i21Uei5X@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

* Daniel J Blueman <daniel.blueman@gmail.com> [2011-03-09 00:07:54 +0800]:

> No response from original post, and it missed getting taken into -rc7
> and -rc8, so repost:
> 
> Release acquired lock on error path, fixing potential hang up.

I already have a patch like this one in my tree, thanks anyway. :)

-- 
Gustavo F. Padovan
http://profusion.mobi
