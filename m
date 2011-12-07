Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EDF328F.1010605@globaledgesoft.com>
References: <4EDF328F.1010605@globaledgesoft.com>
Date: Wed, 7 Dec 2011 15:06:36 +0200
Message-ID: <CABBYNZ+X_ZeG3UvxvqB51o+MfPatkjYo2Xnz4byDUNJGgU=R8w@mail.gmail.com>
Subject: Re: mpris player
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Deepthi <deepthi.pv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 7, 2011 at 11:31 AM, Deepthi <deepthi.pv@globaledgesoft.com> wrote:
> Hello,
>
>
>    If I use "org.mpris.amarok"  inside the dbus_message_new_method_call(),
> Giving an error saying :
>
>    "The name org.mpris.amarok was not provided by any .service files"
>   Please Help,

Make sure amarok is running and that it does register itself as
org.mpris.amarok, it is much easier if you have d-feet installed since
you can explore the list of bus names, so you can figure out why is
not working by looking what objects and interfaces does it export.

-- 
Luiz Augusto von Dentz
