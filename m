Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120219105126.GA27110@x220.P-661HNU-F1>
References: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
	<20120219105126.GA27110@x220.P-661HNU-F1>
Date: Sun, 19 Feb 2012 10:13:09 -0300
Message-ID: <CAA37ikbuWrH96UzspMz10QiumfuD+wyJ1BozJ0=HGWFN_8ayNg@mail.gmail.com>
Subject: Re: [RFC v2 0/4] MGMT Start Discovery interleaved support
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, Feb 19, 2012 at 7:51 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andre,
>
> On Fri, Feb 17, 2012, Andre Guedes wrote:
>> This RFCv2 series implements Marcel's and Johan's comments from previous
>> version. The changes are:
>> 1. Use MGMT_ADDR_* macros instead of hard-coded values to define discovery
>> type macros;
>> 2. Fix locking in mgmt_interleaved_discovery
>>
>> Marcel, I removed your ack from patch 1/4 because I changed it a little
>> bit. MGMT_ADDR_* macros were moved to hci_core.h since they are needed to
>> define discovery type macros.
>
> All four patches have been applied to my bluetooth-next tree. Thanks.
>
> I'd still like to have consistency in the locking since now your
> function is the only one handling the hdev lock by itself and that's
> something that can easily cause bugs in the long run. I.e. probably all
> mgmt_* functions should be converted to take hdev unlocked and handle
> the locking by themselves.

Do you think such a change is worth? I'm not sure if we have just one
function that deals with locking on its own.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
