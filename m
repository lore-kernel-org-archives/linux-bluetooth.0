Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120629133505.GC27007@x220>
References: <1340182921-12448-1-git-send-email-frederic.danis@linux.intel.com>
	<20120620093513.GA17683@x220>
	<CABBYNZLatbQeMHtaBcXRpFVs4HfWZsUmi36MU9MKw2TQYjemZw@mail.gmail.com>
	<20120629133505.GC27007@x220>
Date: Fri, 29 Jun 2012 16:43:24 +0300
Message-ID: <CABBYNZ+JXbzCKc4NyLdfCSKqd65E1X2n14cOko_4YO3dgghZUA@mail.gmail.com>
Subject: Re: [PATCH] sdp: Prevent duplicate records registration
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Jun 29, 2012 at 4:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> This complicates a little bit more the code, the other option is to
>> oFono don't do the socket management itself, this might be possible
>> with org.bluez.Telephony, so just register an agent for DUN as it will
>> be for HFP, bluetoothd takes care of handling the connection and
>> authorization and when its done
>
> Isn't that exactly what the last two patches (for DUN and SAP) from the
> telephony patch set do?

I guess so, but I didn't remember those in the original series so it
might be introduced latter, Frederic?


-- 
Luiz Augusto von Dentz
