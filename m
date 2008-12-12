Return-Path: <cyrus@holtmann.org>
Subject: Re: ObexFTP killing the Local SDP server
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan_savoy@indiatimes.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <676689813.95741228776457856.JavaMail.root@mbv7.indiatimes.com>
References: <676689813.95741228776457856.JavaMail.root@mbv7.indiatimes.com>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 02:47:39 +0100
Message-Id: <1229046459.22285.24.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

> I have a blueZ [version 3.35, wrongly claimed as 3.36] hcid daemon running on a machine, and I have put on it an ObexFTP daemon application [openobex + obexftp] which is statically linked with [bluez-libs-3.36].
> 
> The problem I face is, when I start obexftpd it says cannot register with SDP server,
> register to SDP Server failed, and comes out & then waits for a connecttion.
> 
> When I looked into it, it was failing in the function "sdp_connect_local" in bluez-libs/src/sdp.c & it also caused the SDP server to kill, So I cannot even do an sdptool browse local after this.
> [I checked sdptool browse local before running obexftpd & it is fine...]
> 
> Is it a problem with permissions given to unix domain sockets on platform ? Or something to do with the version mis-match ? Or something totally different ?

I don't know. Your system seems to be screwed up. Why don't you start
using something more recent like 4.22.

Regards

Marcel


