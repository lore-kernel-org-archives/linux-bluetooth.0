Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS PATCH]bluez-pin
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510311010x27fcd538w310b97f5999e7771@mail.gmail.com>
References: <e1effdeb0510311010x27fcd538w310b97f5999e7771@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130783963.32175.1.camel@wyatt.hadess.net>
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
Date: Mon, 31 Oct 2005 18:39:22 +0000

On Mon, 2005-10-31 at 16:10 -0200, Claudio Takahasi wrote:
> Hi,
> 
> here is the patch removing the support for old dbus versions.
> 
> The code style is a little weird, but I kept the code style :)
> 
> Who is responsible for maintain the bluez-pin?

GPE. I committed a few patches in my days, but the code is mostly
mature, or needs updates for new versions of d-bus. Please don't remove
the existing code, it's still being used by some distributions and would
make it impossible to upgrade any bluez utilities or libraries for some
people (like myself).

Cheers

---
Bastien Nocera <hadess@hadess.net> 




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
