Return-Path: <cyrus@holtmann.org>
Message-ID: <4C63F363.4000400@nokia.com>
Date: Thu, 12 Aug 2010 16:13:07 +0300
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Question about phonebook_add_contact
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


  Hi!
I've got question about this part of code from beginning  
phonebook_add_contact func:

if ((contact->numbers == NULL && (contact->fullname == NULL ||
                         contact->fullname[0] == '\0')))
         return;

Is this checking really needed in that place? It is possible to have 
contacts data
in phonebook that have all data except phone set (by example: email 
addresses,
main address etc). In that condition when we want to pull target vcard 
entry, then
empty string will be returned even if user send ATTRIBUTE_MASK to 
include all fields
in the result.

I'm asking because I have problem with "0.vcf" vcard (this is 
responsible for personal
information of device owner). This entry by default does not have any 
phone's data
filled in address book but it is mandatory to put this in vcard-listing.
Actually, I am forced to initialize contact->numbers list with empty 
number even if
none of number is available to return correct result for "0.vcf."(in 
phonebook-tracker)...

Can this 'contact->numbers' checking be removed from there or maybe 
other phonebooks
rely on this behaviour?

BR,
Radek


