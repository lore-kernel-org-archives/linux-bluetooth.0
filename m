Return-Path: <John281198@gmx.de>
Date: Mon, 30 Aug 2004 13:44:25 +0200 (MEST)
From: "Johannes Lintner" <John281198@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary13241093866265"
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
Message-ID: <1324.1093866265@www49.gmx.net>
List-ID: <bluez-users.lists.sourceforge.net>

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary13241093866265
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marcel,

ok, no problem.
The way, to start a server on the Handy I already tried, but I didn't had in
mind, that this has to be so, but to have a completely new connenction
between the devices (or has it to be so?).
The complete protocol is attached to the mail. The accosted lines exists
(see attachment - would it be better to see the java-sources?).

On the pc runs a server, that is listening to a connection. A mobile phone
searches for the device and the service, tries to connect an sends a 7byte
long string ("String!"). This way works without any problems. Immediately
after receiving, the server sends an 6byte long string("Handy!") to the
phone, using the same connection. But the phone only receives an empty
string.


Greetings  Johannes

-- 
Supergünstige DSL-Tarife + WLAN-Router für 0,- EUR*
Jetzt zu GMX wechseln und sparen http://www.gmx.net/de/go/dsl
--========GMXBoundary13241093866265
Content-Type: application/x-bzip; name="conProtocol.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="conProtocol.bz2"

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

--========GMXBoundary13241093866265--
