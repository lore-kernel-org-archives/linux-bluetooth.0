Return-Path: <cyrus@holtmann.org>
Message-ID: <17088774.1285100186795.JavaMail.root@elwamui-rustique.atl.sa.earthlink.net>
Date: Tue, 21 Sep 2010 15:16:26 -0500 (GMT-05:00)
From: Mumia W <mumia.w.18.spam@earthlink.net>
Reply-To: Mumia W <mumia.w.18.spam@earthlink.net>
To: list-linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Need complete docs on PAN and DUN with bluez 4.66
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>Sent: Sep 21, 2010 6:06 AM
>To: Arun Kumar <arunkat@gmail.com>
>Cc: Mumia W <mumia.w.18.spam@earthlink.net>, linux-bluetooth@vger.kernel.org
>Subject: Re: Need complete docs on PAN and DUN with bluez 4.66
>
>Hi,
>
>On Tue, Sep 21, 2010 at 6:56 AM, Arun Kumar <arunkat@gmail.com> wrote:
>> Depends on what role you want to use pand for ...pand is launched as a
>> daemon via command line with set of options you may want to use it for
>> your requirements ...
>
>I wouldn't suggest using pand nor dund because they are deprecated.
>
>PAN is really dead simple, Network.Connect() returns the network
>interface in case of success and both NetworkManager and connman
>should be able to use them, in fact I think both already have specif
>PAN support to connect from their ui.
>

I'm not using Network manager. How do I enable PAN from the command line? I'm an end-user right now.

>DUN is a bit more complicated, it rely on Serial.Connect("dun") which
>creates a RFCOMM port to talk to the modem, but there need to be some
>process that has an AT command engine to handle all the configuration,
>in NetworkManager case there is ModemManager that is supposed to do
>that but I have tried not long ago and it failed for me, I think we
>might want to have ofono to handle this in connman case

What is ofono?

>but so far
>there the support for this is not complete (Gustavo Padovan has been
>working on it).
>
>Both Network and Serial interface are documented in doc/ diretory,
>there is also test-network and test-serial under test/ that can be
>used to manually connect to those profiles.
>

Thank you.



-- 

