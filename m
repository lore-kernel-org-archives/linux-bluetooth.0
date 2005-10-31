Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device configuration permissions
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510310919t4fb1ec61mba79f035a15c98f0@mail.gmail.com>
References: <e1effdeb0510310919t4fb1ec61mba79f035a15c98f0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130779899.5848.28.camel@blade>
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
Date: Mon, 31 Oct 2005 18:31:39 +0100

Hi Claudio,

> There is a open issue that we need define. I was talking with Eduardo
> and Johan in the
> IrC channel about how design the Devices services and handle security.
> In our opinion
> read services should be available to all users and write service
> should be restricted.
> We have a lot of ways to define D-Bus rules, use path, interface,
> method name, user
> and/or a combination of these parameters.
> 
> Define method name rules, can make the maintenance hard. The easiest
> way is use interface
> to define rules.
> 
> Here are some interface names suggestions:
> Suggestion 1:
> org.bluez.Devices.Public
> org.bluez.Devices.Protected
> 
> Suggestion 2:
> org.bluez.Devices.admin
> org.bluez.Devices.user
> 
> 
> Do you agree with this approach of define different interfaces?
> If yes, do you have another suggestion for the interface name?

sorry, but both are the wrong approaches. I don't wanna dictate the
security settings through the interface names and especially not with
keywords like "admin", "protected" etc. This is the wrong approach and
makes the interface really horribly, because the user shouldn't care
that much about it. If our D-Bus rules file get big then this is the
price we have to pay for a nice clean interface. And I am gladly to
paying this price then.

For example we had the HCI security filter inside the kernel that blocks
certain HCI commands and events for normal users. This is not a bad idea
per se, but for some projects the general rules don't apply and they
need special settings. So we must give them a chance to adjust these
setting without cripling the interface for it. And writing these rules
or policies must not be easy.

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
