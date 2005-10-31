Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device configuration permissions
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051031180235.GA10264@localhost.localdomain>
References: <e1effdeb0510310919t4fb1ec61mba79f035a15c98f0@mail.gmail.com>
	 <1130779899.5848.28.camel@blade>
	 <20051031180235.GA10264@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1130782992.5848.39.camel@blade>
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
Date: Mon, 31 Oct 2005 19:23:12 +0100

Hi Johan,

> > sorry, but both are the wrong approaches. I don't wanna dictate the
> > security settings through the interface names and especially not with
> > keywords like "admin", "protected" etc. This is the wrong approach and
> > makes the interface really horribly, because the user shouldn't care
> > that much about it.
> 
> IMHO it would make it easier for the user to understand why some method
> doesn't work for him if the interface name had e.g. "admin" in it. I
> don't see how that makes the interface "horrible".

because if people try to use another security policy/rules, then the
names "admin" etc. are still present even if in their case these are no
longer commands where you need special rights. Don't try to dictate
security rules through the interface. We can split the interface in
logical parts, but not only for the reason of writing easy rules.

> > If our D-Bus rules file get big then this is the price we have to pay
> > for a nice clean interface. And I am gladly to paying this price then.
> 
> So having a rule for each method is ok? This is quite easily doable in
> the config file (although the file will become bigger and more difficult
> to maintain).

The same argument goes with SELinux. This will be something we have to
live with.

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
