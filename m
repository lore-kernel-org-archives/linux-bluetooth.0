Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426FBD8A.8020006@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP sink code finally
References: <20050426123412.48950.qmail@web8310.mail.in.yahoo.com>
In-Reply-To: <20050426123412.48950.qmail@web8310.mail.in.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 27 Apr 2005 10:27:54 -0600

Guys,

I updated the docs to reflect the new a2play usage and basic a2snk 
operation.

I think the best effort spent on a2play now would be to:

  - use the real-time clock for timing
  - optionally open and perform ioctls on /dev/dsp to operate directly on it

Both of these should make live streaming tighter.

Timing improvements include both inserting delays and throwing out data 
when the link doesn't accept it fast enough (or to take up delay), but 
you only need the latter for live streaming.

Brad


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
