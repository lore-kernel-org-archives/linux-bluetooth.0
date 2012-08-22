Return-Path: <cyrus@holtmann.org>
Message-ID: <1345651474.29868.344.camel@pohly-mobl1.fritz.box>
Subject: PBAP + two-step download
From: Patrick Ohly <patrick.ohly@intel.com>
To: Bluez <linux-bluetooth@vger.kernel.org>
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Jeremy Whiting <jpwhiting@kde.org>
Date: Wed, 22 Aug 2012 18:04:34 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

For IVI use cases, Mikel and I were discussing how a phone's address
book could be cached intelligently by an IVI head unit. The rough idea
is that first all contacts get pulled without PHOTO data. This data is
used to match the current phone address book with some potentially
cached local data. Then in a second step, the PHOTO data of all contacts
is requested (*). This is all done in the same PBAP session, so the
numbering of contacts is the same in both steps.

The goal is to get the essential data (names, phone numbers) quickly and
then add pictures later on.

There's one problem with the obexd API regarding this: the result of
PullAll does not include any information about the number that each
entry has in the current PBAP session.

For example, in the first step I get:
BEGIN:VCARD
N:John;;Doe
END:VCARD

In the second step I get:
BEGIN:VCARD
PHOTO:...
END:VCARD

There is no guarantee that this entry is for the same contact, is it?
For example, "John Doe" might have been removed in the meantime, to be
replaced by someone else. The API description also makes no guarantees
about the ordering of entries.

One could request additional data in the second step (and perhaps phones
will send it anyway), but doing the matching based on that anew is
expensive.

Would it be acceptable to extend PullAll() semantics? If the caller
gives the name of an existing target directory, obexd could write each
contact into a separate file in that directory, using a <number>.vcf
naming scheme.

Alternatively, the content of each vcard could be extended with a
"X-OBEXD-PBAP-NUMBER:x" where x is the number of that vcard.

(*) If there was a way to request only contacts which have a photo, that
would be used here. Is there something like it? Without it, the entire
address book needs to be read again with a filter that includes PHOTO
data and nothing else.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


