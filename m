Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Device Configuration D-Bus services
Message-ID: <20051025120646.GA26339@localhost.localdomain>
References: <e1effdeb0510190606x50364b25y52a5092847000105@mail.gmail.com> <3013cac80510241400k2b71125ao7b8b4dfe5077a300@mail.gmail.com> <1130189692.7840.21.camel@blade> <3013cac80510250452j702622acw98ed9abef758bca1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3013cac80510250452j702622acw98ed9abef758bca1@mail.gmail.com>
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
Date: Tue, 25 Oct 2005 15:06:46 +0300

On Tue, Oct 25, 2005, Eduardo Rocha wrote:
> The point is, as we have merged the main operations in two functions (set
> and get), so we have to identify the operation by an integer or by a string
> constant. It seems that a string is better for python binding (can anyone
> confirm that?).

At least by using strings it would be much easier to understand what the
client code is doing, e.g. if you compare
SetProperty("page-timeout", 10)
vs. 
SetProperty(3, 10)

So, I vote for using strings instead of integers.

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
