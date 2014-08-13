Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <947AB89D-2418-4371-A684-F292E888C9B0@holtmann.org>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org>
	<1407791934-3778-2-git-send-email-armansito@chromium.org>
	<947AB89D-2418-4371-A684-F292E888C9B0@holtmann.org>
Date: Tue, 12 Aug 2014 20:51:34 -0700
Message-ID: <CAHrH25QDJZXgn4+b40bS6P3OAbWYNJwcUT4r-BnmdR61sGctZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> struct bt_att {
>>       int ref_count;
>>       int fd;
>> -     bool close_on_unref;
>
> I like to keep the close_on_unref logic. So please do not remove it.
>

I removed this flag in favor of directly calling
io_set_close_on_destroy in bt_att_set_close_on_unref, which achieves
the same thing. Is it better to have a separate flag and not use
io_set_close_on_destroy at all?

Thanks,
Arman
