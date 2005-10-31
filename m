Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510310919t4fb1ec61mba79f035a15c98f0@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Device configuration permissions
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
Date: Mon, 31 Oct 2005 15:19:55 -0200

Hi Marcel,

There is a open issue that we need define. I was talking with Eduardo
and Johan in the
IrC channel about how design the Devices services and handle security.
In our opinion
read services should be available to all users and write service
should be restricted.
We have a lot of ways to define D-Bus rules, use path, interface,
method name, user
and/or a combination of these parameters.

Define method name rules, can make the maintenance hard. The easiest
way is use interface
to define rules.

Here are some interface names suggestions:
Suggestion 1:
org.bluez.Devices.Public
org.bluez.Devices.Protected

Suggestion 2:
org.bluez.Devices.admin
org.bluez.Devices.user


Do you agree with this approach of define different interfaces?
If yes, do you have another suggestion for the interface name?

Regards,
Claudio
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
