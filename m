Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073397739.8735.243.camel@saag>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus>  <1073388369.8729.164.camel@saag>
	 <1073392659.2508.43.camel@pegasus>  <1073394683.8730.225.camel@saag>
	 <1073395217.2508.62.camel@pegasus>  <1073397739.8735.243.camel@saag>
Content-Type: text/plain
Message-Id: <1073398529.2508.92.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 06 Jan 2004 15:15:29 +0100

Hi Edd,

> > maybe the P800 is buggy. Run a second dund on channel 1 to see if it
> > connects.
> 
> Well, that worked once or twice!  Now  we're back to the problem of
> being stalled at this stage...
> 
> > ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
>     MTU 672
> > ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x41 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> 
> Maybe the P800's just gone crazy :(  Oh well.

I don't think so, because if the ACL link is still connected we should
answer the SABM command. Looks for me like a scheduling bug in our
implementation. You got this with 2.4.23-mh1 and 2.6.0-mh2, right? I
think I had some similar problem, but I can't remember where I got it or
how to reproduce it.

BTW is the P800 so stupid that it searches for the SP record, but
connects back to channel 1. To what channel do you connect on the P800
to trigger the callback.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
