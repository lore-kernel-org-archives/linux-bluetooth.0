Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB8sVA_Sth76eEpbvy-nsLEAzki7Py9StRBL=4PwH3xJ=U582g@mail.gmail.com>
References: <CAB8sVA-XJeACK9YHEB0V3vLHbskPaVe6A+C9_oM6t2jP-UV+pQ@mail.gmail.com>
	<20130325162309.GA25769@x220.P-661HNU-F1>
	<CAB8sVA-r2EnKTKWT+tp-eQo0r-nFS58cwpF_gNQ9Hi_v7xtZsA@mail.gmail.com>
	<20130326072529.GA30560@x220>
	<CAB8sVA_Sth76eEpbvy-nsLEAzki7Py9StRBL=4PwH3xJ=U582g@mail.gmail.com>
Date: Tue, 26 Mar 2013 10:22:57 -0400
Message-ID: <CAJdJm_NF3UQ+toEcqf02qs4azEH9meFArh_bw2Wht+xRsxMBuQ@mail.gmail.com>
Subject: Re: Problem Running Bluez Tests
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brendan West <extremeskateboarding@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brendan,

On Tue, Mar 26, 2013 at 9:54 AM, Brendan West
<extremeskateboarding@gmail.com> wrote:
> Johan,
>
> On Tue, Mar 26, 2013 at 3:25 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> BlueZ 5.x installs bluetoothd by default into /usr/libexec/bluetooth/
>> whereas 4.x installs it to /usr/sbin/, so it wouldn't get overwritten.
>
> Ah, that makes sense.  I hate to keep asking questions that I probably
> should already know the answer to, but how do I start the 5.x
> bluetoothd?  I have tried editing the "bluetooth" file in the
> "/etc/init.d/" directory and pointing the "daemon" path to the
> "/usr/libexec/bluetooth/" directory (the one specified in the first
> few lines of the file; the file does say that it is for Bluez 4.x, but
> I couldn't find one for 5.x), but when I use the
> "/etc/init.d/bluetooth start" command, it just hangs and doesn't do
> anything.  Is there a different command/location that I need to
> utilize for 5.x?

If you are just hacking around, you can try these steps (first restore
your /etc/init.d/bluetooth to the original content):

/etc/init.d/bluetooth stop
# do a backup of the original executable
mv /usr/sbin/bluetoothd  /usr/sbin/bluetoothd.orig
ln -s /usr/libexec/bluetooth/bluetoothd /usr/sbin/bluetoothd
/etc/init.d/bluetooth start

Note though that this is just a quick&dirty hack. The correct approach
is for you to do the proper packaging for the distro you are running
(e.g. .deb packaging for Debian based distros).

Unfortunately, I did not find any Debian based distro already
packaging BlueZ 5.x, so you will need to do your own packaging.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
