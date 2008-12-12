Return-Path: <cyrus@holtmann.org>
Subject: Re: ObexFTP killing the Local SDP server
From: Per Thomas Jahr <perja@extern.uio.no>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: pavan_savoy@indiatimes.com
In-Reply-To: <1229046459.22285.24.camel@violet.holtmann.net>
References: <676689813.95741228776457856.JavaMail.root@mbv7.indiatimes.com>
	 <1229046459.22285.24.camel@violet.holtmann.net>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 10:11:29 +0100
Message-Id: <1229073089.3899.21.camel@apollo2>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2008-12-12 at 02:47 +0100, Marcel Holtmann wrote:
> Hi Pavan,
> 
> > I have a blueZ [version 3.35, wrongly claimed as 3.36] hcid daemon running on a machine, and I have put on it an ObexFTP daemon application [openobex + obexftp] which is statically linked with [bluez-libs-3.36].
> > 
> > The problem I face is, when I start obexftpd it says cannot register with SDP server,
> > register to SDP Server failed, and comes out & then waits for a connecttion.
> > 
> > When I looked into it, it was failing in the function "sdp_connect_local" in bluez-libs/src/sdp.c & it also caused the SDP server to kill, So I cannot even do an sdptool browse local after this.
> > [I checked sdptool browse local before running obexftpd & it is fine...]
> > 
> > Is it a problem with permissions given to unix domain sockets on platform ? Or something to do with the version mis-match ? Or something totally different ?
> 
> I don't know. Your system seems to be screwed up. Why don't you start
> using something more recent like 4.22.

If you are on Fedora, there was an security update of dbus a couple of
days ago that screwed up bluetooth (and a couple of other things) for
most users. Maybe that is the problem.

http://forums.fedoraforum.org/showthread.php?t=207069 

-- 
Cheers
Per Thomas

