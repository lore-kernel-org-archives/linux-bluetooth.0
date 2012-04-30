Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1204300803350.2723@mathewm-linux>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
	<1335570655-30878-5-git-send-email-mathewm@codeaurora.org>
	<20120428001819.GA2917@joana>
	<alpine.DEB.2.02.1204300803350.2723@mathewm-linux>
Date: Mon, 30 Apr 2012 18:31:00 -0300
Message-ID: <CAA37ikZ0cNzp8Tgv63Jb_pPtQwOyRgom-8mK70RnrRt1HXLuNA@mail.gmail.com>
Subject: Re: [RFCv2 4/8] Bluetooth: Fix a redundant and problematic incoming
 MTU check
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Gustavo Padovan <gustavo@padovan.org>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Mon, Apr 30, 2012 at 6:04 PM, Mat Martineau <mathewm@codeaurora.org> wro=
te:
>
> Gustavo -
>
>
> On Fri, 27 Apr 2012, Gustavo Padovan wrote:
>
>> Hi Mat,
>>
>> * Mat Martineau <mathewm@codeaurora.org> [2012-04-27 16:50:51 -0700]:
>>
>>> The L2CAP MTU for incoming data is verified differently depending on
>>> the L2CAP mode, so the check is best performed in a mode-specific
>>> context. =A0Checking the incoming MTU before HCI fragment reassembly is
>>> a layer violation and assumes all bytes after the standard L2CAP
>>> header are L2CAP data.
>>>
>>> This approadch causes issues with unsegmented ERTM or streaming mode
>
>
> Oops, I need to fix this "approadch" typo.
>
>
>>> frames, where there are additional enhanced or extended headers before
>>> the data payload and possible FCS bytes after the data payload. =A0A
>>> valid frame could be as many as 10 bytes larger than the MTU.
>>>
>>> Removing this code is the best fix, because the MTU is checked later
>>> on for all L2CAP data frames (connectionless, basic, ERTM, and
>>> streaming). =A0This also gets rid of outdated locking (socket instead o=
f
>>> l2cap_chan) and an extra lookup of the channel ID.
>>
>>
>> I don't think we can remove this code from here. This check is different
>> from the ones you are talking, those are l2cap packets, here we are stil=
l
>> dealing with ACL fragments. This check is there to avoid accept a first
>> ACL packet that is too big. See 8979481328d.
>>
>> One possible solution is to add a slack value to the check, so we can
>> fit those 10+ bytes packets in it.
>
>
> If we just add slack, then we're depending on the real MTU checks to work
> correctly later. =A0Why bother with this early check at all?
>
> I think there's a misunderstanding about the code that is being removed. =
=A0It
> *is* checking the L2CAP MTU for that channel against the value in the L2C=
AP
> length header before the whole frame is assembled, which is why it should=
n't
> be involved with ACL fragments to begin with. =A0It is the only place in
> l2cap_recv_acldata that uses channel-specific information.
>
> This code tries to throw out the first ACL fragment if the L2CAP payload =
is
> longer than than the L2CAP MTU for that channel. =A0The ERTM and streamin=
g
> mode MTU has different meaning - it applies to the reassembled SDU payloa=
d,
> not the size of an individual PDU segment with the extra headers and FCS
> bytes. =A0There is already a length check in the fragment reassembly code=
 that
> makes sure no reassembled ACL frame exceeds 65535 bytes (look at how
> conn->rx_len is used).
>
> The original discussion around this code is here:
>
> http://thread.gmane.org/gmane.linux.bluez.kernel/7505
>
> The purpose was to address a memory allocation failure in __get_free_page=
s -
> which suggests heap corruption. =A0Even if the start fragment is too larg=
e,
> that shouldn't lead to heap corruption, especially if the fragment is
> properly freed. =A0Throwing out this large packet is just hiding the real=
 bug!
>
> The MTU is checked everywhere that it needs to be for L2CAP data, after t=
he
> ACL fragments are reassembled:
>
> * In l2cap_reassemble_sdu for ERTM and Streaming Mode
> * In l2cap_data_channel for Basic Mode
> * In l2cap_connless_channel for connectionless channels
>
> The code being removed doesn't address the signaling channel, because tha=
t
> channel is not in the channel list. The spec defines the MTU for the
> signaling channel to be "MTUsig", and only requires it to be at least 48
> bytes (672 bytes if extended flowspec is supported). =A0It is valid for u=
s not
> to enforce a limit on it other than the maximum L2CAP frame size.
>
>
> We removed this code (because it broke AMP) from our Android kernel back =
in
> September 2011, and have been through several qualifications and rounds o=
f
> testing since then without problems.

Mat, I agree with you here and the patch looks good IMO.

Gustavo, maybe you can have a second look at this patch? The check
indeed looks to be in the wrong layer and it'd be good to remove sk
lock usage and the extra channel lookup for every ACL initial
fragment.

Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
