Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120220144453.GE27197@aemeltch-MOBL1>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329748173.2172.0.camel@aeonflux>
	<20120220144453.GE27197@aemeltch-MOBL1>
Date: Mon, 20 Feb 2012 12:52:48 -0200
Message-ID: <CAA37ikaRSnvSYXgDDh7mviFwSC2Ex=XoDLQ8JfBfNwEgwTxBaQ@mail.gmail.com>
Subject: Re: [RFCv6 00/14] Bluetooth: Change socket lock to l2cap_chan lock
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 20, 2012 at 12:44 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Marcel,
>
> On Mon, Feb 20, 2012 at 03:29:33PM +0100, Marcel Holtmann wrote:
>> Hi Andrei,
>>
>> > Changing socket lock to L2CAP chan lock in L2CAP code. Needed for impl=
ementing
>> > protocol above L2CAP without creating sockets.
>> >
>> > Changes:
>> > =A0 =A0 * RFCv6: Same code but patches 2,3 and 4 from RFCv5 are merged=
 together
>> > =A0 =A0 following recommendations from review.
>> > =A0 =A0 * RFCv5: Fixed locking bug in l2cap_data_channel, added locks =
in
>> > =A0 =A0 l2cap_sock_shutdown function, fixed several styles issues.
>> > =A0 =A0 * RFCv4: Better split patches so they looks more clear and obv=
ious,
>> > =A0 =A0 taking coments about naming change and delete unused vars. See=
 diff change
>> > =A0 =A0 from the previous version below:
>> > =A0 =A0 * RFCv3: Split the big patch to several small (I believe logic=
al) chunks,
>> > =A0 =A0 remove unneded locks from cleanup_listen, use the same argumen=
ts for
>> > =A0 =A0 locked/unlocked socket error functions.
>> > =A0 =A0 * RFCv2: Convert l2cap channel list back to mutex from RCU lis=
t.
>>
>> so what is the general status of this patch series. Are there still
>> concerns or opens? Or should it be go for final review and be merged?
>
> The code looks now good enough for final review.

Marcel, the code looks good for final review and merge. The only thing
concerns me is the change to chan->lock instead of sock lock seems to
be split too much. I mean that we have this change done in a series of
patches while it might be better to change everything at once. Not
sure if worrying about intermediate states here is something you care
or not, though, because I'm almost sure they'll be broken doing it in
small pieces.

And IMO it'd be good if Padovan could take a look at the patches
moving to chan->lock as well.

Regards,
--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
