Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4362425D.5000402@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT-alsa with HT820(MOTO)
References: <4CA6E08AA4616B4FB0BAC7A889A3E9F0045EE90C@pdsmsx404>
In-Reply-To: <4CA6E08AA4616B4FB0BAC7A889A3E9F0045EE90C@pdsmsx404>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 28 Oct 2005 09:23:09 -0600

Jieke

You may need a current kernel like 2.6.13. Module api changes have
happened from time to time that give us trouble.

It could also be your bluetooth adapter. read
http://bluetooth-alsa.sf.net and go to the troubleshooting section. That
will show you how to check the adapter.

>        I have enabled the link with HT820 on my 2.6.9 kernel (PC), also
> I can send the data with ACL to MOTO headset, below is something hcidump
> catched. But still no any audio output can be listened on headset part.
> Any one can deliver some hint? Thanks.
> 

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
