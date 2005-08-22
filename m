Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzus@bedatec.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] authentication problem when pairing with headset
Message-ID: <20050822090249.GA4917@uni-duesseldorf.de>
References: <1124653868.4816.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1124653868.4816.16.camel@localhost.localdomain>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 22 Aug 2005 11:02:49 +0200

Matthias Grüter <mgrueter@ee.ethz.ch> wrote:
> I'm using a Logitech Mobile Freedom Headset with my iBook G4. I have
> been using this device for some time now, but since a week or so I'm not
> able to pair with my headset anymore.

Did you use it with the same dongle on another machine or OS?

> Output of btsco:
> # btsco -v 00:0D:44:32:D3:FF
> btsco v0.4c
> Device is 1:0
> Error: Failed to connect to SDP server: Permission denied
> Assuming channel 2
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Permission denied

This looks like wrong linkkeys. See the btsco page:

>> If you can't pair or connect with the headset, did you pair it with
>> another device? Did it help to reset the pairing by removing
>> /etc/bluetooth/link_key or /var/lib/bluetooth/[headsetaddr]/linkkeys or
>> by putting the headset in pair mode? You may have to redo this often if
>> you try to dual-boot windows or if you use the same dongle on another
>> computer.

Ups - I see there is an error in there. [headsetaddr] should be
[dongleaddr]. The headsetaddr is in the linkkeys file on the line with
the linkkey. It is enough to remove that single line, thus retaining
the other pairing information.

> What kind of authentication failure is this? And how can I solve this
> issue?
> My version of the bluez-tools is 2.18.
> The awkward thing is, that I'm still able to pair with other headsets
> (same model) and my headset is still able to pair with other computers
> or mobile phones.

Yes. sounds perfectly like this problem.


CU, Andy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
