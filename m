Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] missing keys from logitech dinovo keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Dick <dm@chello.nl>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200407061222.47729.dm@chello.nl>
References: <200407061222.47729.dm@chello.nl>
Content-Type: text/plain
Message-Id: <1089110433.4504.134.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 06 Jul 2004 12:40:33 +0200

Hi Dick,

> I'm playing with showkey from kbd (http://freshmeat.net/projects/kbd/)
> All keys are shown except "New" (FnF1), "Reply" (FnF2), "Forward" (FnF3), 
> "Send" (FnF4), "Redo" (FnF6), "Print" (FnF7), "Save" (FnF8), "My 
> Doc" (FnF10), "My Pic" (FnF11) and "My Music" (FnF12) (you get those by 
> enabling F-Lock)
> Undo (FnF5) and MyComp (FnF9) work though, giving keycode 144 and 145
> I'm using 2.6.7-mh1 and bluez-(utils/libs)2.7
> Is this a bug or am I missing something?

I don't know. I never checked the extra keys of my diNovo desktop, but
maybe the HID parser didn't take them into account and transforms them
into the correct key events. Feel free to look at the kernel code.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
