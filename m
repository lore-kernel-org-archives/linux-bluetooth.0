Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20071007184035.GA7430@cathedrallabs.org>
References: <20071007184035.GA7430@cathedrallabs.org>
Date: Sun, 07 Oct 2007 20:23:36 +0100
Message-Id: <1191785016.3626.29.camel@cookie.hadess.net>
Mime-Version: 1.0
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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

Hey Aristeu,

Some comments about your selection of keycodes, CC:'ing Dmitry for
comments.

For reference, here's a picture of the remote in question:
http://files.playstatic.com/playstation-3-hardware/bd-remote-2-playstation-3.jpg

On Sun, 2007-10-07 at 14:40 -0400, Aristeu Sergio Rozanski Filho wrote:
> And finally, adding support to PS3 remote controller.
> 
<snip> 
> +/* ps3 remote support */
> +static unsigned int ps3remote_keymap[] = {
> +	[0x16] = KEY_EJECTCD,
> +	[0x64] = KEY_AUDIO,
> +	[0x65] = KEY_ANGLE,
> +	[0x63] = KEY_SUBTITLE,
> +	[0x0f] = KEY_CLEAR,
> +	[0x28] = KEY_TIME,
> +	[0x00] = KEY_1,
> +	[0x01] = KEY_2,
> +	[0x02] = KEY_3,
> +	[0x03] = KEY_4,
> +	[0x04] = KEY_5,
> +	[0x05] = KEY_6,
> +	[0x06] = KEY_7,
> +	[0x07] = KEY_8,
> +	[0x08] = KEY_9,
> +	[0x09] = KEY_0,
> +	[0x81] = KEY_RED,
> +	[0x82] = KEY_GREEN,
> +	[0x80] = KEY_BLUE,
> +	[0x83] = KEY_YELLOW,
> +	[0x70] = KEY_DISPLAYTOGGLE,	/* display */

This is wrong. Display toggle is to change the LCD/CRT output on
laptops. KEY_INFO sounds like a better option.

> +	[0x1a] = BTN_TOP,		/* top menu */
> +	[0x40] = KEY_MENU,		/* pop up/menu */
> +	[0x0e] = KEY_ESC,		/* return */
> +	[0x5c] = KEY_OPTION,		/* options/triangle */
> +	[0x5d] = KEY_BACK,		/* back/circle */
> +	[0x5f] = KEY_SCREEN,		/* view/square */
> +	[0x5e] = KEY_ENTER,		/* cross */
> +	[0x54] = KEY_UP,
> +	[0x56] = KEY_DOWN,
> +	[0x57] = KEY_LEFT,
> +	[0x55] = KEY_RIGHT,
> +	[0x0b] = KEY_ENTER,
> +	[0x5a] = BTN_1,		/* L1 */
> +	[0x58] = BTN_2,		/* L2 */
> +	[0x51] = BTN_3,		/* L3 */
> +	[0x5b] = BTN_4,		/* R1 */
> +	[0x59] = BTN_5,		/* R2 */
> +	[0x52] = BTN_6,		/* R3 */

Use BTN_TL, BTN_TL2, BTN_TR and BTN_TR2. ("that's trigger left, trigger
left 2"). BTN_THUMBL and BTN_THUMBR are L3 and R3 respectively (thumb
left, thumb right).

> +	[0x43] = KEY_VENDOR,		/* PS button */

KEY_HOMEPAGE sounds better (Sony calls it the Home button).

> +	[0x50] = BTN_SELECT,
> +	[0x53] = BTN_START,
> +	[0x33] = KEY_BACK,		/* scan back */

KEY_REWIND

> +	[0x32] = KEY_PLAY,
> +	[0x34] = KEY_FORWARD,		/* scan forward */
> +	[0x30] = KEY_PREVIOUS,
> +	[0x38] = KEY_STOP,
> +	[0x31] = KEY_NEXT,
> +	[0x60] = KEY_PREVIOUSSONG,	/* slow/step back */

This one...

> +	[0x39] = KEY_PAUSE,
> +	[0x61] = KEY_NEXTSONG,		/* slow/step forward */

...and this one could probably do with additional keys being defined in
input.h

Slow/step forward could be KEY_SLOW, don't know about slow/step back.

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
