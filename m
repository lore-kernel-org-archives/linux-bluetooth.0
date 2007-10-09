Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100710091417s1dc1adddh4e3020b81595fe24@mail.gmail.com>
Date: Tue, 9 Oct 2007 18:17:59 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Fabien Chevalier" <fabchevalier@free.fr>
In-Reply-To: <470B5184.1070507@free.fr>
MIME-Version: 1.0
References: <de4879e80710011431q3fa8c870m95a08dc46ea9a679@mail.gmail.com>
	<de4879e80710051236j243ff5c6mc6bd18e5c43640a6@mail.gmail.com>
	<2d5a2c100710081056m6391d8aao6fbc2d2b1aa34948@mail.gmail.com>
	<1191884194.12212.13.camel@aeonflux.holtmann.net>
	<d89ddf300710081832w1ac37dfana49571dc9306dbf2@mail.gmail.com>
	<470B356F.1050805@silicom.fr>
	<1191919440.31341.9.camel@aeonflux.holtmann.net>
	<470B5184.1070507@free.fr>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] Patch: inheritance problem in gsta2dpsink
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

Hi Fabien

On 10/9/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
> I was more thinking of as a complete rewrite of ipc.h (we should find it
> another name btw : lets call it newipc.h for now ;-) ).
> I already started thinking to how i would like to see it look.
> It should be relatively lightweight, expose directly a message based API
> (as you would find on most RTOS), with just a few functions to create
> and free a session to the audio daemon, and to retrieve the data socket,
> so that each user wouldn't have to know the tricks about ancilliary data
> passing :-)
> I fact it should be so lightweight that i think we could static inline
> all the functions, and thus we wouldn't even need a *.c file.
>
> I'm waiting for comments, int the meantime i'm gonna start drafting a
> newipc.h :-)

Good, I need to rework ipc anyway since there is no capabilities exchange
between the daemon and the plugin and that cause some problems to make
plugin able choose codec parameters. Right now the daemon choose the best
option it find and return to plugin, we should change that so the plugin could
get the device capabilities and choose the best option by it own.

Thiago is having a good progress with gstreamer plugin, so this is a very good
opportunity to work together and make it happen.

My name suggestion is: libbtaudio

Btw I have no problem with LGPL.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
