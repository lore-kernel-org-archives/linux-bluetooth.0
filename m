Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073395217.2508.62.camel@pegasus>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus>  <1073388369.8729.164.camel@saag>
	 <1073392659.2508.43.camel@pegasus>  <1073394683.8730.225.camel@saag>
	 <1073395217.2508.62.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073397739.8735.243.camel@saag>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 14:02:19 +0000
List-ID: <bluez-users.lists.sourceforge.net>

On Tue, 2004-01-06 at 13:20, Marcel Holtmann wrote:
> maybe the P800 is buggy. Run a second dund on channel 1 to see if it
> connects.

Well, that worked once or twice!  Now  we're back to the problem of
being stalled at this stage...

> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
    MTU 672
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x41 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c

Maybe the P800's just gone crazy :(  Oh well.

-- Edd
