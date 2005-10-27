Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Makefile.am dependency problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <436044E9.8020703@xmission.com>
References: <435FFD9B.1030904@xmission.com> <1130364791.32634.1.camel@blade>
	 <436044E9.8020703@xmission.com>
Content-Type: text/plain
Message-Id: <1130400458.32634.14.camel@blade>
Mime-Version: 1.0
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
Date: Thu, 27 Oct 2005 10:07:38 +0200

Hi Brad,

> >>I noticed a strange dependency problem... it's common in bluez where a
> >>library is used. Header file changes don't force a recompile:
> > 
> > look at the bootstrap file. I forced this behavior.
> 
> The principle of "least surprise" would suggest that 'make' always
> rebuilds everything as necessary. At least I would do that in my project
> if I could figure out how to do it in the autosplat stuff.

I changed it in the BlueZ CVS to give it a try again. I can't remember
why I disabled it, but there was a reason for it. You might wanna take a
look at bootstrap and bootstrap-configure now.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
