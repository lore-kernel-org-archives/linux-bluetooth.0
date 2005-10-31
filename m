Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
Message-ID: <20051031120753.GA31744@localhost.localdomain>
References: <20051029175338.GA26114@localhost.localdomain> <1130609278.5396.48.camel@blade> <20051029184820.GA26657@localhost.localdomain> <1130612847.5396.51.camel@blade> <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
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
Date: Mon, 31 Oct 2005 14:07:53 +0200

Hi Claudio,

On Mon, Oct 31, 2005, Claudio Takahasi wrote:
> - use session bus to send the PinRequest message: using the session
> bus it's possible start the dbus pin helper application automatically

I don't think that's the right thing or even a possible thing to do.
This is because hcid is a system-wide daemon and cannot know about users
session busses.

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
