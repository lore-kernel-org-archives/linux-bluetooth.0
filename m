Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCID D-Bus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <5256d0b050909012577fcb19c@mail.gmail.com>
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126220839.5286.57.camel@blade> <5256d0b050909012577fcb19c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126258645.5227.16.camel@blade>
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
Date: Fri, 09 Sep 2005 11:37:25 +0200

Hi Pete,

> I think 0.5 is compatible with >0.35. The current FC4 only uses  0.33
> and I don't think its compatible with > 0.35. I think this is similar
> for a number of the current releases (I think most with gnome 2.10)
> but obviously isn't the case for the development streams that aren't
> releases yet.

having 0.33 is better than 0.23 and this is what Debian unstable still
uses. However lets make a list of the distributions:

	SuSE Linux 10.0		D-Bus 0.35
	Fedora Core 4		D-Bus 0.33
	Ubuntu Breezy		D-Bus 0.36
	Debian unstable		D-Bus 0.23

The only bad guy is Debian unstable and I don't care anymore. They use
Xorg finally and have GCC 4.0 etc., but they can't move over to the next
D-Bus generation. I think that is their problem now and the release of
bluez-utils-0.22 will definitely drop the support for the old D-Bus 0.23
version.

I like to base everything around the current D-Bus 0.50 release, because
the C API should be quite stable now. I will accept small workarounds to
make D-Bus 0.3x work, but as soon as the distributions update their
D-Bus libraries I will drop them.

This is not a nice thing to do, I know, but a wrong usage of D-Bus lets
hcid segfault and this is not what I want.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
