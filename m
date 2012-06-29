Return-Path: <cyrus@holtmann.org>
Message-ID: <4FEDB31E.50806@linux.intel.com>
Date: Fri, 29 Jun 2012 15:52:30 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sdp: Prevent duplicate records registration
References: <1340182921-12448-1-git-send-email-frederic.danis@linux.intel.com> <20120620093513.GA17683@x220> <CABBYNZLatbQeMHtaBcXRpFVs4HfWZsUmi36MU9MKw2TQYjemZw@mail.gmail.com> <20120629133505.GC27007@x220> <CABBYNZ+JXbzCKc4NyLdfCSKqd65E1X2n14cOko_4YO3dgghZUA@mail.gmail.com>
In-Reply-To: <CABBYNZ+JXbzCKc4NyLdfCSKqd65E1X2n14cOko_4YO3dgghZUA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

On 29/06/2012 15:43, Luiz Augusto von Dentz wrote:
> Hi Johan,
>
> On Fri, Jun 29, 2012 at 4:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> This complicates a little bit more the code, the other option is to
>>> oFono don't do the socket management itself, this might be possible
>>> with org.bluez.Telephony, so just register an agent for DUN as it will
>>> be for HFP, bluetoothd takes care of handling the connection and
>>> authorization and when its done
>>
>> Isn't that exactly what the last two patches (for DUN and SAP) from the
>> telephony patch set do?
>
> I guess so, but I didn't remember those in the original series so it
> might be introduced latter, Frederic?
>
You are right, this was introduced in v10 of patches.


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation



