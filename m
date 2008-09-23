Return-Path: <cyrus@holtmann.org>
Message-ID: <61467.65.249.24.198.1222188249.squirrel@ice-gw.trolltech.com.au>
In-Reply-To: <867478754.8791222159193326.JavaMail.root@mbv7.indiatimes.com>
References: <63475.65.249.24.198.1222100847.squirrel@ice-gw.trolltech.com.au>
    <867478754.8791222159193326.JavaMail.root@mbv7.indiatimes.com>
Date: Wed, 24 Sep 2008 02:44:09 +1000 (EST)
Subject: Re: OpenOBEX ObexFTPd problem on BlueZ
From: "Denis Kenzior" <denis.kenzior@trolltech.com>
To: pavan_savoy@indiatimes.com
Cc: "denis kenzior" <denis.kenzior@trolltech.com>,
	linux-bluetooth@vger.kernel.org
Reply-To: denis.kenzior@trolltech.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Thanks, the current situation works for me.
> Windows [MS generic bluetooth radio] bluetooth stack has send and recieve
> file features, for this...
>
> If I run "obexftpd" on board and do a send file [without PASSKEY] feature,
> then it works.
>
> If I click on recieve file on PC and do a obexftp it doesn't work.
> However If I do a sdptool browse and get to know the channel number (1)
> and then give it to obexftp, it seems to work.

Obexftp doesn't perform SDP queries, it assumes a certain default channel.

>
> Now, the question...
> 1. How do I enable the passkey feature [bluepin doesn't exist in 3.36] ?
> **All option of security in hcid.conf has the same effect...

You need to implement a passkey agent.  See the bluez-utils source for an
example.  Basically you need to implement the org.bluez.PasskeyAgent API.

>
> 2. How I check the services of my board, to make it work for other
> stacks??
> [even the services request from current setup doesn;t seem to work, its
> like the sdp server is not started at all on blueZ side, even though the
> messages show it runs...]

SDP server by default does not contain any records since no services are
started.  You can browse local services by running:
'sdptool browse local'

Obexftp does not register any SDP records.  You need to look around for
proper obex daemon that integrates with bluez.  Look for obex-data-server
or obexd or write one yourself.

-Denis



-----------------------------------------
Nokia Pty Ltd, Level 1, 53 Brandl St, Eight Mile Plains, 4113, Queensland, Australia
