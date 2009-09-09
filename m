Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090908222839.GA25653@jh-x301>
References: <4AA6C556.9050804@charter.net> <20090908222839.GA25653@jh-x301>
Date: Wed, 9 Sep 2009 09:32:36 -0300
Message-ID: <2d5a2c100909090532o3475a23fs3a0e3c10d78713af@mail.gmail.com>
Subject: Re: Fix for audio stream XCASE connect:connect failures
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <phurley@charter.net>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 8, 2009 at 7:28 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> - Use /* .. */ for comments instead of //
> - Make sure your lines are max 80 columns (e.g. shorten the debug message
>  or split it into two lines if necessary)
> - commit it to your own tree with a descriptive commit message and prepare
>  a patch using "git format-patch". This way it's easy for me to apply it
>  using "git am" and e.g. the author field gets correctly preserved.
>

Besides this it seems pretty good, please also make sure the DBus
signals are right, which in this case means we shouldn't emit
disconnected when dropping the second connection attempt, you can use
dbus-monitor --system sender='org.bluez'.

Regards,

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
