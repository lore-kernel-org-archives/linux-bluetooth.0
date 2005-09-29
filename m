Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzus@bedatec.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can Anyone share their application which does the audio transfer between an PC and an headset.
Message-ID: <20050929101612.GA5398@uni-duesseldorf.de>
References: <20050929074616.71793.qmail@web36105.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050929074616.71793.qmail@web36105.mail.mud.yahoo.com>
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
Date: Thu, 29 Sep 2005 12:16:12 +0200

Swathi Mathur80 <swathi_mathur80@yahoo.com> wrote:
> I want to write an applications to exchange audio signal between an PC 
> (with Linux and BlueZ) on one side, and headset on the other side.

The headset shows up as an extra ALSA audio device when using btsco. 
Just use it as any other audio device.

Or do you really want to talk to the device yourself, bypassing btsco?


CU, ANdy


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
