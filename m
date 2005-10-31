Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with permissions
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <efa8e58e0510310608s1ef3ddf2h78d11604f4090a31@mail.gmail.com>
References: <efa8e58e0510310608s1ef3ddf2h78d11604f4090a31@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130770569.8578.3.camel@blade>
Mime-Version: 1.0
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
Date: Mon, 31 Oct 2005 15:56:09 +0100

Hi Rune,

> I've been googling around the past week trying to figure out a way to do this..
> I am able to run everything as root, but when it comes to regular
> users i'm able to run "hcitool scan" but not "hcitool cc
> XX:XX:XX:XX:XX" or "hciconfig hci0 up" because operation is not
> permitted.

these operation are protected by CAP_NET_RAW and CAP_NET_ADMIN.

> I tried using hotplug to set the permissions on the rfcommX devices,
> without luck. Then i switched to udev i great hope. But the problems
> seems to persist. The rfcommX device nodes never get created with
> udev, I dont know if they should though. Maybe someone has a better
> answer..

You need to use rfcomm to actually bind a TTY. Otherwise they will not
exists and thus not created.

> The reason i'm trying to do this, is i'm using a regular user to
> develop a java application using the jbluez package, which provides
> access to the BlueZ stack. But I am unable to create connections.

The Bluetooth core will create the ACL links for you, so you don't have
to worry about them. Every user can create L2CAP and RFCOMM connections.

> I read something about changing the kernel HCI security filter, but it
> didn't make too much sense to me...

If you wanna different rights then you need to modify this filter.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
