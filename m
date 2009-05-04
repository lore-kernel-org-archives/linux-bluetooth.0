Return-Path: <cyrus@holtmann.org>
Message-ID: <49FE9FED.5070909@nokia.com>
Date: Mon, 04 May 2009 10:57:33 +0300
From: Roger Quadros <ext-roger.quadros@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>
CC: Marc Pignat <Marc.Pignat@hevs.ch>, justinmattock@gmail.com,
        hidave.darkstar@gmail.com, jkosina@suse.cz,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
References: <49FDCC85020000BF000290ED@mailgw2.hevs.ch> <1241381821.2785.2.camel@localhost.localdomain>
In-Reply-To: <1241381821.2785.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

ext Marcel Holtmann wrote:
> Hi Marc,
> 
> you really need to fix your mailer. You keep breaking the threading all
> the time and that is clearly your fault.
> 
>>> thanks for testing.
>>> Marc, Roger, can you test this and confirm that it works for you and
>>> doesn't have any other side effects. Then I prepare it work upstream
>>> inclusion.
>> Tested and working!
> 
> great. So I queue this up for 2.6.30 inclusion.
> 
>> Exercise left for 2.6.31: use the system wide wq ;)
> 
> Actually no, the private workqueue is used on purpose. No need to bother
> keventd for a regular task.
> 
> Regards
> 
> Marcel
> 
> 

Hi Marcel,

Yes it works for me too. Thanks.

regards,
-roger
