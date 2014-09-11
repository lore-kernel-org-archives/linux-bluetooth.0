Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <024801cfcd86$58382520$08a86f60$@samsung.com>
References: <015d01cfc20a$c9160a00$5b421e00$@samsung.com>
	<024801cfcd86$58382520$08a86f60$@samsung.com>
Date: Thu, 11 Sep 2014 09:27:54 -0700
Message-ID: <CAHrH25RUK3HWQeysAti+BHVxQ4RSVnFfL3M-BNB_4xc_x71Fuw@mail.gmail.com>
Subject: Re: Query Regarding new Gatt server attribute database
From: Arman Uguray <armansito@chromium.org>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

> Is there any plan to update, gatt-dbus.c, or all the functionalities are
> moving to src/shared/ ??
>

Others can comment more but I don't think there is (or there will be)
any work to maintain/develop what's in src/gatt-dbus and src/gatt, at
least not the way that they're currently built. The plan right now is
to move all core functionality into src/shared and then (re)build most
of the daemon's D-Bus bits using the new shared code.

I don't know how well the existing GATT D-Bus server stuff works at
the moment but I was under the impression that none of that's
feature-complete. Others can comment more.

Cheers,
Arman
