Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110329145049.GA12595@jh-x301>
References: <1301409722-16198-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110329145049.GA12595@jh-x301>
Date: Tue, 29 Mar 2011 16:47:29 +0000
Message-ID: <AANLkTimDzwz39VM--ACuTfKosQg8xgfu+xX2D=Gz61aM@mail.gmail.com>
Subject: Re: [PATCH] Remove unused variable in mgmtops plugin
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Mar 29, 2011 at 2:50 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Tue, Mar 29, 2011, Claudio Takahasi wrote:
>> ---
>>  plugins/mgmtops.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
>> index 65b32e6..3f96017 100644
>> --- a/plugins/mgmtops.c
>> +++ b/plugins/mgmtops.c
>> @@ -1410,7 +1410,6 @@ static void mgmt_cleanup(void)
>>  {
>>       g_free(controllers);
>>       controllers = NULL;
>> -     max_index = -1;
>>
>>       if (mgmt_sock >= 0) {
>>               close(mgmt_sock);
>
> I don't understand the purpose of this patch. You're neither removing a
> variable (just removing an assignment) nor is the variable you're
> touching unused.
>
> Johan
>

No comment!
I am not working drunk! Maybe blind! ;-)

Claudio.
