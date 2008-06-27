Return-Path: <cyrus@holtmann.org>
Message-ID: <024a01c8d88d$5515a790$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <1214593557.6131.26.camel@bongo>
Date: Fri, 27 Jun 2008 14:38:08 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
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

Is this version working against the old DBus interface, the new, experimental interface, or does it matter?

DS
----- Original Message ----- 
From: "Michael Terry" <michael.terry@canonical.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Friday, June 27, 2008 2:05 PM
Subject: [Bluez-devel] Wizard patch


Hello, all!

I have attached a patch against 0.27 (it applies cleanly against CVS) to
complete the wizard in the bluez-gnome source tree.

Here's what my patch does in summary, details below:
Wizard dialog shows list of device types we know how to handle (only
mouse/keyboard/headset right now).  Then, it tries to connect to the
appropriate bluetooth dbus service and trust the device.  Basically the
same code steps the Properties -> Services tab does, but more
wizardy.  :)

I made changes to cleanup the wizard interface (removed a couple of
pages that had low signal/noise ratio) and made several of the
bluetooth_client capable of giving feedback about the operation via a
callback.


Details of changes:

applet/main.c:
Uncomments code to add a menu item for the wizard.

common/bluetooth-device-selection.c:
Fixes broken code to set current filter programmatically.

common/client.[ch]:
setup_services():
Note presence of audio and input services on startup

bluetooth_client_get_name():
Gets user-visible device name for a path

bluetooth_client_available_services():
Returns a mask of the device types supported by services the client
knows about.  Not actually used by the rest of my code, but it seemed
possibly useful to one day not show unsupported device types in the
wizard if we wanted to.

bluetooth_client_cancel_call():
Cancels an async call for a particular adapter/address combo.  This is
slightly janky because it only allows for one call at a time per pair,
but that's all that we ever need right now.

connect_to_service():
Handles service-specific calls to initiate a device connection.  Stuff
like CreateSecureDevice or CreateHeadset.

bluetooth_client_connect():
Kicks off a call to connect_to_service

bluetooth_client_create_bonding():
bluetooth_client_remove_bonding():
bluetooth_client_set_trusted():
bluetooth_client_remove_trust():
Modified to allow callbacks

common/dbus.xml:
Add input.CreateSecureDevice and audio.CreateHeadset

properties/adapter.c:
Update a few calls to client functions do to above prototype changes

wizard/agent.[ch]:
Mostly a copy of applet/agent.c, except:
it only holds passkey code (no auth code)
it shows dialogs immediately wrt a parent window

wizard/main.c:
Comment out intro and info pages -- I think the intro page just gets in
the user's way and there was no content in info page, and even if there
was, it would probably also just get in user's way.

I added a pulsing progress bar to the pairing page to give some
feedback.

I changed wording from 'setup' and 'pair' to 'connect'.  I figure that
is more user-friendly (since no real setting up is done by user and they
probably think in terms of connecting to devices not pairing with them).

Pairing process is two-step: bluetooth_client_connect followed by
bluetooth_client_set_trusted.

Show an error if either step fails.

Connect to agent code to display a password prompt immediately in front
of user instead of via bluetooth applet.

wizard/Makefile.am:
Install bluetooth-wizard and add agent.[ch]

Thanks!
-mt


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
