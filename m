Return-Path: <cyrus@holtmann.org>
Message-ID: <48333FBD.9090202@free.fr>
Date: Tue, 20 May 2008 23:16:45 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@nokia.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Frederic Dalleau <frederic.dalleau@access-company.com>,
 Sebastien Baguet <sbaguet@silicom.fr>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Back to some bluez-related work
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Dear Marcel, Johan, Luiz, Frederic and all,

It's been a while i haven't been active on the mailing list.
Main reason is that i didn't use any of my spare time to work on Bluez
related stuff, and that the customer that was
paying for my bluez work on business time ran out of credit... that's
too bad. :-(

Anyway, this is all part of the past now, as this customer has managed
to find some fresh new cash...
which means i will be able to do some work on business time again ! :-)

I've taken a look to the CVS for the used-to-be-named audio service, and
i've noticed not so many things have changed,
given the time elapsed, which i would consider to be a good sign of
maturity from the audio service code. ;-)
I've seen some work from Alok considering  HFP AG over DBUS, with new
signals implemented, as well as an e-mail
about the "Telephony framework", which sounds to still be in an early
design phase.
I guess we'll take time to have a closer look at the code, as we're
gonna now do some HFP related work : we basically need to be able
to plug a telephony framework on top of Bluez, using an interface that
is expected to be somewhat stable for the next two years or so.
Goal is for now to to really basic stuff such as answer/reject and
hangup a call.

'just noticed i wrote 'we' in the previous sentence, i guess that needs
some clarification : the bad news is that i'm currently too busy at work
to be able to provide enough time for this project. I will be assisted
from a junior engineer called Sebastien. He's never worked on an open
source project before, but is more than enough skilled regarding Linux
system & C language, and has some working knowledged about bluetooth and
bluez in general. He's likely gonna do most of the actual work, while
i'm gonna be doing useless and boring stuff such as writing this e-mail
at a time i should already in be in bed :-)

Yet another thing: It's a shame i won't be able to make it for the next
bluez developper meeting, as i will be visiting familly in Marocco
during this very same week :-(.

Hope to hear from you soon on this ML or #bluez !

Regards,

Fabien
