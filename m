Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 24 May 2012 16:44:47 -0300
Message-ID: <CAMOw1v7BR1H9iAROyufdccyJS+WNLMFfRyxgJxt0iQ9SPP0Z-Q@mail.gmail.com>
Subject: [PROPOSAL bluetoothd/obexd] doc/features.txt and doc/TODO
To: Marcel Holtmann <marcel@holtmann.org>, Denis Kenzior <denkenz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

Some times (mainly when I'm preparing presentations about BlueZ) I
have to dig the source code and commit log to check which version and
features of each protocol is supported in BlueZ. I think this is a
common pattern for other BlueZ developers as well. It matters even
more when we are proposing implementations of new features (and then
we realize it's already implemented) or when we are trying to cover a
use case that depends on a feature not done yet.

I propose to follow what oFono does, by maintaining a
doc/features.txt and a doc/TODO  (I don't think the
"Priority"/"Complexity" is very important in the latter but could be
done as well). I'd prefer each developer to fill in the file for
profiles he's used with, so the end result is more accurate than if we
had only 1 person to do it all. I can contribute an initial version
with the features I found the last time I did that.


What do you think?

Regards,
Lucas De Marchi
