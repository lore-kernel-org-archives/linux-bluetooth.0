Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OrV7Xua91zUcyATHCWtHHAZUsOYJbVL8Vn_194O8_=Hw@mail.gmail.com>
References: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
	<CAJdJm_OrV7Xua91zUcyATHCWtHHAZUsOYJbVL8Vn_194O8_=Hw@mail.gmail.com>
Date: Fri, 15 Jun 2012 09:43:02 -0300
Message-ID: <CAFAvTnNJp0Q1JAt+HUy4X5mBG_xO+fQgUYoYiy+90uHJNtx9Mw@mail.gmail.com>
Subject: Re: [PATCH RFC] gdbus: Rename variables named "signal" (so that it
 can be compiled with -Wshadow)
From: Henrique Dante <hdante@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 15, 2012 at 9:29 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Henrique,
>
> On Fri, Jun 15, 2012 at 8:04 AM, Henrique Dante de Almeida
> <hdante@profusion.mobi> wrote:
>> ---
>>  gdbus/object.c |   39 +++++++++++++++++++++------------------
>>  gdbus/watch.c  |    4 ++--
>>  2 files changed, 23 insertions(+), 20 deletions(-)
>
> Would it be interesting to add this option to acinclude.m4? Or does it
> generate too much noise?

 It generates few warnings. Depending on the acceptance of this patch,
I could fix bluez as a whole and add -Wshadow to acinclude.m4.

>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
