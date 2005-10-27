Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <436044E9.8020703@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Makefile.am dependency problem
References: <435FFD9B.1030904@xmission.com> <1130364791.32634.1.camel@blade>
In-Reply-To: <1130364791.32634.1.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 26 Oct 2005 21:09:29 -0600

Marcel

>>I noticed a strange dependency problem... it's common in bluez where a
>>library is used. Header file changes don't force a recompile:
> 
> look at the bootstrap file. I forced this behavior.

The principle of "least surprise" would suggest that 'make' always
rebuilds everything as necessary. At least I would do that in my project
if I could figure out how to do it in the autosplat stuff.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
