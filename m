Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QDJZXgn4+b40bS6P3OAbWYNJwcUT4r-BnmdR61sGctZQ@mail.gmail.com>
Date: Tue, 12 Aug 2014 21:49:14 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <4DEB38A3-893A-44E3-AB27-8EAC1F5900C4@holtmann.org>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org> <1407791934-3778-2-git-send-email-armansito@chromium.org> <947AB89D-2418-4371-A684-F292E888C9B0@holtmann.org> <CAHrH25QDJZXgn4+b40bS6P3OAbWYNJwcUT4r-BnmdR61sGctZQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> struct bt_att {
>>>      int ref_count;
>>>      int fd;
>>> -     bool close_on_unref;
>> 
>> I like to keep the close_on_unref logic. So please do not remove it.
>> 
> 
> I removed this flag in favor of directly calling
> io_set_close_on_destroy in bt_att_set_close_on_unref, which achieves
> the same thing. Is it better to have a separate flag and not use
> io_set_close_on_destroy at all?

good question. I have no idea. If the feature is still there, then I do not care either way. However such a change might be better done in a separate patch.

Regards

Marcel

