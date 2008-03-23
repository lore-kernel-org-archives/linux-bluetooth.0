Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300803231250v4d2914a8ie368820a0993a41d@mail.gmail.com>
Date: Sun, 23 Mar 2008 13:50:21 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] gui pairing issues with windows mobile 6
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

Hi

Has anyone noticed issues when pairing with windows devices?

Using an at&t tilt and bluez-gnome from gutsy, I tried a dozen times
to pair my laptop and the phone. I'd initiate ppp from the laptop, the
confirm dialog and pin dialog would appear on the phone, the gnome pin
dialog would appear, then the phone would close the connection.
hcidump showed the laptop sending the pin and then immediately getting
a disconnection from the remote end. bluez-utils is from a recent cvs
head so it's not the best setup for making it reproducible.

I logged out and used passkey-agent from cvs head and the pairing
completed the first time.

My n810 was able to pair with it on the first try, using the gui.

I will be able to try bluez-gnome from head or the last release when I
have normal network access again, but at the moment I'm just relieved
that I have something that is working.

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
