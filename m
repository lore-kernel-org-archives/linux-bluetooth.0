Return-Path: <cyrus@holtmann.org>
Message-ID: <89b6ba3a0810190954q3826a2a8i4c8087e3d43cf45d@mail.gmail.com>
Date: Sun, 19 Oct 2008 18:54:18 +0200
From: "Patryk Zawadzki" <patrys@pld-linux.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4AA04BF6-26EE-488D-A22C-37855410E2F7@gmail.com>
MIME-Version: 1.0
References: <mailman.81198.1224358186.3608.bluez-users@lists.sourceforge.net>
	<89b6ba3a0810181248u29129a09v50c7befde6741e5b@mail.gmail.com>
	<48FA49A4.9040908@powercraft.nl>
	<89b6ba3a0810190855g2aa8bd00v9fe2c782fe5efb3e@mail.gmail.com>
	<89b6ba3a0810190909l69688cb9n13c8000ca272767@mail.gmail.com>
	<4AA04BF6-26EE-488D-A22C-37855410E2F7@gmail.com>
Subject: Re: [Bluez-devel] [Bluez-users] Motorola S9 and BlueZ 4.14
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sun, Oct 19, 2008 at 6:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> I'm still investigating this, but it seems it's caused by patch
> e303ffce67951a29d822c8c819e74e2c70c297d7 from Luiz which forgot to
> remove set_state(OPEN) from avdtp_open_cmd() (his patch changes OPEN
> state change for the initiator case from the response reveiving to the
> stream L2CAP channel establishment). All in all looking at the AVDTP
> spec 1.2 it seems Luiz's patch isn't correct since according to figure
> 6.9 (page 35) the OPEN state should be entered *before* the stream
> L2CAP channel is established.

Ineed removing the set_state call from avdtp_open_cmd causes the
device to initialize correctly and even work with pulseaudio. If this
is correct according to the specification it is indeed the fix for the
case of Motorola S9.

-- 
Patryk Zawadzki

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
