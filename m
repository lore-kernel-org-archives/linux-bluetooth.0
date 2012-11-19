Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1353314786-11427-2-git-send-email-luiz.dentz@gmail.com>
References: <1353314786-11427-1-git-send-email-luiz.dentz@gmail.com> <1353314786-11427-2-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 19 Nov 2012 10:06:52 -0200
Message-ID: <CAMOw1v7Y3EORhpSyydjhieG4Owx=0d5QAp=G66RweF7-cCshXQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] gdbus: Automatically register '/' path
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 19, 2012 at 6:46 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes g_dbus_setup_bus to automatically register '/' path so
> user application that don't export any interface on '/' will have it
> registered for ObjectManager.
>
> Note that it is now required to call g_dbus_close before exit.

I'm no really fan of this. Why do we need to register '/' now?  If we
are not going to support ObjectManager interfaces in subtrees, it
would be easier to just move the ObjectManager to the shortest path
registered rather than always registering '/'.


Lucas De Marchi
