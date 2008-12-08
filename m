Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Dec 2008 04:17:37 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: <linux-bluetooth@vger.kernel.org>
Message-ID: <676689813.95741228776457856.JavaMail.root@mbv7.indiatimes.com>
Subject: ObexFTP killing the Local SDP server
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a blueZ [version 3.35, wrongly claimed as 3.36] hcid daemon running on a machine, and I have put on it an ObexFTP daemon application [openobex + obexftp] which is statically linked with [bluez-libs-3.36].

The problem I face is, when I start obexftpd it says cannot register with SDP server,
register to SDP Server failed, and comes out & then waits for a connecttion.

When I looked into it, it was failing in the function "sdp_connect_local" in bluez-libs/src/sdp.c & it also caused the SDP server to kill, So I cannot even do an sdptool browse local after this.
[I checked sdptool browse local before running obexftpd & it is fine...]

Is it a problem with permissions given to unix domain sockets on platform ? Or something to do with the version mis-match ? Or something totally different ?


regards,
Pavan


--

"KLUB MJ Hunt, Search for India's First Movie Jockey"
For more details log on to http://www.zeecinema.com
