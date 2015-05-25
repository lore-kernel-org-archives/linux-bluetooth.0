Return-Path: <cyrus@holtmann.org>
Message-ID: <5562D47A.9030907@gmail.com>
Date: Mon, 25 May 2015 09:51:22 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 00/16] Bluetooth: Multi-advertising infrastructure
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com> <1432507154-22925-1-git-send-email-fgrandel@gmail.com> <F21682C7-106D-4293-993D-D68087860A58@holtmann.org>
In-Reply-To: <F21682C7-106D-4293-993D-D68087860A58@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 05/25/2015 02:52 AM, Marcel Holtmann wrote:
> Hi Florian,
>
>> patch set introducing the infrastructure for multi-advertising
>> capability to the HCI core and mgmt API.
>
> the patch set is actually breaking functionality. If you want to overwrite the advertising data of an existing instance, then you can just do that by issuing another management command.
>
> 	add-adv -u 180d 1
> 	add-adv -u 180f 1
>
> This will first enable advertising with the heart rate UUID and then with the battery service UUID. With your patch set, this basic feature does not work anymore.

I'm going to check this, write a test against this case and make sure 
the problem is being fixed.

It's true that I relied on the test suite to already contain tests for 
all basic features. That's why I did my regression testing there.

> I think first we need a lot more mgmt-tester commands that actually test this functionality.

Sure. I can introduce missing tests for prior features that are not yet 
being tested. You can see that I already added a test case earlier that 
was obviously missing (already accepted).

Therefore an important question to you: Which other cases should be 
tested? It's hard for me to find that out without your help.

> Regards
>
> Marcel

Thanks!

Florian
