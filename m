Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20031008174223.058f41d8@unixmail.qualcomm.com>
To: Stephen Crane <steve.crane@rococosoft.com>,
   bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] RFComm channel allocation
Cc: marcel@rvs.uni-bielefeld.de
In-Reply-To: <1062078007.1823.33.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 08 Oct 2003 17:52:57 -0700

At 06:40 AM 8/28/2003, Stephen Crane wrote:
>Hi,
>It seems that bind() on a sockaddr_rc doesn't check its channel
>argument: it allows binding to a channel number which then cannot be
>connect()ed to. (connect() seems to check this argument fine.)
>
>For example, I can bind a listening socket to channel 0 or 40:
>$ cat /proc/bluetooth/rfcomm
>sk  00:00:00:00:00:00 00:00:00:00:00:00 2 0
>sk  00:00:00:00:00:00 00:00:00:00:00:00 4 40
>
>$ cat /proc/bluetooth/rfcomm
>sk  00:00:00:00:00:00 00:00:00:00:00:00 2 0
>sk  00:00:00:00:00:00 00:00:00:00:00:00 4 0
Definitely a bug. The thing is that when we do bind() we don't call RFCOMM 
DLC layer (ie rfcomm_dlc_xxx stuff). connect() is calling rfcomm_dlc_open() 
which where channel validity check it performed.
I guess we'll have to add the same check in bind().

>On a related matter (and I'm pretty sure this /has/ come up before),
>would it be possible to perform automatic channel allocation in the
>kernel? 0 would be a good distinguishing value for this (since it is
>reserved to the RFComm multiplexer).
It's possible but does not seem to be needed. I mean so far nobody had
a strong argument why we need to support it.

Max



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
