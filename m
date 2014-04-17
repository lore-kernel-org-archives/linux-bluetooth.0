Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJFJD3gdBZkP=XtVZ_JN0AVXuYqdAJ1-=-dwjm6KOvAxA@mail.gmail.com>
References: <1397724982-9238-1-git-send-email-sebastian.chlad@tieto.com>
	<CAJCsO8e+y2UNRdu8tGNdHM+R+71MhkJAUPzCB9xrnBpQgAyt_A@mail.gmail.com>
	<CABBYNZJFJD3gdBZkP=XtVZ_JN0AVXuYqdAJ1-=-dwjm6KOvAxA@mail.gmail.com>
Date: Thu, 17 Apr 2014 16:25:08 +0300
Message-ID: <CAJCsO8d2phB_3dZCPnJncw1Nv+4uVD6ZR6hrFWQLMxHFo_E3tg@mail.gmail.com>
Subject: Re: [PATCH] OPP regression or PTS issues
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Sebastian Chlad <sebastian.chlad@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

PICS are set to OPP 1.1.
Anyway as suggested I've checked PTS erratas and there were some ETS
already (i.e. ETS-12081) which can be found here:
https://www.bluetooth.org/pts/issues/view_issue.cfm?id=12081

After using this ETS I've got all test cases 'PASS' except
TC_CLIENT_OPH_BI_01_C. Comment and logs are attached to mentioned
errata on bluetooth.org.

On 17 April 2014 13:19, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Sebastian,
>
> On Apr 17, 2014 12:22 PM, "Sebastian Chlad" <sebastianchlad@gmail.com>
> wrote:
>>
>> I've created an issue: https://01.org/jira/browse/BZ-10 with some logs
>> attached
>
> There does seems to be any logs there as well, btw we should probably start
> by checking PTS issues, i also wonder why opp tests have changed since it is
> a pretty old profile, perhaps this is for 1.2 which is not supported by
> android.
>
>> On 17 April 2014 10:56, Sebastian Chlad <sebastian.chlad@tieto.com> wrote:
>> > There were some major changes between PTS 5.0 and 5.1 for OPP. Some PICS
>> > were
>> > added as well as some tests cases. While doing the regression tests I
>> > came
>> > across some regression however some of those looks to me like PTS issue;
>> > vide:
>> > vcf extension not being recognized.
>> > Would be good to get developers insight into this matter.
>> >
>> > Sebastian Chlad (1):
>> >   android/pts: Re-run OPP PTS 5.1 test
>> >
>> >  android/pts-opp.txt | 116
>> > ++++++++++++++++++++++++++++++++--------------------
>> >  1 file changed, 72 insertions(+), 44 deletions(-)
>> >
>> > --
>> > 1.8.5.3
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-bluetooth" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Seb/
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Seb/
