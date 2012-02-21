Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPHSBCm2KfyqC3BVjSUb9QGqr25Pvfp-SS_CW-ZpYV_6Aeyn=A@mail.gmail.com>
References: <CAPHSBCm2KfyqC3BVjSUb9QGqr25Pvfp-SS_CW-ZpYV_6Aeyn=A@mail.gmail.com>
Date: Tue, 21 Feb 2012 17:37:00 +0200
Message-ID: <CABBYNZ+Dabwb92WQ13-i-_yfTW4D9DQ0OGROPs-fjw2YF0PjcQ@mail.gmail.com>
Subject: Re: AVRCP 1.3 support for CT and TG Role in bluez-4.98
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Rohit Sharma <rohitsharmaddun@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rohit,

On Tue, Feb 21, 2012 at 4:56 PM, Rohit Sharma <rohitsharmaddun@gmail.com> wrote:
> Hi All,
>
> I am trying to test AVRCP 1.3 CT and TG role in bluez-4.98. I tried
> sending the AVRCP 1.3 commands from remote Controller but the commands
> were rejected saying no controllers.
>
> Can anyone please help me out to know which media player or
> application i can use to test this. Please let me know any readme or
> blog which i can refer too. Thanks a lot in advance.

Have your tried test/mpris-player? It should work if you have a player
which implements MPRIS 2.0 interface, or you can also check
test/simple-player if you just want a dummy one.

-- 
Luiz Augusto von Dentz
