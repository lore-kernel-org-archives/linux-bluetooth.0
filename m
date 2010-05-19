Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100519084715.GA11110@vigoh>
References: <1274181632-29873-1-git-send-email-johan.hedberg@gmail.com>
	 <20100519081037.GE6219@vigoh> <20100519082205.GA18772@jh-x301>
	 <20100519084715.GA11110@vigoh>
Date: Wed, 19 May 2010 15:55:17 +0200
Message-ID: <AANLkTimdw00tjbCHK52SNF9FGJjLVHR35f44dX_bzj__@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add blacklist support for incoming
	connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 19, 2010 at 10:48 AM, Gustavo F. Padovan
<gustavo@padovan.org> wrote:
> Hi Johan,
>
> * Johan Hedberg <johan.hedberg@nokia.com> [2010-05-19 10:22:05 +0200]:
>
>> Hi Gustavo,
>>
>> On Wed, May 19, 2010, Gustavo F. Padovan wrote:
>> > > In some circumstances it could be desirable to reject incoming
>> > > connections on the baseband level. This patch adds this feature through
>> > > two new ioctl's: HCIBLOCKADDR and HCIUNBLOCKADDR. Both take a simple
>> > > Bluetooth address as a parameter. BDADDR_ANY can be used with
>> > > HCIUNBLOCKADDR to remove all devices from the blacklist.
>> >
>> > Which circumstances?
>>
>> Whenever you have a badly behaving remote device that keeps on trying to
>> connect to you (e.g. an OPP spambot or someone trying to actively DoS
>> you). I gave some more details in my reply to Jaikumar a few days ago on
>> this mailing list.
>
> Nice. Patch looks ok to me by the way. ;)

Its also very, almost a must, convenient when doing interoperability
testing in some events like upf where we have a lot (annoying) devices
trying to reconnect to us while we are testing with other devices.

@ Johan, Blocked does supersedes Trusted right? Maybe we should rework
those properties (deprecate them?) to something like Authorization
which takes a string where lets say can assume these values: "deny"
("block"), "ask" or "allow".

-- 
Luiz Augusto von Dentz
Computer Engineer
