Return-Path: <fd@cisco.com>
Subject: Re: [Bluez-users] Logitech MX900 oddities and solutions
From: Frederic Detienne <fd@cisco.com>
Reply-To: fd@cisco.com
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078915401.2537.14.camel@pegasus>
References: <1078912919.32148.356.camel@metal.cisco.com>
	 <1078915401.2537.14.camel@pegasus>
Content-Type: text/plain
Message-Id: <1078917509.32636.453.camel@metal.cisco.com>
Mime-Version: 1.0
Date: Wed, 10 Mar 2004 12:18:29 +0100
List-ID: <bluez-users.lists.sourceforge.net>

On Wed, 2004-03-10 at 11:43, Marcel Holtmann wrote:

> you can enable it with the --enable-compat switch for configure, but by
> default this is not on.

I forgot to say that. The problem is that it did not compile anything
(Make says there is "nothing to make for all"). I may have done dirty
things while fiddling around. I will try downloading again from CVS and
do it cleanly.

Don't you thing hcitool should be made current and not just "compat" ?
It is a precious tool...

> > http://sourceforge.net/mailarchive/forum.php?thread_id=3803086&forum_id=1883
> > 
> > I would have expected this patch to be part of -mh4 (that is what I
> > remember having read) but it was not there. It should! :-) I can't wait
> > to have the patches synced to the 2.6 kernel tree.
> 
> I never said that I include the multi-byte patch into -mh4. It seems
> that some people assume this, but this is not true. Use diffstat to
> check the patch and you will see that it only changes Bluetooth stuff.

I realized that after debugging hid2hci :-) So the multibyte fix is
intentionally not part of -mh4. It is good that you confirm that fact.

> However Vojtech Pavlik told me that he will push these patches for
> mainline integration.

You mean the multibyte stuff, right ? What about the -mh4 patch, util2
and lib2 ? Will they be made grand public soon ?

> I add your device ID to the CVS.

thanks!

> If you start the hcid it will modifiy your link policy settings and it
> is important that RSWITCH and SNIFF is on.

slap me! that's exactly what is in /etc/bluetooth/hcid.conf. I guess
I'll have to learn more about BT now that I can experiment with it.

Pseudo-mistery solved.

thanks again!

	fred
