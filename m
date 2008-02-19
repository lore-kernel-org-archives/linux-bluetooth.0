Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802191541y3912b4feie451f20550ffbbb3@mail.gmail.com>
Date: Tue, 19 Feb 2008 16:41:47 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <255b859d0802171852g2677eb74o3605150a07ac084@mail.gmail.com>
MIME-Version: 1.0
References: <255b859d0802171852g2677eb74o3605150a07ac084@mail.gmail.com>
Subject: Re: [Bluez-users] Multiple Earphone/Mic Headsets Intercom
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Peter

On Feb 17, 2008 7:52 PM, Peter Hollenbeck <pwhbeck@gmail.com> wrote:
> I know only a little about Bluetooth and BlueZ. I am interested in building
> an intercom that allows four headsets (phone and mic) to intercommunicate.
> The Bluetooth intercom profile appears to allow for only two devices. Is
> this so and does it apply to the BlueZ implementation?

you won't be able to have more than three sco connections
simultaneously through one bluetooth adapter. If your bluetooth
adapter is usb-connected it will take a kernel patch to get multiple
simultaneous connections. If it's uart-connected (typical for
embedded) then it will work without patching.

either way you will be writing your own userspace software to copy
audio around and negotiate connections.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
