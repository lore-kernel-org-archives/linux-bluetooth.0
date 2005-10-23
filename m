Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <435BDE1C.2070808@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth-Alsa: cannot pair the headset
References: <435B72B0.5050309@libero.it>
In-Reply-To: <435B72B0.5050309@libero.it>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Sun, 23 Oct 2005 13:01:48 -0600

hi

> # btsco -v 00:07:A4:14:0F:BF
> btsco v0.4
> Device is 2:0
> Error: Failed to connect to SDP server: Permission denied
> Assuming channel 2

It looks like you need to remove the link keys so the pairing can get
reset. There's something about that in the http://bluetooth-alsa.sf.org
page.

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
