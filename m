Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 00:12:12 -0500
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080129051211.GA14674@jake.ruivo.org>
References: <2bab7e280801061151s221838ccy9913e62ad4480706@mail.gmail.com>
	<1199706716.6584.4.camel@cookie.hadess.net>
	<2bab7e280801070449h3786dc47jb7811016f71af8e@mail.gmail.com>
	<1199711199.6584.13.camel@cookie.hadess.net>
	<2bab7e280801070640s76089762v208061db0fce57f7@mail.gmail.com>
	<20080107150345.GC6027@cathedrallabs.org>
	<2bab7e280801070712l493fc709v4797d4b6647b8b89@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <2bab7e280801070712l493fc709v4797d4b6647b8b89@mail.gmail.com>
Subject: [Bluez-devel] [PATCH 0/4] updated PS3 bluray remote patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is the updated patches based on latest CVS version. Still pending
the inclusion of some new key defines by Dmitry. Also, there're still
concerns about the keymap. I hope we get this sorted out this time.
Changes since the last series:
- support multiple keys at same time (the joystick keys can be pressed
  at same time, other keys aren't supported)
- changed cross button binding to BTN_0 (yes, I know we shouldn't use
  BTN_ with remotes, but I'm really out of ideas here, please advice)

-- 
Aristeu


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
