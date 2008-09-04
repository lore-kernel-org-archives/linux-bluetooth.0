Return-Path: <cyrus@holtmann.org>
From: James Cloos <cloos@jhcloos.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [BlueZ-Announce] Closing down the mailing lists at SourceForge
In-Reply-To: <1220456996.6714.46.camel@californication> (Marcel Holtmann's
	message of "Wed, 03 Sep 2008 17:49:56 +0200")
References: <1220456996.6714.46.camel@californication>
Date: Thu, 04 Sep 2008 02:11:45 -0400
Message-ID: <m363pc4eyv.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

>>>>> "Marcel" == Marcel Holtmann <marcel@holtmann.org> writes:

Marcel> The announcement mailing list has been quiet for some time
Marcel> now. With the new www.bluez.org website we do have a proper RSS
Marcel> enabled blog. Please use that one if you wanna stay up-to-date
Marcel> with releases and other important information.

Please also CC announcements to the linux-bluetooth list; rss is not a
useful replacement for a mailing list.

Marcel> For everybody who was subscribed to the commit mailing list, you
Marcel> can now also use RSS from the GIT web interface on kernel.org.

The contrib/hooks/post-receive-email file in the git repo does a great
job of sending out email notifications.  (And I see that you are using
it for the obexd.git repo.)  That would be an ideal way to make commit
notices available.

And kudos for moving to kernel.org.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
