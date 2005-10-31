Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Device configuration permissions
Message-ID: <20051031180235.GA10264@localhost.localdomain>
References: <e1effdeb0510310919t4fb1ec61mba79f035a15c98f0@mail.gmail.com> <1130779899.5848.28.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130779899.5848.28.camel@blade>
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
Date: Mon, 31 Oct 2005 20:02:35 +0200

Hi Marcel,

On Mon, Oct 31, 2005, Marcel Holtmann wrote:
> sorry, but both are the wrong approaches. I don't wanna dictate the
> security settings through the interface names and especially not with
> keywords like "admin", "protected" etc. This is the wrong approach and
> makes the interface really horribly, because the user shouldn't care
> that much about it.

IMHO it would make it easier for the user to understand why some method
doesn't work for him if the interface name had e.g. "admin" in it. I
don't see how that makes the interface "horrible".

> If our D-Bus rules file get big then this is the price we have to pay
> for a nice clean interface. And I am gladly to paying this price then.

So having a rule for each method is ok? This is quite easily doable in
the config file (although the file will become bigger and more difficult
to maintain).

Johan


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
