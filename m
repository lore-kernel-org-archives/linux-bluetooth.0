Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAEd0BX-_PbMs1JV4g8_bYf43KScnHHKwsXaci=0cuqHcR-FGhg@mail.gmail.com>
References: <CAEd0BX-_PbMs1JV4g8_bYf43KScnHHKwsXaci=0cuqHcR-FGhg@mail.gmail.com>
Date: Tue, 28 Aug 2012 21:37:16 +0300
Message-ID: <CABBYNZ+nSf9_tt+yRmwWJXouWNVnXvAXYJQYOp4MsyNc6JTuaQ@mail.gmail.com>
Subject: Re: [Crash report & Patch obexd 1/1] map: gboolean holds int value
 which 0/1 crashes in DBusMessage
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Venkateswaran, Srinivasa Ragavan"
	<srinivasa.ragavan.venkateswaran@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 28, 2012 at 2:37 PM, Venkateswaran, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
> Hi,
>
> I was testing MAP and I came across a crash (trace attached). I
> figured out that the crash is because dbus expects gboolean to be 0/1
> where as it holds the 'int' results from strcasecmp. I've attached the
> patch that fixed the problem for me. This is my first message/patch to
> this list, sorry if it isn't in the right/expected format, just
> suggest me and I could put it right.

Interesting that I did not run into this bug before, can you do a some
changes to the commit message:

1. Add a prefix to the first line of the commit e.g: client: Fix crash
on map module
2. Add a description what you are fixing e.g. you can use the
backtrace and state this is caused by line _dbus_return_val_if_fail
(*bool_p == 0 || *bool_p == 1, FALSE);
3. How about using your intel email?

After you are done with that you can send us the patch with git
format-email + git send-email


-- 
Luiz Augusto von Dentz
