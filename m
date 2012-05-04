Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1205021433560.18552@mathewm-linux>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
	<alpine.DEB.2.02.1205021433560.18552@mathewm-linux>
Date: Fri, 4 May 2012 16:10:12 -0300
Message-ID: <CAA37ikZmDD=f2HP-r+89he-qEA4w=oMGsBkTC4qbBBb3W0e8TA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ERTM state machine changes, part 2
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, May 2, 2012 at 6:40 PM, Mat Martineau <mathewm@codeaurora.org> wrot=
e:
>
> On Wed, 2 May 2012, Mat Martineau wrote:
>
>> This is the second patch series reworking the ERTM state machine and
>> closely related streaming mode code. =A0These patches include bug fixes
>> and segmentation of outgoing L2CAP data.
>>
>> RFCv1: =A0 Four of eight patches were merged.
>> RFCv2: =A0 Fixed the send lock patch, found and fixed a few more issues
>> =A0 =A0 =A0 =A0with locking, reference counting, and unused code. =A0Fou=
r of
>> =A0 =A0 =A0 =A0eight patches were merged.
>> PATCHv1: Confirmed ERTM operation with locking and segmentation updates
>>
>>
>> Mat Martineau (4):
>> =A0Bluetooth: Fix a redundant and problematic incoming MTU check
>> =A0Bluetooth: Restore locking semantics when looking up L2CAP channels
>> =A0Bluetooth: Lock the L2CAP channel when sending
>> =A0Bluetooth: Refactor L2CAP ERTM and streaming transmit segmentation
>>
>> include/net/bluetooth/bluetooth.h | =A0 =A02 -
>> include/net/bluetooth/l2cap.h =A0 =A0 | =A0 =A01 +
>> net/bluetooth/l2cap_core.c =A0 =A0 =A0 =A0| =A0184
>> +++++++++++++++++++------------------
>> net/bluetooth/l2cap_sock.c =A0 =A0 =A0 =A0| =A0 15 +--
>> 4 files changed, 103 insertions(+), 99 deletions(-)
>>
>> --
>> 1.7.10
>
>
> Patches 1, 2, and 3 might be appropriate for the bluetooth repository (no=
t
> just bluetooth-next).

I agree they might be candidates for bluetooth repository as well.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
