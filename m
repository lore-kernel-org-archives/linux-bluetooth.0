Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 9 Oct 2007 10:07:02 -0400
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <20071009140702.GF7430@cathedrallabs.org>
References: <20071007184035.GA7430@cathedrallabs.org>
	<1191785016.3626.29.camel@cookie.hadess.net>
	<20071007234210.GD7430@cathedrallabs.org>
	<d120d5000710090651q5beb218fl79fbfba3cb02b94c@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <d120d5000710090651q5beb218fl79fbfba3cb02b94c@mail.gmail.com>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [RFC][PATCH 4/4] add support to ps3
	remote	controller
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

> I'd rather you not used BTN_* for remotes. BTN_T* are used mostly by
> joysticks and I am afraid we might confuse userspace... Might need to
> extend KEY_PROG*.
well, this remote has everything but the analog axis that a standard
playstation gamepad has, but has more buttons to serve as remote.
I never tried, but I think it's even possible to play a game using it.

> > +       [0x50] = BTN_SELECT,
> KEY_SELECT
> > +       [0x53] = BTN_START,
> Don't like using BTN_*, what does the button actually do?
see above, they're the select/start buttons you have in a game controller.

Thanks for the comments Dmitry, I'll work on the changes you've requested.

-- 
Aristeu


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
