Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Kyle Rose <krose+bluez@krose.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <877jpz1ath.fsf@nausicaa.krose.org>
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
	 <1097185188.7325.75.camel@pegasus>
	 <khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
	 <1097186322.7325.79.camel@pegasus>
	 <khnk6u289o5.fsf@hunter-killer.kendall.corp.akamai.com>
	 <87ekk82ar4.fsf@nausicaa.krose.org> <1097342518.12972.3.camel@pegasus>
	 <87zn2v1xry.fsf@nausicaa.krose.org> <1097359976.12972.5.camel@pegasus>
	 <877jpz1ath.fsf@nausicaa.krose.org>
Content-Type: text/plain
Message-Id: <1097395131.12972.20.camel@pegasus>
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
Date: Sun, 10 Oct 2004 09:58:51 +0200

Hi Kyle,

> > why do you enabled auth and encrypt? This is security mode 3. Disable it
> > and try again.
> 
> I just tried this with no auth or encrypt, and the same behavior
> ensues.

I never heard of a 64 bit bug in the HID support, but it seems that
there is one. I don't know if it is in the kernel or in the user space.
Do you tried the bluez-utils from CVS?

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
