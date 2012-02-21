Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120221175602.GC22229@joana>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20120221175602.GC22229@joana>
Date: Tue, 21 Feb 2012 22:44:48 +0200
Message-ID: <CAMXE1-onX6Dwhes4xqZ3HPEr=Y5U2mUF8sc0ERAKnMOD_1sMaQ@mail.gmail.com>
Subject: Re: [PATCHv1 12/14] Bluetooth: Change locking logic in security_cfm
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Feb 21, 2012 at 7:56 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-21 12:55:05 +0200]:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> Change bh_ locking functions to mutex_locks since we can now sleep.
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

> I don't like the idea of this locking change in multiple separate patches, it
> could put the stack in a broken and racy state if we stop in the middle of
> these patches.
> I would say to merge all these patches into one, they were a lot reviewed
> alone, there is no problem in create a big one with all the changes together.

I saw the same comments from Ulisses. I will merge all those patches
together and send new patch series.

Regards,
Andrei
