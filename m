Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple PowerBook and Nokia 6310i
From: Marcel Holtmann <marcel@holtmann.org>
To: Wouter Verhelst <wouter@grep.be>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041020233608.GA26457@grep.be>
References: <20041020233608.GA26457@grep.be>
Content-Type: text/plain
Message-Id: <1098380889.4885.27.camel@pegasus>
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
Date: Thu, 21 Oct 2004 19:48:09 +0200

Hi Wouter,

> I recently (as in, two days ago) acquired a new laptop, a 12" Apple
> PowerBook G4. This thing has bluetooth; so does my Nokia.
> 
> Right now, I'm trying to connect to the Internet using the laptop and
> the Nokia, which doesn't seem to work. I did get it to work using IrDA
> on my previous laptop, but a) that was an i386 laptop, b) it was over
> IrDA instead of bluetooth, and c) the reason I bought this laptop is
> because the previous one was stolen from me -- so I can't look up how I
> did everything anymore.
> 
> After configuring everything, this is what appears in my syslog when I
> try to connect:
> 
> |Oct 21 01:29:41 localhost pppd[10896]: pppd 2.4.2 started by wouter, uid 1000
> |Oct 21 01:29:41 localhost hcid[3587]: link_key_request (sba=00:0D:93:10:92:B6, dba=00:60:57:30:38:D8)
> |Oct 21 01:29:42 localhost chat[10897]: abort on (BUSY)
> |Oct 21 01:29:42 localhost chat[10897]: abort on (NO CARRIER)
> |Oct 21 01:29:42 localhost chat[10897]: abort on (VOICE)
> |Oct 21 01:29:42 localhost chat[10897]: abort on (NO DIALTONE)
> |Oct 21 01:29:42 localhost chat[10897]: send (AT&F^M)
> |Oct 21 01:29:42 localhost chat[10897]: expect (OK)
> |Oct 21 01:29:43 localhost chat[10897]: AT&F^M^M
> |Oct 21 01:29:43 localhost chat[10897]: OK
> |Oct 21 01:29:43 localhost chat[10897]:  -- got it
> |Oct 21 01:29:43 localhost chat[10897]: send (ATDT+3222750205^M)
> |Oct 21 01:29:43 localhost chat[10897]: expect (CONNECT)
> |Oct 21 01:29:43 localhost chat[10897]: ^M
> |Oct 21 01:30:03 localhost chat[10897]: ATDT+3222750205^M^M
> |Oct 21 01:30:03 localhost chat[10897]: CONNECT
> |Oct 21 01:30:03 localhost chat[10897]:  -- got it
> |Oct 21 01:30:03 localhost pppd[10896]: Serial connection established.
> |Oct 21 01:30:03 localhost kernel: divert: not allocating divert_blk for non-ethernet device ppp0
> |Oct 21 01:30:03 localhost pppd[10896]: Using interface ppp0
> |Oct 21 01:30:03 localhost pppd[10896]: Connect: ppp0 <--> /dev/rfcomm0
> |Oct 21 01:30:16 localhost pppd[10896]: Serial line is looped back.
> |Oct 21 01:30:16 localhost pppd[10896]: Connection terminated.
> |Oct 21 01:30:16 localhost kernel: divert: no divert_blk to free, ppp0 not ethernet
> |Oct 21 01:30:28 localhost pppd[10896]: Terminating on signal 15.
> |Oct 21 01:30:28 localhost pppd[10896]: Exit.
> 
> While this happens, I can see the Nokia does set up the connection;
> however, it drops the line somewhere between the "Connect: ppp0 <-->
> /dev/rfcomm0" and te "Serial line is looped back" message. When that
> happens, it appears as if pppd does not immediately notice.

what kernel version is this? Maybe it is a kernel bug in the PPP code or
your settings for pppd are simply wrong. Try other dialers like wvdial.

Regards

Marcel





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
