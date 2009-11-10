Return-Path: <cyrus@holtmann.org>
Message-ID: <4AF9721B.3010405@gmx.de>
Date: Tue, 10 Nov 2009 15:00:59 +0100
From: Susanne Goldammer <susanne.goldammer@gmx.de>
Reply-To: Susanne Goldammer <susanne.goldammer@gmx.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Make bluetoothd start w/o SDP Server
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

i was worrying about the missing cmdline option of bluetoothd which
would allow the new daemon to start without its internal sdp server.
Such an option was available for the old hcid.

So i created a patch for me to fix this in bluez-4.51 source, which
works fine here but might not be the best implementation.
Now I would like to know if anyone is interested in this patch at all
and might want to make it a bit more professional :-)

Or is there already another way to suppress the internal sdp server
starting, so the changes are not needed anymore????

Thanks for responses in advance !

Best regards
Susanne

