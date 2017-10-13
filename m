Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [BlueZ PATCH 3/3] android: Enable multiadvertising
To: Szymon Janc <szymon.janc@codecoup.pl>
References: <20171010092748.30705.23283.stgit@localhost>
 <20171010092755.30705.97375.stgit@localhost> <2331907.AZjV3pQv3C@ix>
Cc: linux-bluetooth@vger.kernel.org
From: Martin Fuzzey <mfuzzey@parkeon.com>
Message-ID: <2a7044d5-2697-8a23-dae0-965fcf6978a6@parkeon.com>
Date: Fri, 13 Oct 2017 15:32:36 +0200
MIME-Version: 1.0
In-Reply-To: <2331907.AZjV3pQv3C@ix>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/10/17 09:33, Szymon Janc wrote:

Hi Szymon,

thanks for the review.

>
>> +	switch(adv->type) {
>> +	case ANDROID_ADVERTISING_EVENT_TYPE_CONNECTABLE:
>> +		cp->flags |= MGMT_ADV_FLAG_CONNECTABLE;
>> +		break;
>> +
>> +	defualt:
>> +		break;
> This will not compile :)

Actually it *does* compile, in spite of  the typo in "defualt" (the 
compiler interprets it as a label)

Good catch though!

I then saw the rule in coding-style.txt about using all values of enums 
in switch statements (though it isn't enforced for Android builds)

So I'll do that for V2

All of your other remarks applied

Thanks,

Martin


