Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <4DEB38A3-893A-44E3-AB27-8EAC1F5900C4@holtmann.org>
References: <1407791934-3778-1-git-send-email-armansito@chromium.org>
	<1407791934-3778-2-git-send-email-armansito@chromium.org>
	<947AB89D-2418-4371-A684-F292E888C9B0@holtmann.org>
	<CAHrH25QDJZXgn4+b40bS6P3OAbWYNJwcUT4r-BnmdR61sGctZQ@mail.gmail.com>
	<4DEB38A3-893A-44E3-AB27-8EAC1F5900C4@holtmann.org>
Date: Wed, 13 Aug 2014 18:18:41 -0700
Message-ID: <CAHrH25RqoQQt0M_+bCj6+tmNyyy+NN-1OPg3ELBLj24qgHuw3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] shared/att: Handle disconnects.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> good question. I have no idea. If the feature is still there, then I do not care either way. However such a change might be better done in a separate patch.
>

Yes, it works. It also has the added benefit of automatically
destroying the connection on an ATT request timeout when we call
io_destroy from the timeout callback, if bt_att_set_close_unref has
been called earlier.

I'll pull it out into a separate patch.
