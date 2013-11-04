Return-Path: <cyrus@holtmann.org>
Message-ID: <5277D0CE.8080205@0x01b.net>
Date: Mon, 04 Nov 2013 09:52:30 -0700
From: Matthew Monaco <dgbaley27@0x01b.net>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vcgomes@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hci2hid: properly format device path
References: <963b569308352e0b0fc18a0a17e2b0c0fe721d72.1383529026.git.matthew.monaco@0x01b.net> <20131104161805.GA32089@molly.amr.corp.intel.com> <1383582221.3373.15.camel@nuvo> <20131104164206.GB31305@molly.amr.corp.intel.com>
In-Reply-To: <20131104164206.GB31305@molly.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ah, didn't see it in git. Sorry about the noise.

On 11/04/2013 09:42 AM, Vinicius Costa Gomes wrote:
> Hi Bastien,
> 
> On 17:23 Mon 04 Nov, Bastien Nocera wrote:
>> On Mon, 2013-11-04 at 14:18 -0200, Vinicius Costa Gomes wrote:
>>> Hi Matthew,
>>>
>>> On 18:46 Sun 03 Nov, Matthew Monaco wrote:
>>>> From: Matthew Monaco <matthew.monaco@0x01b.net>
>>>>
>>>> ---
>>>> Hello! I hope this is the correct place to send a bugfix for bluez.
>>>>  tools/hid2hci.c | 15 +++++++++------
>>>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>>> The patch itself looks good.
>>>
>>> What I think is missing is a better description of the problem it solves, I
>>> would suggest including in the commit message the values of 'path' for before
>>> and after the patch, for a situation that the current implementation doesn't
>>> work.
>>>
>>> Changing the subject line to something like: "tools: Fix wrong paths for
>>> adapters" would make it easier to tell that this patch is indeed a bug fix.
>>
>> Isn't this the same patch Giovanni sent a couple of weeks ago?
>>
>> http://thread.gmane.org/gmane.linux.bluez.kernel/38329
> 
> Yeah, same fix. Thanks for noticing.
> 
>>
>> Cheers
>>
> 
> 
> Cheers,
> 
