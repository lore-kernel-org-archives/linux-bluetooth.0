Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
References: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
Date: Fri, 15 Jun 2012 08:29:33 -0400
Message-ID: <CAJdJm_OrV7Xua91zUcyATHCWtHHAZUsOYJbVL8Vn_194O8_=Hw@mail.gmail.com>
Subject: Re: [PATCH RFC] gdbus: Rename variables named "signal" (so that it
 can be compiled with -Wshadow)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Henrique Dante de Almeida <hdante@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrique,

On Fri, Jun 15, 2012 at 8:04 AM, Henrique Dante de Almeida
<hdante@profusion.mobi> wrote:
> ---
>  gdbus/object.c |   39 +++++++++++++++++++++------------------
>  gdbus/watch.c  |    4 ++--
>  2 files changed, 23 insertions(+), 20 deletions(-)

Would it be interesting to add this option to acinclude.m4? Or does it
generate too much noise?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
