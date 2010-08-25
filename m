Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <131634.48135.qm@web56506.mail.re3.yahoo.com>
References: <131634.48135.qm@web56506.mail.re3.yahoo.com>
Date: Tue, 24 Aug 2010 23:00:11 -0400
Message-ID: <AANLkTi=j6ch9_oQwb0xK9xPZ5btMUSqoHx4D8N8YM6nt@mail.gmail.com>
Subject: Re: [RFCOMM] Cannot complete connections into Ubuntu
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Shreesh Holla <hshreesh@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 23, 2010 at 3:22 AM, Shreesh Holla <hshreesh@yahoo.com> wrote:
> Hi,
>
> I'm running Ubuntu with 2.6.32.24 kernel.
> I have a simple RFCOMM program running on Windows Mobile which would connect
> into the Ubuntu machine. Of course I have the corresponding service running on
> the Ubuntu machine. The RFCOMM port numbers do match up.
>
> This was working a few days back and now with no changes(i.e. the same
> executable), it refuses to work anymore.
>
> So is there some configuration needed  now?
>
> I have the dongle running in Ubuntu as : hciconfig hci0 noauth noencrypt pscan

Had you tried the latest bluez, I did some changes to pair that solve
some problem with RFCOMM and ssp. If that doesn't help maybe you
should try to produce some logs of the so we can take a look.

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer
