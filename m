Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d120d5000710090651q5beb218fl79fbfba3cb02b94c@mail.gmail.com>
References: <20071007184035.GA7430@cathedrallabs.org>
	<1191785016.3626.29.camel@cookie.hadess.net>
	<20071007234210.GD7430@cathedrallabs.org>
	<d120d5000710090651q5beb218fl79fbfba3cb02b94c@mail.gmail.com>
Date: Tue, 09 Oct 2007 15:06:29 +0100
Message-Id: <1191938789.3626.85.camel@cookie.hadess.net>
Mime-Version: 1.0
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

On Tue, 2007-10-09 at 09:51 -0400, Dmitry Torokhov wrote:
> Hi Aristeu,
> 
> On 10/7/07, Aristeu Sergio Rozanski Filho <aris@ruivo.org> wrote:
> > Hi Bastien,
> >
> > > Some comments about your selection of keycodes, CC:'ing Dmitry for
> > > comments.
> > thanks for you comments
> >
> > > > +   [0x70] = KEY_DISPLAYTOGGLE,     /* display */
> > >
> > > This is wrong. Display toggle is to change the LCD/CRT output on
> > > laptops. KEY_INFO sounds like a better option.
> > indeed
> >
> > > > +   [0x5a] = BTN_1,         /* L1 */
> > > > +   [0x58] = BTN_2,         /* L2 */
> > > > +   [0x51] = BTN_3,         /* L3 */
> > > > +   [0x5b] = BTN_4,         /* R1 */
> > > > +   [0x59] = BTN_5,         /* R2 */
> > > > +   [0x52] = BTN_6,         /* R3 */
> > > Use BTN_TL, BTN_TL2, BTN_TR and BTN_TR2. ("that's trigger left, trigger
> > > left 2"). BTN_THUMBL and BTN_THUMBR are L3 and R3 respectively (thumb
> > > left, thumb right).
> > cool, will do it
> >
> 
> I'd rather you not used BTN_* for remotes. BTN_T* are used mostly by
> joysticks and I am afraid we might confuse userspace... Might need to
> extend KEY_PROG*.

It's a Playstation 3 remote, and those buttons are supposed to do the
same as those buttons on the joypads.

> > > > +   [0x43] = KEY_VENDOR,            /* PS button */
> > > KEY_HOMEPAGE sounds better (Sony calls it the Home button).
> > oh, ok
> >
> > > > +   [0x33] = KEY_BACK,              /* scan back */
> > > KEY_REWIND
> > duh, didn't found this one
> >
> > > > +   [0x60] = KEY_PREVIOUSSONG,      /* slow/step back */
> > > This one...
> > >
> > > > +   [0x61] = KEY_NEXTSONG,          /* slow/step forward */
> > > ...and this one could probably do with additional keys being defined in
> > > input.h
> > >
> > > Slow/step forward could be KEY_SLOW, don't know about slow/step back.
> > KEY_SLOWREWIND/KEY_SLOWFORWARD?
> > I'm attaching the input.h change and the updated patch.
> > What you think Dmitry?
> >
> 
> I think HUT defines Frame Forward and Frame Back keys, we shoudl use
> similar names.

Nod.

> > +static unsigned int ps3remote_keymap[] = {
> > +       [0x16] = KEY_EJECTCD,
> > +       [0x64] = KEY_AUDIO,
> > +       [0x65] = KEY_ANGLE,
> > +       [0x63] = KEY_SUBTITLE,
> > +       [0x0f] = KEY_CLEAR,
> > +       [0x28] = KEY_TIME,
> > +       [0x00] = KEY_1,
> > +       [0x01] = KEY_2,
> > +       [0x02] = KEY_3,
> > +       [0x03] = KEY_4,
> > +       [0x04] = KEY_5,
> > +       [0x05] = KEY_6,
> > +       [0x06] = KEY_7,
> > +       [0x07] = KEY_8,
> > +       [0x08] = KEY_9,
> > +       [0x09] = KEY_0,
> 
> I know we are using KEY_0 in lots of remotes but this does not quite
> work for users whose keymaps have digits in upper register (such as
> Czech or French). In the past Vojtech recommended using KEY_KP* but
> that will only work if NumLock is active... Should we define another
> set of constants for remote and other keypads.

This sounds good.
<snip>
> > +       [0x43] = KEY_HOMEPAGE,          /* PS button */
> > +       [0x50] = BTN_SELECT,
> 
> KEY_SELECT
> 
> > +       [0x53] = BTN_START,
> 
> Don't like using BTN_*, what does the button actually do?

It's the same as the START button on the joypad.

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
