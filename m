Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Subject: Various GET functionality fixes (obsoletes: Renewed new missed calls handling)
Date: Mon, 13 Jun 2011 11:34:16 +0200
Message-Id: <1307957658-11330-1-git-send-email-lkslawek@gmail.com>
In-Reply-To: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
References: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some updates.

Now the function for suspending is named suspend_get() as the suspending
mechanism introduced is only related to GET requests. And this is also
why it is not called in every place we do OBEX_SuspendRequest().

The variable is named suspended now, as you suggested.

I don't think there is any need for additional function for resuming
request.  The only place this is done is handle_async_io(). 

