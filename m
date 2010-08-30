Return-Path: <cyrus@holtmann.org>
Message-ID: <287015.9937.qm@web56502.mail.re3.yahoo.com>
References: <131634.48135.qm@web56506.mail.re3.yahoo.com> <AANLkTi=j6ch9_oQwb0xK9xPZ5btMUSqoHx4D8N8YM6nt@mail.gmail.com>
Date: Sun, 29 Aug 2010 23:53:33 -0700 (PDT)
From: Shreesh Holla <hshreesh@yahoo.com>
Subject: Re: [RFCOMM] Cannot complete connections into Ubuntu
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTi=j6ch9_oQwb0xK9xPZ5btMUSqoHx4D8N8YM6nt@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>





----- Original Message ----
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Shreesh Holla <hshreesh@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Tue, August 24, 2010 8:00:11 PM
Subject: Re: [RFCOMM] Cannot complete connections into Ubuntu

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
> So is there some configuration needed  now?
>
> I have the dongle running in Ubuntu as : hciconfig hci0 noauth noencrypt pscan
 ------ Luis says:
>>Had you tried the latest bluez, I did some changes to pair that solve
>>some problem with RFCOMM and ssp. If that doesn't help maybe you
>>should try to produce some logs of the so we can take a look.

>>Regards,

>>-- 
>>Luiz Augusto von Dentz
>>Computer Engineer

Luis,

It seems the problem is in aborting an open RFCOMM connection. And this seems to 
be an issue even with the 2.6.29 kernel. If I do abort a connection i.e. not 
gracefully i.e. by killing the applications then this is what I see:
- The connection is refused until reboot
- I tried to reset by doing a hciconfig hci0 reset AND also hciconfig hci0 
up/down
- When I do a reset actually the VM hangs completely i.e. the only way is to 
power off and restart the VM
- I do have two Bluetooth dongles - but I dont think that could be any issue.

So, fundamentally as long as I do a graceful shutdown of the RFCOMM connections 
all seems to be fine. This issue happens sometimes on the first abort. But 
definitely within three attempts. This is what I have been able to figure out 
since my last e-mail.

Do let me know if this helps. If you would need more details such as the hcidump 
logs or dmesg logs - I ca send that too.

Thanks,
Shreesh


