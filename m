Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] access restrictions after passing PIN
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1687ed8405042723003ae1da8e@mail.gmail.com>
References: <1687ed8405042723003ae1da8e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114768375.8836.52.camel@pegasus>
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
Date: Fri, 29 Apr 2005 11:52:55 +0200

Hi Godfryd,

> I've got a question. Is there any restriction of accessing services
> after passing the pairing procedure? I think about situation when both
> devices are paired and I suppose that now there is no restriction of
> use of any services like serial port or any other. So is there a
> danger of overuse of these services (i.e. in mobile phones it is
> possible to manage them seemlessly through serial port from PC)?

this depends on if the device implements a policy manager or not. If it
uses a simple trust model based on the link key and the device address
then there are no other restrictions.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
