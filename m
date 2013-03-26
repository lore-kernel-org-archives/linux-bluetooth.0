Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130326072529.GA30560@x220>
References: <CAB8sVA-XJeACK9YHEB0V3vLHbskPaVe6A+C9_oM6t2jP-UV+pQ@mail.gmail.com>
	<20130325162309.GA25769@x220.P-661HNU-F1>
	<CAB8sVA-r2EnKTKWT+tp-eQo0r-nFS58cwpF_gNQ9Hi_v7xtZsA@mail.gmail.com>
	<20130326072529.GA30560@x220>
Date: Tue, 26 Mar 2013 09:54:56 -0400
Message-ID: <CAB8sVA_Sth76eEpbvy-nsLEAzki7Py9StRBL=4PwH3xJ=U582g@mail.gmail.com>
Subject: Re: Problem Running Bluez Tests
From: Brendan West <extremeskateboarding@gmail.com>
To: Brendan West <extremeskateboarding@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

On Tue, Mar 26, 2013 at 3:25 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> BlueZ 5.x installs bluetoothd by default into /usr/libexec/bluetooth/
> whereas 4.x installs it to /usr/sbin/, so it wouldn't get overwritten.

Ah, that makes sense.  I hate to keep asking questions that I probably
should already know the answer to, but how do I start the 5.x
bluetoothd?  I have tried editing the "bluetooth" file in the
"/etc/init.d/" directory and pointing the "daemon" path to the
"/usr/libexec/bluetooth/" directory (the one specified in the first
few lines of the file; the file does say that it is for Bluez 4.x, but
I couldn't find one for 5.x), but when I use the
"/etc/init.d/bluetooth start" command, it just hangs and doesn't do
anything.  Is there a different command/location that I need to
utilize for 5.x?

> D-Bus policy files are provided by each service that needs them. You
> won't get the new BlueZ policy with some centralized D-Bus package. I
> tried to tell you that you'll find the policy file in the BlueZ source
> tree and you just need to copy it to the right place (also explained in
> my email).

Sorry about that; I had misunderstood what you said in your email.  I
did figure out what you meant a while after I responded, so thank you
for pointing that out.  I did replace the file, but I'm still having
the problem that I mentioned above.

Thanks for all of your help.

Brendan West
