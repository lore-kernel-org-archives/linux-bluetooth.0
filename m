Return-Path: <cyrus@holtmann.org>
Message-ID: <4AA7CE83.8010509@charter.net>
Date: Wed, 09 Sep 2009 11:49:23 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Fix for audio stream XCASE connect:connect failures
References: <4AA6C556.9050804@charter.net> <20090908222839.GA25653@jh-x301>
In-Reply-To: <20090908222839.GA25653@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> That's some really nice analysis of the situation you've done.
Thanks.
> - Use /* .. */ for comments instead of //
> - Make sure your lines are max 80 columns (e.g. shorten the debug message
>   or split it into two lines if necessary)
> - commit it to your own tree with a descriptive commit message and prepare
>   a patch using "git format-patch". This way it's easy for me to apply it
>   using "git am" and e.g. the author field gets correctly preserved.
>   
Sorry about the style snafus: that's fixed, committed & the patch has 
been generated.  Since I use T-bird as my email client and that doesn't 
seem to be going too well with inline patches, I'm setting up Postfix so 
I can use git send-email.  Just need to get SMTP AUTH working with my ISP...

Luiz Augusto von Dentz wrote:
> ........................ please also make sure the DBus
> signals are right, which in this case means we shouldn't emit
> disconnected when dropping the second connection attempt, you can use
> dbus-monitor --system sender='org.bluez'.
>   
I will be sure to double-check that before I mail the patch.  (Shouldn't 
be a problem because the state change to _CONNECTING on the duplicate 
connect attempt never happens).

Regards,
Peter
